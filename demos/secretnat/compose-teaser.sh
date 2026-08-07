#!/usr/bin/env bash
# Teaser (~28s): title card -> ##snat status -> paste+answer -> grep reveal -> end card.
# Segments cut to their own files (VFR-safe) then concat with the concat demuxer.
set -euo pipefail
T="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../tapes" && pwd)"
MAIN="$T/render-sandbox/demo-snat/story-ad11-secretnat.mp4"
VO="$T/say/story-ad11-teaser.mp3"
TITLE="$T/cards/title-ad11.png"
END="$T/cards/end-ad11.png"
OUT="$T/out"
TMP=$(mktemp -d)

enc="-r 30 -c:v libx264 -crf 20 -preset medium -pix_fmt yuv420p"

echo "== title (2.5s) + end (3s) cards =="
ffmpeg -y -loglevel error -loop 1 -t 2.5 -i "$TITLE" -vf "scale=1920:1080,format=yuv420p" $enc "$TMP/00_title.mp4"
ffmpeg -y -loglevel error -loop 1 -t 3   -i "$END"   -vf "scale=1920:1080,format=yuv420p" $enc "$TMP/99_end.mp4"

echo "== cut demo segments (own files) — timestamps for the 80.9s cut =="
# ##snat status view
ffmpeg -y -loglevel error -ss 10 -t 5 -i "$MAIN" -vf "scale=1920:1080,format=yuv420p" $enc -an "$TMP/10_status.mp4"
# ##snat get reveal (you unmask it locally — the model only saw the token)
ffmpeg -y -loglevel error -ss 52 -t 5 -i "$MAIN" -vf "scale=1920:1080,format=yuv420p" $enc -an "$TMP/20_answer.mp4"
# grep reveal (money shot) — held
ffmpeg -y -loglevel error -ss 68 -t 11 -i "$MAIN" -vf "scale=1920:1080,format=yuv420p" $enc -an "$TMP/30_grep.mp4"

echo "== concat =="
for f in 00_title 10_status 20_answer 30_grep 99_end; do echo "file '$TMP/$f.mp4'"; done > "$TMP/list.txt"
ffmpeg -y -loglevel error -f concat -safe 0 -i "$TMP/list.txt" -c copy "$TMP/silent.mp4"

echo "== mux teaser VO =="
ffmpeg -y -loglevel error -i "$TMP/silent.mp4" -i "$VO" \
  -map 0:v -map 1:a -c:v copy -c:a aac -b:a 192k "$OUT/story-ad11-secretnat-teaser.mp4"

DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$OUT/story-ad11-secretnat-teaser.mp4")
echo "== teaser done: $OUT/story-ad11-secretnat-teaser.mp4 (${DUR}s) =="
rm -rf "$TMP"
