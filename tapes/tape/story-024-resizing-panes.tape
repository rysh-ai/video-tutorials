# Story 24: Resizing Panes (40s)
# Hook: "Give the important pane more room -- arrow keys in layout mode flex the space."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-024-resizing-panes.tape

# --- Output Settings ---
Output story-024-resizing-panes.mp4
Output story-024-resizing-panes.gif

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
# "Give the important pane more room --
#  arrow keys in layout mode flex the space."
# ============================================================
Sleep 4.16s

# ============================================================
# 0:04-0:14  Launch rysh and build a column plus a row
# "Start rysh, split right for a second column,
#  then split down so we can resize in both directions."
# ============================================================
Type "rysh"
Enter
Sleep 3.22s
Ctrl+p
Sleep 1.07s
Type "n"
Sleep 1.07s
Ctrl+p
Sleep 1.07s
Type "v"
Sleep 2.15s
Escape
Sleep 1.07s

# ============================================================
# 0:14-0:19  Enter layout mode
# "Press Ctrl+L. Now the arrow keys resize the active pane."
# ============================================================
Ctrl+l
Sleep 5.13s

# ============================================================
# 0:19-0:27  Right / Left for width
# "Right grows the pane's width, Left shrinks it.
#  The neighbors give and take flex weight as you go."
# ============================================================
Right
Sleep 2.03s
Right
Sleep 2.02s
Left
Sleep 4.05s

# ============================================================
# 0:27-0:35  Up / Down for height
# "Up and Down adjust height within the column.
#  It's all flex-based, so the layout always stays proportional."
# ============================================================
Up
Sleep 2.03s
Up
Sleep 2.02s
Down
Sleep 4.05s

# ============================================================
# 0:35-0:40  Exit, hold frame
# "Escape when it looks right. Arrow keys -- the simplest way
#  to tune every pane's size."
# ============================================================
Escape
Sleep 5.13s
