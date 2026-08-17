#!/usr/bin/env bash
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
R="$DIR/../_bin/rysh"
cd /tmp/rysh-demo-3 2>/dev/null || exit 0
"$R" stop parallel           >/dev/null 2>&1
"$R" delete-session parallel >/dev/null 2>&1
echo "[teardown] parallel: stopped"
