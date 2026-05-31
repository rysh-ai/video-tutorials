# Story 25: Equalize, Swap & Fullscreen (45s)
# Hook: "Three quick moves to reset chaos: equalize, swap lanes, and go fullscreen."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-025-equalize-swap-fullscreen.tape

# --- Output Settings ---
Output story-025-equalize-swap-fullscreen.mp4
Output story-025-equalize-swap-fullscreen.gif

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
# "Three quick moves to reset chaos:
#  equalize, swap lanes, and go fullscreen."
# ============================================================
Sleep 1s

# ============================================================
# 0:04-0:16  Launch rysh and make an uneven layout
# "Start rysh, split into columns, then grow one pane wide
#  so we've got an uneven layout to fix."
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
Sleep 1s
Ctrl+l
Sleep 1s
Right
Sleep 1s
Right
Sleep 2s

# ============================================================
# 0:16-0:23  h or = equalize widths
# "Still in layout mode, press h or equals to equalize all
#  the widths -- instantly balanced columns."
# ============================================================
Type "="
Sleep 2s

# ============================================================
# 0:23-0:30  v equalize heights
# "Press v to equalize heights the same way for stacked rows."
# ============================================================
Type "v"
Sleep 2s

# ============================================================
# 0:30-0:37  s swap lanes
# "Press s to swap lane positions and reorder your columns."
# ============================================================
Type "s"
Sleep 2s

# ============================================================
# 0:37-0:45  m fullscreen, exit, hold
# "And m fullscreens the active pane -- same as Alt+P f from
#  normal mode. Press it again to restore, Escape to finish."
# ============================================================
Type "m"
Sleep 2s
Type "m"
Sleep 1s
Escape
Sleep 3s
