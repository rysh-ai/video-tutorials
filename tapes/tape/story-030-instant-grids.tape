# Story 30: Instant Grids (##new grid) (50s)
# Hook: "Spin up a whole grid of agent panes with a single command."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-030-instant-grids.tape

# --- Output Settings ---
Output story-030-instant-grids.mp4
Output story-030-instant-grids.gif

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
# "Spin up a whole grid of agent panes
#  with a single command."
# ============================================================
Sleep 3.12s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh. Building layouts by hand is fine,
#  but the new grid command does it in one shot."
# ============================================================
Type "rysh"
Enter
Sleep 4.82s

# ============================================================
# 0:08-0:14  Switch to rysh mode
# "Double-press Escape until the prompt shows hash-hash --
#  that's rysh mode for system commands."
# ============================================================
Escape
Sleep 0.74s
Escape
Sleep 0.74s
Escape
Sleep 0.74s
Escape
Sleep 3.71s

# ============================================================
# 0:14-0:24  ##new grid 4
# "Give it a single number and it stacks that many
#  panes into the current lane. New grid four
#  builds a four-pane stack instantly."
# ============================================================
Type "##new grid 4"
Enter
Sleep 9.41s

# ============================================================
# 0:24-0:36  ##new grid 3x4
# "Add a dimension. Three by four lays out
#  three lanes, each holding four panes --
#  a twelve-pane wall in one keystroke."
# ============================================================
Type "##new grid 3x4"
Enter
Sleep 11.34s

# ============================================================
# 0:36-0:46  ##new grid 2x3x4
# "Go further with three dimensions: tabs, then lanes,
#  then panes. Two by three by four creates two tabs,
#  each with three lanes of four panes."
# ============================================================
Type "##new grid 2x3x4"
Enter
Sleep 9.11s

# ============================================================
# 0:46-0:50  Hold final frame
# "From one pane to a whole agent grid -- instantly."
# ============================================================
Sleep 4.15s
