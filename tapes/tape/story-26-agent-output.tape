# Story 26: Agent Output Routing (40s)
# Hook: "Route agent output to any pane -- monitor your agents in real time."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-26-agent-output.tape

# --- Output Settings ---
Output story-26-agent-output.mp4
Output story-26-agent-output.gif

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
# "Start rysh -- we'll route agent output to a named pane."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:06  Switch to prompt mode
# "Double-press Escape to enter prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:06-0:10  Spawn a monitor agent
# "Create an agent that watches for issues."
# ============================================================
Type "##agent spawn monitor Watch for issues and report."
Enter
Sleep 2s

# ============================================================
# 0:10-0:14  Name the current pane
# "Name this pane so we can reference it."
# ============================================================
Type "##pane name my-pane"
Enter
Sleep 1s

# ============================================================
# 0:14-0:18  Register output routing
# "Route the monitor agent's output to my-pane.
#  Everything the agent says will appear here."
# ============================================================
Type "##agent register-output monitor my-pane"
Enter
Sleep 1s

# ============================================================
# 0:18-0:30  Send a task to the agent
# "Ask the agent to check the current directory.
#  Output streams to the registered pane."
# ============================================================
Type "@monitor check the current directory for any issues"
Enter
Sleep 8s

# ============================================================
# 0:30-0:34  Wait for response
# "The agent's response appears in the named pane."
# ============================================================
Sleep 4s

# ============================================================
# 0:34-0:38  Unregister output
# "Unregister when you no longer need the routing."
# ============================================================
Type "##agent unregister-output monitor my-pane"
Enter
Sleep 1s

# ============================================================
# 0:38-0:40  Hold final frame
# "Output routing: full control over where agent responses go."
# ============================================================
Sleep 2s
