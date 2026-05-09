# Story 12: Shell Mode (35s)
# Hook: "Shell mode is a real terminal. Full PTY, full ANSI,
#  full history. No compromises."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-12-shell-mode.tape

# --- Output Settings ---
Output story-12-shell-mode.mp4
Output story-12-shell-mode.gif

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
# "Shell mode is a real terminal. No compromises."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:06  Launch rysh
# "Start rysh -- you're in shell mode by default."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:06-0:11  Run echo to show full PTY
# "Full PTY terminal. Everything works as expected."
# ============================================================
Type "echo 'Shell mode - full PTY terminal'"
Enter
Sleep 2s

# ============================================================
# 0:11-0:15  List files
# "Run any command -- ls, grep, git, whatever you need."
# ============================================================
Type "ls -la"
Enter
Sleep 2s

# ============================================================
# 0:15-0:18  Show pwd
# "Check your working directory."
# ============================================================
Type "pwd"
Enter
Sleep 1.5s

# ============================================================
# 0:18-0:21  Show date
# "Run date, or any other standard command."
# ============================================================
Type "date"
Enter
Sleep 1.5s

# ============================================================
# 0:21-0:26  Show ANSI color support
# "Full ANSI color support -- your terminal, your colors."
# ============================================================
Type "echo 'Full ANSI color support'"
Enter
Sleep 2s

# ============================================================
# 0:26-0:32  Up arrow for history navigation
# "Up arrow navigates command history, just like any terminal."
# ============================================================
Up
Sleep 1s
Up
Sleep 1s
Up
Sleep 1s

# ============================================================
# 0:32-0:35  Hold final frame
# ============================================================
Sleep 3s
