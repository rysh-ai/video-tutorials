# Story 57: Background Bash (45s)
# Hook: "Long-running jobs don't block the agent -- bash_background returns a session id and keeps running."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-057-background-bash.tape

# --- Output Settings ---
Output story-057-background-bash.mp4
Output story-057-background-bash.gif

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
# "Long-running jobs don't block the agent --
#  bash_background returns a session id and keeps running."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh in a project with something long-running, like a dev server."
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
# 0:13-0:32  Ask the agent to start a background job
# "Ask it to start a long-running command in the background. The bash_background
#  tool launches it and immediately returns a session id, so the agent stays free
#  to keep working. Starting a background job is approval-gated -- press y to allow it."
# ============================================================
Type "start a long-running ping to localhost in the background"
Enter
Sleep 9s
Type "y"
Sleep 4s

# ============================================================
# 0:32-0:42  Narrate the ring buffer
# "Output is captured in a 256-kilobyte ring buffer, and the session persists
#  until you kill it or close the pane -- perfect for dev servers, watchers,
#  and build daemons you want to leave running."
# ============================================================
Sleep 4s

# ============================================================
# 0:42-0:45  Hold final frame
# "Fire it off, get a session id, and move on."
# ============================================================
Sleep 3s
