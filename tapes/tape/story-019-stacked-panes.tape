# Story 19: Stacked Panes (45s)
# Hook: "Stack panes like a deck of cards -- many terminals in the footprint of one."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-019-stacked-panes.tape

# --- Output Settings ---
Output story-019-stacked-panes.mp4
Output story-019-stacked-panes.gif

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
# "Stack panes like a deck of cards --
#  many terminals in the footprint of one."
# ============================================================
Sleep 1s

# ============================================================
# 0:04-0:09  Launch rysh
# "Start rysh with a single pane."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:09-0:17  Ctrl+P s -- first stack
# "Press Ctrl+P then s to stack a new pane on top of the group.
#  The border title now reads one of two."
# ============================================================
Ctrl+p
Sleep 1s
Type "s"
Sleep 2s

# ============================================================
# 0:17-0:25  Ctrl+P s -- second stack
# "Stack another and the title shows one of three.
#  Only the front pane is full-size."
# ============================================================
Ctrl+p
Sleep 1s
Type "s"
Sleep 2s

# ============================================================
# 0:25-0:35  Observe grey background title bars
# "The panes behind it sit in the same slot, showing up as grey
#  title bars at the bottom -- a deck you flip through."
# ============================================================
Escape
Sleep 1s
Type "echo front of the stack"
Enter
Sleep 3s

# ============================================================
# 0:35-0:45  Recap / hold frame
# "Stacking keeps related terminals together without crowding
#  your screen. Next up: rotating through the stack."
# ============================================================
Sleep 4s
