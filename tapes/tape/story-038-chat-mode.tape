# Story 38: Chat Mode (40s)
# Hook: "The at-sign prompt is chat mode -- a conversation lane separate from prompt mode."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - A configured provider (api_key set, or claude CLI on PATH)
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-038-chat-mode.tape

# --- Output Settings ---
Output story-038-chat-mode.mp4
Output story-038-chat-mode.gif

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
# "The at-sign prompt is chat mode --
#  a conversation lane separate from prompt mode."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:09  Launch rysh
# "Start rysh in shell mode, then we'll cycle
#  all the way around to chat."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:09-0:20  Cycle to chat mode
# "Double-Escape moves through prompt and rysh,
#  then lands on the at-sign marker -- that's chat mode,
#  for sending messages to AI chat."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 1s
Escape
Sleep 0.3s
Escape
Sleep 1s
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:20-0:32  Send a chat message
# "Chat keeps its own per-mode buffer, distinct from
#  prompt mode's stream. Type a message and send it."
# ============================================================
Type "give me one tip for using rysh effectively"
Enter
Sleep 10s

# ============================================================
# 0:32-0:40  Distinct from prompt mode
# "Chat and prompt are separate streams in the same pane --
#  one for quick conversation, one for agentic work.
#  Double-Escape returns you to shell."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 3s
