#!/usr/bin/env bash
# Start one fleet agent in the pane this is typed in.
#
#   ./agent.sh roadmap | fleet-manager | worker-1 | worker-2
#
# The brief goes in as argv rather than being typed after boot: a prompt typed
# into a booting claude is dropped on the floor — there is no ready signal — and
# argv is the only delivery that cannot lose the first turn. It also keeps the
# command line short enough to read on camera.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
role="${1:?usage: agent.sh <roadmap|fleet-manager|worker-1|worker-2>}"
brief="$DIR/_run/briefs/$role.md"
[ -f "$brief" ] || { echo "no brief for $role — run launch-agents.sh, not this" >&2; exit 1; }

exec claude --dangerously-skip-permissions --model sonnet "$(cat "$brief")"
