#!/usr/bin/env python3
"""
Build an SRT for a narration MP3: Deepgram's timings, the .say file's words.

    DEEPGRAM_API_KEY=... python3 srt_from_deepgram.py agent-board-fleet.mp3 agent-board-fleet.say
    python3 srt_from_deepgram.py agent-board-fleet.mp3 agent-board-fleet.say --reuse

Writes <stem>.srt and caches the API response as <stem>.dg.json (--reuse reads
the cache instead of calling the API again).

WHY BOTH SOURCES, AND WHICH ONE WINS WHERE
------------------------------------------
*Timings* come from Deepgram, because the .say cues are requests, not facts:
tts_openai.py places each segment at its cue and then advances its cursor by the
ACTUAL synthesised length, so speech drifts from the script the moment a segment
runs long. Only the audio knows when a word was really said.

*Words* come from the .say file, because a transcript of synthetic speech is
still a transcript. On this narration Deepgram returned "One Rish session",
"the road map agent", "a to do manager", "no back end" — and, changing the
meaning outright, "the page IN the style sheet" where the script says "the page
AND the stylesheet". Subtitles that say something the script does not are worse
than no subtitles.

So the two streams are aligned with difflib and each script word inherits the
clock of the Deepgram word it matched; words inside a mismatched run get their
times by interpolating between the nearest anchors on either side.

Stdlib only.
"""

from __future__ import annotations

import argparse
import math
import difflib
import json
import os
import re
import sys
import urllib.error
import urllib.request

API = "https://api.deepgram.com/v1/listen"
MODEL = os.environ.get("DG_MODEL", "nova-3")

# Cue shape. A cue is up to two lines; one line is a stub and three is a wall.
MAX_CHARS = 84
WRAP_WIDTH = 44
MAX_SECONDS = 5.5
# Break after a comma/colon once the cue is already this long — it keeps clauses
# whole instead of guillotining them at the character limit.
SOFT_BREAK_AT = 52


# --------------------------------------------------------------------------
# inputs


def parse_say(path: str) -> list[list[str]]:
    """The .say file's segments, each as a list of words (punctuation kept)."""
    segments: list[list[str]] = []
    lines = open(path).read().split("\n")
    i = 0
    cue = re.compile(r"\[(\d+):(\d+)\.(\d+)\s*-->\s*(\d+):(\d+)\.(\d+)\]")
    while i < len(lines):
        if cue.match(lines[i].strip()):
            i += 1
            text: list[str] = []
            while i < len(lines) and lines[i].strip():
                text.extend(lines[i].strip().split())
                i += 1
            if text:
                segments.append(text)
        i += 1
    if not segments:
        raise SystemExit(f"no timed segments found in {path}")
    return segments


def transcribe(path: str, key: str) -> dict:
    body = open(path, "rb").read()
    url = f"{API}?model={MODEL}&smart_format=true&punctuate=true&language=en"
    req = urllib.request.Request(
        url,
        data=body,
        method="POST",
        headers={"Authorization": f"Token {key}", "Content-Type": "audio/mpeg"},
    )
    try:
        with urllib.request.urlopen(req, timeout=300) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as e:
        # The key is in the request headers, never in the message.
        raise SystemExit(f"deepgram {e.code}: {e.read().decode('utf-8', 'replace')[:400]}")


def dg_words(result: dict) -> list[dict]:
    alts = result["results"]["channels"][0]["alternatives"]
    if not alts or not alts[0].get("words"):
        raise SystemExit("deepgram returned no words — nothing to time subtitles on")
    return alts[0]["words"]


# --------------------------------------------------------------------------
# alignment


def norm(w: str) -> str:
    return re.sub(r"[^a-z0-9]", "", w.lower())


def align(script: list[str], heard: list[dict]) -> list[tuple[float, float]]:
    """
    Give every script word a (start, end).

    Matched words take their Deepgram word's clock directly. A run of script
    words with no match — "roadmap" against the heard "road map", say — is
    spread evenly across the audio span between the anchors around it, which is
    accurate to well within a subtitle's tolerance.
    """
    s_norm = [norm(w) for w in script]
    h_norm = [norm(w["word"]) for w in heard]
    times: list[tuple[float, float] | None] = [None] * len(script)

    for blk in difflib.SequenceMatcher(a=s_norm, b=h_norm, autojunk=False).get_matching_blocks():
        for k in range(blk.size):
            hw = heard[blk.b + k]
            times[blk.a + k] = (hw["start"], hw["end"])

    known = [i for i, t in enumerate(times) if t is not None]
    if not known:
        raise SystemExit("script and transcript share no words — wrong pair of files?")

    # Everything before the first anchor and after the last one hugs that anchor.
    first, last = known[0], known[-1]
    for i in range(first):
        times[i] = (times[first][0], times[first][0])
    for i in range(last + 1, len(times)):
        times[i] = (times[last][1], times[last][1])

    # Interior gaps: spread evenly between the anchors that bracket them.
    for a, b in zip(known, known[1:]):
        if b - a <= 1:
            continue
        t0, t1 = times[a][1], times[b][0]
        step = (t1 - t0) / (b - a)
        for j in range(a + 1, b):
            times[j] = (t0 + step * (j - a - 1), t0 + step * (j - a))

    return [t for t in times if t is not None]


# --------------------------------------------------------------------------
# cues


def _split_balanced(items: list[tuple[str, tuple[float, float]]]) -> list[list]:
    """
    Cut one sentence into as few pieces as it needs, of even length.

    Chopping greedily at the character limit is what produces orphans — a cue
    of 82 characters followed by a cue reading "demo is." Splitting into n
    even parts instead, and preferring a comma near each ideal boundary, gives
    pieces that end where a reader would pause.
    """
    text_len = len(" ".join(w for w, _ in items))
    span = items[-1][1][1] - items[0][1][0]

    n = max(1, math.ceil(text_len / MAX_CHARS), math.ceil(span / MAX_SECONDS))
    if n <= 1:
        return [items]

    target = text_len / n
    parts, cur, cur_len = [], [], 0
    for i, (word, t) in enumerate(items):
        cur.append((word, t))
        cur_len += len(word) + 1
        remaining = len(parts) + 1 < n
        if not remaining or i == len(items) - 1:
            continue
        at_clause = word[-1:] in ",:;"
        # Cut once this piece has reached its share, or a touch earlier at a
        # clause boundary — a comma is a better seam than a space.
        if cur_len >= target or (at_clause and cur_len >= target * 0.6):
            parts.append(cur)
            cur, cur_len = [], 0
    if cur:
        parts.append(cur)
    return parts


def build_cues(segments: list[list[str]], times: list[tuple[float, float]]) -> list[dict]:
    cues: list[dict] = []
    idx = 0
    for seg in segments:
        # Pair every word with its clock, then work in sentences: a subtitle
        # that spans a full stop reads as two thoughts glued together.
        timed = [(w, times[idx + i]) for i, w in enumerate(seg)]
        idx += len(seg)

        sentences, cur = [], []
        for word, t in timed:
            cur.append((word, t))
            if word[-1:] in ".?!":
                sentences.append(cur)
                cur = []
        if cur:
            sentences.append(cur)

        seg_cues = []
        for sentence in sentences:
            for part in _split_balanced(sentence):
                seg_cues.append(
                    {
                        "start": part[0][1][0],
                        "end": part[-1][1][1],
                        "text": " ".join(w for w, _ in part),
                    }
                )

        # Merge neighbours that are both short — "Then the other three check in."
        # and "Standing by." are one glance, not two.
        merged: list[dict] = []
        for c in seg_cues:
            if merged:
                p = merged[-1]
                joined = f"{p['text']} {c['text']}"
                if len(joined) <= MAX_CHARS and c["end"] - p["start"] <= MAX_SECONDS:
                    merged[-1] = {"start": p["start"], "end": c["end"], "text": joined}
                    continue
            merged.append(c)
        cues.extend(merged)
    return cues


def wrap(text: str) -> str:
    """At most two lines, split as evenly as the words allow."""
    if len(text) <= WRAP_WIDTH:
        return text
    words = text.split()
    best, best_score = None, None
    for i in range(1, len(words)):
        a, b = " ".join(words[:i]), " ".join(words[i:])
        score = max(len(a), len(b))
        if best_score is None or score < best_score:
            best, best_score = (a, b), score
    return "\n".join(best) if best else text


def ts(seconds: float) -> str:
    ms = int(round(max(0.0, seconds) * 1000))
    h, ms = divmod(ms, 3_600_000)
    m, ms = divmod(ms, 60_000)
    s, ms = divmod(ms, 1000)
    return f"{h:02d}:{m:02d}:{s:02d},{ms:03d}"


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("audio")
    ap.add_argument("say")
    ap.add_argument("--reuse", action="store_true", help="use the cached .dg.json")
    args = ap.parse_args()

    stem = args.audio.rsplit(".", 1)[0]
    cache = f"{stem}.dg.json"

    if args.reuse and os.path.exists(cache):
        result = json.load(open(cache))
        print(f"  reusing {cache}")
    else:
        key = os.environ.get("DEEPGRAM_API_KEY", "").strip()
        if not key:
            raise SystemExit("DEEPGRAM_API_KEY is not set")
        result = transcribe(args.audio, key)
        with open(cache, "w") as fh:
            json.dump(result, fh, indent=2)

    heard = dg_words(result)
    segments = parse_say(args.say)
    script = [w for seg in segments for w in seg]
    times = align(script, heard)
    cues = build_cues(segments, times)

    with open(f"{stem}.srt", "w") as fh:
        for i, c in enumerate(cues, 1):
            fh.write(f"{i}\n{ts(c['start'])} --> {ts(c['end'])}\n{wrap(c['text'])}\n\n")

    print(
        f"  script {len(script)} words · heard {len(heard)} · cues {len(cues)}"
        f" · last word {times[-1][1]:.1f}s  -> {stem}.srt"
    )


if __name__ == "__main__":
    main()
