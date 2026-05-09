# Story 11: Four Input Modes (50s)
# Hook: "Four modes, one terminal. Shell, Prompt, Rysh, Chat --
#  double-Escape cycles through them all."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-11-four-input-modes.tape

# --- Output Settings ---
Output story-11-four-input-modes.mp4
Output story-11-four-input-modes.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:03  Title / Hook
# "Four modes, one terminal. Double-Escape cycles between them."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:07  Launch rysh -- lands in shell mode
# "Start rysh -- you land in shell mode with the > prompt."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:07-0:14  Shell mode: run a command
# "Shell mode works like any terminal. Run commands normally."
# ============================================================
Type "ls -la"
Enter
Sleep 4s

# ============================================================
# 0:14-0:18  Double-Escape to switch to prompt mode
# "Double-press Escape to cycle to the next mode.
#  The prompt changes to < -- you're now in prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:18-0:28  Prompt mode: ask the AI a question
# "In prompt mode, type a question. The AI sees your context."
# ============================================================
Type "what files are in the current directory?"
Enter
Sleep 3s

# ============================================================
# 0:28-0:34  Double-Escape to rysh mode
# "Double-Escape again. The prompt changes to ## --
#  this is rysh mode for system commands."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:34-0:40  Rysh mode: type a system command
# "In rysh mode, type system commands like help."
# ============================================================
Type "help"
Enter
Sleep 2s

# ============================================================
# 0:40-0:44  Double-Escape to chat mode
# "Double-Escape once more. The prompt changes to @ --
#  chat mode for extended AI conversations."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 1s

# ============================================================
# 0:44-0:48  Double-Escape back to shell mode
# "And one more Double-Escape brings you full circle
#  back to shell mode with the > prompt."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:48-0:50  Hold final frame
# ============================================================
Sleep 2s
