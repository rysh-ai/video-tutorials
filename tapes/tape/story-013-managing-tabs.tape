# Story 13: Managing Tabs (##tab) (40s)
# Hook: "The ##tab command is your full tab control center -- list, inspect, delete, and pipeline."
#
# Run: vhs story-013-managing-tabs.tape

# --- Output Settings ---
Output story-013-managing-tabs.mp4
Output story-013-managing-tabs.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:04  Title / Hook
# "The ##tab command is your tab control center --
#  list, inspect, delete, and toggle pipelines."
# ============================================================
Sleep 2s

Type "rysh"
Enter
Sleep 3s

# Make a couple of tabs to manage
Ctrl+t
Sleep 1s
Type "n"
Sleep 1s
Type "n"
Sleep 1.5s
Escape
Sleep 1s

# Switch to rysh input mode
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1s

# ============================================================
# 0:04-0:14  List tabs
# "##tab list shows every tab with its ID
#  and how many panes it holds."
# ============================================================
Type "##tab list"
Sleep 2s
Enter
Sleep 3s

# ============================================================
# 0:14-0:23  List panes in a tab
# "##tab list-panes drills into the active tab
#  and lists the panes inside it."
# ============================================================
Type "##tab list-panes"
Sleep 2s
Enter
Sleep 3s

# ============================================================
# 0:23-0:31  Delete a tab
# "##tab delete with an ID removes a tab you no longer need."
# ============================================================
Type "##tab delete 3"
Sleep 2s
Enter
Sleep 3s

# ============================================================
# 0:31-0:40  Pipeline toggle
# "And ##tab pipeline enable turns on pipeline mode
#  for the tab; disable turns it back off."
# ============================================================
Type "##tab pipeline enable"
Sleep 2s
Enter
Sleep 4s
