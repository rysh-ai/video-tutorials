# Story 15: Pane Mode (Ctrl+P) (50s)
# Hook: "Ctrl+P is your pane command center -- split, stack, close, and rename without leaving the keyboard."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-015-pane-mode.tape

# --- Output Settings ---
Output story-015-pane-mode.mp4
Output story-015-pane-mode.gif

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
# "Ctrl+P is your pane command center --
#  split, stack, close, and rename without leaving the keyboard."
# ============================================================
Sleep 1s

# ============================================================
# 0:04-0:09  Launch rysh
# "Start rysh, then press Ctrl+P to enter pane mode."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:09-0:14  Enter pane mode
# "The footer shows your pane-mode bindings.
#  Every key now manages panes."
# ============================================================
Ctrl+p
Sleep 2s

# ============================================================
# 0:14-0:20  n = split right
# "Press n to split right -- a new pane opens in a new column."
# ============================================================
Type "n"
Sleep 2s

# ============================================================
# 0:20-0:27  v = split down
# "Press v to split down -- a new pane stacks below in the
#  same column."
# ============================================================
Ctrl+p
Sleep 1s
Type "v"
Sleep 2s

# ============================================================
# 0:27-0:34  s = stack
# "Press s to stack a pane on top of the active group --
#  like dealing a new card onto the deck."
# ============================================================
Ctrl+p
Sleep 1s
Type "s"
Sleep 2s

# ============================================================
# 0:34-0:42  r = rename
# "Press r to rename the active pane. Type a name, hit Enter,
#  and it becomes the pane's given-name."
# ============================================================
Ctrl+p
Sleep 1s
Type "r"
Sleep 1s
Type "builder"
Enter
Sleep 2s

# ============================================================
# 0:42-0:50  x = close, Esc = exit
# "Press x to close a pane, and Escape to leave pane mode
#  whenever you're done. Split, stack, rename -- all from Ctrl+P."
# ============================================================
Ctrl+p
Sleep 1s
Type "x"
Sleep 2s
Escape
Sleep 3s
