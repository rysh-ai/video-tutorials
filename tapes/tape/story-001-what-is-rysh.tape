# Story 1: What Is Rysh? (60s)
# Hook: "A terminal that thinks. Shell mode runs commands. Prompt mode talks to AI."
#
# Run: vhs story-001-what-is-rysh.tape

# --- Output Settings ---
Output story-001-what-is-rysh.mp4
Output story-001-what-is-rysh.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:04  Title / Hook
# "A terminal that thinks. Shell mode runs commands,
#  prompt mode talks to AI -- and every pane is both."
# ============================================================
Sleep 2s

# ============================================================
# 0:04-0:10  Launch rysh
# "Just type rysh. You land in shell mode --
#  your familiar terminal, fully PTY-backed."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:10-0:18  Run a shell command
# "In shell mode everything works like a normal terminal.
#  Full color, full ANSI -- run any command you want."
# ============================================================
Type "ls -la"
Enter
Sleep 3s

# ============================================================
# 0:18-0:26  Switch to prompt mode with double-Escape
# "Double-press Escape to cycle the input mode.
#  Watch the marker change to a less-than sign --
#  now you're talking to an AI agent."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:26-0:40  Type an AI prompt and wait for response
# "Ask anything. The agent sees your terminal context
#  and answers right inside the pane, rendered as markdown."
# ============================================================
Type "explain this directory structure"
Enter
Sleep 10s

# ============================================================
# 0:40-0:46  Return to shell mode
# "Escape again brings you back through the modes
#  to shell. One pane, two ways to work."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:46-0:53  Split a pane with Ctrl+P n
# "Ctrl+P enters pane mode. Press n to split right --
#  two independent panes, each its own shell and agent."
# ============================================================
Ctrl+p
Sleep 1s
Type "n"
Sleep 2s
Escape
Sleep 0.5s

# ============================================================
# 0:53-0:60  Create a new tab with Ctrl+T n
# "Ctrl+T enters tab mode. Press n for a whole new tab.
#  That's Rysh: every pane is a shell plus an AI agent."
# ============================================================
Ctrl+t
Sleep 1s
Type "n"
Sleep 2s
Escape
Sleep 3s
