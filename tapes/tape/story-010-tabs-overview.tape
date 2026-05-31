# Story 10: Tabs Overview (45s)
# Hook: "Tabs hold panes, panes hold agents -- and switching between them is one keystroke."
#
# Run: vhs story-010-tabs-overview.tape

# --- Output Settings ---
Output story-010-tabs-overview.mp4
Output story-010-tabs-overview.gif

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
# 0:00-0:05  Title / Hook
# "Tabs hold panes, panes hold agents --
#  and switching between tabs is one keystroke."
# ============================================================
Sleep 2s

# ============================================================
# 0:05-0:13  Launch with the default layout
# "Start rysh and you get one tab with one pane.
#  That's your starting point."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:13-0:22  Make a couple of tabs to switch between
# "Let's add a tab so we have something to move between --
#  Ctrl+T, then n."
# ============================================================
Ctrl+t
Sleep 1s
Type "n"
Sleep 2s
Escape
Sleep 0.5s
Ctrl+t
Sleep 1s
Type "n"
Sleep 2s
Escape
Sleep 1s

# ============================================================
# 0:22-0:32  Switch tabs with brackets
# "The bracket keys move between tabs:
#  left bracket for previous, right bracket for next."
# ============================================================
Type "["
Sleep 2s
Type "["
Sleep 2s
Type "]"
Sleep 2s

# ============================================================
# 0:32-0:45  Switch tabs with Alt+Arrows
# "Alt plus the left and right arrows do the same thing.
#  Each tab is its own workspace of panes and agents."
# ============================================================
Type "["
Sleep 2s
Type "]"
Sleep 2s
Type "]"
Sleep 4s
