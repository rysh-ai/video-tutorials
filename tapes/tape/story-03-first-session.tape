# Story 3: Your First Session (50s)
# Hook: "Name your session. Detach. Reattach. Your work is always waiting."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing "my-project" session (run: rysh delete-session my-project)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-03-first-session.tape

# --- Output Settings ---
Output story-03-first-session.mp4
Output story-03-first-session.gif

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
# 0:00-0:02  Title / Hook
# "Name your session. Detach. Reattach. Your work is always waiting."
# ============================================================
Sleep 2s

# ============================================================
# 0:02-0:07  Launch a named session
# "Start rysh with a session name. This creates a persistent workspace."
# ============================================================
Type "rysh my-project"
Enter
Sleep 3s

# ============================================================
# 0:07-0:13  Run some commands in the session
# "Work as you normally would. Run commands, explore your project."
# ============================================================
Type "ls -la"
Enter
Sleep 2s

Type "git status"
Enter
Sleep 2s

# ============================================================
# 0:13-0:19  Split a pane
# "Ctrl+P n splits a pane. Now you have two terminals."
# ============================================================
Ctrl+p
Sleep 1s
Type "n"
Sleep 2s

# Exit pane mode
Escape
Sleep 0.5s

# ============================================================
# 0:19-0:24  Type a command in the second pane
# "Each pane is independent. Run different tasks side by side."
# ============================================================
Type "echo 'running tests in second pane'"
Enter
Sleep 2s

# ============================================================
# 0:24-0:30  Detach from session with Ctrl+O then d
# "Ctrl+O enters prefix mode. Press d to detach.
#  You're back at your original shell, but the session lives on."
# ============================================================
Ctrl+o
Sleep 1s
Type "d"
Sleep 3s

# ============================================================
# 0:30-0:36  List sessions
# "List your sessions to see what's running."
# ============================================================
Type "rysh list-sessions"
Enter
Sleep 3s

# ============================================================
# 0:36-0:44  Reattach to the session
# "Reattach and everything is exactly where you left it.
#  Your panes, your output, your context -- all preserved."
# ============================================================
Type "rysh attach my-project"
Enter
Sleep 5s

# ============================================================
# 0:44-0:50  Show session is restored -- cycle panes
# "Both panes are still here. Pick up right where you left off."
# ============================================================
Tab
Sleep 1.5s
Tab
Sleep 1.5s

# ============================================================
# Hold final frame
# ============================================================
Sleep 3s
