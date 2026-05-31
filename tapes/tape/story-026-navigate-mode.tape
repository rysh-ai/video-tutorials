# Story 26: Navigate Mode (Ctrl+Space) (40s)
# Hook: "Move by direction, not by order -- Ctrl+Space lets you focus panes with arrows."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-026-navigate-mode.tape

# --- Output Settings ---
Output story-026-navigate-mode.mp4
Output story-026-navigate-mode.gif

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
# "Move by direction, not by order --
#  Ctrl+Space lets you focus panes with arrows."
# ============================================================
Sleep 1s

# ============================================================
# 0:04-0:16  Launch rysh and build a grid
# "Start rysh and build a small grid: split right for a column,
#  then split down in each so panes sit above and beside each other."
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
Type "v"
Sleep 2s
Escape
Sleep 1s

# ============================================================
# 0:16-0:21  Enter navigate mode
# "Press Ctrl+Space to enter navigate mode."
# ============================================================
Ctrl+Space
Sleep 2s

# ============================================================
# 0:21-0:30  Directional focus with arrows / hjkl
# "Arrow keys or h, j, k, l move focus by direction --
#  left, down, up, right -- jumping to the pane that's actually there."
# ============================================================
Type "h"
Sleep 1s
Type "l"
Sleep 1s
Type "j"
Sleep 1s
Type "k"
Sleep 2s

# ============================================================
# 0:30-0:36  Exit navigate mode and confirm focus
# "Escape leaves navigate mode with that pane focused,
#  ready for input."
# ============================================================
Escape
Sleep 1s
Type "echo focused here"
Enter
Sleep 2s

# ============================================================
# 0:36-0:40  Hold frame
# "Tab cycles in order; Ctrl+Space moves by direction.
#  Pick whichever feels natural."
# ============================================================
Sleep 3s
