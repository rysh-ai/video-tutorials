# Story 5: Tabs and Panes (50s)
# Hook: "Tabs hold panes. Panes hold agents. It's that simple."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-05-tabs-and-panes.tape

# --- Output Settings ---
Output story-05-tabs-and-panes.mp4
Output story-05-tabs-and-panes.gif

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
# "Tabs hold panes. Panes hold agents. It's that simple."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:06  Launch rysh -- one tab, one pane
# "When you start rysh, you get one tab with one pane."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:06-0:10  Ctrl+T enters tab mode, press n for new tab
# "Ctrl+T enters tab mode. Press n to create a new tab."
# ============================================================
Ctrl+t
Sleep 1s
Type "n"
Sleep 2s

# ============================================================
# 0:10-0:15  Switch tabs with [ and ]
# "Square brackets switch tabs. Left bracket goes back,
#  right bracket goes forward."
# ============================================================

# Press Escape to exit tab mode first
Escape
Sleep 0.5s

# Switch to previous tab with [
Type "["
Sleep 1.5s

# Switch to next tab with ]
Type "]"
Sleep 1.5s

# ============================================================
# 0:18-0:23  Ctrl+P enters pane mode, press n to split right
# "Ctrl+P enters pane mode. Press n to split right --
#  a new pane in a new column."
# ============================================================
Ctrl+p
Sleep 1s
Type "n"
Sleep 2s

# ============================================================
# 0:23-0:29  Tab key cycles between panes
# "The Tab key cycles between panes.
#  Watch the border highlight change."
# ============================================================

# Exit pane mode first
Escape
Sleep 0.5s

Tab
Sleep 1.5s
Tab
Sleep 1.5s

# ============================================================
# 0:29-0:35  Type a command in each pane to show independence
# "Now you've got two panes side by side.
#  Each one is an independent terminal."
# ============================================================
Type "echo 'Hello from Pane 1'"
Enter
Sleep 1.5s

Tab
Sleep 0.5s
Type "echo 'Hello from Pane 2'"
Enter
Sleep 1.5s

# ============================================================
# 0:35-0:38  Alt+B/F to switch tabs (macOS Alt+Arrow emits these)
# "Alt plus arrow keys navigate globally.
#  Alt Left/Right switches tabs."
# Note: VHS doesn't support Alt+Arrow, so we use Alt+B / Alt+F
# which rysh also accepts for tab navigation on macOS.
# ============================================================
Alt+b
Sleep 1.5s
Alt+f
Sleep 1.5s

# ============================================================
# 0:38-0:42  Tab key cycles between panes
# "Tab key cycles between panes in the active tab."
# Note: Ctrl+Space (navigate mode) is not supported by VHS,
# so we use Tab cycling to demonstrate pane switching.
# ============================================================
Tab
Sleep 1.5s
Tab
Sleep 1.5s

# ============================================================
# 0:42-0:46  Create a third tab to show multi-tab workspace
# "Mix and match. Each tab is an independent workspace."
# ============================================================
Ctrl+t
Sleep 0.5s
Type "n"
Sleep 2s

# Exit tab mode
Escape
Sleep 0.5s

# Split a pane in this tab too
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 1.5s

# Exit pane mode
Escape
Sleep 0.5s

# ============================================================
# 0:46-0:50  Final tour -- cycle through tabs
# "Tabs organize your workspace. Each pane is an independent
#  terminal with its own shell and AI agent."
# ============================================================
Type "["
Sleep 1s
Type "["
Sleep 1s
Type "]"
Sleep 1s
Type "]"
Sleep 2s

# Hold final frame
Sleep 3s
