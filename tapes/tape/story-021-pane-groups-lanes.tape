# Story 21: Pane Groups & Lanes (45s)
# Hook: "Beneath every layout is a tree -- lanes hold groups, groups hold panes."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-021-pane-groups-lanes.tape

# --- Output Settings ---
Output story-021-pane-groups-lanes.mp4
Output story-021-pane-groups-lanes.gif

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
# "Beneath every layout is a tree --
#  lanes hold groups, groups hold panes."
# ============================================================
Sleep 4.11s

# ============================================================
# 0:04-0:14  Launch rysh and build a couple of columns
# "Start rysh and split right a couple of times.
#  Each column you create is a pane group with its own flex weight."
# ============================================================
Type "rysh"
Enter
Sleep 3.17s
Ctrl+p
Sleep 1.06s
Type "n"
Sleep 1.06s
Ctrl+p
Sleep 1.06s
Type "n"
Sleep 2.12s
Escape
Sleep 1.06s

# ============================================================
# 0:14-0:23  ##pg list
# "Switch to rysh mode and run ##pg list -- short for panegroup --
#  to see every group in the tab and its flex share."
# ============================================================
Type "##pg list"
Enter
Sleep 8.5s

# ============================================================
# 0:23-0:32  ##pg info
# "##pg info zooms in on the group holding the active pane."
# ============================================================
Type "##pg info"
Enter
Sleep 8.5s

# ============================================================
# 0:32-0:40  ##lane list
# "Lanes are the rows of columns that tile your tab.
#  ##lane list shows them, with the panes they contain."
# ============================================================
Type "##lane list"
Enter
Sleep 7.33s

# ============================================================
# 0:40-0:45  Hold frame
# "Lanes, groups, panes -- a tidy hierarchy you can inspect
#  any time from rysh mode."
# ============================================================
Sleep 5.14s
