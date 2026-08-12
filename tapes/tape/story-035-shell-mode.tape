# Story 35: Shell Mode (40s)
# Hook: "Shell mode is a real terminal -- full color, full ANSI, nothing held back."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-035-shell-mode.tape

# --- Output Settings ---
Output story-035-shell-mode.mp4
Output story-035-shell-mode.gif

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
# "Shell mode is a real terminal --
#  full color, full ANSI, nothing held back."
# ============================================================
Sleep 3.2s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh and you're already in shell mode.
#  The greater-than marker is your cue."
# ============================================================
Type "rysh"
Enter
Sleep 4.95s

# ============================================================
# 0:08-0:16  Run a normal command
# "Every command runs in the pane's own PTY-backed shell,
#  exactly like the terminal you already know."
# ============================================================
Type "ls -la"
Enter
Sleep 8s

# ============================================================
# 0:16-0:26  Show color and ANSI
# "Color and ANSI escapes come through untouched --
#  git status, ls with color, anything that paints the screen."
# ============================================================
Type "git status"
Enter
Sleep 9.83s

# ============================================================
# 0:26-0:34  Pipes and environment
# "Pipes, redirects, environment variables --
#  it's a full shell, not a sandbox."
# ============================================================
Type "echo $SHELL && uname -a"
Enter
Sleep 6.72s

# ============================================================
# 0:34-0:40  Hold final frame
# "Shell mode is home base. Everything else is one
#  double-Escape away."
# ============================================================
Type "echo 'shell mode: your familiar terminal'"
Enter
Sleep 3.24s
