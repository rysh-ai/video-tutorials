# Story 63: Loop Detection & Last-Prompt-Wins (45s)
# Hook: "Runaway agents get stopped, and a new prompt always interrupts the old one."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-063-loop-detection-last-prompt-wins.tape

# --- Output Settings ---
Output story-063-loop-detection-last-prompt-wins.mp4
Output story-063-loop-detection-last-prompt-wins.gif

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
# "Runaway agents get stopped, and a new prompt
#  always interrupts the old one."
# ============================================================
Sleep 3.16s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh and drop into prompt mode."
# ============================================================
Type "rysh"
Enter
Sleep 2.69s
Escape
Sleep 0.27s
Escape
Sleep 1.79s

# ============================================================
# 0:08-0:20  Kick off a long-running prompt
# "Give the agent a big task. The orchestrator watches a
#  sliding window of twenty tool calls as it works."
# ============================================================
Type "analyze every file in this repo and summarize the architecture"
Enter
Sleep 7.93s

# ============================================================
# 0:20-0:34  Last-prompt-wins: a new prompt cancels the in-flight call
# "Change your mind mid-thought. Send a new prompt and the
#  in-flight LLM call is cancelled -- last prompt wins."
# ============================================================
Type "actually, just tell me the Go version in go.mod"
Enter
Sleep 11.16s

# ============================================================
# 0:34-0:42  Loop detection explained
# "And if the agent repeats the same tool call three times,
#  loop detection blocks it so it can never spin forever."
# ============================================================
Escape
Sleep 0.7s
Type "echo 'loop detection: blocks after 3 identical calls in a 20-call window'"
Enter
Sleep 2.11s

# ============================================================
# 0:42-0:45  Hold final frame
# "Safe by design: no infinite loops, always interruptible."
# ============================================================
Sleep 3.16s
