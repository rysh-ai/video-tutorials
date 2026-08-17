#!/usr/bin/env bash
# Build the fleet session and its layout from nothing.
#
# Result — one tab, three lanes, five panes:
#
#   lane-1 (planning)   lane-2 (build)      lane-3 (board)
#   +----------------+  +----------------+  +----------------+
#   | roadmap  claude|  | worker-1 codex |  |                |
#   +----------------+  +----------------+  | agents-board   |
#   | manager  codex |  | worker-2 claude|  |                |
#   +----------------+  +----------------+  +----------------+
#
# Nothing is launched here; that is launch-fleet.sh. Adapted from
# ../../agent-board-fleet/setup-session.sh, which worked out most of this the
# hard way — the comments that survive are the ones that cost someone a take.
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
SESSION=fleetboard
WS=/tmp/rysh-demo-4
RWS=/private/tmp/rysh-demo-4        # the resolved path both vendors record

export PATH="$DIR/../_bin:$PATH"    # `rysh` under its plain name: it is the
                                    # command the agents' briefs tell them to
                                    # run, and the one the camera shows.

say() { printf '\033[36m[setup]\033[0m %s\n' "$*"; }
rx()  { rysh exec --session "$SESSION" -- "$@"; }

# --- a clean session ------------------------------------------------------
# STOP FROM THE SESSION'S OWN DIRECTORY. rysh state is project-local, so a stop
# issued anywhere else silently succeeds and leaves the daemon — and its live
# agents — running for the next take to trip on. Six of them piled up that way
# while demo 3 was being shot.
say "clearing any previous $SESSION"
mkdir -p "$WS"
( cd "$WS" && rysh stop "$SESSION" >/dev/null 2>&1; rysh delete-session "$SESSION" >/dev/null 2>&1 ) || true
pkill -f "_bin/rysh daemon $SESSION" 2>/dev/null || true
sleep 1

# `delete-session` does NOT empty the board: it is a JetStream KV bucket keyed by
# session name, living in the nats data_dir, so it outlives the session that
# wrote it and the next take opens on the last take's posts. Wiping the workspace
# is what actually resets the board.
cd /
rm -rf "$WS"; mkdir -p "$WS"; cd "$WS"
# Everything the fleet needs lives IN the workspace, so the tape types
# `./start-fleet.sh` rather than an absolute repo path nobody would read on
# screen — and so the agents never see the repo that is filming them.
mkdir -p "$WS/_run/briefs-src" "$WS/_bin"
cp "$DIR/rysh.config.yaml" "$WS/"
cp "$DIR/agent.sh" "$DIR/launch-fleet.sh" "$DIR/start-fleet.sh" "$WS/"
cp "$DIR/briefs/"*.md "$WS/_run/briefs-src/"
chmod +x "$WS/agent.sh" "$WS/launch-fleet.sh" "$WS/start-fleet.sh"
ln -sf "$DIR/../_bin/rysh" "$WS/_bin/rysh"

# --- trust, both vendors ---------------------------------------------------
# Each asks its own dialog and BLOCKS on it, with nobody at the keyboard to
# answer — four panes that look like a slow start and never move. They are two
# different questions in two different files, so both grants are needed.
say "trusting $RWS for claude and codex"
python3 - "$RWS" <<'PY'
import json, os, sys
target = sys.argv[1]

# claude: ~/.claude.json projects[dir].hasTrustDialogAccepted — exactly the state
# clicking "Yes, I trust this folder" writes.
cfg = os.path.expanduser("~/.claude.json")
try:
    data = json.load(open(cfg)) if os.path.isfile(cfg) else {}
except Exception:
    data = {}
data.setdefault("projects", {}).setdefault(target, {})["hasTrustDialogAccepted"] = True
tmp = cfg + ".tmp"
json.dump(data, open(tmp, "w"), indent=2)
os.replace(tmp, cfg)

# codex: ~/.codex/config.toml [projects."<dir>"] trust_level = "trusted"
home = os.environ.get("CODEX_HOME") or os.path.expanduser("~/.codex")
os.makedirs(home, exist_ok=True)
ctoml = os.path.join(home, "config.toml")
text = open(ctoml).read() if os.path.isfile(ctoml) else ""
header = '[projects."%s"]' % target
if header not in text:
    with open(ctoml, "a") as f:
        f.write('\n# added by the 04-fleet-board demo\n%s\ntrust_level = "trusted"\n' % header)
print("  trust granted")
PY

say "creating $SESSION"
# THE DAEMON'S ENVIRONMENT IS EVERY AGENT'S ENVIRONMENT. Pane shells inherit it,
# and so does every agent started in one. Run from inside a claude session — which
# is how this demo gets built — that inheritance carries the OPERATOR's session
# state into all four agents: an inherited CLAUDE_EFFORT makes them think at the
# operator's effort level and a demo crawls; CLAUDE_CODE_CHILD_SESSION puts a
# "Transcript saving is off" banner in every pane; the messaging socket and token
# address the OPERATOR's claude, which no agent should hold.
env -u CLAUDE_EFFORT -u CLAUDE_CODE_CHILD_SESSION -u CLAUDE_CODE_ENTRYPOINT \
    -u CLAUDE_CODE_EXECPATH -u CLAUDE_CODE_MESSAGING_SOCKET \
    -u CLAUDE_CODE_MESSAGING_TOKEN -u CLAUDE_CODE_SESSION_ID \
    -u CLAUDE_PID -u CLAUDECODE \
    rysh create "$SESSION" --detached >/dev/null

ready=0
for _ in $(seq 1 60); do
  if rx '##tab list' >/dev/null 2>&1; then ready=1; break; fi
  sleep 0.5
done
[ "$ready" -eq 1 ] || { echo "daemon never became ready" >&2; exit 1; }

# The demo must own its own bus (see rysh.config.yaml). Assert we are listening.
port=$(rx '##session' | sed -n 's/.*nats port *: *\([0-9]*\).*/\1/p')
pid=$(rx '##session'  | sed -n 's/.*daemon pid *: *\([0-9]*\).*/\1/p')
if ! lsof -nP -iTCP:"$port" -sTCP:LISTEN 2>/dev/null | grep -q "^[^ ]* *$pid "; then
  echo "daemon $pid is not the NATS listener on $port — it joined someone else's bus" >&2
  exit 1
fi
say "daemon $pid owns nats :$port"

# --- layout ---------------------------------------------------------------
# A fresh session is one lane with one pane. `##new grid 2x2` ADDS two lanes
# rather than reusing that one, so the born-with lane survives as a scratch lane
# — which is what we want, because `##board open` puts the board at the bottom of
# the ACTIVE lane, and the active lane is that one.
say "building 2x2 grid"
rx '##new grid 2x2' >/dev/null

TAB=$(rx '##tab list' | sed -n 's/.*id=\([0-9a-f-]\{36\}\).*/\1/p' | head -1)

# Anchored on the "[n]" row marker on purpose: `##pane list` opens with a header
# carrying the TAB's uuid in the same `id=` shape, so an unanchored match returns
# the tab as pane #1 and silently shifts every id by one.
pane_ids() { rx '##pane list' | sed -n 's/^ *>\{0,1\} *\[[0-9]*\] .*id=\([0-9a-f-]\{36\}\).*/\1/p'; }
panes=$(pane_ids)
SCRATCH=$(echo "$panes" | sed -n 1p)
ROADMAP=$(echo "$panes" | sed -n 2p)
MANAGER=$(echo "$panes" | sed -n 3p)
WORKER1=$(echo "$panes" | sed -n 4p)
WORKER2=$(echo "$panes" | sed -n 5p)

say "opening the agents board"
BOARD=$(rx '##board open' | sed -n 's/.*in pane \([0-9a-f]\{8\}\).*/\1/p')
BOARD=$(pane_ids | grep "^$BOARD" | head -1)
[ -n "$BOARD" ] || { echo "##board open did not report a pane" >&2; exit 1; }

# The board is born in the scratch lane. Move it into a lane of its own at the
# far right, then drop the scratch lane — a pane cannot be deleted out of a
# single-pane group, so the lane is the unit of teardown, and `##lane delete`
# needs the FULL uuid, which only `##lane info` run AS a pane in that lane prints
# (every listing truncates it to eight characters).
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

mkdir -p "$WS/_run"
cat > "$WS/_run/panes.env" <<EOF
# written by setup.sh
RYSH_BIN_DIR=$WS/_bin
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
say "workspace $WS — pane ids in _run/panes.env"
