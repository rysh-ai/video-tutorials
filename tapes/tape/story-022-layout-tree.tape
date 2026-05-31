# Story 22: Layout Tree (##pg layout) (40s)
# Hook: "See your whole tab at once -- ##pg layout draws the entire structure as a tree."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-022-layout-tree.tape

# --- Output Settings ---
Output story-022-layout-tree.mp4
Output story-022-layout-tree.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:04  Title / Hook
# "See your whole tab at once --
#  ##pg layout draws the entire structure as a tree."
# ============================================================
Sleep 1s

# ============================================================
# 0:04-0:16  Launch rysh and build a richer layout
# "Start rysh and build something with depth:
#  split right for a column, split down for a row,
#  then stack a pane on top."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Ctrl+p
Sleep 1s
Type "n"
Sleep 1s
Ctrl+p
Sleep 1s
Type "v"
Sleep 1s
Ctrl+p
Sleep 1s
Type "s"
Sleep 2s
Escape
Sleep 1s

# ============================================================
# 0:16-0:28  ##pg layout
# "In rysh mode, ##pg layout prints the full tree:
#  lanes, then groups, then the stacked panes inside them."
# ============================================================
Type "##pg layout"
Enter
Sleep 4s

# ============================================================
# 0:28-0:36  ##pg info for the active group
# "Pair it with ##pg info to drill into just the group
#  your active pane lives in."
# ============================================================
Type "##pg info"
Enter
Sleep 3s

# ============================================================
# 0:36-0:40  Hold frame
# "One command, the whole picture.
#  ##pg layout is your map of any tab."
# ============================================================
Sleep 3s
