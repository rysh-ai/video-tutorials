# Story 20: Background Bash (45s)
# Hook: "Run long commands in the background. Check on them whenever you want."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-20-background-bash.tape

# --- Output Settings ---
Output story-20-background-bash.mp4
Output story-20-background-bash.gif

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
# 0:00-0:04  Launch rysh
# "Start rysh -- you land in shell mode."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Switch to prompt mode with double-Escape
# "Double-press Escape to enter prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:08-0:18  Ask AI to run a background command
# "Ask the AI to run a long-running command in the background.
#  It won't block your terminal."
# ============================================================
Type "run 'sleep 5 && echo done' in the background"
Enter
Sleep 5s

# ============================================================
# 0:18-0:23  Wait and then check on it
# "While the command runs, you keep working.
#  Check the output whenever you want."
# ============================================================
Sleep 2s
Type "check the background session output"
Enter
Sleep 3s

# ============================================================
# 0:23-0:30  See the output
# "The AI retrieves the output from the background session."
# ============================================================
Sleep 4s

# ============================================================
# 0:30-0:38  List all background sessions
# "List all background sessions to see what's running."
# ============================================================
Type "list all background sessions"
Enter
Sleep 3s

# ============================================================
# 0:38-0:42  See the session list
# "Every background session is tracked -- you never
#  lose track of running tasks."
# ============================================================
Sleep 2s

# ============================================================
# 0:42-0:45  Hold final frame
# "Background bash -- fire and forget, check anytime."
# ============================================================
Sleep 3s
