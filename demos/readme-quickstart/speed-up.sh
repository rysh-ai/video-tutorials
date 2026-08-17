#!/usr/bin/env bash
# Re-time a finished demo to a playback factor. Default 1.5x.
#
#   ./speed-up.sh                 # every demo in out/1x, at 1.5x
#   ./speed-up.sh 1.25            # a different factor
#   ./speed-up.sh 1.5 02-stop-start
#
# The 1x masters live in out/1x/ and are READ ONLY here. The sped-up files take
# the plain names in out/, because those are the ones that get uploaded — the
# paths do not change when the factor does.
#
# PLAIN NAME = SUBTITLES BURNED IN. A soft track is off by default in most
# players, so a file that technically "has subtitles" opens without any. The
# selectable-track version keeps the .softsubs suffix; upload that one to YouTube
# with the .srt beside it, where its own captions render better than baked pixels.
#
# WHY NOT JUST setpts. Three streams carry time and all three have to move
# together, or the result is worse than the original:
#
#   video     setpts=PTS/F        drops nothing; it re-stamps every frame
#   audio     atempo=F            changes tempo WITHOUT changing pitch. A naive
#                                 rate change would raise the narrator a fifth at
#                                 1.5x. atempo is limited to 0.5–2.0 per instance,
#                                 so factors outside that are chained below.
#   subtitles timestamps ÷ F      ffmpeg filters do not touch a subtitle stream,
#                                 so the .srt is rewritten here and re-muxed. Skip
#                                 this and the captions drift a third of the way
#                                 out by the end — worse than having none, because
#                                 they are confidently wrong.
#
# The burned-in cut is rebuilt from the re-timed SRT rather than sped up itself:
# text that has already been rasterised into the picture cannot be re-timed, and
# scaling it would just blur it.
set -uo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"
F="${1:-1.5}"
ONE="$DIR/out/1x"
OUT="$DIR/out"

say() { printf '\033[36m[speed]\033[0m %s\n' "$*"; }
die() { printf '\033[31m[speed]\033[0m %s\n' "$*" >&2; exit 1; }

command -v ffmpeg >/dev/null || die "ffmpeg is not installed"
[ -d "$ONE" ] || die "no 1x masters at $ONE"
python3 -c "import sys; sys.exit(0 if float('$F') > 0 else 1)" 2>/dev/null \
  || die "factor must be a positive number (got '$F')"

# atempo only accepts 0.5–2.0, so decompose the factor into a chain that multiplies out.
ATEMPO=$(python3 -c "
f=float('$F'); parts=[]
while f > 2.0: parts.append(2.0); f/=2.0
while f < 0.5: parts.append(0.5); f/=0.5
parts.append(f)
print(','.join('atempo=%.6f' % p for p in parts))")

shift 2>/dev/null || true
DEMOS=("$@")
if [ ${#DEMOS[@]} -eq 0 ]; then
  DEMOS=()
  for m in "$ONE"/*.mp4; do
    b="$(basename "$m" .mp4)"; case "$b" in *.softsubs) continue;; esac
    DEMOS+=("$b")
  done
fi
[ ${#DEMOS[@]} -gt 0 ] || die "nothing to re-time in $ONE"

dur() { ffprobe -v error -show_entries format=duration -of csv=p=0 "$1"; }

for d in "${DEMOS[@]}"; do
  srt1="$ONE/$d.srt"
  [ -f "$srt1" ] || die "missing 1x subtitles: $srt1"

  # TWO KINDS OF MASTER, and telling them apart is what stops a double burn.
  #
  #   soft master (<d>.softsubs.mp4 present) — subtitles are a TRACK. `-sn` drops
  #     it cleanly and the burn at the end paints them on once, in this repo's
  #     style. That is how demos 1-4 are built.
  #
  #   pre-burned master (only <d>.mp4) — subtitles are already PIXELS, made by
  #     another pipeline. They stretch with the picture and stay in sync for
  #     free. Burning again would lay a second copy on top of the first, so the
  #     burn step is skipped and its style is left as its author made it.
  if [ -f "$ONE/$d.softsubs.mp4" ]; then
    src="$ONE/$d.softsubs.mp4"; preburned=""
  elif [ -f "$ONE/$d.mp4" ]; then
    src="$ONE/$d.mp4"; preburned=yes
  else
    die "no 1x master for $d in $ONE"
  fi
  say "$d at ${F}x${preburned:+ (pre-burned master — subtitles ride the picture)}"

  # 1. subtitles first — the mux below needs them
  python3 - "$srt1" "$OUT/$d.srt" "$F" <<'PY'
import re, sys
src, dst, f = sys.argv[1], sys.argv[2], float(sys.argv[3])
def scale(m):
    def t(h, mi, s, ms):
        total = (int(h)*3600 + int(mi)*60 + int(s) + int(ms)/1000.0) / f
        h2 = int(total//3600); mi2 = int((total%3600)//60)
        s2 = int(total%60);    ms2 = round((total - int(total))*1000)
        if ms2 == 1000: s2 += 1; ms2 = 0
        return "%02d:%02d:%02d,%03d" % (h2, mi2, s2, ms2)
    return t(*m.groups()[:4]) + " --> " + t(*m.groups()[4:])
pat = re.compile(r"(\d{2}):(\d{2}):(\d{2}),(\d{3}) --> (\d{2}):(\d{2}):(\d{2}),(\d{3})")
open(dst, "w").write(pat.sub(scale, open(src).read()))
PY

  # 2. picture and narration, together, subtitles dropped for now (-sn)
  tmp="$OUT/.$d.speed.mp4"
  ffmpeg -y -v error -i "$src" \
    -filter:v "setpts=PTS/$F" -filter:a "$ATEMPO" \
    -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
    -c:a aac -b:a 160k -sn "$tmp" || die "re-time failed on $d"

  if [ -n "$preburned" ]; then
    mv "$tmp" "$OUT/$d.mp4"
    printf '  %-32s %6.1fs -> %6.1fs  (subtitles already burned by its own pipeline)\n' \
      "$d" "$(dur "$src")" "$(dur "$OUT/$d.mp4")"
    continue
  fi

  # 3. soft subtitle track back on
  ffmpeg -y -v error -i "$tmp" -i "$OUT/$d.srt" -c copy -c:s mov_text \
    -metadata:s:s:0 language=eng "$OUT/$d.softsubs.mp4" || die "soft-sub mux failed on $d"
  rm -f "$tmp"

  # 4. burned-in cut, rebuilt from the RE-TIMED srt (see the header note)
  ASS="$OUT/.$d.ass"
  ffmpeg -y -v error -i "$OUT/$d.srt" "$ASS" || die "ass conversion failed on $d"
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
  ffmpeg -y -v error -i "$OUT/$d.softsubs.mp4" -vf "ass=$ASS" \
    -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p -c:a copy \
    "$OUT/$d.mp4" || die "burn-in failed on $d"
  rm -f "$ASS"

  printf '  %-32s %6.1fs -> %6.1fs\n' "$d" "$(dur "$src")" "$(dur "$OUT/$d.mp4")"
done

say "1x masters untouched in out/1x/"
