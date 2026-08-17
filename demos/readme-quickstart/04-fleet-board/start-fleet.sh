#!/usr/bin/env bash
# One short, readable line for the tape to type before it attaches.
#
# nohup + redirect because the launcher outlives the shell vhs types into, and
# because a single stray line of its output on top of the TUI ruins the take.
cd "$(dirname "$0")"
nohup ./launch-fleet.sh > _run/launch.log 2>&1 &
echo "fleet starting — four agents, log: _run/launch.log"
