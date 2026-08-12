# Story 61: Tool Approval Flow (50s)
# Hook: "Your AI agent never touches a file or runs a destructive command without your say-so."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-061-tool-approval-flow.tape

# --- Output Settings ---
Output story-061-tool-approval-flow.mp4
Output story-061-tool-approval-flow.gif

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
# "Your AI agent never touches a file or runs
#  a destructive command without your say-so."
# ============================================================
Sleep 3.19s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh. We are in shell mode -- your familiar terminal."
# ============================================================
Type "rysh"
Enter
Sleep 4.94s

# ============================================================
# 0:08-0:16  Switch to prompt mode and ask for an edit
# "Double-press Escape for prompt mode, then ask the agent
#  to change a file. Tools like file_edit always need approval."
# ============================================================
Escape
Sleep 0.11s
Escape
Sleep 0.75s
Type "add a hello world comment to the top of README.md"
Enter
Sleep 3.74s

# ============================================================
# 0:16-0:30  Approval prompt with diff preview
# "Before anything is written, the footer shows the action
#  and a diff preview. Nothing changes until you decide."
# ============================================================
Sleep 14.88s

# ============================================================
# 0:30-0:40  Approve with y
# "Press y to approve. The edit applies and the agent continues.
#  Press n to reject and the action is cancelled."
# ============================================================
Type "y"
Sleep 10.55s

# ============================================================
# 0:40-0:47  Recap the gate
# "Reads and searches run freely. But writes, patches,
#  commits, and dangerous bash are all gated behind you."
# ============================================================
Sleep 7.44s

# ============================================================
# 0:47-0:50  Hold final frame
# "You are always the final approver."
# ============================================================
Sleep 3.19s
