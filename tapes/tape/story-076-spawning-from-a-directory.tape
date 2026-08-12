# Story 76: Spawning From a Directory (40s)
# Hook: "A folder of skill files becomes a whole team of agents in one command."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-076-spawning-from-a-directory.tape

# --- Output Settings ---
Output story-076-spawning-from-a-directory.mp4
Output story-076-spawning-from-a-directory.gif

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
# "A folder of skill files becomes a whole team of agents
#  in one command."
# ============================================================
Sleep 2.63s

# ============================================================
# 0:03-0:08  Launch rysh
# "Launch rysh. Suppose you have a directory of agent skill files."
# ============================================================
Type "rysh"
Enter
Sleep 4.01s

# ============================================================
# 0:08-0:18  Create a directory of skill files
# "Each markdown file in the directory describes one agent."
# ============================================================
Type "mkdir -p .rysh/agents"
Enter
Sleep 0.1s
Type "printf -- '---\\nname: reviewer\\n---\\nYou review code.\\n' > .rysh/agents/reviewer.md"
Enter
Sleep 0.1s
Type "printf -- '---\\nname: tester\\n---\\nYou write tests.\\n' > .rysh/agents/tester.md"
Enter
Sleep 0.1s
Type "ls .rysh/agents"
Enter
Sleep 0.1s

# ============================================================
# 0:18-0:28  Spawn them all at once
# "Double-Escape into rysh mode and run ##agent spawn-all on the directory.
#  Rysh creates one agent per markdown file -- instantly."
# ============================================================
Escape
Sleep 0.34s
Escape
Sleep 0.34s
Escape
Sleep 0.34s
Escape
Sleep 1.71s
Type "##agent spawn-all .rysh/agents"
Enter
Sleep 3.42s

# ============================================================
# 0:28-0:37  List the spawned agents
# "##agent list shows the full roster -- a complete team
#  bootstrapped from one folder."
# ============================================================
Type "##agent list"
Enter
Sleep 6.92s

# ============================================================
# 0:37-0:40  Hold final frame
# "spawn-all: version your whole agent team in one directory."
# ============================================================
Sleep 2.63s
