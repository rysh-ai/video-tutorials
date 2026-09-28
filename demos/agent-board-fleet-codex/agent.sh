#!/usr/bin/env bash
# Start one fleet agent in the pane this is typed in.
#
#   ./agent.sh roadmap | fleet-manager | worker-1 | worker-2
#
# The brief goes in as argv rather than being typed after boot: a prompt typed
# into a booting agent is dropped on the floor — there is no ready signal — and
# argv is the only delivery that cannot lose the first turn. Codex takes its
# prompt positionally (`codex [OPTIONS] [PROMPT]`) exactly as claude does, which
# is what lets this stay a one-line change from the claude version.
#
# --dangerously-bypass-approvals-and-sandbox is CODEX's full-auto flag, and it
# is not claude's. Handing codex `--dangerously-skip-permissions` is an
# immediate hard error at the pane; handing it nothing is an approval prompt
# that hangs a fleet agent forever, because nobody is at the keyboard.
#
# It also turns the sandbox off, which this demo needs: the agents write files
# and shell out to `rysh board post` on every step.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
role="${1:?usage: agent.sh <roadmap|fleet-manager|worker-1|worker-2>}"
brief="$DIR/_run/briefs/$role.md"
[ -f "$brief" ] || { echo "no brief for $role — run launch-agents.sh, not this" >&2; exit 1; }

exec codex --dangerously-bypass-approvals-and-sandbox "$(cat "$brief")"
