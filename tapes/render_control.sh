#!/usr/bin/env bash
#
# render_control.sh — render named tapes UNMODIFIED and measure what came out.
#
# This is the T2 calibration harness. render_all.sh renders the whole corpus and
# records only OK/FAIL; this one renders a named few and records the three
# numbers T1's re-timing model needs:
#
#   static budget   sum of Sleep + typing cost          (tape_budget.py)
#   wall time       how long the render actually took   (SECONDS)
#   real duration   what ffprobe reports about the mp4  (the ground truth)
#
# plus the 1-minute load average before and after each render, because VHS
# output length shrinks under machine load (E5 work order, §3) — a duration
# with no load reading beside it is not a measurement, it is an anecdote.
#
# The tapes are rendered BYTE-FOR-BYTE as committed. Nothing here edits a tape;
# they are the control.
#
# Usage:
#   ./render_control.sh story-019-stacked-panes story-050-editing-files
#   RESULTS=/tmp/r.tsv ./render_control.sh story-001-what-is-rysh
set -uo pipefail

TAPES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SANDBOX="$TAPES_DIR/render-sandbox"
OUT_DIR="$TAPES_DIR/out"
RYSH_BIN="${RYSH_BIN:-$SANDBOX/bin/rysh}"
RESULTS="${RESULTS:-$TAPES_DIR/render-control-results.tsv}"
LOG="${LOG:-$TAPES_DIR/render-control.log}"

[ "$#" -gt 0 ] || { echo "usage: $0 <tape-basename> [<tape-basename> ...]"; exit 2; }

# The sandbox build goes first on PATH so the tapes' typed `rysh` is the binary
# we just built, never some stale copy from the founder's shell.
export PATH="$SANDBOX/bin:$PATH"

if ! "$TAPES_DIR/check_render_prereqs.sh" >/dev/null 2>&1; then
  echo "FATAL: prerequisites not met — run ./check_render_prereqs.sh to see which"
  exit 1
fi

load1() { uptime | sed 's/.*load averages*: //' | awk '{print $1}'; }

mkdir -p "$OUT_DIR" "$SANDBOX"
# Some tapes cat these fixtures. Seed them only when ABSENT — render_all.sh:26
# does an unconditional `cp -f`, which silently overwrites the sandbox's own
# tracked hello.go with tapes/hello.go and leaves the repo dirty after every
# render. Copy-if-missing gives the same guarantee without the churn.
for fixture in hello.go hello.txt; do
  [ -e "$SANDBOX/$fixture" ] || cp "$TAPES_DIR/$fixture" "$SANDBOX/" 2>/dev/null || true
done

[ -s "$RESULTS" ] || printf 'tape\tstatic_budget_s\twall_s\treal_duration_s\tdrift_ratio\tload_before\tload_after\trc\n' > "$RESULTS"
: > "$LOG"

for base in "$@"; do
  tape="$TAPES_DIR/tape/$base.tape"
  if [ ! -f "$tape" ]; then echo "skip: no such tape $tape"; continue; fi

  budget=$(python3 "$TAPES_DIR/tape_budget.py" "$tape" --tsv | awk 'NR==2{print $5}')
  sess="${base:0:9}"          # story-019 — one session per tape, as render_all.sh does

  "$RYSH_BIN" delete-session "$sess" >/dev/null 2>&1
  rm -f "$SANDBOX/$base.mp4" "$SANDBOX/$base.gif"

  lb=$(load1)
  echo "=== $base  budget=${budget}s  load_before=$lb ===" | tee -a "$LOG"

  start=$SECONDS
  ( cd "$SANDBOX" && RYSH_SESSION="$sess" vhs "$tape" ) >>"$LOG" 2>&1
  rc=$?
  wall=$((SECONDS - start))
  la=$(load1)

  "$RYSH_BIN" delete-session "$sess" >/dev/null 2>&1
  "$RYSH_BIN" delete-session default >/dev/null 2>&1

  real="" ; drift=""
  if [ -f "$SANDBOX/$base.mp4" ]; then
    mv -f "$SANDBOX/$base.mp4" "$OUT_DIR/"
    [ -f "$SANDBOX/$base.gif" ] && mv -f "$SANDBOX/$base.gif" "$OUT_DIR/"
    real=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$OUT_DIR/$base.mp4")
    drift=$(awk -v r="$real" -v b="$budget" 'BEGIN{ if (b>0) printf "%.3f", r/b; else print "" }')
  fi

  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$base" "$budget" "$wall" "${real:-RENDER-FAILED}" "${drift:-}" "$lb" "$la" "$rc" >> "$RESULTS"
  printf '%-38s budget=%-8s wall=%-5ss real=%-9s drift=%-6s load %s->%s rc=%s\n' \
    "$base" "$budget" "$wall" "${real:-FAILED}" "${drift:-n/a}" "$lb" "$la" "$rc"
done

echo
echo "results -> $RESULTS   (vhs stdout/stderr -> $LOG)"
