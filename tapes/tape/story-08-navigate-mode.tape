# Story 8: Navigate Mode (40s)
# Hook: "Navigate your pane grid -- Tab cycles through them all."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-08-navigate-mode.tape

# --- Output Settings ---
Output story-08-navigate-mode.mp4
Output story-08-navigate-mode.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:03  Title / Hook
# "Navigate your pane grid -- Tab cycles through them all."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:06  Launch rysh
# "Start rysh with a single pane."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:06-0:16  Create a 2x2 grid of panes
# "Let's build a 2x2 grid. Ctrl+P n splits right,
#  Ctrl+P v splits down."
# ============================================================

# Split right -- now we have left | right
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 1.5s
Escape
Sleep 0.5s

# Tab back to left pane
Tab
Sleep 0.5s

# Split down in left column -- now top-left and bottom-left
Ctrl+p
Sleep 0.5s
Type "v"
Sleep 1.5s
Escape
Sleep 0.5s

# Tab to right pane
Tab
Sleep 0.5s

# Split down in right column -- now top-right and bottom-right
Ctrl+p
Sleep 0.5s
Type "v"
Sleep 1.5s
Escape
Sleep 0.5s

# ============================================================
# 0:16-0:26  Label each pane with an echo command
# "Label each quadrant so we can see focus change."
# ============================================================

# We are in bottom-right after the last split
Type "echo 'Bottom Right'"
Enter
Sleep 1s

Tab
Sleep 0.5s
Type "echo 'Top Left'"
Enter
Sleep 1s

Tab
Sleep 0.5s
Type "echo 'Bottom Left'"
Enter
Sleep 1s

Tab
Sleep 0.5s
Type "echo 'Top Right'"
Enter
Sleep 1s

# ============================================================
# 0:26-0:36  Cycle through all 4 panes with Tab
# "Tab cycles focus through every pane. Watch the
#  highlighted border move around the grid."
# ============================================================
Tab
Sleep 1.5s
Tab
Sleep 1.5s
Tab
Sleep 1.5s
Tab
Sleep 1.5s

# ============================================================
# 0:36-0:40  Final frame
# "Four panes, one key to navigate. Tab takes you
#  through each pane in order."
# ============================================================
Sleep 3s
