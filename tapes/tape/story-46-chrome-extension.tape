# Story 46: Chrome Extension (50s)
# Hook: "Your browser IS a rysh pane."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-46-chrome-extension.tape

# --- Output Settings ---
Output story-46-chrome-extension.mp4
Output story-46-chrome-extension.gif

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
# "Start rysh -- the Chrome extension makes your browser a pane."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:07  Title
# "Chrome Extension -- your browser as a pane."
# ============================================================
Type "echo 'Chrome Extension - Your Browser as a Pane'"
Enter
Sleep 0.5s

# ============================================================
# 0:07-0:09  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:09-0:13  Core concept
# "The extension IS a rysh pane."
# ============================================================
Type "echo 'The extension IS a rysh pane'"
Enter
Sleep 0.5s

# ============================================================
# 0:13-0:17  Protocol
# "Same NATSEnvelope protocol as every other actor."
# ============================================================
Type "echo 'Same NATSEnvelope protocol as every other actor'"
Enter
Sleep 0.5s

# ============================================================
# 0:17-0:21  Connection
# "Connects via NATS WebSocket to rysh-server."
# ============================================================
Type "echo 'Connects via NATS WebSocket to rysh-server'"
Enter
Sleep 0.5s

# ============================================================
# 0:21-0:23  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:23-0:26  Features header
# "Key features of the Chrome extension."
# ============================================================
Type "echo 'Features:'"
Enter
Sleep 0.5s

# ============================================================
# 0:26-0:30  Page context
# "AI reads the active tab's page context."
# ============================================================
Type "echo '  - AI reads active tab's page context'"
Enter
Sleep 0.5s

# ============================================================
# 0:30-0:34  Tool approval
# "Tool approval dialogs appear in the extension."
# ============================================================
Type "echo '  - Tool approval dialogs in extension'"
Enter
Sleep 0.5s

# ============================================================
# 0:34-0:38  History
# "Conversation history persists across page navigations."
# ============================================================
Type "echo '  - Conversation history across page navigations'"
Enter
Sleep 0.5s

# ============================================================
# 0:38-0:42  Side panel
# "Side panel interface for easy access."
# ============================================================
Type "echo '  - Side panel interface'"
Enter
Sleep 2s

# ============================================================
# 0:42-0:50  Hold final frame
# "Chrome extension -- your browser, now a first-class rysh actor."
# ============================================================
Sleep 8s
