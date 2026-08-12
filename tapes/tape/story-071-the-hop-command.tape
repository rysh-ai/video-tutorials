# Story 71: The Hop Command (50s)
# Hook: "Hop a pane's output into another and let a fresh agent pick up right where you left off."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-071-the-hop-command.tape

# --- Output Settings ---
Output story-071-the-hop-command.mp4
Output story-071-the-hop-command.gif

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
# "Hop a pane's output into another and let a fresh agent
#  pick up right where you left off."
# ============================================================
Sleep 3.22s

# ============================================================
# 0:03-0:08  Launch rysh and split a pane
# "Start rysh and split a target pane to hop into."
# ============================================================
Type "rysh"
Enter
Sleep 2.2s
Ctrl+p
Sleep 0.37s
Type "n"
Sleep 1.46s
Escape
Sleep 0.73s

# ============================================================
# 0:08-0:18  Name the target pane
# "Name the right-hand pane so we can hop to it by name."
# ============================================================
Escape
Sleep 0.48s
Escape
Sleep 0.48s
Escape
Sleep 3.19s
Type "##pane name reviewer"
Enter
Sleep 4.78s

# ============================================================
# 0:18-0:30  Produce some output, then hop it
# "Back in the source pane, generate some work, then run
#  hop reviewer to transfer this pane's output to that one."
# ============================================================
Tab
Sleep 0.85s
Escape
Sleep 1.69s
Type "git log --oneline -5"
Enter
Sleep 2.54s
Escape
Sleep 0.25s
Escape
Sleep 0.25s
Escape
Sleep 1.69s
Type "##hop reviewer"
Enter
Sleep 2.53s

# ============================================================
# 0:30-0:40  Check status, then resume in the target pane
# "Check hop status to confirm. In the reviewer pane, run hop
#  resume and the agent continues with the copied text."
# ============================================================
Type "##hop status"
Enter
Sleep 3.26s
Tab
Sleep 1.09s
Type "##hop resume"
Enter
Sleep 4.35s

# ============================================================
# 0:40-0:47  Clear the hop
# "When the handoff is done, hop clear wipes the copied
#  content from the pane."
# ============================================================
Type "##hop clear"
Enter
Sleep 6.61s

# ============================================================
# 0:47-0:50  Hold final frame
# "Hand work from pane to pane in one command."
# ============================================================
Sleep 3.22s
