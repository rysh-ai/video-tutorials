# Story 104: Per-Mode Streams & Scrollback (45s)
# Hook: "Shell, AI, Chat, Rysh -- four streams, one pane, all on your phone."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-104-per-mode-streams-scrollback.tape

# --- Output Settings ---
Output story-104-per-mode-streams-scrollback.mp4
Output story-104-per-mode-streams-scrollback.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:05  Title / Hook
# "Shell, AI, Chat, Rysh -- four streams,
#  one pane, all on your phone."
# ============================================================
Sleep 5.11s

# ============================================================
# 0:05-0:15  Bottom mode tabs
# "At the bottom of a pane, mobile shows tabs for each mode: Shell, AI, Chat,
#  and Rysh. Each one is its own independent output stream."
# ============================================================
Type "echo 'Bottom mode tabs: [ Shell ] [ AI ] [ Chat ] [ Rysh ]'"
Enter
Sleep 5.72s

# ============================================================
# 0:15-0:25  Unread badges
# "When a mode you are not looking at produces output -- say the AI finishes a
#  reply -- that tab gets an unread badge so nothing slips past you."
# ============================================================
Type "echo 'Background output -> unread badge on its mode tab'"
Enter
Sleep 5.95s

# ============================================================
# 0:25-0:36  Per-pane per-mode scrollback
# "Scrollback is kept per pane and per mode, so scrolling up in the AI stream
#  never disturbs your shell history -- each thread stays separate."
# ============================================================
Type "echo 'Scrollback is tracked per pane AND per mode -- threads never mix'"
Enter
Sleep 5.84s

# ============================================================
# 0:36-0:45  Wrap
# "Switch modes with a tap, scroll each one on its own -- the full four-mode
#  model, sized for a small screen."
# ============================================================
Type "echo 'Tap to switch modes, scroll each independently'"
Enter
Sleep 5.15s
