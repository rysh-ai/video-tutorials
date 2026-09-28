#!/usr/bin/env bash
# Pre-accept Claude Code's workspace-trust dialog for this directory.
#
#   ./trust-dir.sh
#
# Without this every agent boots into "Quick safety check: Is this a project you
# created or one you trust?" and sits there forever — four panes, four dialogs,
# nobody at the keyboard, and a recording of a fleet that never starts. Found
# exactly that way on the first dry run.
#
# The dialog is skipped only in non-interactive mode (`-p`, or a non-TTY stdout),
# and these agents are deliberately interactive so a human can watch and take
# over. So the answer has to be stored, and it is stored in ~/.claude.json under
# projects["<dir>"].hasTrustDialogAccepted. This is exactly the state clicking
# "1. Yes, I trust this folder" writes — nothing here grants a permission the
# dialog would not have.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"

python3 - "$DIR" <<'PY'
import json, os, shutil, sys, tempfile, time

target = sys.argv[1]
cfg = os.path.expanduser("~/.claude.json")

with open(cfg) as fh:
    data = json.load(fh)

projects = data.setdefault("projects", {})
entry = projects.setdefault(target, {})
if entry.get("hasTrustDialogAccepted") is True:
    print(f"[trust] already trusted: {target}")
    sys.exit(0)

# Back up before touching it. This file is live — the founder's own claude
# writes to it — so a lost update here is somebody else's session state.
backup = f"{cfg}.bak-{time.strftime('%Y%m%d-%H%M%S')}"
shutil.copy2(cfg, backup)

entry["hasTrustDialogAccepted"] = True
entry.setdefault("hasCompletedProjectOnboarding", True)
entry.setdefault("projectOnboardingSeenCount", 1)

# Atomic replace: a half-written ~/.claude.json is unrecoverable for every
# claude on this machine, not just this demo.
fd, tmp = tempfile.mkstemp(dir=os.path.dirname(cfg), prefix=".claude.json.")
with os.fdopen(fd, "w") as fh:
    json.dump(data, fh, indent=2)
os.replace(tmp, cfg)
print(f"[trust] trusted {target}\n[trust] backup {backup}")
PY
