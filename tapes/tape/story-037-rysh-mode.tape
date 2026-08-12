# Story 37: Rysh Mode (## commands) (40s)
# Hook: "Hash-hash is rysh mode -- the control panel for your whole workspace."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-037-rysh-mode.tape

# --- Output Settings ---
Output story-037-rysh-mode.mp4
Output story-037-rysh-mode.gif

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
# "Hash-hash is rysh mode --
#  the control panel for your whole workspace."
# ============================================================
Sleep 3.29s

# ============================================================
# 0:03-0:09  Launch rysh and enter rysh mode
# "Start rysh, then double-Escape until the prompt
#  shows hash-hash. System commands inject their output
#  right into the active pane."
# ============================================================
Type "rysh"
Enter
Sleep 3.28s
Escape
Sleep 0.33s
Escape
Sleep 0.33s
Escape
Sleep 0.32s
Escape
Sleep 1.64s

# ============================================================
# 0:09-0:18  ##help
# "Help lists every system command --
#  panes, tabs, lanes, sharing, agents, and more."
# ============================================================
Type "##help"
Enter
Sleep 9.34s

# ============================================================
# 0:18-0:28  ##pane info
# "Try one: pane info reports the active pane's
#  details, all without leaving the keyboard."
# ============================================================
Type "##pane info"
Enter
Sleep 10.06s

# ============================================================
# 0:28-0:38  ##> vs ##
# "One caution: a line starting with hash-hash-greater-than
#  is not a command. Those are pipeline events,
#  forwarded straight to NATS instead of being run."
# ============================================================
Type "##tab list"
Enter
Sleep 10.14s

# ============================================================
# 0:38-0:40  Hold final frame
# "Rysh mode is how you drive the multiplexer itself."
# ============================================================
Sleep 2.19s
