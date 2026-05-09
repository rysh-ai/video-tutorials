# Story 24: Spawning an Agent (50s)
# Hook: "Create autonomous agents that work alongside you -- spawn, prompt, and control them."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-24-spawning-agent.tape

# --- Output Settings ---
Output story-24-spawning-agent.mp4
Output story-24-spawning-agent.gif

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
# "Start rysh -- your multi-agent terminal."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:10  Switch to prompt mode and spawn an agent
# "Double-press Escape to enter prompt mode.
#  Use ##agent spawn to create an autonomous agent."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:10-0:16  Spawn the code-reviewer agent
# "Give it a name and a system prompt -- the agent is born."
# ============================================================
Type "##agent spawn code-reviewer You are a code reviewer. Review code for quality and correctness."
Enter
Sleep 2s

# ============================================================
# 0:16-0:20  List agents
# "##agent list shows all running agents and their status."
# ============================================================
Type "##agent list"
Enter
Sleep 2s

# ============================================================
# 0:20-0:32  Send a prompt to the agent
# "Use @agent-name to talk directly to an agent.
#  The agent processes the request autonomously."
# ============================================================
Type "@code-reviewer review the files in the current directory"
Enter
Sleep 8s

# ============================================================
# 0:32-0:38  Wait for response and observe
# "The agent uses its tools to analyze the codebase."
# ============================================================
Sleep 4s

# ============================================================
# 0:38-0:42  Deactivate the agent
# "Use @@agent-name deactivate to pause an agent."
# ============================================================
Type "@@code-reviewer deactivate"
Enter
Sleep 1s

# ============================================================
# 0:42-0:46  Activate the agent
# "Use @@agent-name activate to resume it."
# ============================================================
Type "@@code-reviewer activate"
Enter
Sleep 1s

# ============================================================
# 0:46-0:50  Hold final frame
# "Spawn, prompt, control -- agents at your fingertips."
# ============================================================
Sleep 4s
