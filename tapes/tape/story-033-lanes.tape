# Story 33: Lanes (##lane / ##new lane) (40s)
# Hook: "Lanes are the columns that organize your panes -- manage them directly."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-033-lanes.tape

# --- Output Settings ---
Output story-033-lanes.mp4
Output story-033-lanes.gif

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
# "Lanes are the columns that organize your panes --
#  manage them directly."
# ============================================================
Sleep 3.16s

# ============================================================
# 0:03-0:09  Launch rysh and enter rysh mode
# "Start rysh and cycle into rysh mode
#  with double-Escape."
# ============================================================
Type "rysh"
Enter
Sleep 3.13s
Escape
Sleep 0.32s
Escape
Sleep 0.31s
Escape
Sleep 0.31s
Escape
Sleep 1.57s

# ============================================================
# 0:09-0:16  ##new lane
# "New lane adds a fresh column to the tab,
#  ready to hold its own panes."
# ============================================================
Type "##new lane"
Enter
Sleep 6.55s

# ============================================================
# 0:16-0:24  ##lane list
# "Lane list shows every lane in the active tab
#  with its identifier and contents."
# ============================================================
Type "##lane list"
Enter
Sleep 7.53s

# ============================================================
# 0:24-0:31  ##lane info
# "Lane info zooms into the lane holding
#  your active pane -- its panes, groups, and flex weight."
# ============================================================
Type "##lane info"
Enter
Sleep 6.47s

# ============================================================
# 0:31-0:40  ##lane name and ##lane delete
# "Lane name gives a lane a readable label,
#  and lane delete removes one you no longer need.
#  Lanes give your layout real structure."
# ============================================================
Type "##lane name backend"
Enter
Sleep 3.22s
Type "##lane list"
Enter
Sleep 3.86s
