# Story 51: Running Bash (40s)
# Hook: "Ask in plain English, and the agent runs the shell for you -- dangerous patterns ask first."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-051-running-bash.tape

# --- Output Settings ---
Output story-051-running-bash.mp4
Output story-051-running-bash.gif

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
# "Ask in plain English, and the agent runs the shell for you --
#  dangerous patterns ask first."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh and switch over to the agent."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:13  Switch to prompt mode
# "Double-press Escape for prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:13-0:30  Ask about disk usage
# "Ask what's using your disk. The agent calls the bash tool to run a real
#  shell command and reads the output back to you. Safe, read-only commands
#  just run -- but anything matching a dangerous pattern needs your approval first."
# ============================================================
Type "what is my disk usage in this directory"
Enter
Sleep 10s

# ============================================================
# 0:30-0:37  Narrate the safety net
# "That approval gate is what makes the bash tool safe: deletes, force-pushes,
#  and other risky commands stop and wait for a yes before they ever execute."
# ============================================================
Sleep 4s

# ============================================================
# 0:37-0:40  Hold final frame
# "Natural language in, real shell commands out -- with a safety net."
# ============================================================
Sleep 3s
