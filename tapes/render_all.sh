#!/usr/bin/env bash
# Batch-render Rysh tutorial tapes with VHS.
#
# Each tape is rendered in a sandbox working directory with a UNIQUE rysh
# session (RYSH_SESSION=<story-id>) so concurrent/sequential renders never
# collide on the "default" session or its JetStream KV. Outputs (mp4 + gif)
# are moved into out/. Sessions are deleted after each render.
#
# Usage:
#   ./render_all.sh                 # render all tapes except the EXCLUDE list
#   ./render_all.sh story-005 story-010   # render only matching tapes
#
# Excludes 002/003 by default: those tapes type real `brew/apt/make install`
# commands which VHS would actually execute in the shell.

set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
TAPE_DIR="$ROOT/tape"
OUT_DIR="$ROOT/out"
SANDBOX="$ROOT/render-sandbox"
LOG="$ROOT/render.log"

EXCLUDE_REGEX='story-002-|story-003-'

mkdir -p "$OUT_DIR" "$SANDBOX"
cp -f "$ROOT/hello.go" "$ROOT/hello.txt" "$SANDBOX/" 2>/dev/null || true
: > "$LOG"

LIST="$(mktemp)"
if [ "$#" -gt 0 ]; then
  for pat in "$@"; do ls "$TAPE_DIR"/${pat}*.tape 2>/dev/null; done | sort -u > "$LIST"
else
  ls "$TAPE_DIR"/story-*.tape | grep -Ev "$EXCLUDE_REGEX" | sort > "$LIST"
fi

total=$(wc -l < "$LIST" | tr -d ' ')
ok=0; fail=0; i=0
echo "Rendering $total tapes -> $OUT_DIR" | tee -a "$LOG"

while IFS= read -r tape; do
  [ -z "$tape" ] && continue
  i=$((i+1))
  base="$(basename "$tape" .tape)"
  sess="${base:0:9}"   # e.g. story-005
  printf "[%3d/%3d] %s ... " "$i" "$total" "$base" | tee -a "$LOG"
  rysh delete-session "$sess" >/dev/null 2>&1
  (
    cd "$SANDBOX" || exit 1
    RYSH_SESSION="$sess" vhs "$tape" >>"$LOG" 2>&1
  )
  rc=$?
  # collect outputs
  moved=0
  for ext in mp4 gif; do
    if [ -f "$SANDBOX/$base.$ext" ]; then
      mv -f "$SANDBOX/$base.$ext" "$OUT_DIR/" && moved=1
    fi
  done
  rysh delete-session "$sess" >/dev/null 2>&1
  rysh delete-session default >/dev/null 2>&1
  if [ "$rc" -eq 0 ] && [ "$moved" -eq 1 ]; then
    echo "OK" | tee -a "$LOG"; ok=$((ok+1))
  else
    echo "FAIL (rc=$rc)" | tee -a "$LOG"; fail=$((fail+1))
  fi
done < "$LIST"
rm -f "$LIST"

echo "Done. OK=$ok FAIL=$fail TOTAL=$total" | tee -a "$LOG"
