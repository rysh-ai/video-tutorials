# Story 39: Help & History (40s)
# Hook: "Forget a command? Rysh tells you. ##help lists everything, ##history recalls what you typed."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-039-help-and-history.tape

# --- Output Settings ---
Output story-039-help-and-history.mp4
Output story-039-help-and-history.gif

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
# "Forget a command? Rysh tells you.
#  ##help lists everything, ##history recalls what you typed."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:07  Launch rysh
# "Launch rysh and run a couple of shell commands to build up some history."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:07-0:14  Build some history
# "Every command you run is remembered, per input mode."
# ============================================================
Type "ls -la"
Enter
Sleep 2s
Type "pwd"
Enter
Sleep 2s

# ============================================================
# 0:14-0:20  Switch to rysh mode
# "Double-press Escape twice to reach rysh mode --
#  the prompt becomes a double-hash, ready for system commands."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s

# ============================================================
# 0:20-0:28  Run ##help
# "Type ##help to list every system command Rysh understands --
#  tabs, panes, lanes, sharing, snapshots, and more."
# ============================================================
Type "##help"
Enter
Sleep 4s

# ============================================================
# 0:28-0:37  Run ##history
# "Type ##history -- or just ##h -- to see the command history
#  for the current input mode. Nothing gets lost."
# ============================================================
Type "##history"
Enter
Sleep 4s

# ============================================================
# 0:37-0:40  Hold final frame
# "Help and history: your two-command safety net inside any pane."
# ============================================================
Sleep 3s
