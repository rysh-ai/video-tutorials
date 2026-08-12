# Story 77: Talking To & Controlling Agents (45s)
# Hook: "@name to prompt it, @@name to command it."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-077-talking-to-and-controlling-agents.tape

# --- Output Settings ---
Output story-077-talking-to-and-controlling-agents.mp4
Output story-077-talking-to-and-controlling-agents.gif

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
# "At-name to prompt it,
#  double-at-name to command it."
# ============================================================
Sleep 3.07s

# ============================================================
# 0:03-0:10  Launch rysh and spawn an agent
# "Launch rysh, drop into rysh mode, and spawn a reviewer to work with."
# ============================================================
Type "rysh"
Enter
Sleep 0.35s
Escape
Sleep 0.1s
Escape
Sleep 0.1s
Escape
Sleep 0.1s
Escape
Sleep 0.17s
Type "##agent spawn code-reviewer 'You review code carefully and concisely.'"
Enter
Sleep 0.35s

# ============================================================
# 0:10-0:22  Prompt the agent with @name
# "A single at-sign plus the name sends a prompt.
#  The agent runs it with its full toolbelt and reports back."
# ============================================================
Type "@code-reviewer what are the top three things you check in a pull request?"
Enter
Sleep 6.74s

# ============================================================
# 0:22-0:31  Control with @@name deactivate
# "Two at-signs send a control command instead of a prompt.
#  Deactivate pauses the agent -- it keeps its state but ignores prompts."
# ============================================================
Type "@@code-reviewer deactivate"
Enter
Sleep 7.19s

# ============================================================
# 0:31-0:38  Reactivate
# "Activate brings it right back to life."
# ============================================================
Type "@@code-reviewer activate"
Enter
Sleep 5.3s

# ============================================================
# 0:38-0:45  Delete the agent
# "And ##agent delete removes it entirely when you're done.
#  Prompt, pause, resume, delete -- you're always in control."
# ============================================================
Type "##agent delete code-reviewer"
Enter
Sleep 5s
