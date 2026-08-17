#!/usr/bin/env bash
# Fresh state before a take.
#
# THE WORKSPACE IS OUTSIDE THE REPO ON PURPOSE. Agents launched by the demo run
# with approvals off, in whatever directory the pane is in. Filmed inside the
# demo folder, one of them read the tape that was filming it and began proposing
# edits to demo.tape on camera. A bare scratch directory has nothing to find, and
# it keeps the monorepo's internal paths out of the agents' banners.
#
# STOP BEFORE YOU CD, AND CD BEFORE YOU STOP — in that order, or not at all.
# rysh state is PROJECT-LOCAL: `rysh stop <name>` resolves the session through
# the `.rysh/` of the CURRENT directory. An earlier version of this script ran
# stop/delete from the demo folder and only then touched the workspace, so it
# was asking the wrong project about a session it did not have, silently did
# nothing, and returned success. Six `rysh daemon parallel` processes piled up
# across failed takes, each with live agents, and every new take attached to
# whichever one answered first — which is why a take once opened onto a Claude
# that had been running since two takes earlier and read `##new stack 2` as chat.
# The flakiness that looked like codex, then like navigation, was partly this.
#
# AND CODEX MUST TRUST THE WORKSPACE BEFORE THE CAMERA ROLLS. On first run in an
# unfamiliar directory codex asks "Do you trust the contents of this directory?
# 1. Yes, continue / 2. No, quit" and blocks; the tape's next keystrokes then
# land in that dialog and dismiss it, leaving bash holding the pane. The tell was
# that /private/tmp/rysh-demo-2 is in codex's trusted list — demo 2's first take
# pressed Enter on the dialog by accident, which accepts the default — while
# rysh-demo-3 never was. Trusting it here is the same answer a person gives once,
# made repeatable. Codex records the RESOLVED path, so /private/tmp/..., not
# /tmp/....
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
R="$DIR/../_bin/rysh"
WS=/tmp/rysh-demo-3
RWS=/private/tmp/rysh-demo-3          # what codex writes down

# 1. stop the session FROM ITS OWN PROJECT DIRECTORY, while it still exists
mkdir -p "$WS"
( cd "$WS" && "$R" stop parallel >/dev/null 2>&1; "$R" delete-session parallel >/dev/null 2>&1 )

# 2. belt and braces: a take that died mid-record never reached its teardown
pkill -f "$DIR/../_bin/rysh daemon parallel" 2>/dev/null
sleep 1
left=$(ps -eo command | grep -c "_bin/rysh daemon parallel$" || true)
[ "$left" -eq 0 ] || echo "[setup] WARNING: $left stray parallel daemon(s) still up" >&2

# 3. now the workspace can go
cd /
rm -rf "$WS"; mkdir -p "$WS"; cd "$WS"

CFG="$HOME/.codex/config.toml"
if [ -f "$CFG" ] && ! grep -qF "[projects.\"$RWS\"]" "$CFG"; then
  printf '\n[projects."%s"]\ntrust_level = "trusted"\n' "$RWS" >> "$CFG"
  echo "[setup] codex: trusted $RWS"
else
  echo "[setup] codex: $RWS already trusted"
fi

"$R" create parallel -d >/dev/null 2>&1 || { echo "[setup] could not create parallel" >&2; exit 1; }
sleep 3
echo "[setup] parallel: created, detached, workspace $WS"
