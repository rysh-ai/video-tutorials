#!/usr/bin/env bash
# Build one narrated, subtitled README demo.
#
#   ./make-demo.sh 01-first-panes                 # record, narrate, subtitle, mux
#   ./make-demo.sh 01-first-panes --skip-record   # reuse the clips in .build, redo audio
#   ./make-demo.sh 01-first-panes --skip-voice    # reuse the cues, re-record only
#
# Output:
#   out/1x/<demo>.mp4           the master, subtitles BURNED IN
#   out/1x/<demo>.softsubs.mp4  the same, subtitles as a selectable track
#   out/1x/<demo>.srt           its subtitle file
#
# The plain name is the burned-in cut on purpose: a soft track is switched off by
# default in most players, so a file that "has subtitles" plays without any.
#   out/<demo>.{mp4,subs.mp4,srt}   the SHIPPING cut — the master re-timed to
#                           $PLAYBACK (default 1.5x) by speed-up.sh, run as
#                           the last stage of this script.
#
# The sped-up cut takes the PLAIN names because those are the ones that get
# uploaded, and a rebuild must not quietly replace a 1.5x upload with a 1x file
# at the same path. Set PLAYBACK=1 to ship the master unchanged. (SPEED, separately,
# is how fast the narrator SPEAKS — a different thing at a different stage.)
#
# ---------------------------------------------------------------------------
# WHY THIS RECORDS SECTION BY SECTION RATHER THAN IN ONE VHS RUN
#
# VHS does not capture in real time. video-tutorials/tapes/RENDERING.md measured
# three unmodified tapes coming out at 0.097, 0.142 and 0.279 of the length their
# Sleep lines ask for: it drops frames whenever the terminal renders faster than
# it can screenshot, and it drops them UNEVENLY. There is therefore no formula
# from Sleep values to a frame offset, and a voice track laid against wall clock
# drifts further out with every paragraph.
#
# So: each `# @section N` of the tape is recorded as its own clip, one cue of
# narration is synthesised per section, and clip N is fitted to cue N. Sync
# becomes structural instead of arithmetic — the narration physically cannot
# describe something that is not on screen. Inherited, with the measurement,
# from marketing/assets/videos/graph-engineering/narrate.sh.
#
# THE TOP MARGIN. `Set Padding` in tape-header.txt is what keeps the first rows
# of the terminal off the top edge of the frame. VHS 0.11 has no `Set Margin`,
# and padding is the only lever it offers; it applies to every side, so the
# number there is chosen for the TOP edge and the other three inherit it.
#
# WHICH BINARY IS FILMED. _bin/rysh points at the RELEASED, publicly installable
# build, not at a local dev build. A demo attached to the README has to show what
# someone gets from the install line in that README.
#
# Requirements: vhs, ttyd, ffmpeg, ffprobe, python3, curl, and the two keys in
# the rysh secret store (OPENAI_API_KEY for the voice, DEEPGRAM_API_KEY for the
# subtitle timings).
set -uo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
DEMO="${1:-}"
[ -n "$DEMO" ] || { echo "usage: $0 <demo-dir> [--skip-record|--skip-voice]" >&2; exit 2; }
shift || true
DEMO="${DEMO%/}"
SRC="$DIR/$DEMO"
[ -d "$SRC" ] || { echo "no such demo: $SRC" >&2; exit 2; }

TAPE="$SRC/demo.tape"
NARRATION="$SRC/narration.txt"
BUILD="$SRC/.build"
OUTDIR="$DIR/out/1x"
SOFT="$OUTDIR/$DEMO.softsubs.mp4"   # selectable track
OUT="$OUTDIR/$DEMO.mp4"             # burned in — what a player shows unasked
SRT="$OUTDIR/$DEMO.srt"

LEAD=0.45                      # quiet beat before each cue
TAIL=1.10                      # quiet beat after each cue
MAX_STRETCH=2.5                # never slow a clip more than this
VOICE="${VOICE:-nova}"
TTS_MODEL="${TTS_MODEL:-tts-1-hd}"
SPEED="${SPEED:-1.0}"
TARGET_I="${TARGET_I:--16}"    # LUFS integrated — web playback level
TARGET_TP="${TARGET_TP:--1.5}" # dBTP ceiling

SKIP_RECORD=""; SKIP_VOICE=""
for a in "$@"; do
  case "$a" in
    --skip-record) SKIP_RECORD=yes ;;
    --skip-voice)  SKIP_VOICE=yes ;;
    *) echo "unknown flag: $a" >&2; exit 2 ;;
  esac
done

say() { printf '\033[36m[%s]\033[0m %s\n' "$DEMO" "$*"; }
die() { printf '\033[31m[%s]\033[0m %s\n' "$DEMO" "$*" >&2; exit 1; }

for c in vhs ttyd ffmpeg ffprobe python3 curl; do
  command -v "$c" >/dev/null || die "$c is not installed"
done
[ -f "$TAPE" ]      || die "no tape: $TAPE"
[ -f "$NARRATION" ] || die "no narration: $NARRATION"

# _bin/rysh is gitignored (it is a symlink to an absolute path), so a fresh clone
# has none. Recreate it pointing at the RELEASED build — the one the README's
# install line produces — because that is what these demos are supposed to film.
if [ ! -e "$DIR/_bin/rysh" ]; then
  mkdir -p "$DIR/_bin"
  gobin="$(go env GOPATH 2>/dev/null)/bin/rysh"
  [ -x "$gobin" ] || die "no $gobin — run: go install github.com/rysh-ai/rysh-cli-code/cmd/rysh@latest"
  ln -sf "$gobin" "$DIR/_bin/rysh"
  say "_bin/rysh -> $gobin"
fi

dur() { ffprobe -v error -show_entries format=duration -of csv=p=0 "$1"; }

# --- keys ------------------------------------------------------------------
# `##secret get` prints the REAL value on stdout, so it is captured straight into
# a variable: never echoed, never written to a file, never passed on a command
# line where `ps` would show it. Only the LENGTH is ever printed — a prefix of a
# live key is still a leak into a transcript that outlives this run.
RYSH_BIN="${RYSH_BIN:-$HOME/.local/bin/rysh_local}"
KEY_SESSION="${KEY_SESSION:-rysh}"
KEY_WORKDIR="${KEY_WORKDIR:-$DIR/../../..}"   # rysh state is PROJECT-local: the
                                              # fetch must run where that session's
                                              # .rysh lives, i.e. the repo root.
fetch_secret() {
  ( cd "$KEY_WORKDIR" && "$RYSH_BIN" exec --session "$KEY_SESSION" -- "##secret get $1" ) 2>/dev/null \
    | sed -E 's/^\[secret\][^=]*= //; s/[[:space:]]+\[[^]]*\][[:space:]]*$//' | tr -d '\n'
}

# THE TWO KEYS ARE FETCHED SEPARATELY, because they are needed at different
# stages and --skip-voice only skips ONE of them. Fetching both behind the voice
# guard meant `--skip-voice` reached the subtitle pass with no Deepgram key and
# died there, after re-encoding every clip — the expensive half done, the cheap
# half impossible.
if [ -z "$SKIP_VOICE" ]; then
  say "reading the TTS key from the \"$KEY_SESSION\" session's secret store"
  OPENAI_API_KEY="${OPENAI_API_KEY:-$(fetch_secret OPENAI_API_KEY)}"
  export OPENAI_API_KEY
  [ "${#OPENAI_API_KEY}" -gt 20 ] || die "OPENAI_API_KEY looks empty (${#OPENAI_API_KEY} chars)"
  say "TTS key loaded (${#OPENAI_API_KEY} chars)"
fi
# Subtitles are timed on every run, skip-voice or not, unless a cached Deepgram
# response is being reused.
if [ -z "${DG_REUSE:-}" ]; then
  say "reading the subtitle key from the \"$KEY_SESSION\" session's secret store"
  DEEPGRAM_API_KEY="${DEEPGRAM_API_KEY:-$(fetch_secret DEEPGRAM_API_KEY)}"
  export DEEPGRAM_API_KEY
  [ "${#DEEPGRAM_API_KEY}" -gt 20 ] || die "DEEPGRAM_API_KEY looks empty (${#DEEPGRAM_API_KEY} chars)"
  say "subtitle key loaded (${#DEEPGRAM_API_KEY} chars)"
fi

mkdir -p "$BUILD/cues" "$BUILD/tts-cache" "$OUTDIR"
if [ -z "$SKIP_RECORD" ]; then rm -f "$BUILD"/sec*.mp4; fi
rm -f "$BUILD"/vid*.mp4 "$BUILD"/aud*.wav "$BUILD"/concat.txt "$BUILD"/video.mp4 "$BUILD"/audio.wav

# --- 1. split the tape into one tape per @section ---------------------------
# Everything before the first marker is the shared header and is prepended to
# every clip, so every section is styled — and padded — identically.
python3 - "$TAPE" "$BUILD" <<'PY' || die "tape split failed"
import re, sys, os
tape, build = sys.argv[1], sys.argv[2]
lines = open(tape).read().splitlines()
header, sections, cur = [], [], None
for ln in lines:
    m = re.match(r'^#\s*@section\s+(\d+)', ln)
    if m:
        cur = {'n': int(m.group(1)), 'body': []}
        sections.append(cur)
        continue
    if ln.lstrip().startswith('Output '):
        continue
    (cur['body'] if cur else header).append(ln)
if not sections:
    sys.exit('%s has no @section markers' % tape)
for s in sections:
    with open(os.path.join(build, 'sec%02d.tape' % s['n']), 'w') as f:
        f.write('Output "%s/sec%02d.mp4"\n' % (build, s['n']))
        f.write('\n'.join(header) + '\n')
        f.write('\n'.join(s['body']) + '\n')
print('%d sections' % len(sections))
PY

SECTIONS=$(python3 -c "
import glob,os,re
print(' '.join(sorted(re.search(r'sec(\d+)',os.path.basename(p)).group(1)
                      for p in glob.glob('$BUILD/sec*.tape'))))")
say "sections: $SECTIONS"

# --- 2. one cue per [n] in narration.txt ------------------------------------
python3 - "$NARRATION" "$BUILD/cues" <<'PY' || die "cue split failed"
import re, sys, os
txt = open(sys.argv[1]).read()
os.makedirs(sys.argv[2], exist_ok=True)
for n, body in re.findall(r'^\[(\d+)\]\n(.*?)(?=^\[|\Z)', txt, re.S | re.M):
    spoken = ' '.join(l for l in body.splitlines()
                      if not l.lstrip().startswith('#')).split()
    open(os.path.join(sys.argv[2], 'cue%02d.txt' % int(n)), 'w').write(' '.join(spoken))
PY

# --- 3. synthesise one voice cue per section --------------------------------
# Cached by sha256 of the text, so iterating on one paragraph does not re-bill
# the whole script.
if [ -z "$SKIP_VOICE" ]; then
  say "synthesising voice (openai $TTS_MODEL, $VOICE, speed $SPEED)"
  for n in $SECTIONS; do
    t="$BUILD/cues/cue$n.txt"
    [ -f "$t" ] || die "$(basename "$NARRATION") has no cue [$((10#$n))] for section $n"
    [ -s "$t" ] || die "cue [$((10#$n))] is empty"
    h=$(python3 -c "
import hashlib,sys
print(hashlib.sha256(open(sys.argv[1],'rb').read()+b'|$VOICE|$TTS_MODEL|$SPEED').hexdigest()[:16])" "$t")
    cached="$BUILD/tts-cache/$h.mp3"
    if [ ! -s "$cached" ]; then
      python3 - "$t" "$cached" "$VOICE" "$TTS_MODEL" "$SPEED" <<'PY' || die "openai TTS failed on cue $n"
import json, os, sys, urllib.request, urllib.error
text, out, voice, model, speed = sys.argv[1:6]
body = json.dumps({"model": model, "voice": voice, "speed": float(speed),
                   "input": open(text).read(), "response_format": "mp3"}).encode()
req = urllib.request.Request("https://api.openai.com/v1/audio/speech", data=body,
    headers={"Authorization": "Bearer " + os.environ["OPENAI_API_KEY"],
             "Content-Type": "application/json"})
try:
    with urllib.request.urlopen(req, timeout=180) as r, open(out, "wb") as f:
        f.write(r.read())
except urllib.error.HTTPError as e:
    sys.exit("openai HTTP %s: %s" % (e.code, e.read()[:300].decode("utf-8", "replace")))
PY
      hit=""
    else
      hit=" (cached)"
    fi
    ffmpeg -y -v error -i "$cached" -ar 44100 -ac 2 "$BUILD/cue$n.wav" || die "cue $n decode failed"
    printf '  cue %s  %6.2fs%s\n' "$n" "$(dur "$BUILD/cue$n.wav")" "$hit"
  done
fi

# --- 4. record each section --------------------------------------------------
# In order, in one process: sections are NOT independent — a later one types into
# the session an earlier one created.
if [ -z "$SKIP_RECORD" ]; then
  export PATH="$DIR/_bin:$PATH"
  ( cd "$SRC" && [ -x ./setup.sh ] && ./setup.sh ) || true
  # TEARDOWN RUNS EVEN WHEN A SECTION FAILS. It used to sit after the loop, so a
  # `die` mid-record skipped it and left the session — and its live agents —
  # running. Six daemons for one session name piled up that way across failed
  # takes, and the next take attached to whichever answered first, which looks
  # like every other bug in turn: a dead agent, lost keystrokes, a pane that
  # replies to `##new stack 2` in prose. A failed take must leave nothing behind.
  trap '( cd "$SRC" && [ -x ./teardown.sh ] && ./teardown.sh ) || true' EXIT
  for n in $SECTIONS; do
    say "recording section $n ..."
    ( cd "$SRC" && vhs "$BUILD/sec$n.tape" ) >"$BUILD/vhs$n.log" 2>&1 \
      || { tail -20 "$BUILD/vhs$n.log"; die "vhs failed on section $n — see $BUILD/vhs$n.log"; }
    [ -s "$BUILD/sec$n.mp4" ] || die "section $n produced no clip"
  done
  trap - EXIT
  ( cd "$SRC" && [ -x ./teardown.sh ] && ./teardown.sh ) || true
fi

# --- 5. fit each clip to its cue, then concatenate --------------------------
: > "$BUILD/concat.txt"
inputs=(); filters=(); i=0; cursor=0
: > "$BUILD/timeline.tsv"
for n in $SECTIONS; do
  v="$BUILD/sec$n.mp4"; a="$BUILD/cue$n.wav"
  [ -f "$v" ] || die "missing clip $v (drop --skip-record)"
  [ -f "$a" ] || die "missing cue $a (drop --skip-voice)"
  vd=$(dur "$v"); ad=$(dur "$a")
  read -r target stretch <<<"$(python3 -c "
vd, ad, lead, tail, mx = $vd, $ad, $LEAD, $TAIL, $MAX_STRETCH
target = max(vd, lead + ad + tail)
print('%.4f %.4f' % (target, min(mx, target / vd)))")"
  # setpts stretches playback; tpad then freezes the last frame for the remainder.
  ffmpeg -y -v error -i "$v" \
    -vf "setpts=${stretch}*PTS,tpad=stop_mode=clone:stop_duration=600,fps=25" \
    -t "$target" -an -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
    "$BUILD/vid$n.mp4" || die "fit failed on section $n"
  ms=$(python3 -c "print(int($LEAD*1000))")
  ffmpeg -y -v error -i "$a" -af "adelay=$ms|$ms,apad" -t "$target" \
    -ar 44100 -ac 2 "$BUILD/aud$n.wav" || die "cue pad failed on section $n"
  printf "file '%s'\n" "$BUILD/vid$n.mp4" >> "$BUILD/concat.txt"
  inputs+=(-i "$BUILD/aud$n.wav"); filters+=("[$i:a]"); i=$((i+1))
  # remember where this cue actually lands, for the .say the subtitler reads
  printf '%s\t%s\t%s\n' "$n" \
    "$(python3 -c "print('%.3f' % ($cursor + $LEAD))")" \
    "$(python3 -c "print('%.3f' % ($cursor + $LEAD + $ad))")" >> "$BUILD/timeline.tsv"
  cursor=$(python3 -c "print('%.4f' % ($cursor + $target))")
  printf '  section %s  clip %6.2fs  cue %6.2fs  ->  %6.2fs (x%.2f)\n' \
    "$n" "$vd" "$ad" "$target" "$stretch"
done

ffmpeg -y -v error -f concat -safe 0 -i "$BUILD/concat.txt" -c copy "$BUILD/video.mp4" \
  || die "video concat failed"
ffmpeg -y -v error "${inputs[@]}" \
  -filter_complex "${filters[*]}concat=n=$i:v=0:a=1[a]" -map "[a]" "$BUILD/audio.wav" \
  || die "audio concat failed"

# --- 6. loudness ------------------------------------------------------------
# Raw TTS lands around -29 LUFS; web playback sits near -16. That gap is a video
# people turn up and still cannot hear. It cannot be closed with a plain gain —
# +13 dB on a -8 dB peak clips hard — so loudnorm is used, and run TWO-pass: the
# first pass measures, the second corrects against those measurements. One-pass
# loudnorm works off a running estimate and pumps on speech with long silences,
# which narration over a terminal recording is full of.
say "normalising loudness to ${TARGET_I} LUFS"
measured=$(ffmpeg -hide_banner -nostats -i "$BUILD/audio.wav" \
  -af "loudnorm=I=$TARGET_I:TP=$TARGET_TP:LRA=11:print_format=json" -f null - 2>&1 \
  | sed -n '/^{/,/^}/p')
mi=$(printf '%s' "$measured"  | sed -n 's/.*"input_i" *: *"\([^"]*\)".*/\1/p')
mtp=$(printf '%s' "$measured" | sed -n 's/.*"input_tp" *: *"\([^"]*\)".*/\1/p')
mlra=$(printf '%s' "$measured"| sed -n 's/.*"input_lra" *: *"\([^"]*\)".*/\1/p')
mth=$(printf '%s' "$measured" | sed -n 's/.*"input_thresh" *: *"\([^"]*\)".*/\1/p')
[ -n "$mi" ] || die "loudnorm measurement pass produced no JSON"
ffmpeg -y -v error -i "$BUILD/audio.wav" \
  -af "loudnorm=I=$TARGET_I:TP=$TARGET_TP:LRA=11:measured_I=$mi:measured_TP=$mtp:measured_LRA=$mlra:measured_thresh=$mth:linear=true" \
  -ar 44100 -ac 2 "$BUILD/audio.norm.wav" || die "loudnorm failed"
ffmpeg -y -v error -i "$BUILD/audio.norm.wav" -c:a libmp3lame -b:a 192k "$BUILD/narration.mp3" \
  || die "narration mp3 failed"
say "narration $mi LUFS -> $TARGET_I LUFS"

# --- 7. mux ------------------------------------------------------------------
ffmpeg -y -v error -i "$BUILD/video.mp4" -i "$BUILD/audio.norm.wav" \
  -c:v copy -c:a aac -b:a 160k -shortest "$BUILD/voiced.mp4" || die "mux failed"

# --- 8. subtitles ------------------------------------------------------------
# Timings from Deepgram (only the audio knows when a word was really said);
# WORDS from the narration script (a transcript of synthetic speech is still a
# transcript, and a subtitle that says something the script does not is worse
# than no subtitle at all). srt_from_deepgram.py aligns the two with difflib.
say "timing subtitles with deepgram"
python3 - "$BUILD/timeline.tsv" "$BUILD/cues" "$BUILD/narration.say" <<'PY' || die "say build failed"
import sys, os
tl, cues, out = sys.argv[1:4]
def stamp(t):
    t = float(t); return "%02d:%02d.%03d" % (int(t)//60, int(t)%60, round((t-int(t))*1000))
with open(out, "w") as f:
    f.write("# generated by make-demo.sh — words for the subtitler, timings are Deepgram's\n\n")
    for line in open(tl):
        n, a, b = line.rstrip("\n").split("\t")
        text = open(os.path.join(cues, "cue%s.txt" % n)).read().strip()
        f.write("[%s --> %s]\n%s\n\n" % (stamp(a), stamp(b), text))
PY
SRTGEN="$DIR/../agent-board-fleet/voiceover/srt_from_deepgram.py"
[ -f "$SRTGEN" ] || die "subtitle generator not found: $SRTGEN"
( cd "$BUILD" && python3 "$SRTGEN" narration.mp3 narration.say ${DG_REUSE:+--reuse} ) \
  || die "deepgram subtitle pass failed"
[ -f "$BUILD/narration.srt" ] || die "no SRT produced"
cp "$BUILD/narration.srt" "$SRT"

# Soft subtitle track: selectable in a player, does not touch a pixel.
ffmpeg -y -v error -i "$BUILD/voiced.mp4" -i "$SRT" -c copy -c:s mov_text \
  -metadata:s:s:0 language=eng "$SOFT" || die "soft-sub mux failed"
say "voiced master (soft subs): $SOFT"

# --- 9. burned-in subtitles --------------------------------------------------
# Via an ASS file with an EXPLICIT PlayRes, not `subtitles=...:force_style`.
# ffmpeg converts SRT to ASS at a default script resolution of 384x288, and
# libass then scales every size by 1080/288 = 3.75 — so `Fontsize=21` renders at
# about 79 pixels, subtitles that cover three panes. Sizes only mean anything
# once the script resolution matches the video; then they are plain pixels.
say "burning in subtitles"
ASS="$BUILD/subs.ass"
ffmpeg -y -v error -i "$SRT" "$ASS" || die "ass conversion failed"
python3 - "$ASS" <<'PY'
import re, sys
p = sys.argv[1]; s = open(p).read()
s = re.sub(r"^PlayResX:.*$", "PlayResX: 1920", s, flags=re.M)
s = re.sub(r"^PlayResY:.*$", "PlayResY: 1080", s, flags=re.M)
if "PlayResX" not in s:
    s = s.replace("[Script Info]", "[Script Info]\nPlayResX: 1920\nPlayResY: 1080", 1)
# Fields: Fontname,Fontsize,Primary,Secondary,Outline,Back,Bold,...,
# BorderStyle,Outline,Shadow,Alignment,MarginL,MarginR,MarginV,Encoding
#
# BorderStyle 3 = opaque BOX behind the text, filled with BackColour, instead of
# an outline. &H40000000 is 75% opaque black. An outline alone disappears into a
# terminal recording the moment the text lands on a pane border or a status line.
#
# MarginV 60, not 14. At 14 the text sits on the very bottom edge — which is
# exactly where every video player draws its scrub bar and time code, so the
# subtitles were being covered by the player chrome rather than being absent.
# 60 clears it and still sits below rysh's own status line.
style = ("Style: Default,Helvetica,40,&H00FFFFFF,&H000000FF,&H00000000,&H40000000,"
         "1,0,0,0,100,100,0,0,3,3,0,2,60,60,60,1")
s = re.sub(r"^Style: Default,.*$", style, s, flags=re.M)
open(p, "w").write(s)
PY
ffmpeg -y -v error -i "$SOFT" -vf "ass=$ASS" \
  -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p -c:a copy "$OUT" \
  || die "burn-in failed"
say "burned-in subs: $OUT"

printf '\n1x master  %s  %.1fs  (%s bytes)\n' "$(basename "$OUT")" "$(dur "$OUT")" "$(wc -c < "$OUT" | tr -d ' ')"

# --- 10. the shipping cut -----------------------------------------------------
# Re-timed here rather than by hand, so `out/<demo>.mp4` is never a 1x file left
# behind by a rebuild. speed-up.sh also rewrites the .srt timestamps and rebuilds
# the burned-in cut from them — an ffmpeg filter cannot re-time a subtitle
# stream, and captions that drift are worse than none.
# NOT named SPEED: that is already taken, above, for how fast the narrator
# SPEAKS at synthesis time. One name for both would mean asking for a 1.5x
# playback cut and silently getting a chipmunk voice-over as well.
PLAYBACK="${PLAYBACK:-1.5}"
if [ "$PLAYBACK" = "1" ] || [ "$PLAYBACK" = "1.0" ]; then
  say "PLAYBACK=$PLAYBACK — shipping the master as recorded"
  cp "$OUT" "$DIR/out/$DEMO.mp4"; cp "$SOFT" "$DIR/out/$DEMO.softsubs.mp4"; cp "$SRT" "$DIR/out/$DEMO.srt"
else
  "$DIR/speed-up.sh" "$PLAYBACK" "$DEMO" || die "speed-up failed"
fi
printf 'shipping   %s  %.1fs\n' "$DEMO.mp4" "$(dur "$DIR/out/$DEMO.mp4")"
