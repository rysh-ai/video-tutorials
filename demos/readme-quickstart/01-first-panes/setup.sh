#!/usr/bin/env bash
# Fresh state before a take.
#
# THE WORKSPACE IS OUTSIDE THE REPO ON PURPOSE. Agents launched by the demo run
# with approvals off, in whatever directory the pane is in. Filmed inside this
# folder, one of them read the tape that was filming it and started proposing
# edits to demo.tape on camera. A bare scratch directory has nothing to find,
# and it also keeps the monorepo's internal paths out of the agents' banners.
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
R="$DIR/../_bin/rysh"
WS=/tmp/rysh-demo-1
# stop the session FROM ITS OWN PROJECT DIRECTORY, while it still exists: rysh
# state is project-local, so a stop issued from anywhere else silently succeeds
# and leaves the daemon — and its agents — running for the next take to trip on.
mkdir -p "$WS"
( cd "$WS" && "$R" stop first-panes >/dev/null 2>&1; "$R" delete-session first-panes >/dev/null 2>&1 )
pkill -f "$DIR/../_bin/rysh daemon first-panes" 2>/dev/null
cd /; rm -rf "$WS"; mkdir -p "$WS"; cd "$WS"
echo "[setup] first-panes: clean, workspace $WS"
