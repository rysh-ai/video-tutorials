#!/usr/bin/env bash
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
R="$DIR/../_bin/rysh"
cd /tmp/rysh-demo-2 2>/dev/null || exit 0
"$R" stop stopstart           >/dev/null 2>&1
"$R" delete-session stopstart >/dev/null 2>&1
echo "[teardown] stopstart: stopped"
