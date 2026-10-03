#!/usr/bin/env bash
#
# wait_load_render.sh — WO-3a: render the August story-019 control only when the
# box is NATURALLY loaded (1-min load >= MIN_LOAD). It generates no load itself:
# it polls `sysctl -n vm.loadavg` at most once a minute and otherwise sleeps.
#
# Each render is one `render_control_isolated.sh render <tape> 1` call, so the
# live-session-list isolation proof is repeated before every run. Rows go to
# RESULTS (default: out/wo3a-raw.tsv); the caller decides which rows qualify
# (load_before as recorded by the render script itself, >= MIN_LOAD).
#
# Usage: DEADLINE_EPOCH=<unix-ts> ./wait_load_render.sh
set -uo pipefail

TAPES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TAPE="$TAPES_DIR/control-aug/story-019-stacked-panes.tape"
MIN_LOAD="${MIN_LOAD:-60}"
WANT="${WANT:-3}"
DEADLINE_EPOCH="${DEADLINE_EPOCH:?set DEADLINE_EPOCH}"
export RESULTS="${RESULTS:-$TAPES_DIR/out/wo3a-raw.tsv}"
LOG="${LOG:-$TAPES_DIR/out/wo3a-wait.log}"

load1() { sysctl -n vm.loadavg | awk '{print $2}'; }
qualifying() { [ -s "$RESULTS" ] && awk -F'\t' -v m="$MIN_LOAD" 'NR>1 && $4!="FAIL" && $9+0>=m' "$RESULTS" | wc -l | tr -d ' ' || echo 0; }

while :; do
  q=$(qualifying)
  [ "$q" -ge "$WANT" ] && { echo "$(date '+%F %T') done: $q qualifying runs" | tee -a "$LOG"; exit 0; }
  [ "$(date +%s)" -ge "$DEADLINE_EPOCH" ] && { echo "$(date '+%F %T') DEADLINE: $q qualifying runs" | tee -a "$LOG"; exit 0; }
  l=$(load1)
  echo "$(date '+%F %T') load1=$l qualifying=$q" >> "$LOG"
  if awk -v l="$l" -v m="$MIN_LOAD" 'BEGIN{exit !(l>=m)}'; then
    echo "$(date '+%F %T') load $l >= $MIN_LOAD — rendering" | tee -a "$LOG"
    "$TAPES_DIR/render_control_isolated.sh" render "$TAPE" 1 >> "$LOG" 2>&1
    echo "$(date '+%F %T') render exit=$?" | tee -a "$LOG"
    grep -q 'BLOCKED\|WARNING: live list changed' "$LOG" && { echo "ISOLATION FAILURE — stopping" | tee -a "$LOG"; exit 3; }
  fi
  sleep 60
done
