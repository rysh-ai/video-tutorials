# Story 40: Inspecting Your Workspace (45s)
# Hook: "Lost track of your layout? A handful of ## commands map your entire workspace."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-040-inspecting-your-workspace.tape

# --- Output Settings ---
Output story-040-inspecting-your-workspace.mp4
Output story-040-inspecting-your-workspace.gif

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
# "Lost track of your layout?
#  A handful of ## commands map your entire workspace."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:07  Launch rysh
# "Start rysh and build a small layout to inspect."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:07-0:13  Split to create structure
# "Ctrl+P then n splits right, giving us a second pane in a new group."
# ============================================================
Ctrl+p
Sleep 1s
Type "n"
Sleep 2s
Escape
Sleep 1s

# ============================================================
# 0:13-0:18  Enter rysh mode
# "Double-Escape over to rysh mode so we can issue inspection commands."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s

# ============================================================
# 0:18-0:24  ##pane info
# "##pane info shows the active pane's details --
#  id, mode, given-name, and status."
# ============================================================
Type "##pane info"
Enter
Sleep 3s

# ============================================================
# 0:24-0:30  ##tab list and ##lane list
# "##tab list shows every tab with its pane count;
#  ##lane list shows the columns in this tab."
# ============================================================
Type "##tab list"
Enter
Sleep 2s
Type "##lane list"
Enter
Sleep 2s

# ============================================================
# 0:30-0:36  ##pg list
# "##pg list -- short for panegroup list --
#  enumerates every pane group in the active tab."
# ============================================================
Type "##pg list"
Enter
Sleep 3s

# ============================================================
# 0:36-0:42  ##pg layout
# "And ##pg layout prints the full tab tree:
#  lanes, groups, and stacked panes, all in one view."
# ============================================================
Type "##pg layout"
Enter
Sleep 4s

# ============================================================
# 0:42-0:45  Hold final frame
# "Five commands, and you can see your whole workspace at a glance."
# ============================================================
Sleep 3s
