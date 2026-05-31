# Story 23: Layout Mode (Ctrl+L) (45s)
# Hook: "Ctrl+L is where you shape your workspace -- resize, equalize, swap, and fullscreen."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-023-layout-mode.tape

# --- Output Settings ---
Output story-023-layout-mode.mp4
Output story-023-layout-mode.gif

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
# "Ctrl+L is where you shape your workspace --
#  resize, equalize, swap, and fullscreen."
# ============================================================
Sleep 1s

# ============================================================
# 0:04-0:14  Launch rysh and split into columns
# "Start rysh and split into a few columns so we have
#  something to rearrange."
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
Type "n"
Sleep 2s
Escape
Sleep 1s

# ============================================================
# 0:14-0:20  Enter layout mode
# "Press Ctrl+L to enter layout mode.
#  The footer lists every shaping key."
# ============================================================
Ctrl+l
Sleep 2s

# ============================================================
# 0:20-0:28  Arrow keys resize
# "Arrow keys resize the active pane --
#  Right and Left for width, Up and Down for height."
# ============================================================
Right
Sleep 1s
Right
Sleep 2s

# ============================================================
# 0:28-0:36  Equalize with = and fullscreen with m
# "Press equals to balance the widths back out,
#  and m to fullscreen the active pane."
# ============================================================
Type "="
Sleep 2s
Type "m"
Sleep 2s

# ============================================================
# 0:36-0:45  Toggle fullscreen off, exit, hold
# "Press m again to restore, then Escape to leave layout mode.
#  Resize, equalize, swap, fullscreen -- all under Ctrl+L."
# ============================================================
Type "m"
Sleep 1s
Escape
Sleep 3s
