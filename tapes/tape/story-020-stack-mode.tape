# Story 20: Stack Mode (Ctrl+S) (40s)
# Hook: "Ctrl+S turns a stack into a flip-book -- rotate through your panes with j and k."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-020-stack-mode.tape

# --- Output Settings ---
Output story-020-stack-mode.mp4
Output story-020-stack-mode.gif

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
# "Ctrl+S turns a stack into a flip-book --
#  rotate through your panes with j and k."
# ============================================================
Sleep 4.2s

# ============================================================
# 0:04-0:14  Launch rysh and build a 3-pane stack
# "Start rysh, then stack three panes with Ctrl+P, s --
#  twice over -- so the title reads one of three."
# ============================================================
Type "rysh"
Enter
Sleep 3.68s
Ctrl+p
Sleep 1.23s
Type "s"
Sleep 1.23s
Ctrl+p
Sleep 1.23s
Type "s"
Sleep 2.46s

# ============================================================
# 0:14-0:19  Enter stack mode
# "Press Ctrl+S to enter stack mode.
#  Now j and k rotate the deck."
# ============================================================
Ctrl+S
Sleep 5.18s

# ============================================================
# 0:19-0:26  j -- rotate next
# "Press j to bring the next pane to the front.
#  The counter ticks forward."
# ============================================================
Type "j"
Sleep 3.61s
Type "j"
Sleep 3.6s

# ============================================================
# 0:26-0:33  k -- rotate previous
# "Press k to rotate back the other way.
#  You can fan through every pane in the group."
# ============================================================
Type "k"
Sleep 3.61s
Type "k"
Sleep 3.6s

# ============================================================
# 0:33-0:40  Esc -- exit, hold frame
# "Escape leaves stack mode. j and k -- that's all it takes
#  to navigate a deck of stacked panes."
# ============================================================
Escape
Sleep 7.28s
