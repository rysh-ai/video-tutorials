# Story 7: Stacked Panes (45s)
# Hook: "Stack panes like cards -- flip through them instantly."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-07-stacked-panes.tape

# --- Output Settings ---
Output story-07-stacked-panes.mp4
Output story-07-stacked-panes.gif

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
# "Stack panes like cards -- flip through them instantly."
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
# 0:06-0:10  Type in Pane 1
# "This is pane 1 -- the bottom of our stack."
# ============================================================
Type "echo 'Pane 1 - Top of stack'"
Enter
Sleep 1.5s

# ============================================================
# 0:10-0:16  Ctrl+P then s = create stacked pane
# "Ctrl+P, then s creates a stacked pane. It slides on
#  top of the current pane."
# ============================================================
Ctrl+p
Sleep 1s
Type "s"
Sleep 2s

# Exit pane mode
Escape
Sleep 0.5s

Type "echo 'Pane 2 - On top now'"
Enter
Sleep 1.5s

# ============================================================
# 0:16-0:22  Another stacked pane
# "Do it again -- Ctrl+P, s. Now we have three panes
#  stacked in the same space."
# ============================================================
Ctrl+p
Sleep 1s
Type "s"
Sleep 2s

# Exit pane mode
Escape
Sleep 0.5s

Type "echo 'Pane 3 - Newest'"
Enter
Sleep 1.5s

# ============================================================
# 0:22-0:32  Ctrl+S = stack mode, j/k to navigate
# "Ctrl+S enters stack mode. Press j to go to the next
#  pane in the stack, k to go back."
# ============================================================
Ctrl+S
Sleep 1s

# j = rotate to next pane in stack
Type "j"
Sleep 1.5s

Type "j"
Sleep 1.5s

Type "j"
Sleep 1.5s

# k = rotate to previous pane in stack
Type "k"
Sleep 1.5s

Type "k"
Sleep 1.5s

# ============================================================
# 0:32-0:38  Escape to exit stack mode
# "Press Escape to exit stack mode. Your panes stay
#  stacked and ready."
# ============================================================
Escape
Sleep 2s

# ============================================================
# 0:38-0:45  Show the result
# "Stacked panes give you maximum screen real estate.
#  One column, multiple contexts -- flip through them
#  with j and k."
# ============================================================
Type "echo 'Stacked panes save screen space!'"
Enter
Sleep 3s
