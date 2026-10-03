#!/usr/bin/env bash
#
# render_control_isolated.sh — render a control tape against a rysh that CANNOT
# reach the human's live session.
#
# render_control.sh:64,76,77 run `"$RYSH_BIN" delete-session` (including
# `delete-session default`) against whatever rysh the ambient environment
# reaches. On a box running a live rysh session that is a loaded gun, so this
# script exists instead of editing that one (its history is evidence).
#
# Isolation, all of it enforced here:
#   - HOME and RYSH_DIR point at a fresh dir under tapes/out/iso-home/; the
#     script exits 2 unless RYSH_DIR resolves under that root.
#   - Every inherited RYSH_* variable except RYSH_DIR is unset (the pane's
#     RYSH_SESSION/RYSH_PANE/... would otherwise address the live session).
#   - The session name comes from an isolated rysh.config.yaml in the iso dir,
#     which is also vhs's cwd (rysh resolves config from cwd only); NATS is
#     embedded with port 0, the recipe internal/daemontest uses so concurrent
#     daemons never collide.
#   - `delete-session default` is never called. The only session ever stopped
#     or deleted is the one this script created, by name, inside the iso dir.
#
# Usage:
#   ./render_control_isolated.sh prove                       # isolation proof only
#   ./render_control_isolated.sh render <tape-file> <n>      # proof, then n renders
set -uo pipefail

TAPES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ISO_ROOT="$TAPES_DIR/out/iso-home"
RYSH_SRC="${RYSH_SRC:-/Users/halilagin/.local/bin/rysh}"
RESULTS="${RESULTS:-$TAPES_DIR/control-arm64-results.tsv}"
LIVE_DIRS=("/Users/halilagin/root/github/rysh-ai" "$HOME")   # where live registries resolve from

mode="${1:-}"; [ "$mode" = prove ] || [ "$mode" = render ] || { echo "usage: $0 prove | render <tape> <n>"; exit 2; }

# --- live list, from the ORIGINAL environment, read-only --------------------
live_list() {
  local d
  for d in "${LIVE_DIRS[@]}"; do
    echo "## live list-sessions, cwd=$d"
    ( cd "$d" && env -u RYSH_PANE -u RYSH_TAB -u RYSH_LANE -u RYSH_STACK -u RYSH_SESSION -u RYSH_DIR \
        "$RYSH_SRC" list-sessions 2>&1 )
  done
}
LIVE_BEFORE="$(live_list)"

# --- build the isolated environment ----------------------------------------
mkdir -p "$ISO_ROOT"
ISO="$(mktemp -d "$ISO_ROOT/run-XXXXXX")"
for v in $(env | sed -n 's/^\(RYSH_[A-Za-z0-9_]*\)=.*/\1/p'); do unset "$v"; done
export HOME="$ISO"
export RYSH_DIR="$ISO/.rysh"
mkdir -p "$RYSH_DIR" "$ISO/bin"
ln -sf "$RYSH_SRC" "$ISO/bin/rysh"
export PATH="$ISO/bin:$PATH"

resolved="$(cd "$RYSH_DIR" && pwd -P)"
root_resolved="$(cd "$ISO_ROOT" && pwd -P)"
case "$resolved" in
  "$root_resolved"/*) ;;
  *) echo "REFUSE: RYSH_DIR=$resolved is not under $root_resolved"; exit 2 ;;
esac

echo "## env | grep ^RYSH (inside the script, after isolation)"
env | grep ^RYSH
echo "## HOME=$HOME"
echo "## rysh: $(command -v rysh) -> $RYSH_SRC  $(rysh --version 2>&1 | head -1)  sha256=$(shasum -a 256 "$RYSH_SRC" | cut -d' ' -f1)"

write_cfg() {  # $1 = session name
  cat > "$ISO/rysh.config.yaml" <<EOF
rysh:
  session_name: "$1"
nats:
  mode: "embedded"
  port: 0
provider:
  name: "claude"
  api_key: ""
EOF
}

# The only processes this script may stop: `rysh daemon <name> [--config ...]`
# whose cwd is $ISO (pattern must allow the trailing --config argument).
iso_daemons() {  # $1 = session name
  local pid
  for pid in $(pgrep -f "rysh daemon $1( |\$)" 2>/dev/null); do
    if lsof -a -p "$pid" -d cwd -Fn 2>/dev/null | grep -q "^n$ISO"; then echo "$pid"; fi
  done
}

show_daemon() {  # $1 = session name
  local pid
  for pid in $(iso_daemons "$1"); do
    echo "## isolated daemon pid=$pid"
    ps -o pid,ppid,command -p "$pid"
    echo "## its cwd and unix sockets / listening ports (lsof)"
    lsof -a -p "$pid" -d cwd 2>/dev/null
    lsof -a -p "$pid" -U 2>/dev/null | head -10
    lsof -p "$pid" 2>/dev/null | grep -c "$ISO" | sed "s/^/  open files under ISO: /"
    ps eww -p "$pid" | tr " " "\n" | grep -E "^(HOME|RYSH_)=" | sed "s/^/  daemon env: /"
    lsof -a -p "$pid" -iTCP -sTCP:LISTEN 2>/dev/null
  done
}

teardown() {  # $1 = session name — only ever a session this script created
  ( cd "$ISO" && rysh stop "$1" ) 2>&1 | sed 's/^/  stop: /'
  ( cd "$ISO" && rysh delete-session "$1" ) 2>&1 | sed 's/^/  delete: /'
  local pid
  for pid in $(iso_daemons "$1"); do echo "  leftover iso daemon $pid — killing"; kill "$pid"; done
}

# --- 1.2: isolation proof --------------------------------------------------
probe="iso-probe-$$"
write_cfg "$probe"
echo "## create throwaway session $probe in the isolated env"
( cd "$ISO" && rysh --config "$ISO/rysh.config.yaml" create "$probe" --detached ) 2>&1 | tail -5
sleep 3
echo "## isolated list-sessions"
( cd "$ISO" && rysh list-sessions ) 2>&1
n_iso=$(iso_daemons "$probe" | wc -l | tr -d ' ')
show_daemon "$probe"
teardown "$probe"
LIVE_AFTER="$(live_list)"

echo "===== LIVE BEFORE ====="; echo "$LIVE_BEFORE"
echo "===== LIVE AFTER  ====="; echo "$LIVE_AFTER"
if [ "$LIVE_BEFORE" != "$LIVE_AFTER" ]; then echo "BLOCKED: live session list changed"; exit 3; fi
if [ "$n_iso" -lt 1 ]; then echo "BLOCKED: no separate daemon started under $ISO"; exit 3; fi
echo "ISOLATION OK: live lists identical; separate daemon ran with cwd under $ISO"
[ "$mode" = prove ] && exit 0

# --- 2a: renders -----------------------------------------------------------
tape="$2"; n="${3:-3}"
[ -f "$tape" ] || { echo "no such tape: $tape"; exit 2; }
tape="$(cd "$(dirname "$tape")" && pwd)/$(basename "$tape")"   # vhs runs with cwd=$ISO
base="$(basename "$tape" .tape)"
sess="${base:0:9}"
vhs_sha=$(shasum -a 256 "$(readlink -f "$(command -v vhs)")" | cut -d' ' -f1)
rysh_sha=$(shasum -a 256 "$RYSH_SRC" | cut -d' ' -f1)
tape_sha=$(shasum -a 256 "$tape" | cut -d' ' -f1)
budget=$(python3 "$TAPES_DIR/tape_budget.py" "$tape" --tsv | awk 'NR==2{print $5}')
OUT_DIR="$TAPES_DIR/out/control-arm64"; mkdir -p "$OUT_DIR"
for f in hello.go hello.txt; do cp -n "$TAPES_DIR/$f" "$ISO/" 2>/dev/null || true; done
[ -s "$RESULTS" ] || printf 'tape\trun\tbudget_s\tnb_frames\tduration_s\tratio\tr_frame_rate\twall_s\tload_before\tvhs_sha256\trysh_sha256\ttape_sha256\tmp4_path\tmp4_sha256\n' > "$RESULTS"
load1() { sysctl -n vm.loadavg | awk '{print $2}'; }
now()   { python3 -c 'import time;print(f"{time.time():.3f}")'; }

for run in $(seq 1 "$n"); do
  write_cfg "$sess"
  out="$OUT_DIR/$base-run$run.mp4"; rm -f "$out"
  lb=$(load1); t0=$(now)
  ( cd "$ISO" && vhs -o "$out" "$tape" ) > "$OUT_DIR/$base-run$run.log" 2>&1
  rc=$?; t1=$(now)
  wall=$(python3 -c "print(f'{$t1-$t0:.1f}')")
  teardown "$sess"
  if [ "$rc" -ne 0 ] || [ ! -s "$out" ]; then
    echo "FAIL run$run rc=$rc (log $OUT_DIR/$base-run$run.log)"
    printf '%s\t%s\t%s\tFAIL\t\t\t\t%s\t%s\t%s\t%s\t%s\t%s\t\n' "$base" "$run" "$budget" "$wall" "$lb" "$vhs_sha" "$rysh_sha" "$tape_sha" "$out" >> "$RESULTS"
    continue
  fi
  read -r rfr nbf < <(ffprobe -v error -select_streams v:0 -count_frames \
    -show_entries stream=r_frame_rate,nb_read_frames -of csv=p=0 "$out" | tr ',' ' ')
  dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$out")
  ratio=$(python3 -c "print(f'{$dur/$budget:.3f}')")
  sha=$(shasum -a 256 "$out" | cut -d' ' -f1)
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$base" "$run" "$budget" "$nbf" "$dur" "$ratio" "$rfr" "$wall" "$lb" "$vhs_sha" "$rysh_sha" "$tape_sha" "$out" "$sha" >> "$RESULTS"
  echo "$base run$run: frames=$nbf duration=${dur}s ratio=$ratio wall=${wall}s load=$lb"
done

LIVE_END="$(live_list)"
echo "===== LIVE AT END ====="; echo "$LIVE_END"
[ "$LIVE_BEFORE" = "$LIVE_END" ] && echo "live list unchanged across the whole run" || echo "WARNING: live list changed during renders"
