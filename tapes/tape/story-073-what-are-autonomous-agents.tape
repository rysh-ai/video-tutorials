# Story 73: What Are Autonomous Agents? (50s)
# Hook: "Headless AI workers. No terminal, no pane -- just a brain with tools."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-073-what-are-autonomous-agents.tape

# --- Output Settings ---
Output story-073-what-are-autonomous-agents.mp4
Output story-073-what-are-autonomous-agents.gif

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
# "Headless AI workers. No terminal, no pane --
#  just a brain with tools."
# ============================================================
Sleep 3.24s

# ============================================================
# 0:03-0:08  Launch rysh
# "Launch rysh. Every pane is a shell plus an agent --
#  but autonomous agents live entirely in the background."
# ============================================================
Type "rysh"
Enter
Sleep 5.02s

# ============================================================
# 0:08-0:14  Switch to rysh mode
# "Double-press Escape twice to reach rysh mode,
#  where the double-hash system commands live."
# ============================================================
Escape
Sleep 0.77s
Escape
Sleep 0.77s
Escape
Sleep 0.77s
Escape
Sleep 3.86s

# ============================================================
# 0:14-0:24  Spawn an agent
# "Spawn an agent with a name and a system prompt.
#  It has no PTY and no terminal -- just its own AgenticActor
#  running independently in the workspace."
# ============================================================
Type "##agent spawn code-reviewer 'You review code for quality, correctness, and best practices.'"
Enter
Sleep 3.88s

# ============================================================
# 0:24-0:32  List agents
# "Check ##agent list to see every agent and its status.
#  Created via ##agent spawn, prompted with @name, controlled with @@name."
# ============================================================
Type "##agent list"
Enter
Sleep 7.65s

# ============================================================
# 0:32-0:44  Prompt the agent
# "Talk to it with the at-sign prefix from any input mode.
#  The agent runs the prompt with full tool access in the background."
# ============================================================
Type "@code-reviewer summarize what a good code review checks for"
Enter
Sleep 8.44s

# ============================================================
# 0:44-0:50  Hold final frame
# "Autonomous agents: tireless workers you spawn, prompt, and command --
#  without ever opening a pane."
# ============================================================
Sleep 6.47s
