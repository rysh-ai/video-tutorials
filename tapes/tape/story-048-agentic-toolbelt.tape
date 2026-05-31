# Story 48: The Agentic Toolbelt (50s)
# Hook: "Every prompt-mode pane carries 35+ tools -- files, git, code, tests, build, web, and cross-pane coordination."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-048-agentic-toolbelt.tape

# --- Output Settings ---
Output story-048-agentic-toolbelt.mp4
Output story-048-agentic-toolbelt.gif

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
# "Every prompt-mode pane carries thirty-five-plus tools --
#  files, git, code, tests, build, web, and cross-pane coordination."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Launch rysh. In any pane, the AI agent already has a full toolbelt wired up."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:16  Switch to prompt mode
# "Double-press Escape to enter prompt mode -- the marker turns into a
#  less-than sign. Now you're talking to the agent."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:16-0:30  Ask the agent to list its tools
# "Ask it to list its tools. Under the hood it calls the list_tools tool
#  and reports every capability it has -- no approval needed for that one."
# ============================================================
Type "list all the tools you have available"
Enter
Sleep 10s

# ============================================================
# 0:30-0:45  Narrate the categories
# "The tools fall into clear categories: file and shell, git, code intelligence,
#  testing and build, background execution, and web. Read-only tools run freely;
#  anything that writes, commits, or runs dangerous commands asks for approval first."
# ============================================================
Sleep 4s

# ============================================================
# 0:45-0:50  Hold final frame
# "One agent, one toolbelt, in every pane you open."
# ============================================================
Sleep 3s
