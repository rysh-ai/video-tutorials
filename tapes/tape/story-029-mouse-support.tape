# Story 29: Mouse Support (40s)
# Hook: "Keyboard-first, but the mouse is right there when you want it."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-029-mouse-support.tape

# --- Output Settings ---
Output story-029-mouse-support.mp4
Output story-029-mouse-support.gif

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
# "Keyboard-first, but the mouse is right there
#  when you want it."
# ============================================================
Sleep 3.13s

# ============================================================
# 0:03-0:08  Launch rysh
# "Rysh has full mouse support built in.
#  Let's walk through what it can do."
# ============================================================
Type "rysh"
Enter
Sleep 4.85s

# ============================================================
# 0:08-0:14  Split so there are panes to click
# "Split into two panes. With the mouse, a single click
#  on any pane focuses it instantly."
# ============================================================
Ctrl+p
Sleep 0.86s
Type "n"
Sleep 2.59s
Escape
Sleep 2.59s

# ============================================================
# 0:14-0:24  Explain click-drag selection
# "Click and drag across text to select it.
#  When you release the button, the selection is copied
#  straight to your system clipboard."
# ============================================================
Type "echo 'click a pane to focus -- drag to select -- release to copy'"
Enter
Sleep 5.5s

# ============================================================
# 0:24-0:33  Explain wheel scrolling
# "The mouse wheel scrolls the pane under your cursor,
#  three lines per step, through the same scrollback buffer."
# ============================================================
Type "seq 1 120"
Enter
Sleep 3.09s
PageUp
Sleep 2.32s
PageDown
Sleep 3.09s

# ============================================================
# 0:33-0:40  Recap and hold
# "Click to focus, drag to select, release to copy,
#  wheel to scroll. The mouse and keyboard work together."
# ============================================================
Type "echo 'mouse + keyboard, your choice'"
Enter
Sleep 4.54s
