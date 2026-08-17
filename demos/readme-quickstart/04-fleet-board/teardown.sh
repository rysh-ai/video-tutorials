#!/usr/bin/env bash
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
export PATH="$DIR/../_bin:$PATH"
cd /tmp/rysh-demo-4 2>/dev/null || exit 0
rysh stop fleetboard           >/dev/null 2>&1
rysh delete-session fleetboard >/dev/null 2>&1
pkill -f "_bin/rysh daemon fleetboard" 2>/dev/null
echo "[teardown] fleetboard: stopped"
