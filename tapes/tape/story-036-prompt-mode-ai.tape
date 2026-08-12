# Story 36: Prompt Mode AI (50s)
# Hook: "Prompt mode turns your pane into an AI agent that sees your terminal."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - A configured provider (api_key set, or claude CLI on PATH)
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-036-prompt-mode-ai.tape

# --- Output Settings ---
Output story-036-prompt-mode-ai.mp4
Output story-036-prompt-mode-ai.gif

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
# "Prompt mode turns your pane into an AI agent
#  that sees your terminal."
# ============================================================
Sleep 3.24s

# ============================================================
# 0:03-0:09  Launch rysh and set context
# "Start rysh and run a command so the agent
#  has some context to work with."
# ============================================================
Type "rysh"
Enter
Sleep 3.34s
Type "ls -la"
Enter
Sleep 2.23s

# ============================================================
# 0:09-0:16  Switch to prompt mode
# "Double-press Escape. The prompt becomes a less-than sign --
#  input now goes to the configured LLM provider,
#  Claude over the API or the claude CLI."
# ============================================================
Escape
Sleep 0.97s
Escape
Sleep 6.43s

# ============================================================
# 0:16-0:32  Ask the AI
# "Ask it anything. The agent sees your terminal context
#  and answers with rendered markdown -- and it has
#  thirty-five-plus tools for files, git, and the web."
# ============================================================
Type "explain what this directory contains"
Enter
Sleep 14.48s

# ============================================================
# 0:32-0:44  A follow-up
# "Follow up naturally -- the conversation carries forward
#  within the pane's own AI output stream."
# ============================================================
Type "which file is the entry point?"
Enter
Sleep 10.62s

# ============================================================
# 0:44-0:50  Back to shell, hold
# "Press Escape to return to shell mode.
#  Your agent is always one double-Escape away."
# ============================================================
Escape
Sleep 6.4s
