#!/usr/bin/env bash
# Record the agent-board-fleet demo, end to end.
#
#   ./record.sh                 # full take: reset, build, film, verify, trim
#   ./record.sh --no-reset      # film against the session that is already up
#
# Output: _run/agent-board-fleet-codex.mp4 (raw) and out/agent-board-fleet-codex.mp4 (trimmed).
set -uo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"
export PATH="$DIR/_bin:$PATH"

SESSION=codexfleet
RAW=_run/agent-board-fleet-codex.mp4
OUT=out/agent-board-fleet-codex.mp4

say() { printf '\033[32m[record]\033[0m %s\n' "$*"; }
die() { printf '\033[31m[record]\033[0m %s\n' "$*" >&2; exit 1; }

command -v vhs   >/dev/null || die "vhs is not installed (github.com/charmbracelet/vhs)"
command -v ttyd  >/dev/null || die "ttyd is not installed — vhs needs it"
command -v ffmpeg >/dev/null || die "ffmpeg is not installed — vhs needs it"

if [ "${1:-}" != "--no-reset" ]; then
  say "building a clean session"
  ./setup-session.sh >_run/setup.log 2>&1 || { cat _run/setup.log; die "setup failed"; }
  say "layout up, board empty"
fi

# The tape starts the fleet itself and then attaches, so the camera is already
# rolling when the first post lands. Nothing here touches the session.
say "rolling (about 6 minutes)"
mkdir -p out
vhs agent-board-fleet-codex.tape >_run/vhs.log 2>&1 || { tail -20 _run/vhs.log; die "vhs failed"; }
[ -f "$RAW" ] || die "vhs produced no file"
say "raw take: $RAW"

# --- did the take actually capture a finished run? ------------------------
# The board is the only honest answer. A file of the right length proves the
# camera ran, not that the fleet did anything.
posts=$(rysh board tail --session "$SESSION" --limit 80 2>/dev/null)
signoffs=$(printf '%s\n' "$posts" | grep -c 'my task is finished')
if printf '%s\n' "$posts" | grep -q 'DEMO COMPLETE'; then
  say "run finished: DEMO COMPLETE on the board, $signoffs/4 sign-offs"
  complete=1
else
  say "WARNING: the board never reached DEMO COMPLETE ($signoffs/4 sign-offs)."
  say "         The file is a take of an unfinished run — re-record before using it."
  complete=0
fi

# --- trim the static tail --------------------------------------------------
# By FRAMES, never by wall clock: vhs drops frames unevenly under load, so the
# tape's Sleep values do not map onto timestamps in the output (showcase.tape).
# freezedetect finds where the picture stopped changing; everything after that
# plus a beat of hold is dead air.
say "finding the end of the action"
dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$RAW" | cut -d. -f1)
freeze=$(ffmpeg -hide_banner -i "$RAW" -vf "freezedetect=n=0.002:d=6" -map 0:v -f null - 2>&1 \
         | sed -n 's/.*freeze_start: \([0-9.]*\).*/\1/p' | tail -1)

if [ -n "$freeze" ]; then
  end=$(awk -v f="$freeze" 'BEGIN{printf "%.2f", f+5}')
  keep=$(awk -v e="$end" 'BEGIN{printf "%d", e}')
  if [ "$keep" -ge 60 ]; then
    ffmpeg -hide_banner -loglevel error -y -i "$RAW" -t "$end" -c copy "$OUT" \
      && say "trimmed ${dur}s -> ${keep}s  ->  $OUT"
  else
    say "freeze at ${freeze}s is too early to trust — keeping the full take"
    cp "$RAW" "$OUT"
  fi
else
  say "no static tail found — keeping the full take"
  cp "$RAW" "$OUT"
fi

say "done: $OUT"
[ "$complete" -eq 1 ] || exit 1
