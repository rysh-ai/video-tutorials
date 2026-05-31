# Story 102: Multi-Workspace in Desktop (40s)
# Hook: "Many workspaces, one window. The desktop app stacks them two rows high."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-102-multi-workspace-desktop.tape

# --- Output Settings ---
Output story-102-multi-workspace-desktop.mp4
Output story-102-multi-workspace-desktop.gif

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
# "Many workspaces, one window.
#  The desktop app stacks them two rows high."
# ============================================================
Sleep 1s

# ============================================================
# 0:05-0:14  Two-row header
# "The desktop header has two rows. The top row lists your workspaces;
#  the row below lists the tabs inside the workspace you have selected."
# ============================================================
Type "echo 'Header row 1: workspaces   |   Header row 2: tabs of the active workspace'"
Enter
Sleep 3s

# ============================================================
# 0:14-0:23  Switching
# "Click a workspace up top to switch your entire context -- a different project,
#  a different upstream, a different set of tabs and panes."
# ============================================================
Type "echo 'Switch workspace -> swap the whole project context'"
Enter
Sleep 3s

# ============================================================
# 0:23-0:32  Voice and pipeline panel
# "The desktop app also surfaces voice prompting and a dedicated pipeline output
#  panel, so multi-stage runs are visible right beside your panes."
# ============================================================
Type "echo 'Plus: voice prompting + a pipeline output panel'"
Enter
Sleep 3s

# ============================================================
# 0:32-0:40  Wrap
# "One window, every workspace -- the desktop app is built for juggling projects."
# ============================================================
Type "echo 'Multi-workspace desktop: juggle projects without leaving the window'"
Enter
Sleep 4s
