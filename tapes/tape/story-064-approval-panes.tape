# Story 64: Approval Panes (40s)
# Hook: "Route every approval request to one dedicated pane and triage them in one place."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-064-approval-panes.tape

# --- Output Settings ---
Output story-064-approval-panes.mp4
Output story-064-approval-panes.gif

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
# "Route every approval request to one dedicated pane
#  and triage them in one place."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh and split a pane
# "Start rysh, then split a second pane that will collect
#  approvals from across your workspace."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s
Escape
Sleep 1s

# ============================================================
# 0:08-0:18  Name this pane the approval pane
# "Switch to rysh mode and register this pane as the approval
#  pane. Now tool requests from other panes land right here."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 2s
Type "##pane approval-pane approvals"
Enter
Sleep 3s

# ============================================================
# 0:18-0:30  Manage the approval pane
# "List pending approvals, clear the queue, and enable an
#  attention indicator so you never miss a waiting action."
# ============================================================
Type "##pane approval-pane list"
Enter
Sleep 3s
Type "##pane approval-pane enable-attention"
Enter
Sleep 3s

# ============================================================
# 0:30-0:37  Clear the queue
# "A quick clear empties the queue when you're caught up."
# ============================================================
Type "##pane approval-pane clear"
Enter
Sleep 3s

# ============================================================
# 0:37-0:40  Hold final frame
# "One pane, every decision, no context switching."
# ============================================================
Sleep 3s
