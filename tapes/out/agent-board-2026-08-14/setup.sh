#!/usr/bin/env bash
# setup.sh — build the demo session from scratch, with an EMPTY board.
#
#   lane-1 : the agents board pane (full height, left)
#   lane-2 : alice / bob / operator (right)
#
# `##board open` always lands in the tab's ACTIVE lane, not in the lane of
# --pane-id (workspace_board_pane.go: resolveLaneInTab(tab, "")). So the board
# is opened FIRST, into lane-1, and its seed shell is removed afterwards.
set -euo pipefail
D="$(cd "$(dirname "$0")" && pwd)"
cd "$D"
S=boarddemo
R() { ./rr exec --session $S "$@"; }
# pane ids only from the "[n] name id=..." rows: the header line carries the TAB
# id in the same id= shape and silently wins a naive sed.
panes() { R -- '##pane list' | sed -n 's/^[ >]*\[[0-9]*\] .*id=\([0-9a-f-]\{36\}\).*/\1/p'; }
newpane() { # $1 = "##..." command that creates exactly one pane; echoes its id
  local before; before="$(panes | sort)"
  R -- "$1" >/dev/null; sleep 1.5
  comm -13 <(echo "$before") <(panes | sort) | head -1
}

./rr stop $S >/dev/null 2>&1 || true
./rr delete-session $S >/dev/null 2>&1 || true
sleep 2
rm -rf "$D/nats" "$D"/.prompt-*.txt "$D"/*-probe.txt "$D"/alice-env.txt
./rr create $S -d 2>&1 | tail -1
sleep 4

TAB="$(R -- '##tab list' | sed -n 's/^[> ] *\[[0-9]*\] .*id=\([0-9a-f-]\{36\}\).*/\1/p' | head -1)"

# lane-1: the board, then drop the seed group it was opened beside
R -- '##board open' | tail -1
sleep 1.5
SEED_PG="$(./rr pane-group list --session $S | awk '/^  lane 1/{l=1} l && /\[group 1\]/{print $3; exit}' | sed 's/id=//')"
./rr pane-group delete --id "$SEED_PG" --session $S | tail -1
sleep 1.5
BOARD="$(panes | head -1)"
R -- "##pane name $BOARD board" >/dev/null

# lane-2: alice, then bob and operator as their own groups beside her
ALICE="$(newpane "##new lane $TAB")"
R -- "##pane name $ALICE alice" >/dev/null
LANE2="$(R --pane-id "$ALICE" -- '##lane info' | sed -n 's/^ *id *: *\([0-9a-f-]\{36\}\).*/\1/p' | head -1)"
BOB="$(newpane "##new pane $TAB $LANE2")";      R -- "##pane name $BOB bob" >/dev/null
OP="$(newpane  "##new pane $TAB $LANE2")";      R -- "##pane name $OP operator" >/dev/null

pg_of() { ./rr pane-group list --session $S | grep -B1 "$1" | awk '/\[group /{print $3}' | sed 's/id=//' | head -1; }
{
  echo "TAB=$TAB"; echo "LANE2=$LANE2"
  echo "BOARD=$BOARD"; echo "ALICE=$ALICE"; echo "BOB=$BOB"; echo "OP=$OP"
  echo "PG_ALICE=$(pg_of "$ALICE")"; echo "PG_BOB=$(pg_of "$BOB")"; echo "PG_OP=$(pg_of "$OP")"
} > panes.env
cat panes.env
echo
R -- '##ansa who'
echo "--- board must be empty ---"
./rr board tail --session $S --json | python3 -c 'import sys,json;d=json.load(sys.stdin);print("threads:",len(d["threads"]),"roster:",sorted(r["persona"] for r in d["roster"]))'
