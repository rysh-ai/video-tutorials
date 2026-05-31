# Story 105: Overflow Menu & Pane Actions (40s)
# Hook: "Long-press a pane on mobile and the full action menu opens up."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-105-overflow-menu-pane-actions.tape

# --- Output Settings ---
Output story-105-overflow-menu-pane-actions.mp4
Output story-105-overflow-menu-pane-actions.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:05  Title / Hook
# "Long-press a pane on mobile and the full
#  action menu opens up."
# ============================================================
Sleep 1s

# ============================================================
# 0:05-0:15  Overflow menu actions
# "A long-press, or the overflow menu, gives you the common pane actions:
#  copy the output, rename the pane, or share it."
# ============================================================
Type "echo 'Overflow / long-press menu: Copy output | Rename | Share'"
Enter
Sleep 3s

# ============================================================
# 0:15-0:25  Terminal focus control
# "There is a terminal focus control too -- you decide when keystrokes go into the
#  pane versus when you are just scrolling and reading."
# ============================================================
Type "echo 'Terminal focus control: type into the pane vs. scroll & read'"
Enter
Sleep 3s

# ============================================================
# 0:25-0:34  Landscape keyboard avoidance
# "And rotating to landscape works cleanly -- the on-screen keyboard is handled
#  with keyboard avoidance so it never covers the pane you are typing in."
# ============================================================
Type "echo 'Landscape: keyboard avoidance keeps the active pane in view'"
Enter
Sleep 3s

# ============================================================
# 0:34-0:40  Wrap
# "Everything you need to manage a pane -- one press away."
# ============================================================
Type "echo 'Pane actions on mobile: one long-press away'"
Enter
Sleep 4s
