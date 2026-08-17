#!/usr/bin/env bash
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
R="$DIR/../_bin/rysh"
cd /tmp/rysh-demo-1 2>/dev/null || exit 0
"$R" stop first-panes           >/dev/null 2>&1
"$R" delete-session first-panes >/dev/null 2>&1
echo "[teardown] first-panes: stopped"
