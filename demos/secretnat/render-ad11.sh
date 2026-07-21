#!/usr/bin/env bash
# Render the ad11 SecretNAT demo with the wire-logging proxy live.
# Fixes the deleted-inode bug: the proxy is (re)started AFTER wire.log is
# cleared, so its file handle points at the live file the on-camera grep reads.
set -euo pipefail

REPO=/Users/halilagin/root/github/agentic-zellij
SANDBOX="$REPO/video-tutorials/tapes/render-sandbox/demo-snat"
PROXYDIR="$REPO/video-tutorials/demos/secretnat"
WLOG="$SANDBOX/wire.log"
SESSION=story-ad11

cd "$SANDBOX"
export RYSH_SESSION_DIR="$SANDBOX/.rysh/sessions"
export PATH="$SANDBOX/bin:$PATH"

echo "== cleanup =="
./bin/rysh delete-session "$SESSION" 2>/dev/null || true
pgrep -f "daemon $SESSION" | xargs -r kill 2>/dev/null || true
pkill -f "wireproxy" 2>/dev/null || true
sleep 1
rm -f "$WLOG" deploy/.env

echo "== start proxy AFTER clearing wire.log (valid FD) =="
( cd "$PROXYDIR" && nohup go run wireproxy.go "$WLOG" > /tmp/wireproxy.out 2>&1 & )
sleep 2
lsof -iTCP:8899 -sTCP:LISTEN -n >/dev/null 2>&1 && echo "proxy up" || { echo "PROXY FAILED"; exit 1; }

echo "== secret hygiene =="
[ -d .rysh/secrets ] && { echo "ABORT: .rysh/secrets exists"; exit 1; } || echo "clean"

echo "== render =="
export RYSH_API_URL="http://127.0.0.1:8899"
export RYSH_SESSION="$SESSION"
[ -n "${ANTHROPIC_API_KEY:-}" ] || { echo "ABORT: ANTHROPIC_API_KEY missing"; exit 1; }
timeout 300 vhs ../../tape/story-ad11-secretnat.tape

echo "== wire proof =="
echo -n "real key on wire: "; grep -c sk_live_DEMOKEY_REDACTED "$WLOG" || true
echo -n "token on wire:    "; grep -oE 'sk_live_SNAT[0-9]+' "$WLOG" | sort -u || true
ls -la story-ad11-secretnat.mp4
