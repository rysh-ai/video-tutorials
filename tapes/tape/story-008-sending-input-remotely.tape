# Story 8: Sending Input Remotely (45s)
# Hook: "Drive a session from the outside -- no attach required."
#
# Run: vhs story-008-sending-input-remotely.tape

# --- Output Settings ---
Output story-008-sending-input-remotely.mp4
Output story-008-sending-input-remotely.gif

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
# 0:00-0:05  Title / Hook
# "Drive a running session from the outside --
#  no attach required."
# ============================================================
Sleep 5s

# ============================================================
# 0:05-0:15  Send to the active pane
# "rysh send delivers input to a session's active pane.
#  Here we run ls -la in my-session without attaching."
# ============================================================
Type "rysh send my-session 'ls -la'"
Sleep 3.1s
Enter
Sleep 4.65s

# ============================================================
# 0:15-0:24  Target a specific pane
# "Add --pane with a pane ID to target one exact pane."
# ============================================================
Type "rysh send my-session 'go test ./...' --pane abc123"
Sleep 2.07s
Enter
Sleep 3.1s

# ============================================================
# 0:24-0:34  Send a prompt
# "Use --mode prompt to send an AI prompt instead of a command --
#  the agent in that pane handles it."
# ============================================================
Type "rysh send my-session 'summarize the codebase' --mode prompt"
Sleep 2.2s
Enter
Sleep 3.3s

# ============================================================
# 0:34-0:45  Force shell mode
# "Or --mode shell to run a command explicitly.
#  Omit --mode and Rysh uses the pane's current mode."
# ============================================================
Type "rysh send my-session 'make build' --mode shell"
Sleep 2.49s
Enter
Sleep 4.98s
