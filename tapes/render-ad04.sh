#!/usr/bin/env bash
#
# render-ad04.sh — film both sides of the ad04 Forge tunneling demo.
#
# Take A (owner):  forge add → enable → share → tail -f proof window → lsof.
#                  A background driver fires the TEAM agent's read call during
#                  the tail -f window so the access-log lines land on camera.
# Take B (team):   list-remote → subscribe → agent read call → mutation denial.
#                  The owner daemon stays up between takes (it executes the
#                  tunneled calls).
#
# Filming happens in NEUTRAL home dirs (~/acme-billing, ~/rysh-teammate) so
# on-camera absolute paths tell the story (take-1 QC lesson: repo sandbox paths
# leak the production setup). The repo sandbox (render-sandbox-ad04/) stays the
# canonical committed copy; this script seeds the film dirs from it.
#
# Prereqs: rysh-server stack up (127.0.5.251:34080), ANTHROPIC_API_KEY set,
#          vhs/ttyd/ffmpeg installed, rysh-cli built (make build → rysh_local).
#
# Usage:   cd video-tutorials/tapes && bash render-ad04.sh [owner|team|all|cleanup]
#
set -euo pipefail

TAPES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SANDBOX="$TAPES_DIR/render-sandbox-ad04"
OWNER_FILM="$HOME/acme-billing"
TEAM_FILM="$HOME/rysh-teammate"
RYSH_BIN="$(cd "$TAPES_DIR/../.." && pwd)/rysh-cli/rysh_local"
WHICH="${1:-all}"

export PATH="$SANDBOX/bin:$PATH"   # `rysh` → rysh_local shim for the vhs shell
export RYSH_GROUNDING=off          # crisp AI beats: no grounding-gate noise on camera

hygiene() { # $1=workdir  $2=session — precise kill + delete (NEVER pkill blindly)
  local dir="$1" sess="$2"
  local pid
  pid=$(pgrep -f "rysh_local daemon $sess$" || true)
  if [ -n "$pid" ]; then echo "[hygiene] killing daemon $sess (pid $pid)"; kill "$pid"; sleep 1; fi
  [ -d "$dir" ] && (cd "$dir" && "$RYSH_BIN" delete-session "$sess" >/dev/null 2>&1 || true)
  rm -rf "$dir/.rysh"              # forge store must be empty: on-camera add is first-time
}

seed_films() {
  mkdir -p "$OWNER_FILM" "$TEAM_FILM"
  cp "$SANDBOX/owner/rysh.config.yaml" "$SANDBOX/owner/billing-openapi.yaml" "$SANDBOX/owner/billing-api" "$OWNER_FILM/"
  cp "$SANDBOX/team/rysh.config.yaml" "$TEAM_FILM/"
}

start_billing() {
  local pid
  pid=$(lsof -ti :8099 || true)
  [ -n "$pid" ] && { echo "[billing] killing stale :8099 (pid $pid)"; kill $pid; sleep 1; }
  rm -f "$OWNER_FILM/billing.log"
  (cd "$OWNER_FILM" && nohup ./billing-api > billing.log 2>&1 &)
  ok=""
  for i in $(seq 1 10); do
    curl -sf -m 2 127.0.0.1:8099/health >/dev/null && { ok=1; break; }
    sleep 0.5
  done
  [ -n "$ok" ] || { echo "FATAL: billing API failed to start"; exit 1; }
  echo "[billing] up on 127.0.0.1:8099 in $OWNER_FILM"
}

create_daemon() { # $1=workdir $2=session
  (cd "$1" && "$RYSH_BIN" create "$2" --detached)
  sleep 3
}

team_driver() {  # fires the teammate's agent call during the owner's tail -f window
  # Owner-tape timeline: tail -f starts ~t+58s after vhs launch (incl. nudge);
  # window is 62s. Fire at +68s → API hit ~+95s, mid-window.
  sleep 68
  (cd "$TEAM_FILM" && "$RYSH_BIN" send story-ad04-team '##forge subscribe billing' >/dev/null 2>&1)
  sleep 4
  (cd "$TEAM_FILM" && "$RYSH_BIN" send story-ad04-team "list this month's unpaid invoices and total them" --mode prompt >/dev/null 2>&1)
  echo "[driver] team agent call fired"
}

if [ "$WHICH" = "cleanup" ]; then
  hygiene "$OWNER_FILM" story-ad04-owner
  hygiene "$TEAM_FILM"  story-ad04-team
  pid=$(lsof -ti :8099 || true); [ -n "$pid" ] && kill $pid
  echo "[cleanup] done (film dirs left in place: $OWNER_FILM, $TEAM_FILM)"
  exit 0
fi

[ -x "$RYSH_BIN" ] || { echo "FATAL: build rysh first (cd rysh-cli && make build)"; exit 1; }
[ -n "${ANTHROPIC_API_KEY:-}" ] || { echo "FATAL: ANTHROPIC_API_KEY not set"; exit 1; }
curl -sf -m 3 http://127.0.5.251:34080/health >/dev/null || { echo "FATAL: upstream server not reachable"; exit 1; }

if [ "$WHICH" = "owner" ] || [ "$WHICH" = "all" ]; then
  echo "=== TAKE A (owner) ==="
  hygiene "$OWNER_FILM" story-ad04-owner
  hygiene "$TEAM_FILM"  story-ad04-team
  seed_films
  start_billing
  create_daemon "$OWNER_FILM" story-ad04-owner
  create_daemon "$TEAM_FILM"  story-ad04-team
  team_driver &
  DRIVER_PID=$!
  (cd "$OWNER_FILM" && vhs "$TAPES_DIR/tape/story-ad04-forge-owner.tape")
  wait "$DRIVER_PID" 2>/dev/null || true
  mv -f "$OWNER_FILM/story-ad04-forge-owner.mp4" "$SANDBOX/owner/" 2>/dev/null || true
  echo "=== TAKE A done → $SANDBOX/owner/story-ad04-forge-owner.mp4 ==="
fi

if [ "$WHICH" = "team" ] || [ "$WHICH" = "all" ]; then
  echo "=== TAKE B (team) ==="
  # Owner daemon + billing must be alive (take A leaves them up).
  pgrep -f "rysh_local daemon story-ad04-owner$" >/dev/null || { echo "FATAL: owner daemon not running (run take A first)"; exit 1; }
  curl -sf localhost:8099/health >/dev/null || { echo "FATAL: billing API not running"; exit 1; }
  # Fresh team session so the on-camera subscribe is genuinely first-time.
  hygiene "$TEAM_FILM" story-ad04-team
  cp "$SANDBOX/team/rysh.config.yaml" "$TEAM_FILM/"
  create_daemon "$TEAM_FILM" story-ad04-team
  (cd "$TEAM_FILM" && vhs "$TAPES_DIR/tape/story-ad04-forge-team.tape")
  mv -f "$TEAM_FILM/story-ad04-forge-team.mp4" "$SANDBOX/team/" 2>/dev/null || true
  echo "=== TAKE B done → $SANDBOX/team/story-ad04-forge-team.mp4 ==="
fi

echo ""
echo "When QC'd:  bash $TAPES_DIR/render-ad04.sh cleanup"
