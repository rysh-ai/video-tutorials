# Story 58: Reading Background Output / Killing (40s)
# Hook: "Check on a background job with bash_output, and shut it down with kill_shell."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - A background session already running in this pane (see story 57)
#
# Run: vhs story-058-reading-background-output-killing.tape

# --- Output Settings ---
Output story-058-reading-background-output-killing.mp4
Output story-058-reading-background-output-killing.gif

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
# "Check on a background job with bash_output,
#  and shut it down with kill_shell."
# ============================================================
Sleep 3.29s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh -- assume a background job is already running here."
# ============================================================
Type "rysh"
Enter
Sleep 5.1s

# ============================================================
# 0:08-0:13  Switch to prompt mode
# "Double-press Escape for prompt mode."
# ============================================================
Escape
Sleep 0.7s
Escape
Sleep 4.63s

# ============================================================
# 0:13-0:28  Ask to read the background output
# "Ask what the background jobs are doing. The bash_output tool reads from a
#  session's ring buffer, or lists every running session if you don't name one.
#  It's read-only, so there's no approval prompt."
# ============================================================
Type "list my background sessions and show their latest output"
Enter
Sleep 12.15s

# ============================================================
# 0:28-0:37  Ask to kill the session
# "When you're done, ask it to stop the job. The kill_shell tool terminates the
#  session and returns its final output. Killing is approval-gated -- press y to confirm."
# ============================================================
Type "kill that background session"
Enter
Sleep 5.07s
Type "y"
Sleep 2.54s

# ============================================================
# 0:37-0:40  Hold final frame
# "Watch it, then end it -- full control over background work."
# ============================================================
Sleep 3.29s
