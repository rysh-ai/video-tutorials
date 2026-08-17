#!/usr/bin/env bash
# Render the briefs and start the four agents in their panes.
#
# Staged on purpose. `roadmap` goes first and we WAIT for its opening post to
# land before the other three start, so the board's first frame is the aim of the
# demo rather than three "standing by" replies under a placeholder root.
#
# (The board self-heals either way — a reply arriving before its root makes a
# provisional thread that re-parents when the root lands, design 025 §4.3. This
# is about what the camera sees, not about correctness.)
set -euo pipefail

WS=/tmp/rysh-demo-4
SRC="$WS/_run/briefs-src"    # raw briefs, copied in by setup.sh
# The agents' briefs tell them to run `rysh board post`, so `rysh` has to be on
# PATH under its plain name — in this script AND in the pane shells the daemon
# spawns. setup.sh writes the directory into _run/panes.env for both.
export PATH="${RYSH_BIN_DIR:-$WS/_bin}:$PATH"

[ -f "$WS/_run/panes.env" ] || { echo "no panes.env — run ./setup.sh first" >&2; exit 1; }
set -a; . "$WS/_run/panes.env"; set +a

# RYSH_SESSION beats the config file, and this normally runs from a pane of the
# OPERATOR's session — so an inherited RYSH_SESSION silently points
# `rysh board tail` at the wrong session, where it finds no posts and waits out
# its whole timeout. Pin it to the demo.
export RYSH_SESSION="$SESSION"
cd "$WS"

say() { printf '\033[35m[launch]\033[0m %s\n' "$*"; }

# --- render the briefs ----------------------------------------------------
# The thread id is minted here, not by an agent, and it is minted as
# "<roadmap-pane-id>/1" because the board only accepts a post as a thread ROOT
# from the pane whose id prefixes the thread (board.ownsThread). Any other string
# files every post as a reply to a thread that never arrives, and the board
# renders "awaiting root" for the whole demo.
THREAD="$ROADMAP/1"
say "thread $THREAD"

mkdir -p "$WS/briefs"
sed "s|{{THREAD}}|$THREAD|g" "$SRC/_protocol.md" > "$WS/briefs/_protocol.md"

# The protocol is spliced in by FILE, not through `awk -v`: a -v value may not
# contain a newline, and awk fails the whole render with "newline in string".
for role in roadmap fleet-manager worker-1 worker-2; do
  awk -v pf="$WS/briefs/_protocol.md" '
    /\{\{PROTOCOL\}\}/ { while ((getline line < pf) > 0) print line; close(pf); next }
    { print }
  ' "$SRC/$role.md" | sed "s|{{THREAD}}|$THREAD|g" > "$WS/briefs/$role.md"
done
say "briefs rendered -> $WS/briefs/"

start() { # start <pane-id> <role>
  say "starting $2"
  rysh send "$SESSION" "./agent.sh $2" --pane "$1" --mode shell >/dev/null
}

start "$ROADMAP" roadmap

say "waiting for the roadmap to open the board"
opened=0
for _ in $(seq 1 90); do          # ~3 min ceiling: agent boot + one post
  if rysh board tail --limit 20 2>/dev/null | grep -q 'DEMO:'; then opened=1; break; fi
  sleep 2
done
[ "$opened" -eq 1 ] && say "board opened" || say "roadmap has not posted yet — starting the rest anyway"

start "$MANAGER" fleet-manager
sleep 1
start "$WORKER1" worker-1
sleep 1
start "$WORKER2" worker-2

say "all four agents started"
