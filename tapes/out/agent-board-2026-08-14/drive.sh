#!/usr/bin/env bash
# drive.sh — run the agent-board demo on a fixed schedule, so a screen recorder
# started at the same moment films it.
#
# ACT 1  two claudes follow the shipped fleet brief verbatim  -> `rysh: command
#        not found`, and the board stays empty.
# ACT 2  the operator pane shows why: there is no `rysh` on PATH, only rysh_local.
# ACT 3  the same two agents, same panes, corrected binary -> the board fills,
#        and alice's ANSA message reaches bob, who posts on receipt.
set -uo pipefail
D="$(cd "$(dirname "$0")" && pwd)"
cd "$D"; source "$D/panes.env"
S=boarddemo
R() { "$D/rr" exec --session $S "$@"; }
Q_ALICE="--tab $TAB --lane $LANE2 --pg $PG_ALICE --pane $ALICE"
Q_BOB="--tab $TAB --lane $LANE2 --pg $PG_BOB --pane $BOB"
Q_OP="--tab $TAB --lane $LANE2 --pg $PG_OP --pane $OP"
CLEAN="env -u CLAUDECODE -u CLAUDE_CODE_ENTRYPOINT -u CLAUDE_CODE_EXECPATH -u CLAUDE_CODE_CHILD_SESSION -u CLAUDE_CODE_SESSION_ID -u CLAUDE_SESSION_ID -u CLAUDE_PID -u CLAUDE_EFFORT"
say() { echo "[drive $(date +%H:%M:%S)] $*"; }

# a line printed in the operator pane, for the camera
op() { R -- "##cmd pane $Q_OP $*" >/dev/null 2>&1; }

LEAD="${DEMO_LEAD:-14}"
op "clear"
say "lead-in ${LEAD}s (let the recorder attach)"; sleep "$LEAD"

# ---------------------------------------------------------------- ACT 1
op "echo; echo '=== ACT 1 - two claudes, the shipped fleet brief, verbatim ==='"
sleep 3
sed "s|{{ALICE}}|$ALICE|g; s|{{BOB}}|$BOB|g" brief-alice.md > .prompt-alice.txt
sed "s|{{ALICE}}|$ALICE|g; s|{{BOB}}|$BOB|g" brief-bob.md   > .prompt-bob.txt
say "starting claude in alice and bob"
R -- "##cmd pane $Q_ALICE $CLEAN claude --session-id $ALICE --dangerously-skip-permissions \"\$(cat $D/.prompt-alice.txt)\"" >/dev/null
R -- "##cmd pane $Q_BOB   $CLEAN claude --session-id $BOB   --dangerously-skip-permissions \"\$(cat $D/.prompt-bob.txt)\"" >/dev/null

say "act 1 running (${ACT1_WAIT:-120}s)"; sleep "${ACT1_WAIT:-120}"

# ---------------------------------------------------------------- ACT 2
op "echo; echo '=== ACT 2 - the board is empty. why? ==='"
sleep 3
op "rysh_local board tail --session $S"
sleep 5
op "echo; echo 'the brief says:  rysh board post --as \$RYSH_PANE -- ...'"
sleep 4
op "command -v rysh || echo 'rysh: NOT ON PATH'"
sleep 4
op "command -v rysh_local"
sleep 5

# ---------------------------------------------------------------- ACT 3
op "echo; echo '=== ACT 3 - same agents, same panes, the binary that exists ==='"
sleep 3
say "correcting bob first, so it is ready for alice's message"
"$D/rr" ansa prompt "$BOB" --as "$OP" --session $S -- "Correction: the rysh binary on this machine is \`rysh_local\`, not \`rysh\`. Retry with it: rysh_local board post --as \$RYSH_PANE -- 'bob: online'. Then wait; when alice messages you, post what she asks with rysh_local board post --as \$RYSH_PANE, and reply to her with rysh_local ansa prompt @alice. One line of report each time." >/dev/null 2>&1
sleep 6
say "correcting alice"
"$D/rr" ansa prompt "$ALICE" --as "$OP" --session $S -- "Correction: the rysh binary on this machine is \`rysh_local\`, not \`rysh\`. Redo the three steps with it, in order: (1) rysh_local board post --as \$RYSH_PANE -- 'alice: online'  (2) rysh_local ansa prompt @bob -- 'alice here - post your status to the board'  (3) rysh_local board post --as \$RYSH_PANE -- 'alice: messaged bob'. One line of report." >/dev/null 2>&1

say "act 3 running (${ACT3_WAIT:-170}s)"; sleep "${ACT3_WAIT:-170}"

# ---------------------------------------------------------------- RECEIPT
op "echo; echo '=== the board, read back over NATS ==='"
sleep 3
op "rysh_local board tail --session $S"
sleep "${TAIL_WAIT:-20}"
say "done"
