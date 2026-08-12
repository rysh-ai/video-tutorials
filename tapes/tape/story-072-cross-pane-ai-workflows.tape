# Story 72: Cross-Pane AI Workflows (40s)
# Hook: "Combine listening, inspection, and sending to solve problems across many panes at once."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-072-cross-pane-ai-workflows.tape

# --- Output Settings ---
Output story-072-cross-pane-ai-workflows.mp4
Output story-072-cross-pane-ai-workflows.gif

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
# "Combine listening, inspection, and sending to solve
#  problems across many panes at once."
# ============================================================
Sleep 3.26s

# ============================================================
# 0:03-0:10  Launch rysh and build a small grid
# "Start rysh and create a couple of panes -- think of one as
#  a server and one as a coordinator."
# ============================================================
Type "rysh"
Enter
Sleep 2.39s
Ctrl+p
Sleep 0.4s
Type "n"
Sleep 1.2s
Escape
Sleep 0.4s
Ctrl+p
Sleep 0.4s
Type "n"
Sleep 1.19s
Escape
Sleep 0.8s

# ============================================================
# 0:10-0:18  Coordinator discovers the workspace
# "From the coordinator pane, the agent lists every pane with
#  agents_list to see what's running and where."
# ============================================================
Escape
Sleep 0.1s
Escape
Sleep 0.63s
Type "list every pane, then inspect each one and report their state"
Enter
Sleep 3.16s

# ============================================================
# 0:18-0:32  Drive a fix across panes
# "Now it inspects a failing pane and uses pane_send to apply a
#  fix there -- a full multi-pane workflow from one prompt."
# ============================================================
Type "if any pane shows an error, send the command to fix it there"
Enter
Sleep 8.13s
Type "y"
Sleep 2.44s

# ============================================================
# 0:32-0:40  Recap
# "Listen, inspect, and send -- together they turn separate
#  panes into one coordinated agentic team."
# ============================================================
Sleep 8.69s
