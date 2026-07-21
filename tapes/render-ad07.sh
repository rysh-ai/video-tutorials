#!/usr/bin/env bash
#
# render-ad07.sh — film the terminal side of the ad07 Slack-humanoid demo.
#
# Modes:
#   dry   — render the tape with NO Slack traffic (validates tape mechanics:
#           mode cycling, register-output, prompts; wait windows show idle).
#   live  — the real take: the operator posts the two teammate questions in
#           #support at the [SLACK-DRIVER] offsets in the tape, and the Slack
#           window is region-captured in parallel (capture-slack-ad07.sh).
#
# ⚠️ BEFORE any live take:
#   1. Pause the desktop app's own slack-bot (same Slack app, ai mode — it
#      answers over the scene):
#        rysh --humanoid --session rysh channel stop slack-bot slack
#      Restore after: … channel start slack-bot slack
#   2. Check no OTHER daemons hold the Slack app: ps aux | grep 'rysh.*daemon'
#
# Usage: cd video-tutorials/tapes && bash render-ad07.sh [dry|live|cleanup]
#
set -euo pipefail

TAPES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SANDBOX="$TAPES_DIR/render-sandbox-ad07"
REPO="$(cd "$TAPES_DIR/../.." && pwd)"
RYSH_BIN="$SANDBOX/bin/rysh"     # feature build (branch feat-slack-governance)
SKILL_SRC="$REPO/video-tutorials/demos/slack-humanoid/humanoids/support-bot/SKILL.md"
SECRETS="$REPO/.rysh/secrets/halil-macbook-rysh"
SESSION="story-ad07"
MODE="${1:-dry}"

export PATH="$SANDBOX/bin:$PATH"   # `rysh` in the vhs shell → feature build
export RYSH_GROUNDING=off          # crisp replies from persona facts, no grounding noise

[ -x "$RYSH_BIN" ] || { echo "FATAL: $RYSH_BIN missing (copy worktree rysh_local)"; exit 1; }
[ -f "$SKILL_SRC" ] || { echo "FATAL: skill file missing: $SKILL_SRC"; exit 1; }

# Slack tokens from the rysh persisted-secret files — values never printed.
export SLACK_BOT_TOKEN="$(cat "$SECRETS/SLACK_BOT_TOKEN")"
export SLACK_APP_TOKEN="$(cat "$SECRETS/SLACK_APP_TOKEN")"
[ -n "$SLACK_BOT_TOKEN" ] && [ -n "$SLACK_APP_TOKEN" ] || { echo "FATAL: Slack tokens empty"; exit 1; }

hygiene() {
  # Precise kill of THIS sandbox's zombie daemon only (never pkill blindly —
  # the founder's own sessions run under binaries also named rysh).
  local pid
  pid=$(pgrep -f "render-sandbox-ad07/bin/rysh daemon $SESSION" || true)
  if [ -n "$pid" ]; then echo "[hygiene] killing zombie daemon $SESSION (pid $pid)"; kill "$pid"; sleep 1; fi
  (cd "$SANDBOX" && "$RYSH_BIN" delete-session "$SESSION" >/dev/null 2>&1 || true)
  # delete-session WIPES the workdir's .rysh/ — re-seed the skill AFTER it.
  mkdir -p "$SANDBOX/.rysh/humanoids/support-bot"
  cp "$SKILL_SRC" "$SANDBOX/.rysh/humanoids/support-bot/SKILL.md"
  echo "[hygiene] session clean, skill re-seeded"
}

if [ "$MODE" = "cleanup" ]; then
  hygiene
  echo "[cleanup] done — remember to restart the app's slack-bot channel if paused:"
  echo "  rysh --humanoid --session rysh channel start slack-bot slack"
  exit 0
fi

if [ "$MODE" = "live" ]; then
  echo "=== LIVE take pre-flight ==="
  echo "  [ ] desktop app slack-bot channel STOPPED?"
  echo "  [ ] Slack window capture running? (capture-slack-ad07.sh)"
  echo "  [ ] operator ready to post Q1 at T+~34s, Q2 at T+~62s?"
fi

hygiene
(cd "$SANDBOX" && "$RYSH_BIN" create "$SESSION" --detached)
sleep 4
echo "[daemon] $SESSION up — launching vhs (T0 = now)"
date '+T0=%H:%M:%S'
(cd "$SANDBOX" && vhs "$TAPES_DIR/tape/story-ad07-slack-humanoid.tape")
echo "=== take done → $SANDBOX/story-ad07-slack-humanoid.mp4 ==="
echo "Post-take: kill the zombie daemon before the next take:  bash $0 cleanup"
