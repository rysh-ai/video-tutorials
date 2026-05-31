# Story 62: Approve Always & Reject With Reason (45s)
# Hook: "Approve once and forever, or reject with a reason the agent can learn from."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-062-approve-always-reject-reason.tape

# --- Output Settings ---
Output story-062-approve-always-reject-reason.mp4
Output story-062-approve-always-reject-reason.gif

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
# "Approve once and forever, or reject with a reason
#  the agent can learn from."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh and switch into prompt mode to talk to the agent."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:16  Ask for a file write to trigger approval
# "Ask the agent to create a file. file_write is a gated tool,
#  so an approval prompt appears in the footer."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s
Type "create a file notes.txt with a short todo list"
Enter
Sleep 10s

# ============================================================
# 0:16-0:26  Approve always with capital Y
# "Press capital Y to approve always. Rysh remembers this
#  decision so the same kind of action won't ask again."
# ============================================================
Type "Y"
Sleep 6s

# ============================================================
# 0:26-0:38  Reject with reason on a second prompt
# "Now ask for something risky. Press capital N to reject
#  with a reason -- type why, and the agent adapts."
# ============================================================
Type "now delete notes.txt"
Enter
Sleep 9s
Type "N"
Sleep 2s
Type "keep the file, just empty it instead"
Enter
Sleep 6s

# ============================================================
# 0:38-0:45  Recap the keys
# "y approves, capital Y always approves, n rejects,
#  capital N rejects with a reason, and Escape rejects silently."
# ============================================================
Sleep 4s
