#!/usr/bin/env bash
#
# capture-slack-ad07.sh — region-capture the Slack (Chrome) window for ad07.
#
# ⚠️ PRIVACY RULE (cost a near-miss once): region-capture ONLY the app window,
#    NEVER the full desktop. This script positions Chrome at a known rect and
#    records ONLY the web-content region (browser chrome cropped out).
#
# Choreography for the LIVE take (wall-clock from vhs launch T0; timings from
# dry-run 4, tape total 95.3s, vhs boot ~7.5s):
#   T0+55   post Q1 in #support: "@Rysh when does the staging release freeze start?"
#   T0+70   terminal types "send" (tape) → approved reply posts ~T0+72-75
#   T0+77   click Q1's "1 reply" → thread shows the single approved reply
#   T0+85   post Q2: "@Rysh how do I install nwcli?"  (governance=ai by now)
#   T0+97   click Q2's thread → auto-reply visible
#   T0+115  capture ends
#
# Usage: bash capture-slack-ad07.sh <duration-seconds> [outfile]
#
set -euo pipefail

DUR="${1:-115}"
OUT="${2:-$(dirname "$0")/render-sandbox-ad07/slack-side-ad07.mov}"

# Position Chrome: window at (40,40) sized 1440x980 → content region below
# browser chrome (~80pt) captured at 1440x900.
osascript -e 'tell application "Google Chrome"
  activate
  set bounds of front window to {40, 40, 1480, 1020}
end tell'
sleep 1

# Screenshot-check the region BEFORE recording (QC rule from the checklist).
screencapture -x -R40,120,1440,900 "${OUT%.mov}-region-check.png"
echo "[check] region still: ${OUT%.mov}-region-check.png — LOOK at it before the take"

echo "[capture] recording ${DUR}s of region 40,120 1440x900 → $OUT"
screencapture -v -V"$DUR" -R40,120,1440,900 "$OUT"
echo "[capture] done → $OUT"
