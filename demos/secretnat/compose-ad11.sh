#!/usr/bin/env bash
# Compose the final ad11 video: title-card overlay (fade out) on the opening,
# an appended end card, and the timed voiceover. Keeps the grep money-shot
# visible during the closing narration (end card is appended, not overlaid).
set -euo pipefail
T=/Users/halilagin/root/github/agentic-zellij/video-tutorials/tapes
MAIN="$T/render-sandbox/demo-snat/story-ad11-secretnat.mp4"
VO="$T/say/story-ad11-secretnat.mp3"
TITLE="$T/cards/title-ad11.png"
END="$T/cards/end-ad11.png"
OUT="$T/out"
TMP=$(mktemp -d)
mkdir -p "$OUT"

echo "== title overlay (fade out 2.3-3.0s) =="
ffmpeg -y -loglevel error -i "$MAIN" -i "$TITLE" -filter_complex \
  "[1]format=rgba,fade=t=out:st=2.3:d=0.7:alpha=1[t];[0][t]overlay=0:0:enable='lte(t,3)',format=yuv420p" \
  -r 30 -c:v libx264 -crf 20 -preset medium -an "$TMP/titled.mp4"

echo "== end card clip (4s) =="
ffmpeg -y -loglevel error -loop 1 -t 4 -i "$END" \
  -vf "scale=1920:1080,format=yuv420p" -r 30 -c:v libx264 -crf 20 -preset medium "$TMP/end.mp4"

echo "== concat main + end =="
ffmpeg -y -loglevel error -i "$TMP/titled.mp4" -i "$TMP/end.mp4" -filter_complex \
  "[0:v][1:v]concat=n=2:v=1:a=0[v]" -map "[v]" -r 30 -c:v libx264 -crf 20 -preset medium "$TMP/silent.mp4"

echo "== mux voiceover =="
ffmpeg -y -loglevel error -i "$TMP/silent.mp4" -i "$VO" \
  -map 0:v -map 1:a -c:v copy -c:a aac -b:a 192k "$OUT/story-ad11-secretnat.vover.mp4"

DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$OUT/story-ad11-secretnat.vover.mp4")
echo "== done: $OUT/story-ad11-secretnat.vover.mp4  (${DUR}s) =="
rm -rf "$TMP"
