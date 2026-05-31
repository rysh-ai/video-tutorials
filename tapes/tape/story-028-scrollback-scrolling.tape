# Story 28: Scrollback & Scrolling (40s)
# Hook: "Long output scrolls off the top? Walk back through every line."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-028-scrollback-scrolling.tape

# --- Output Settings ---
Output story-028-scrollback-scrolling.mp4
Output story-028-scrollback-scrolling.gif

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
# "Long output scrolls off the top?
#  Walk back through every line."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh and generate a wall of output
#  so we have a real scrollback buffer to explore."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:14  Produce lots of output
# "Each pane keeps its own scrollback.
#  Let's fill it up."
# ============================================================
Type "seq 1 200"
Enter
Sleep 3s

# ============================================================
# 0:14-0:22  Page up and down
# "PageUp scrolls the active pane up one full page,
#  PageDown brings you back down a page at a time."
# ============================================================
PageUp
Sleep 1.5s
PageUp
Sleep 1.5s
PageDown
Sleep 2s

# ============================================================
# 0:22-0:30  Line-by-line with Shift+Up / Shift+Down
# "For fine control, Shift+Up and Shift+Down
#  move a single line per press."
# ============================================================
PageUp
Sleep 1s
PageUp
Sleep 1s
PageDown
Sleep 2s

# ============================================================
# 0:30-0:37  Home and End jump to top / bottom
# "Home snaps to the very top of the buffer,
#  and End drops you straight back to the live prompt."
# ============================================================
PageUp
Sleep 2s
PageDown
Sleep 2s

# ============================================================
# 0:37-0:40  Hold final frame
# "Page, line, top, bottom -- you never lose a line of history."
# ============================================================
Sleep 3s
