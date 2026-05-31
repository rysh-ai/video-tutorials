# Story 34: Four Input Modes (50s)
# Hook: "One pane, four modes. Double-Escape cycles through them all."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-034-four-input-modes.tape

# --- Output Settings ---
Output story-034-four-input-modes.mp4
Output story-034-four-input-modes.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:03  Title / Hook
# "One pane, four modes.
#  Double-Escape cycles through them all."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh in shell mode
# "Start rysh and you land in shell mode --
#  the greater-than prompt runs commands in your PTY."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Type "echo shell mode"
Enter
Sleep 2s

# ============================================================
# 0:08-0:18  Double-Escape to prompt mode
# "Double-press Escape. The prompt becomes a less-than sign --
#  that's prompt mode, where input goes to your AI agent
#  with its own output stream."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:18-0:28  Double-Escape to rysh mode
# "Double-Escape again and the prompt turns to hash-hash.
#  This is rysh mode for built-in system commands."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 1.5s
Type "##help"
Enter
Sleep 3s

# ============================================================
# 0:28-0:38  Double-Escape to chat mode
# "Once more and the prompt shows an at-sign --
#  chat mode, a separate AI chat with its own buffer."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:38-0:46  Double-Escape back to shell
# "A final double-Escape brings you full circle
#  back to shell. Greater-than, less-than, hash-hash, at-sign."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:46-0:50  Hold final frame
# "Four markers, one key. Each mode keeps its own stream."
# ============================================================
Sleep 3s
