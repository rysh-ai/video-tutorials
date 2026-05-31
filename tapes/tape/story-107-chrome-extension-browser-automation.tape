# Story 107: Chrome Extension Browser Automation (50s)
# Hook: "A rysh pane that lives in your browser's side panel and drives the page."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-107-chrome-extension-browser-automation.tape

# --- Output Settings ---
Output story-107-chrome-extension-browser-automation.mp4
Output story-107-chrome-extension-browser-automation.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:05  Title / Hook
# "A rysh pane that lives in your browser's side panel
#  and drives the page."
# ============================================================
Sleep 1s

# ============================================================
# 0:05-0:15  The side panel is a pane
# "The Chrome extension's side panel is a real rysh pane -- same modes, same AI
#  agent -- except its job is to drive the browser you are looking at."
# ============================================================
Type "echo 'Chrome side panel = a rysh pane whose target is the browser'"
Enter
Sleep 3s

# ============================================================
# 0:15-0:26  How it connects
# "It connects to your session the same way every other client does: a
#  NATS-over-WebSocket link back to the bus."
# ============================================================
Type "echo 'Extension <-> session over NATS WebSocket -- same bus as the CLI'"
Enter
Sleep 3s

# ============================================================
# 0:26-0:38  Conversation persists across navigation
# "Because the agent lives in the pane and not the page, your conversation
#  persists across navigations -- click a link, load a new URL, the agent keeps
#  its full context."
# ============================================================
Type "echo 'Navigate to a new page -> the agent keeps the whole conversation'"
Enter
Sleep 3s

# ============================================================
# 0:38-0:50  Wrap
# "Ask the agent to fill a form or pull data, and it acts on the live tab --
#  a browser copilot wired into your terminal."
# ============================================================
Type "echo 'Ask -> the agent acts on the live tab. A browser copilot in rysh.'"
Enter
Sleep 4s
