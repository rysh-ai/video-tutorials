#!/usr/bin/env bash
# Build the demo session and its layout from nothing.
#
#   ./setup-session.sh
#
# Result — one tab, three lanes, five panes:
#
#   lane-1            lane-2            lane-3
#   +--------------+  +--------------+  +--------------+
#   | roadmap      |  | worker-1     |  |              |
#   +--------------+  +--------------+  | agents-board |
#   | fleet-manager|  | worker-2     |  |              |
#   +--------------+  +--------------+  +--------------+
#
# Nothing is launched here; that is launch-agents.sh. This script only has to
# be idempotent and to leave _run/panes.env holding the five pane ids.
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

SESSION=agentfleet
export PATH="$DIR/_bin:$PATH"

# _bin/rysh is a symlink to the binary under test, put on PATH under its plain
# name so the recording shows the command a viewer would actually type — and so
# `rysh board post` is the line an agent has to remember, not `rysh_local`.
mkdir -p _bin _run
[ -e _bin/rysh ] || ln -s "$HOME/.local/bin/rysh_local" _bin/rysh

say() { printf '\033[36m[setup]\033[0m %s\n' "$*"; }
rx()  { rysh exec --session "$SESSION" -- "$@"; }

# --- a clean session ------------------------------------------------------
# stop THEN delete: create does not boot a session that is merely "stopped",
# and a stale record makes the next create look like it worked.
say "clearing any previous $SESSION"
rysh stop "$SESSION"           >/dev/null 2>&1 || true
rysh delete-session "$SESSION" >/dev/null 2>&1 || true

# `delete-session` does NOT empty the board. The board is a JetStream KV bucket
# keyed by session name (internal/board/persist.go), living in the nats data_dir
# — so it outlives the session that wrote it and the next take opens on the last
# take's posts. Wiping .rysh is what actually resets the board.
rm -rf .rysh _run/briefs _run/launch.log
# And the demo has to start from nothing on screen too.
rm -rf todo-app ROADMAP.md

say "trusting this directory for claude"
./trust-dir.sh

say "creating $SESSION"
# THE DAEMON'S ENVIRONMENT IS EVERY AGENT'S ENVIRONMENT. Pane shells inherit it,
# and so does every claude started in one. Run from inside a claude session
# (which is how this demo gets built) that inheritance carries the PARENT's
# session state into all four agents:
#
#   CLAUDE_EFFORT               -> agents think at the operator's effort level;
#                                  an inherited "xhigh" makes a demo crawl
#   CLAUDE_CODE_CHILD_SESSION   -> "Transcript saving is off" banner in every
#                                  pane, and no transcript to debug a take with
#   CLAUDE_CODE_MESSAGING_*     -> a socket and token addressing the OPERATOR's
#                                  claude; agents must not hold either
#
# All three were observed live in the first dry run.
env -u CLAUDE_EFFORT -u CLAUDE_CODE_CHILD_SESSION -u CLAUDE_CODE_ENTRYPOINT \
    -u CLAUDE_CODE_EXECPATH -u CLAUDE_CODE_MESSAGING_SOCKET \
    -u CLAUDE_CODE_MESSAGING_TOKEN -u CLAUDE_CODE_SESSION_ID \
    -u CLAUDE_PID -u CLAUDECODE \
    rysh create "$SESSION" --detached >/dev/null

ready=0
for _ in $(seq 1 60); do
  if rx '##tab list' >/dev/null 2>&1; then ready=1; break; fi
  sleep 0.3
done
[ "$ready" -eq 1 ] || { echo "daemon never became ready" >&2; exit 1; }

# The demo must own its own NATS server. If the configured port is already
# taken, the daemon quietly joins the OTHER server as a client and the two
# sessions share a bus — see rysh.config.yaml. Assert we are the listener.
port=$(rx '##session' | sed -n 's/.*nats port *: *\([0-9]*\).*/\1/p')
pid=$(rx '##session'  | sed -n 's/.*daemon pid *: *\([0-9]*\).*/\1/p')
if ! lsof -nP -iTCP:"$port" -sTCP:LISTEN 2>/dev/null | grep -q "^[^ ]* *$pid "; then
  echo "daemon $pid is not the NATS listener on $port — it joined someone else's bus" >&2
  exit 1
fi
say "daemon $pid owns nats :$port"

# --- layout ---------------------------------------------------------------
# A fresh session is one lane with one pane. `##new grid 2x2` ADDS two lanes
# (it does not reuse the existing one), so the born-with lane survives as a
# scratch lane — which is exactly what we want, because `##board open` puts the
# board at the bottom of the ACTIVE lane and the active lane is that one.
say "building 2x2 grid"
rx '##new grid 2x2' >/dev/null

TAB=$(rx '##tab list' | sed -n 's/.*id=\([0-9a-f-]\{36\}\).*/\1/p' | head -1)

# Read the five panes back in layout order rather than guessing ids.
#
# Anchored on the "[n]" row marker on purpose: `##pane list` opens with a
# header that carries the TAB's uuid in the same `id=` shape, so an unanchored
# match returns the tab as pane #1 and silently shifts every id by one.
pane_ids() { rx '##pane list' | sed -n 's/^ *>\{0,1\} *\[[0-9]*\] .*id=\([0-9a-f-]\{36\}\).*/\1/p'; }
panes=$(pane_ids)
SCRATCH=$(echo "$panes" | sed -n 1p)   # lane-1, the born-with pane
ROADMAP=$(echo "$panes" | sed -n 2p)   # lane-2 group-1  -> becomes lane-1 top
MANAGER=$(echo "$panes" | sed -n 3p)   # lane-2 group-2  -> becomes lane-1 bottom
WORKER1=$(echo "$panes" | sed -n 4p)   # lane-3 group-1  -> becomes lane-2 top
WORKER2=$(echo "$panes" | sed -n 5p)   # lane-3 group-2  -> becomes lane-2 bottom

say "opening the agents board"
BOARD=$(rx '##board open' | sed -n 's/.*in pane \([0-9a-f]\{8\}\).*/\1/p')
BOARD=$(pane_ids | grep "^$BOARD" | head -1)
[ -n "$BOARD" ] || { echo "##board open did not report a pane" >&2; exit 1; }

# The board is born in the scratch lane. Move it into a lane of its own at the
# far right, then drop the scratch lane — a pane cannot be deleted out of a
# single-pane group, so the lane is the unit of teardown, and `##lane delete`
# needs the FULL uuid, which only `##lane info` run AS a pane in that lane
# prints (every listing truncates it to eight characters).
say "moving the board into its own rightmost lane"
rx "##move pane $BOARD to-new-lane --last" >/dev/null

SCRATCH_LANE=$(rysh exec --session "$SESSION" --pane-id "$SCRATCH" -- '##lane info' \
  | sed -n 's/^ *id *: *\([0-9a-f-]\{36\}\).*/\1/p')
[ -n "$SCRATCH_LANE" ] || { echo "could not read the scratch lane id" >&2; exit 1; }
rx "##lane delete $SCRATCH_LANE" >/dev/null
sleep 1

# --- names ----------------------------------------------------------------
# `##pane name` renames the CALLER's pane; there is no positional id. So each
# rename is sent AS the pane being renamed. These given-names are what
# `rysh ansa prompt @worker-1` resolves, so they are wiring, not decoration.
name_pane() { rysh exec --session "$SESSION" --pane-id "$1" -- "##pane name $2" >/dev/null; }
say "naming panes"
name_pane "$ROADMAP" roadmap
name_pane "$MANAGER" fleet-manager
name_pane "$WORKER1" worker-1
name_pane "$WORKER2" worker-2
name_pane "$BOARD"   agents-board

lane_name() { rysh exec --session "$SESSION" --pane-id "$1" -- "##lane name $2" >/dev/null 2>&1 || true; }
lane_name "$ROADMAP" planning
lane_name "$WORKER1" build
lane_name "$BOARD"   board

cat > _run/panes.env <<EOF
# written by setup-session.sh
SESSION=$SESSION
TAB=$TAB
ROADMAP=$ROADMAP
MANAGER=$MANAGER
WORKER1=$WORKER1
WORKER2=$WORKER2
BOARD=$BOARD
EOF

say "layout:"
rx '##pane list'
say "pane ids -> _run/panes.env"
