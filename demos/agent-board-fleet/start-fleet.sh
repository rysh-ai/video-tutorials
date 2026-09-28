#!/usr/bin/env bash
# Kick the fleet off and return immediately.
#
# This exists so the tape has one short, readable line to type before it
# attaches. nohup + redirect because the launcher outlives the shell vhs types
# into, and because a single stray line of its output on top of the TUI ruins
# the take.
cd "$(dirname "$0")"
nohup ./launch-agents.sh > _run/launch.log 2>&1 &
echo "fleet starting — log: _run/launch.log"
