# Story 37: Hop Command (45s)
# Hook: "Transfer your AI context to another pane -- hop and resume seamlessly."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-37-hop-command.tape

# --- Output Settings ---
Output story-37-hop-command.mp4
Output story-37-hop-command.gif

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
# "Start rysh -- context follows you across panes."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Work in pane A
# "Build up some context in this pane."
# ============================================================
Type "echo 'Working in pane A...'"
Enter
Sleep 0.5s

# ============================================================
# 0:08-0:11  More context
# "Run a few commands -- the AI remembers all of this."
# ============================================================
Type "echo 'Running some commands'"
Enter
Sleep 0.5s

# ============================================================
# 0:11-0:14  Even more context
# "The conversation and shell history form a rich context."
# ============================================================
Type "echo 'Building context'"
Enter
Sleep 0.5s

# ============================================================
# 0:14-0:20  Create pane B and name it
# "Split right and name the new pane 'target'."
# ============================================================
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s
Type "##pane name target"
Enter
Sleep 1s

# ============================================================
# 0:20-0:24  Tab back to pane A
# "Go back to the original pane where your context lives."
# ============================================================
Tab
Sleep 1s

# ============================================================
# 0:24-0:30  Hop to target
# "##hop target copies the full AI context to the target pane.
#  Conversation history, tool results, everything transfers."
# ============================================================
Type "##hop target"
Enter
Sleep 2s

# ============================================================
# 0:30-0:34  Tab to target pane
# "Switch to the target pane to pick up where you left off."
# ============================================================
Tab
Sleep 1s

# ============================================================
# 0:34-0:40  Resume in target
# "##hop resume tells the AI to continue with the transferred
#  context -- no re-explaining needed."
# ============================================================
Type "##hop resume"
Enter
Sleep 3s

# ============================================================
# 0:40-0:45  Hold final frame
# "Hop -- move your AI brain between panes instantly."
# ============================================================
Sleep 5s
