# Story 1: What Is Rysh? (60s)
# Hook: "A terminal that thinks. Shell mode runs commands. Prompt mode talks to AI."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-01-what-is-rysh.tape

# --- Output Settings ---
Output story-01-what-is-rysh.mp4
Output story-01-what-is-rysh.gif

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
# "A terminal that thinks. Shell mode runs commands.
#  Prompt mode talks to AI."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:07  Launch rysh
# "Start rysh and you land in shell mode -- your familiar terminal."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:07-0:13  Run a shell command
# "In shell mode, everything works like a normal terminal.
#  Run any command you want."
# ============================================================
Type "ls -la"
Enter
Sleep 3s

# ============================================================
# 0:13-0:20  Switch to prompt mode with double-Escape
# "Double-press Escape to switch to prompt mode.
#  Watch the prompt change to < -- now you're talking to AI."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:20-0:32  Type an AI prompt and wait for response
# "Ask the AI anything. It sees your terminal context."
# ============================================================
Type "explain this directory structure"
Enter
Sleep 10s

# ============================================================
# 0:32-0:37  Return to shell mode with Escape
# "Press Escape to go back to shell mode."
# ============================================================
Escape
Sleep 2s

# ============================================================
# 0:37-0:43  Split a pane with Ctrl+P n
# "Ctrl+P enters pane mode. Press n to split right --
#  now you have two independent terminals side by side."
# ============================================================
Ctrl+p
Sleep 1s
Type "n"
Sleep 2s

# Exit pane mode
Escape
Sleep 0.5s

# ============================================================
# 0:43-0:49  Create a new tab with Ctrl+T n
# "Ctrl+T enters tab mode. Press n for a new tab --
#  a whole separate workspace."
# ============================================================
Ctrl+t
Sleep 1s
Type "n"
Sleep 2s

# Exit tab mode
Escape
Sleep 0.5s

# ============================================================
# 0:49-0:57  Quick tour -- switch tabs and panes
# "Navigate your workspace: brackets switch tabs,
#  Tab key cycles panes. Your AI-powered terminal is ready."
# ============================================================
Type "["
Sleep 1.5s
Tab
Sleep 1.5s
Tab
Sleep 1.5s
Type "]"
Sleep 1.5s

# ============================================================
# 0:57-1:00  Hold final frame
# ============================================================
Sleep 3s
