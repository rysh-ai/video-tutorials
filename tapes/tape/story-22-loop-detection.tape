# Story 22: Loop Detection (30s)
# Hook: "Rysh detects when the AI gets stuck in a loop and breaks it out."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-22-loop-detection.tape

# --- Output Settings ---
Output story-22-loop-detection.mp4
Output story-22-loop-detection.gif

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
# 0:00-0:04  Launch rysh
# "Start rysh -- you land in shell mode."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Explain loop detection -- title
# "The orchestrator watches for repetitive tool calls."
# ============================================================
Type "echo 'Loop Detection'"
Enter
Sleep 2s

# ============================================================
# 0:08-0:13  Explain the tracking mechanism
# "It tracks the last 20 tool calls in a sliding window."
# ============================================================
Type "echo 'The orchestrator tracks the last 20 tool calls'"
Enter
Sleep 2s

# ============================================================
# 0:13-0:18  Explain the threshold
# "After 3 identical calls in a row, execution is blocked."
# ============================================================
Type "echo 'After 3 identical calls, execution is blocked'"
Enter
Sleep 2s

# ============================================================
# 0:18-0:23  Explain the recovery
# "The AI is told to try a different approach."
# ============================================================
Type "echo 'The AI is told to try a different approach'"
Enter
Sleep 2s

# ============================================================
# 0:23-0:27  Explain the sliding window
# "The sliding window means no permanent penalty --
#  old calls age out naturally."
# ============================================================
Type "echo 'Sliding window - no permanent penalty'"
Enter
Sleep 2s

# ============================================================
# 0:27-0:30  Hold final frame
# "Loop detection keeps the AI productive, not stuck."
# ============================================================
Sleep 3s
