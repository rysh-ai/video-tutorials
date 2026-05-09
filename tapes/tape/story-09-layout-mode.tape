# Story 9: Layout Mode (50s)
# Hook: "Resize panes on the fly -- arrow keys in layout mode."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-09-layout-mode.tape

# --- Output Settings ---
Output story-09-layout-mode.mp4
Output story-09-layout-mode.gif

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
# "Resize panes on the fly -- arrow keys in layout mode."
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
# 0:06-0:14  Create a 3-pane layout
# "Build a 3-pane layout: two splits with Ctrl+P n."
# ============================================================

# First split right
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 1.5s
Escape
Sleep 0.5s

# Second split right
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 1.5s
Escape
Sleep 0.5s

# Label the panes
Type "echo 'Pane 3'"
Enter
Sleep 0.5s

Tab
Sleep 0.5s
Type "echo 'Pane 1'"
Enter
Sleep 0.5s

Tab
Sleep 0.5s
Type "echo 'Pane 2'"
Enter
Sleep 0.5s

Tab
Sleep 0.5s

Sleep 1s

# ============================================================
# 0:14-0:24  Ctrl+L = enter layout mode, Right arrow to grow
# "Ctrl+L enters layout mode. Right arrow grows the
#  current pane's width."
# ============================================================
Ctrl+l
Sleep 1.5s

# Grow width with Right arrow
Right
Sleep 0.5s
Right
Sleep 0.5s
Right
Sleep 0.5s
Right
Sleep 0.5s
Right
Sleep 1s

# ============================================================
# 0:24-0:30  Left arrow to shrink width
# "Left arrow shrinks it back."
# ============================================================
Left
Sleep 0.5s
Left
Sleep 0.5s
Left
Sleep 0.5s
Left
Sleep 0.5s
Left
Sleep 1s

# ============================================================
# 0:30-0:38  Down arrow to grow height, Up to shrink
# "Down arrow grows height. Up arrow shrinks it."
# ============================================================
Down
Sleep 0.5s
Down
Sleep 0.5s
Down
Sleep 0.5s
Down
Sleep 0.5s
Down
Sleep 1s

Up
Sleep 0.5s
Up
Sleep 0.5s
Up
Sleep 0.5s
Up
Sleep 0.5s
Up
Sleep 1s

# ============================================================
# 0:38-0:43  Escape to exit layout mode
# "Press Escape to lock in your layout."
# ============================================================
Escape
Sleep 2s

# ============================================================
# 0:43-0:50  Final frame
# "Ctrl+L, arrow keys, Escape. Resize any pane to fit
#  your workflow."
# ============================================================
Type "echo 'Layout adjusted!'"
Enter
Sleep 3s
