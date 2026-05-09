# Story 13: Prompt Mode (50s)
# Hook: "Prompt mode lets you talk to the AI with full context.
#  It sees your terminal, your files, your session."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-13-prompt-mode.tape

# --- Output Settings ---
Output story-13-prompt-mode.mp4
Output story-13-prompt-mode.gif

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
# 0:00-0:03  Title / Hook
# "Prompt mode -- talk to the AI with full terminal context."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:06  Launch rysh
# "Start rysh in shell mode."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:06-0:10  Double-Escape to prompt mode
# "Double-Escape switches to prompt mode.
#  The prompt changes to < -- now you're talking to AI."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:10-0:25  Ask the AI to explain directory contents
# "Ask a question in natural language. The AI sees your context."
# ============================================================
Type "explain what files are in this directory"
Enter
Sleep 5s

# ============================================================
# 0:25-0:28  Wait for the AI to finish responding
# "The AI responds with context-aware answers."
# ============================================================
Sleep 5s

# ============================================================
# 0:28-0:45  Ask a follow-up question
# "Ask a follow-up -- the AI remembers the conversation."
# ============================================================
Type "list the largest files"
Enter
Sleep 5s

# ============================================================
# 0:45-0:50  Wait for response and hold
# "Prompt mode gives you an AI assistant that lives
#  inside your terminal."
# ============================================================
Sleep 5s
