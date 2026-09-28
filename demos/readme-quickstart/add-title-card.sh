#!/usr/bin/env bash
# Prepend each video's own thumbnail as a title card.
#
#   ./add-title-card.sh [seconds]      default 2
#
# WHY. GitHub renders <video> in its own player and that player previews the
# FIRST FRAME. There is no other lever: it strips the `poster` attribute
# (tested), and an <img> beside the player cannot stand in for one — GitHub
# auto-wraps every image in a link to itself, so clicking the picture opens the
# picture, never the player. Baking the thumbnail into frame 0 is the only way a
# single element is both thumbnail and player.
#
# Subtitles shift with it, or the captions run ahead of the picture all the way
# through.
set -uo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
CARD="${1:-2}"
SRC="$DIR/out"
THUMBS="$DIR/.thumbs"
DEST="$HOME/Downloads/rysh-video-tutorials/with-thumbnail"
mkdir -p "$DEST"
die() { printf '\033[31m[card]\033[0m %s\n' "$*" >&2; exit 1; }

for f in "$SRC"/0*.mp4; do
  b="$(basename "$f" .mp4)"; case "$b" in *.softsubs) continue;; esac
  png="$THUMBS/$b.png"
  [ -f "$png" ] || die "no thumbnail for $b at $png"
  tmp="$(mktemp -d)"

  # The card is encoded to the SAME shape as the video (1920x1080, 25fps,
  # yuv420p, 44.1k stereo). concat refuses streams that disagree, and a subtle
  # mismatch surfaces as A/V drift rather than as an error.
  ffmpeg -y -v error -loop 1 -t "$CARD" -i "$png" \
    -f lavfi -t "$CARD" -i anullsrc=channel_layout=stereo:sample_rate=44100 \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,fps=25,format=yuv420p" \
    -c:v libx264 -preset medium -crf 20 -c:a aac -b:a 160k -shortest "$tmp/card.mp4" || die "card: $b"

  ffmpeg -y -v error -i "$tmp/card.mp4" -i "$f" \
    -filter_complex "[0:v][0:a][1:v][1:a]concat=n=2:v=1:a=1[v][a]" -map "[v]" -map "[a]" \
    -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p -c:a aac -b:a 160k \
    "$DEST/$b.mp4" || die "concat: $b"

  python3 - "$SRC/$b.srt" "$DEST/$b.srt" "$CARD" <<'PY'
import re, sys
src, dst, shift = sys.argv[1], sys.argv[2], float(sys.argv[3])
def t(h, mi, s, ms):
    x = int(h)*3600 + int(mi)*60 + int(s) + int(ms)/1000.0 + shift
    return "%02d:%02d:%02d,%03d" % (x//3600, (x % 3600)//60, x % 60, round((x-int(x))*1000))
pat = re.compile(r"(\d{2}):(\d{2}):(\d{2}),(\d{3}) --> (\d{2}):(\d{2}):(\d{2}),(\d{3})")
open(dst, "w").write(pat.sub(lambda m: t(*m.groups()[:4]) + " --> " + t(*m.groups()[4:]),
                             open(src).read()))
PY
  rm -rf "$tmp"
  printf '  %-28s %6.1fs -> %6.1fs\n' "$b" \
    "$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$f")" \
    "$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$DEST/$b.mp4")"
done
printf '\033[36m[card]\033[0m ready to upload: %s\n' "$DEST"
