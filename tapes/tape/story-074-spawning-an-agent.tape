# Story 74: Spawning an Agent (45s)
# Hook: "One command, one prompt, and your agent is alive."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-074-spawning-an-agent.tape

# --- Output Settings ---
Output story-074-spawning-an-agent.mp4
Output story-074-spawning-an-agent.gif

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
# "One command, one prompt,
#  and your agent is alive."
# ============================================================
Sleep 3.08s

# ============================================================
# 0:03-0:08  Launch rysh and enter rysh mode
# "Launch rysh and double-press Escape into rysh mode
#  to run the agent system commands."
# ============================================================
Type "rysh"
Enter
Sleep 2.47s
Escape
Sleep 0.25s
Escape
Sleep 0.25s
Escape
Sleep 0.25s
Escape
Sleep 1.24s

# ============================================================
# 0:08-0:18  Spawn the agent
# "Use ##agent spawn, then a name, then the system prompt in quotes.
#  That prompt defines the agent's whole personality and job."
# ============================================================
Type "##agent spawn code-reviewer 'You are a meticulous code reviewer focused on bugs and clarity.'"
Enter
Sleep 3.22s

# ============================================================
# 0:18-0:28  Spawn a second agent
# "Spawn as many as you need. Here's a second agent for writing tests."
# ============================================================
Type "##agent spawn test-writer 'You write thorough unit tests for Go code.'"
Enter
Sleep 4.94s

# ============================================================
# 0:28-0:40  List agents and their status
# "Then ##agent list shows every agent with its current status --
#  active, deactivated, or working a prompt right now."
# ============================================================
Type "##agent list"
Enter
Sleep 11.35s

# ============================================================
# 0:40-0:45  Hold final frame
# "Spawn, name, prompt, list. That's the whole lifecycle of an agent."
# ============================================================
Sleep 5.13s
