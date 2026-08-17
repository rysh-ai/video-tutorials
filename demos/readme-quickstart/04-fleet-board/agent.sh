#!/usr/bin/env bash
# Start one fleet agent in the pane this is typed in.
#
#   ./agent.sh roadmap | fleet-manager | worker-1 | worker-2
#
# THE ROLE DECIDES THE VENDOR. This demo is a mixed fleet, which is its whole
# point — the two halves of it are different programs with different flags:
#
#   roadmap        claude   sets the goal
#   fleet-manager  codex    splits it into work orders
#   worker-1       codex    builds
#   worker-2       claude   builds
#
# The full-auto flag is NOT the same flag. Codex takes
# `--dangerously-bypass-approvals-and-sandbox`; hand it claude's
# `--dangerously-skip-permissions` and it is an immediate hard error at the pane.
# Hand either of them nothing and it stops at an approval prompt that nobody is
# there to answer, which on camera is indistinguishable from a slow start.
#
# The brief goes in as argv rather than being typed after boot: a prompt typed
# into a booting agent is dropped on the floor — there is no ready signal — and
# argv is the only delivery that cannot lose the first turn. Both programs take
# their prompt positionally, which is what lets this stay one script.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
role="${1:?usage: agent.sh <roadmap|fleet-manager|worker-1|worker-2>}"
brief="$DIR/briefs/$role.md"
[ -f "$brief" ] || { echo "no brief for $role — run launch-fleet.sh, not this" >&2; exit 1; }

case "$role" in
  roadmap|worker-2)        vendor=claude ;;
  fleet-manager|worker-1)  vendor=codex  ;;
  *) echo "unknown role: $role" >&2; exit 2 ;;
esac

if [ "$vendor" = codex ]; then
  exec codex --dangerously-bypass-approvals-and-sandbox "$(cat "$brief")"
else
  exec claude --dangerously-skip-permissions --model sonnet "$(cat "$brief")"
fi
