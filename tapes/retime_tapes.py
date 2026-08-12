#!/usr/bin/env python3
"""
Re-time VHS tapes so each one runs as long as its narration.

Why this exists
---------------
All 111 voiced masters in `final/` fail QC: the narration runs ~3.7x longer than
the video, so `merge_voiceover.py` (which mixes the mp3 at t=0 and passes
`-shortest`) cuts every story off mid-sentence. The tapes were written to a
storyboard timeline that the rendered footage never matched.

The fix is to keep the storyboard's *shape* and replace its *scale*:

  shape  <- the `# M:SS-M:SS` section headers already in each tape. Their spans
            give the intended proportions between beats.
  scale  <- the duration of the matching `say/<tape stem>.mp3`, read with
            ffprobe. That is the number the video has to hit.

Each section's budget is `shape_i / sum(shape) * (target - pre-roll)`. A
section's `Type` and key directives are not free -- VHS spends `TypingSpeed` per
character and per key press -- so that typing cost is subtracted first and only
the remainder is spread across the section's `Sleep` directives, in their
original proportions. `Type` and key lines are never touched.

What this is NOT
----------------
The durations this tool prints are a **static model that has not been validated
by rendering**. VHS output length is not the sum of a tape's `Sleep` directives.
E5 worker-2 measured `story-019-stacked-panes` on this box: a 20.550s static
budget rendered to a 2.000s mp4 (drift 0.097 of budget, at load 63-131), while
the same tape on 2026-05-29 rendered to 7.28s (drift 0.354). Output is 25fps and
its duration is `nb_frames / 25`, so real length tracks vhs's frame-capture
throughput, not these `Sleep` values. The drift is load-dependent and unbounded
and there is no constant correction factor, so this tool does not apply one.

Consequently **re-timing alone will not make the 111 masters pass QC**: a render
on a quiet box plus per-file ffprobe verification is also required. See
`E5-video.md` section 3 and `RETIME-REPORT.md`.

Usage
-----
    # rewrite every tape that has a matching mp3, and write the report
    python3 retime_tapes.py --say-dir say --report RETIME-REPORT.md

    # model only, touch nothing
    python3 retime_tapes.py --say-dir say --dry-run

`say/*.mp3` is gitignored (`.gitignore`: `*.mp3`), so inside a worktree point
`--say-dir` at the main checkout's `tapes/say`.
"""

from __future__ import annotations

import argparse
import json
import math
import os
import re
import subprocess
import sys
from dataclasses import dataclass, field
from typing import Optional

# --- model constants ---------------------------------------------------------

# Shortest Sleep we will ever emit. A tape that cannot fit its target above this
# floor is clamped and reported, never given a zero or negative Sleep.
MIN_SLEEP = 0.1

# "predicted within this many seconds of the mp3" is the T1 done-criterion.
TOLERANCE = 1.0

# VHS's own default when a tape does not `Set TypingSpeed`. Every tape in this
# repo sets it explicitly (117 at 75ms, 3 at 60ms, 1 at 65ms), so this fallback
# is not exercised today; it is here so a future tape that omits the setting is
# still modelled the way VHS would actually run it.
FALLBACK_TYPING_SPEED = 0.05

SLEEP_RE = re.compile(r"^Sleep\s+(\S+)\s*$")
HEADER_RE = re.compile(r"^#\s+(\d+):(\d{2})\s*-\s*(\d+):(\d{2})(?:\s|$)")
TYPE_RE = re.compile(r"^Type(?:@(\S+))?\s+(.+)$")
SET_TYPING_RE = re.compile(r"^Set\s+TypingSpeed\s+(\S+)\s*$")
DURATION_RE = re.compile(r"^([0-9]*\.?[0-9]+)\s*(ms|s|m)?$")

# VHS key directives. Each press costs one TypingSpeed unit.
KEY_NAMES = {
    "Enter", "Escape", "Tab", "Space", "Backspace", "Delete", "Insert",
    "Up", "Down", "Left", "Right", "Home", "End", "PageUp", "PageDown",
}
KEY_MOD_RE = re.compile(r"^(?:Ctrl|Alt|Shift)(?:\+(?:Ctrl|Alt|Shift))*\+\S+$")
KEY_LINE_RE = re.compile(r"^(\S+)(?:\s+(\d+))?\s*$")


# --- small helpers -----------------------------------------------------------

def parse_duration(text: str) -> float:
    """`2s` / `0.3s` / `500ms` / `1m` -> seconds."""
    m = DURATION_RE.match(text.strip())
    if not m:
        raise ValueError("unparseable duration: %r" % text)
    value = float(m.group(1))
    unit = m.group(2) or "s"
    return value * {"ms": 0.001, "s": 1.0, "m": 60.0}[unit]


def format_duration(seconds: float) -> str:
    """Seconds -> the tidiest VHS literal: 2.0 -> `2s`, 2.35 -> `2.35s`."""
    rounded = round(seconds + 1e-12, 2)
    if abs(rounded - round(rounded)) < 1e-9:
        return "%ds" % int(round(rounded))
    text = ("%.2f" % rounded).rstrip("0").rstrip(".")
    return text + "s"


def parse_header(line: str) -> Optional[tuple]:
    """`# 0:04-0:10  Launch rysh` -> (4.0, 10.0). Anything else -> None."""
    m = HEADER_RE.match(line)
    if not m:
        return None
    start = int(m.group(1)) * 60 + int(m.group(2))
    end = int(m.group(3)) * 60 + int(m.group(4))
    return (float(start), float(end))


def header_title(line: str) -> str:
    """`# 0:04-0:10  Launch rysh` -> `Launch rysh`."""
    m = HEADER_RE.match(line)
    return line[m.end():].strip() if m else ""


def _type_payload_length(payload: str) -> int:
    """Character count of a `Type` argument, minus one matching quote pair."""
    text = payload.strip()
    if len(text) >= 2 and text[0] == text[-1] and text[0] in "\"'`":
        text = text[1:-1]
    return len(text)


def directive_cost(line: str, typing_speed: float) -> float:
    """
    Wall-clock a single line costs VHS, excluding `Sleep`.

    `Sleep` is the adjustable budget and is accounted separately, so it reads 0
    here. `Set`/`Output`/comments are free. `Type` costs one TypingSpeed per
    character (honouring a `Type@40ms` override), and a key press costs one
    TypingSpeed each.
    """
    text = line.strip()
    if not text or text.startswith("#"):
        return 0.0
    if SLEEP_RE.match(text):
        return 0.0

    m = TYPE_RE.match(text)
    if m:
        speed = parse_duration(m.group(1)) if m.group(1) else typing_speed
        return _type_payload_length(m.group(2)) * speed

    km = KEY_LINE_RE.match(text)
    if km:
        name = km.group(1)
        if name in KEY_NAMES or KEY_MOD_RE.match(name):
            repeat = int(km.group(2)) if km.group(2) else 1
            return repeat * typing_speed
    return 0.0


def allocate(weights, floors, total: float):
    """
    Split `total` across items proportional to `weights`, never below `floors`.

    Proportional water-filling: any item whose proportional share falls under its
    floor is pinned at the floor and the rest is re-split over what remains, so
    the total is still hit exactly whenever the floors allow it. When they do
    not, everything sits on its floor and the caller sees the overrun.
    """
    n = len(weights)
    alloc = [0.0] * n
    active = set(range(n))
    remaining = float(total)

    while active:
        w_sum = sum(weights[i] for i in active)
        if w_sum <= 0:
            share = remaining / len(active)
            under = [i for i in active if share < floors[i]]
            if not under:
                for i in active:
                    alloc[i] = share
                return alloc
        else:
            under = [i for i in active if remaining * weights[i] / w_sum < floors[i]]
            if not under:
                for i in active:
                    alloc[i] = remaining * weights[i] / w_sum
                return alloc
        for i in under:
            alloc[i] = floors[i]
            remaining -= floors[i]
            active.discard(i)
    return alloc


def round_to_sum(values, total: float, minimum: float, places: int = 2):
    """
    Round `values` to `places` decimals so they still sum to `total`.

    Largest-remainder, with `minimum` as a hard floor. Values already at the
    target precision round to themselves, which is what makes a second pass over
    an already-retimed tape a no-op.
    """
    if not values:
        return []
    q = 10 ** places
    min_units = int(round(minimum * q))
    total_units = int(round(total * q))
    units = [max(int(math.floor(v * q + 1e-9)), min_units) for v in values]

    diff = total_units - sum(units)
    if diff > 0:
        order = sorted(range(len(values)),
                       key=lambda i: -(values[i] * q - math.floor(values[i] * q + 1e-9)))
        for k in range(diff):
            units[order[k % len(order)]] += 1
    elif diff < 0:
        order = sorted(range(len(values)), key=lambda i: -units[i])
        k = 0
        guard = 0
        while diff < 0 and any(u > min_units for u in units) and guard < 10 * len(units) + diff * -1:
            i = order[k % len(order)]
            if units[i] > min_units:
                units[i] -= 1
                diff += 1
            k += 1
            guard += 1
    return [u / q for u in units]


# --- tape model --------------------------------------------------------------

@dataclass
class Section:
    start: float
    end: float
    header_index: int
    body_start: int
    body_end: int
    lines: list = field(default_factory=list)      # raw body lines
    sleep_positions: list = field(default_factory=list)  # indices into `lines`
    fixed_cost: float = 0.0
    typing_speed: float = FALLBACK_TYPING_SPEED
    title: str = ""

    @property
    def weight(self) -> float:
        return max(self.end - self.start, 0.0)

    def sleep_values(self):
        return [parse_duration(SLEEP_RE.match(self.lines[i].strip()).group(1))
                for i in self.sleep_positions]

    def sleep_total(self) -> float:
        return sum(self.sleep_values())

    def current_duration(self) -> float:
        return self.fixed_cost + self.sleep_total()

    def floor(self) -> float:
        return self.fixed_cost + len(self.sleep_positions) * MIN_SLEEP

    @property
    def rigid(self) -> bool:
        """No Sleep to give: the section's length cannot be changed at all."""
        return not self.sleep_positions


@dataclass
class Tape:
    lines: list
    typing_speed: float
    sections: list
    preamble_end: int
    trailing_newline: bool = True

    def preamble_duration(self) -> float:
        total = 0.0
        for line in self.lines[:self.preamble_end]:
            text = line.strip()
            m = SLEEP_RE.match(text)
            total += parse_duration(m.group(1)) if m else directive_cost(line, self.typing_speed)
        return total

    def render(self) -> str:
        out = "\n".join(self.lines)
        return out + "\n" if self.trailing_newline else out


def parse_tape(text: str) -> Tape:
    """Split a tape into its pre-roll and its `# M:SS-M:SS` sections."""
    trailing_newline = text.endswith("\n")
    lines = text.split("\n")
    if trailing_newline:
        lines = lines[:-1]

    typing_speed = FALLBACK_TYPING_SPEED
    for line in lines:
        m = SET_TYPING_RE.match(line.strip())
        if m:
            typing_speed = parse_duration(m.group(1))
            break

    header_indices = [i for i, ln in enumerate(lines) if parse_header(ln)]

    # A header sits inside a banner comment block; the block starts at the first
    # comment line of the run that contains it.
    def block_start(h: int) -> int:
        i = h
        while i - 1 >= 0 and lines[i - 1].strip().startswith("#"):
            i -= 1
        return i

    # ...and the body starts at the first line after it that is not a comment.
    def body_start(h: int) -> int:
        i = h + 1
        while i < len(lines) and lines[i].strip().startswith("#"):
            i += 1
        return i

    starts = [block_start(h) for h in header_indices]
    sections = []
    for n, h in enumerate(header_indices):
        span = parse_header(lines[h])
        bs = body_start(h)
        be = starts[n + 1] if n + 1 < len(header_indices) else len(lines)
        sec = Section(start=span[0], end=span[1], header_index=h,
                      body_start=bs, body_end=be, typing_speed=typing_speed,
                      title=header_title(lines[h]))
        sec.lines = lines[bs:be]
        for k, ln in enumerate(sec.lines):
            if SLEEP_RE.match(ln.strip()):
                sec.sleep_positions.append(k)
            else:
                sec.fixed_cost += directive_cost(ln, typing_speed)
        sections.append(sec)

    preamble_end = starts[0] if starts else len(lines)
    return Tape(lines=lines, typing_speed=typing_speed, sections=sections,
                preamble_end=preamble_end, trailing_newline=trailing_newline)


def predict_duration(text: str) -> float:
    """
    Modelled wall-clock of a whole tape: every Sleep plus every typing cost.

    Deliberately computed straight off the file rather than from the section
    tree, so it is an independent check on the rewrite.
    """
    tape = parse_tape(text)
    total = 0.0
    for line in tape.lines:
        m = SLEEP_RE.match(line.strip())
        total += parse_duration(m.group(1)) if m else directive_cost(line, tape.typing_speed)
    return total


# --- the rewrite -------------------------------------------------------------

@dataclass
class TapeReport:
    name: str = ""
    target: float = 0.0
    predicted: float = 0.0
    original: float = 0.0
    ok: bool = False
    clamped_sections: list = field(default_factory=list)
    rigid_sections: list = field(default_factory=list)
    notes: list = field(default_factory=list)
    sections: int = 0

    @property
    def delta(self) -> float:
        return self.predicted - self.target


def retime_tape_text(text: str, target_seconds: float, name: str = ""):
    """
    Rewrite a tape's `Sleep` directives so it models out at `target_seconds`.

    Returns `(new_text, TapeReport)`. Only `Sleep` lines change; `Type`, key and
    comment lines come through byte-for-byte.
    """
    tape = parse_tape(text)
    report = TapeReport(name=name, target=target_seconds,
                        original=predict_duration(text),
                        sections=len(tape.sections))

    if not tape.sections:
        report.predicted = report.original
        report.notes.append("no `# M:SS-M:SS` section headers: left untouched")
        return text, report

    pre_roll = tape.preamble_duration()
    if pre_roll > 0:
        report.notes.append("pre-roll of %.2fs before the first section is inside the budget"
                            % pre_roll)

    budget = target_seconds - pre_roll

    # Rigid sections (no Sleep at all) cannot move; pin them and split the rest.
    rigid = [s for s in tape.sections if s.rigid]
    movable = [s for s in tape.sections if not s.rigid]
    for s in rigid:
        budget -= s.fixed_cost
        report.rigid_sections.append("%s (%.2fs of typing, no Sleep to adjust)"
                                     % (s.title or "%d:%02d" % (s.start // 60, s.start % 60),
                                        s.fixed_cost))

    if movable:
        weights = [s.weight for s in movable]
        floors = [s.floor() for s in movable]
        shares = allocate(weights, floors, budget)
        w_sum = sum(weights)
        for sec, share, floor in zip(movable, shares, floors):
            # A section that ends up sitting on its floor got less than the shape
            # asked for: the typing plus the minimum sleeps do not fit its share.
            # That is the tape's shape being violated, so it gets recorded.
            if share <= floor + 1e-9:
                wanted = budget * sec.weight / w_sum if w_sum > 0 else 0.0
                report.clamped_sections.append({
                    "title": sec.title or "%d:%02d" % (sec.start // 60, sec.start % 60),
                    "floor": round(floor, 2),
                    "typing": round(sec.fixed_cost, 2),
                    "sleeps": len(sec.sleep_positions),
                    "share": round(max(wanted, 0.0), 2),
                    "over": round(floor - max(wanted, 0.0), 2),
                })
            n = len(sec.sleep_positions)
            sleep_budget = round(share - sec.fixed_cost, 2)
            if sleep_budget < n * MIN_SLEEP:
                sleep_budget = round(n * MIN_SLEEP, 2)
            originals = sec.sleep_values()
            exact = allocate(originals, [MIN_SLEEP] * n, sleep_budget)
            rounded = round_to_sum(exact, sleep_budget, MIN_SLEEP)
            for pos, value in zip(sec.sleep_positions, rounded):
                sec.lines[pos] = "Sleep " + format_duration(value)

    # splice the rewritten section bodies back into the file
    new_lines = list(tape.lines)
    for sec in tape.sections:
        new_lines[sec.body_start:sec.body_end] = sec.lines
    out = "\n".join(new_lines) + ("\n" if tape.trailing_newline else "")

    report.predicted = predict_duration(out)
    report.ok = abs(report.predicted - target_seconds) <= TOLERANCE
    return out, report


# --- driving it over the tree ------------------------------------------------

def mp3_duration(path: str) -> float:
    out = subprocess.run(
        ["ffprobe", "-v", "error", "-show_entries", "format=duration",
         "-of", "default=nw=1:nk=1", path],
        capture_output=True, text=True, check=True)
    return float(out.stdout.strip())


def write_report(path: str, reports, tolerance: float) -> None:
    hits = [r for r in reports if r.ok]
    misses = [r for r in reports if not r.ok]
    lines = []
    lines.append("# Tape re-timing report (T1)")
    lines.append("")
    lines.append("Generated by `tapes/retime_tapes.py`. Every tape with a matching")
    lines.append("`say/<stem>.mp3` was re-timed: the section shape comes from its")
    lines.append("`# M:SS-M:SS` headers, the scale from the mp3's ffprobe duration.")
    lines.append("")
    lines.append("## These numbers are a static model, and they have NOT been validated by rendering")
    lines.append("")
    lines.append("**Nothing in this report was rendered.** Every \"predicted\" duration below is the")
    lines.append("modelled sum of a tape's `Sleep` directives plus its typing cost. That is not what")
    lines.append("`vhs` actually produces.")
    lines.append("")
    lines.append("E5 worker-2 measured the gap on this box. Rendering `story-019-stacked-panes`")
    lines.append("against a static `Sleep` budget of **20.550s** produced an mp4 whose `ffprobe`")
    lines.append("duration was **2.000s** -- a drift of **0.097** of the budget, at load 63-131. The")
    lines.append("same tape rendered on 2026-05-29 came out at 182 frames = 7.28s, a drift of")
    lines.append("**0.354**. The mechanism: every output is 25fps and its duration is")
    lines.append("`nb_frames / 25`, so real output length tracks vhs's frame-capture throughput, not")
    lines.append("the `Sleep` directives this tool rewrites. **The drift is load-dependent and")
    lines.append("unbounded, and no constant correction factor exists** -- which is why this tool")
    lines.append("does not apply one.")
    lines.append("")
    lines.append("Therefore, stated plainly:")
    lines.append("")
    lines.append("- These tapes are **not** \"correctly timed\" now. They are re-timed against a model.")
    lines.append("- **Re-timing alone will not make the 111 masters pass QC.** A render on a quiet")
    lines.append("  box plus per-file `ffprobe` verification against the narration is also required.")
    lines.append("- The ~3.7x narration overrun recorded in `E5-video.md` section 1 is **not**")
    lines.append("  demonstrated fixed by this report. Nothing here re-rendered or re-measured a")
    lines.append("  master.")
    lines.append("")
    lines.append("What this work does establish is narrower and still necessary: the tapes genuinely")
    lines.append("were mis-timed against their narration, their storyboard shape is now scaled to a")
    lines.append("real measured input (`ffprobe` on `say/*.mp3`), and the three tapes that cannot be")
    lines.append("re-timed at all are identified below.")
    lines.append("")
    lines.append("## Summary")
    lines.append("")
    lines.append("| | |")
    lines.append("|---|---|")
    lines.append("| Tapes re-timed | %d |" % len(reports))
    lines.append("| Predicted within %.1fs of narration | **%d / %d** |"
                 % (tolerance, len(hits), len(reports)))
    lines.append("| Outside %.1fs | %d |" % (tolerance, len(misses)))
    if reports:
        worst = max(reports, key=lambda r: abs(r.delta))
        lines.append("| Largest miss | %s, %+.2fs |" % (worst.name, worst.delta))
        lines.append("| Mean absolute miss | %.3fs |"
                     % (sum(abs(r.delta) for r in reports) / len(reports)))
    lines.append("")
    lines.append("## Tapes outside tolerance, and why")
    lines.append("")
    if not misses:
        lines.append("None. Every re-timed tape models within %.1fs of its narration." % tolerance)
    else:
        lines.append("| Tape | Narration | Predicted | Delta | Sections at floor | The binding section |")
        lines.append("|---|---:|---:|---:|---:|---|")
        for r in sorted(misses, key=lambda r: -abs(r.delta)):
            if r.clamped_sections:
                worst = max(r.clamped_sections, key=lambda c: c["over"])
                why = ("`%s` -- %.2fs of typing forces a %.2fs floor, but the shape only gives it "
                       "%.2fs" % (worst["title"], worst["typing"], worst["floor"], worst["share"]))
            else:
                why = "; ".join(str(x) for x in (r.rigid_sections + r.notes)) or \
                      "shape and scale disagree by more than the floor allows"
            lines.append("| `%s` | %.2fs | %.2fs | %+.2fs | %d of %d | %s |"
                         % (r.name, r.target, r.predicted, r.delta,
                            len(r.clamped_sections), r.sections, why.replace("|", "/")))
        lines.append("")
        lines.append("The cause is the same in all three: **the tape's own typing takes longer than")
        lines.append("the whole narration**. Each of these stories builds a skill file by typing")
        lines.append("dozens of `echo '...' >> .rysh/humanoids/support.md` lines at 75ms/char, so one")
        lines.append("section alone costs 40-62s against a 47-48s narration. A section's floor is its")
        lines.append("typing cost plus a %.2fs minimum `Sleep` per directive, and re-timing cannot go" % MIN_SLEEP)
        lines.append("below that floor without deleting typing -- which would change what the video")
        lines.append("shows. **These are not re-time cases.** Each needs one of: a `Type@` speed")
        lines.append("override for the file-authoring block, replacing the typed heredoc with a")
        lines.append("`cat` of a prepared file, or a longer narration. That is a separate decision,")
        lines.append("not something this tool should make silently.")
        lines.append("")
        lines.append("Note for whoever picks that up: these are exactly the three tutorials")
        lines.append("`E5-video.md` section 5 flags as carrying an adapter claim that must be checked")
        lines.append("against `new_roadmap/designs/024-investor-claims.md` before they go out. Do not")
        lines.append("re-cut them on timing grounds alone.")
    lines.append("")
    lines.append("## All tapes")
    lines.append("")
    lines.append("| Tape | Sections | Was | Narration | Predicted | Delta | Within %.1fs |"
                 % tolerance)
    lines.append("|---|---:|---:|---:|---:|---:|---|")
    for r in sorted(reports, key=lambda r: r.name):
        lines.append("| `%s` | %d | %.2fs | %.2fs | %.2fs | %+.2fs | %s |"
                     % (r.name, r.sections, r.original, r.target, r.predicted,
                        r.delta, "yes" if r.ok else "**no**"))
    lines.append("")
    with open(path, "w") as fh:
        fh.write("\n".join(lines))


def main(argv=None) -> int:
    here = os.path.dirname(os.path.abspath(__file__))
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--tape-dir", default=os.path.join(here, "tape"))
    ap.add_argument("--say-dir", default=os.path.join(here, "say"),
                    help="where the narration mp3s live (gitignored; in a worktree "
                         "point this at the main checkout's tapes/say)")
    ap.add_argument("--report", default=None, help="write a markdown report here")
    ap.add_argument("--json", default=None, help="also dump the raw numbers here")
    ap.add_argument("--tolerance", type=float, default=TOLERANCE)
    ap.add_argument("--dry-run", action="store_true", help="model only, write nothing")
    ap.add_argument("--only", default=None, help="substring filter on the tape stem")
    args = ap.parse_args(argv)

    if not os.path.isdir(args.say_dir):
        print("error: --say-dir %r does not exist. say/*.mp3 is gitignored, so in a "
              "worktree point it at the main checkout." % args.say_dir, file=sys.stderr)
        return 2

    tapes = sorted(f for f in os.listdir(args.tape_dir) if f.endswith(".tape"))
    reports = []
    skipped = []
    for filename in tapes:
        stem = filename[:-len(".tape")]
        if args.only and args.only not in stem:
            continue
        mp3 = os.path.join(args.say_dir, stem + ".mp3")
        if not os.path.exists(mp3):
            skipped.append(stem)
            continue
        path = os.path.join(args.tape_dir, filename)
        with open(path) as fh:
            text = fh.read()
        target = mp3_duration(mp3)
        out, report = retime_tape_text(text, target, name=stem)
        reports.append(report)
        if not args.dry_run and out != text:
            with open(path, "w") as fh:
                fh.write(out)
        flag = "ok " if report.ok else "MISS"
        print("%s %-46s was %6.2fs  narration %6.2fs  predicted %6.2fs  %+6.2fs"
              % (flag, stem, report.original, report.target, report.predicted, report.delta))

    hits = sum(1 for r in reports if r.ok)
    print("\n%d tapes re-timed, %d within %.1fs, %d outside, %d skipped (no mp3)"
          % (len(reports), hits, args.tolerance, len(reports) - hits, len(skipped)))
    if skipped:
        print("skipped: " + ", ".join(skipped))
    print("predicted durations are a STATIC MODEL, not validated by rendering: worker-2 measured "
          "a 20.550s budget render to 2.000s (drift 0.097). Re-timing alone will not pass QC.")

    if args.report and not args.dry_run:
        write_report(args.report, reports, args.tolerance)
        print("report: %s" % args.report)
    if args.json and not args.dry_run:
        with open(args.json, "w") as fh:
            json.dump([{"name": r.name, "target": r.target, "predicted": r.predicted,
                        "original": r.original, "delta": r.delta, "ok": r.ok,
                        "sections": r.sections, "clamped": r.clamped_sections,
                        "rigid": r.rigid_sections, "notes": r.notes} for r in reports],
                      fh, indent=2)
    return 0 if len(reports) - hits == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
