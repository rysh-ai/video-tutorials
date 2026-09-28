#!/usr/bin/env bash
# Pre-accept Codex's workspace-trust prompt for this directory.
#
#   ./trust-dir.sh          # grant
#   ./trust-dir.sh --revoke # take back exactly what this script granted
#
# On interactive launch codex asks "Do you trust the contents of this
# directory?" and BLOCKS until answered. A fleet agent has nobody to answer it,
# so four panes would sit there looking exactly like a slow start. (The claude
# version of this demo hit the identical wall with a different dialog and a
# different config file — see ../agent-board-fleet/trust-dir.sh.)
#
# The grant is per-directory and it is a REAL, persistent write to the user's
# ~/.codex/config.toml. So it is marked with a comment naming this demo, and
# --revoke removes only blocks carrying that mark: a directory that was already
# trusted before we got here was somebody else's grant and must survive.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
MARK="# added by agent-board-fleet-codex demo"

python3 - "$DIR" "$MARK" "${1:-}" <<'PY'
import os, shutil, sys, tempfile, time

target, mark, mode = sys.argv[1], sys.argv[2], sys.argv[3]
home = os.environ.get("CODEX_HOME") or os.path.expanduser("~/.codex")
cfg = os.path.join(home, "config.toml")
header = f'[projects."{target}"]'

text = open(cfg).read() if os.path.isfile(cfg) else ""

def backup():
    if os.path.isfile(cfg):
        b = f"{cfg}.bak-{time.strftime('%Y%m%d-%H%M%S')}"
        shutil.copy2(cfg, b)
        return b
    return None

def write(new: str):
    os.makedirs(home, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=home, prefix=".config.toml.")
    with os.fdopen(fd, "w") as fh:
        fh.write(new)
    os.replace(tmp, cfg)

if mode == "--revoke":
    lines, kept, removed = text.splitlines(), [], []
    i = 0
    while i < len(lines):
        if lines[i].strip() == mark:
            i += 1
            if i < len(lines) and lines[i].startswith("[projects."):
                removed.append(lines[i])
                i += 1
                # the block runs to the next table header, or EOF
                while i < len(lines) and not lines[i].startswith("["):
                    i += 1
            continue
        kept.append(lines[i])
        i += 1
    if removed:
        b = backup()
        write("\n".join(kept).rstrip() + "\n")
        print(f"[trust] revoked {len(removed)} grant(s)\n[trust] backup {b}")
    else:
        print("[trust] nothing this demo granted is left to revoke")
    sys.exit(0)

if header in text:
    # Already trusted — by us on a previous run, or by the user long ago. Either
    # way there is nothing to add, and nothing this script may later revoke.
    print(f"[trust] already trusted: {target}")
    sys.exit(0)

b = backup()
write(text.rstrip() + f"\n\n{mark}\n{header}\ntrust_level = \"trusted\"\n")
print(f"[trust] trusted {target}")
print(f"[trust] backup {b}" if b else "[trust] created a new config.toml")
PY
