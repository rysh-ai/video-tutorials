# Story 70: Inspecting & Sending Across Panes (45s)
# Hook: "Your agent can read another pane's state and even type into it -- with approval."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-070-inspecting-sending-across-panes.tape

# --- Output Settings ---
Output story-070-inspecting-sending-across-panes.mp4
Output story-070-inspecting-sending-across-panes.gif

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
# "Your agent can read another pane's state and even
#  type into it -- with approval."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:09  Launch rysh and split a pane
# "Start rysh and split a second pane so the agent has a
#  neighbor to inspect and drive."
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
# 0:09-0:20  List the workspace agents
# "From prompt mode, ask the agent who else is around.
#  The agents_list tool shows every pane and its status."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s
Type "list all the panes in this workspace and their status"
Enter
Sleep 10s

# ============================================================
# 0:20-0:32  Inspect another pane
# "Ask it to inspect that other pane. pane_inspect reads the
#  pane's recent output and state without you switching focus."
# ============================================================
Type "inspect the other pane and tell me what's running there"
Enter
Sleep 10s

# ============================================================
# 0:32-0:42  Send input across panes (approval-gated)
# "Now have it send a command into that pane. pane_send injects
#  input -- and because it acts elsewhere, it asks for approval."
# ============================================================
Type "send 'pwd' to the other pane"
Enter
Sleep 8s
Type "y"
Sleep 3s

# ============================================================
# 0:42-0:45  Hold final frame
# "Inspect, coordinate, and act across panes -- safely."
# ============================================================
Sleep 3s
