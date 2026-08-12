#!/usr/bin/env bash
#
# check_render_prereqs.sh — fail BEFORE a render, not 40 minutes into one.
#
# Every check here is one a tape actually depends on, verified by reading the
# tapes and the render scripts — not a wish list. The script is the executable
# half of RENDERING.md: if this passes, `vhs tape/story-NNN-*.tape` renders.
#
# It is deliberately red on a fresh machine. `rysh` is NOT a released binary on
# this box's PATH — it is built from source per E5 T2 — so a clean checkout
# fails REQUIRED check 5 until `rysh-cli` is built and put on PATH. That red is
# the point: a prerequisite list nobody watched fail proves nothing.
#
# Usage:
#   ./check_render_prereqs.sh              # check the ambient environment
#   PATH="$PWD/render-sandbox/bin:$PATH" ./check_render_prereqs.sh
#
# Exit 0 = every REQUIRED check passed (WARN checks may still be red).
# Exit 1 = at least one REQUIRED check failed; the message names what is missing.
set -uo pipefail

TAPES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

req_fail=0
warn_fail=0

ok()   { printf '  \033[32mPASS\033[0m  %-28s %s\n' "$1" "${2:-}"; }
bad()  { printf '  \033[31mFAIL\033[0m  %-28s %s\n' "$1" "${2:-}"; req_fail=$((req_fail+1)); }
warn() { printf '  \033[33mWARN\033[0m  %-28s %s\n' "$1" "${2:-}"; warn_fail=$((warn_fail+1)); }

echo "=== render prerequisites: $(uname -s) $(uname -m) ==="
echo

# 1. vhs — the renderer itself. Tapes are VHS syntax; nothing else reads them.
if command -v vhs >/dev/null 2>&1; then
  ok "vhs" "$(vhs --version 2>&1 | head -1) at $(command -v vhs)"
else
  bad "vhs" "not on PATH — brew install vhs"
fi

# 2. ttyd — vhs drives a real terminal through ttyd. Without it vhs exits
#    "ttyd is not installed" before it reads a single Sleep directive.
if command -v ttyd >/dev/null 2>&1; then
  ok "ttyd" "$(ttyd --version 2>&1 | head -1) at $(command -v ttyd)"
else
  bad "ttyd" "not on PATH — brew install ttyd"
fi

# 3. ffmpeg — vhs shells out to it to encode the mp4/gif.
if command -v ffmpeg >/dev/null 2>&1; then
  ok "ffmpeg" "$(ffmpeg -version 2>&1 | head -1 | cut -d' ' -f1-3) at $(command -v ffmpeg)"
else
  bad "ffmpeg" "not on PATH — brew install ffmpeg"
fi

# 4. ffprobe — not needed to render, but every duration claim in this epic is
#    an ffprobe reading. A render you cannot measure does not calibrate T1.
if command -v ffprobe >/dev/null 2>&1; then
  ok "ffprobe" "$(ffprobe -version 2>&1 | head -1 | cut -d' ' -f1-3)"
else
  bad "ffprobe" "not on PATH — ships with ffmpeg"
fi

# 5. rysh — the subject of the film. 121 of 121 tapes type `rysh` at the shell;
#    without it every tape renders a wall of "command not found".
if command -v rysh >/dev/null 2>&1; then
  ok "rysh" "$(rysh --version 2>&1 | head -1) at $(command -v rysh)"
else
  bad "rysh" "not on PATH — build rysh-cli: (cd ../../rysh-cli && GOWORK=off make build) then put it on PATH as 'rysh'"
fi

# 6. bash — every tape carries `Set Shell "bash"`; vhs spawns exactly that.
if command -v bash >/dev/null 2>&1; then
  ok "bash" "$(bash --version 2>&1 | head -1 | cut -d',' -f1) at $(command -v bash)"
else
  bad "bash" "not on PATH — tapes declare Set Shell \"bash\""
fi

# 7. Chrome/Chromium — vhs 0.11 screenshots the ttyd page through a headless
#    browser. No browser, no frames.
browser=""
for cand in "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
            "/Applications/Chromium.app/Contents/MacOS/Chromium"; do
  [ -x "$cand" ] && { browser="$cand"; break; }
done
if [ -z "$browser" ]; then
  for cand in google-chrome chromium chromium-browser; do
    command -v "$cand" >/dev/null 2>&1 && { browser="$(command -v "$cand")"; break; }
  done
fi
if [ -n "$browser" ]; then ok "chrome/chromium" "$browser"; else
  bad "chrome/chromium" "no headless browser found — vhs cannot capture frames"
fi

# 8. Font. Tapes do NOT set FontFamily, so vhs applies its default,
#    "JetBrains Mono". If it is absent the browser silently falls back to a
#    generic monospace: the render still succeeds and the duration is
#    unaffected, so this is a WARN — it changes glyphs, not timing.
if find /Library/Fonts /System/Library/Fonts "$HOME/Library/Fonts" \
        -iname '*JetBrains*' 2>/dev/null | grep -q .; then
  ok "font JetBrains Mono" "installed"
else
  warn "font JetBrains Mono" "absent — vhs falls back to a generic monospace (glyphs differ, timing does not)"
fi

# 9. Sources and destination.
if [ -d "$TAPES_DIR/tape" ]; then
  ok "tape/" "$(ls -1 "$TAPES_DIR"/tape/*.tape 2>/dev/null | wc -l | tr -d ' ') tapes"
else
  bad "tape/" "missing: $TAPES_DIR/tape"
fi

if mkdir -p "$TAPES_DIR/out" 2>/dev/null && [ -w "$TAPES_DIR/out" ]; then
  ok "out/ writable" "$TAPES_DIR/out"
else
  bad "out/ writable" "cannot write $TAPES_DIR/out"
fi

if mkdir -p "$TAPES_DIR/render-sandbox" 2>/dev/null && [ -w "$TAPES_DIR/render-sandbox" ]; then
  ok "render-sandbox/" "$TAPES_DIR/render-sandbox"
else
  bad "render-sandbox/" "cannot write $TAPES_DIR/render-sandbox"
fi

# 10. Machine load. Not a gate — a fact to record. VHS output length shrinks
#     under load (E5 work order §3), so a duration measured at load 40 is not
#     the same measurement as one taken at load 2. Print it so every render in
#     RENDERING.md can be read against the load it was taken at.
echo
echo "  load average now: $(uptime | sed 's/.*load averages*: //')"

echo
if [ "$req_fail" -eq 0 ]; then
  echo "==== PREREQS OK ($warn_fail warning(s)) ===="
  exit 0
fi
echo "==== PREREQS FAILED: $req_fail required check(s) red, $warn_fail warning(s) ===="
exit 1
