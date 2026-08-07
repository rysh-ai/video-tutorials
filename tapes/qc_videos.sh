#!/usr/bin/env bash
# qc_videos.sh — quality gate for the 111 final voiced tutorial videos.
#
# Verifies, for every tapes/final/story-NNN-*.vover.mp4:
#   1. an audio stream exists
#   2. the SOURCE narration (say/<story>.mp3) fits the video within TOL seconds
#   3. audio is non-silent (mean volume above SILENCE_DB)
#   4. resolution matches the expected WxH
#
# Prints a per-file table and a PASS/FAIL summary. Exit 1 if any check fails,
# so it can gate publishing in CI.
#
# Check 2 deliberately measures the source mp3, not the muxed audio track.
# merge_voiceover.py runs ffmpeg with -shortest, so the muxed audio is always
# truncated to the video length — comparing it against the video is tautological
# and passes even when most of the narration was thrown away. Measuring the
# source mp3 is what actually catches a demo that races ahead of its voiceover.
#
# Usage: ./qc_videos.sh [final_dir] [say_dir]
set -euo pipefail

DIR="${1:-$(dirname "$0")/final}"
SAY_DIR="${2:-$(dirname "$0")/say}"
TOL="${TOL:-1.0}"          # max |narration-video| duration delta (seconds)
SILENCE_DB="${SILENCE_DB:--50}"  # mean_volume must be louder than this (dB)
EXP_W="${EXP_W:-1920}"
EXP_H="${EXP_H:-1080}"

pass=0; fail=0; failed_list=()

printf '%-44s %7s %7s %8s %9s %-5s\n' "FILE" "VIDEO" "NARR" "MEANdB" "RES" "OK"
printf '%.0s-' {1..86}; echo

for f in "$DIR"/story-[0-9][0-9][0-9]-*.vover.mp4; do
  [ -e "$f" ] || { echo "no files in $DIR"; exit 1; }
  name=$(basename "$f")
  reasons=()

  vdur=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of csv=p=0 "$f" 2>/dev/null || echo "")
  adur=$(ffprobe -v error -select_streams a:0 -show_entries stream=duration -of csv=p=0 "$f" 2>/dev/null || echo "")
  res=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0:s=x "$f" 2>/dev/null || echo "")

  [ -z "$adur" ] && reasons+=("no-audio")

  # Compare the video against the SOURCE narration, not the muxed track — the
  # muxed track is -shortest-truncated to the video and so always "matches".
  src="$SAY_DIR/${name%.vover.mp4}.mp3"
  if [ -f "$src" ]; then
    ndur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$src" 2>/dev/null || echo "")
  else
    ndur=""
    reasons+=("no-source-mp3")
  fi

  if [ -n "$vdur" ] && [ -n "$ndur" ]; then
    delta=$(awk -v a="$ndur" -v v="$vdur" 'BEGIN{d=a-v; if(d<0)d=-d; printf "%.3f", d}')
    over=$(awk -v d="$delta" -v t="$TOL" 'BEGIN{print (d>t)?1:0}')
    [ "$over" = "1" ] && reasons+=("narration-overruns-video-by=${delta}s")
  fi

  # NOTE: the bracket class is deliberate — BSD/macOS sed has no \? operator, so
  # the GNU-only 's/...\(-\?[0-9.]*\)...' this used to carry never matched here
  # and every file failed with "no-meandB", i.e. the silence check never ran.
  mean=$(ffmpeg -hide_banner -nostats -i "$f" -af volumedetect -f null /dev/null 2>&1 \
         | sed -n 's/.*mean_volume: \([-0-9.]*\) dB.*/\1/p' | head -1)
  if [ -n "$mean" ]; then
    quiet=$(awk -v m="$mean" -v s="$SILENCE_DB" 'BEGIN{print (m<s)?1:0}')
    [ "$quiet" = "1" ] && reasons+=("silent(${mean}dB)")
  else
    reasons+=("no-meandB")
  fi

  [ -n "$res" ] && [ "$res" != "${EXP_W}x${EXP_H}" ] && reasons+=("res=$res")

  if [ ${#reasons[@]} -eq 0 ]; then ok="OK"; pass=$((pass+1)); else ok="FAIL"; fail=$((fail+1)); failed_list+=("$name: ${reasons[*]}"); fi
  printf '%-44s %7s %7s %8s %9s %-5s\n' "$name" "${vdur:-?}" "${ndur:-?}" "${mean:-?}" "${res:-?}" "$ok"
done

echo
echo "==== QC SUMMARY: $pass passed, $fail failed ===="
if [ "$fail" -gt 0 ]; then
  printf '%s\n' "${failed_list[@]}"
  exit 1
fi
echo "All voiced videos passed the quality gate."
