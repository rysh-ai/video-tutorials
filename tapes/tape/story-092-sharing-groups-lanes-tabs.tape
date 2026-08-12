# Story 92: Sharing Groups, Lanes & Tabs (45s)
# Hook: "Share one pane, or a whole tab. Each level brings its children along."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - An enabled [upstream] block in rysh.config
#
# Run: vhs story-092-sharing-groups-lanes-tabs.tape

# --- Output Settings ---
Output story-092-sharing-groups-lanes-tabs.mp4
Output story-092-sharing-groups-lanes-tabs.gif

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
# "Share one pane, or a whole tab.
#  Each level brings its children along."
# ============================================================
Sleep 3.16s

# ============================================================
# 0:03-0:10  Launch rysh and build a layout
# "Start rysh and split a couple of panes so we have a group,
#  a lane, and a tab worth sharing."
# ============================================================
Type "rysh"
Enter
Sleep 2.36s
Ctrl+p
Sleep 0.79s
Type "n"
Sleep 1.18s
Type "v"
Sleep 1.58s
Escape
Sleep 0.79s

# ============================================================
# 0:10-0:16  Enter rysh mode
# "Double-Escape into rysh mode. The share command works at
#  four scopes: pane, panegroup, lane, and tab."
# ============================================================
Escape
Sleep 0.76s
Escape
Sleep 0.75s
Escape
Sleep 0.75s
Escape
Sleep 3.76s

# ============================================================
# 0:16-0:24  Share the pane group
# "##share panegroup control shares the active group --
#  every stacked pane inside it comes along."
# ============================================================
Type "##share panegroup control"
Enter
Sleep 6.48s

# ============================================================
# 0:24-0:31  Share the lane
# "##share lane shares the whole column: all groups, all panes
#  in that lane, as one unit."
# ============================================================
Type "##share lane view"
Enter
Sleep 6.03s

# ============================================================
# 0:31-0:39  Share the tab
# "And ##share tab publishes the entire tab -- every lane and
#  pane your collaborators need, in one command."
# ============================================================
Type "##share tab view"
Enter
Sleep 7.15s

# ============================================================
# 0:39-0:45  List and hold
# "##share list shows all of them together. Share at the level
#  that fits the work."
# ============================================================
Type "##share list"
Enter
Sleep 5.35s
