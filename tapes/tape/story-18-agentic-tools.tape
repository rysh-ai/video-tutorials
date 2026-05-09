# Story 18: 35+ Agentic Tools (60s)
# Hook: "Your AI co-pilot comes loaded with 35+ tools -- file ops, search, git, and more."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-18-agentic-tools.tape

# --- Output Settings ---
Output story-18-agentic-tools.mp4
Output story-18-agentic-tools.gif

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
# "Start rysh -- you land in shell mode."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Switch to prompt mode with double-Escape
# "Double-press Escape to enter prompt mode.
#  The prompt changes to < -- now you're talking to AI."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:08-0:22  Ask AI to list all available tools
# "Ask the AI to show its full toolkit.
#  35+ tools covering file ops, search, git, web, and more."
# ============================================================
Type "list all your available tools"
Enter
Sleep 8s

# ============================================================
# 0:22-0:28  Let the tool list render
# "File read, file write, glob search, grep, bash execution,
#  git operations, web fetch, context store -- the list goes on."
# ============================================================
Sleep 6s

# ============================================================
# 0:28-0:38  Ask AI to read a file
# "Now put a tool to work -- read the first 10 lines
#  of the nearest README."
# ============================================================
Type "read the first 10 lines of the nearest README file"
Enter
Sleep 5s

# ============================================================
# 0:38-0:48  Watch the response
# "The AI calls its file_read tool behind the scenes
#  and returns the content right in your terminal."
# ============================================================
Sleep 5s

# ============================================================
# 0:48-0:55  Return to shell mode
# "Press Escape to drop back to shell mode."
# ============================================================
Escape
Sleep 2s

# ============================================================
# 0:55-1:00  Hold final frame
# "35+ tools, zero setup. Your AI is ready to work."
# ============================================================
Sleep 5s
