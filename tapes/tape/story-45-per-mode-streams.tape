# Story 45: Per-Mode Streams (40s)
# Hook: "Each mode gets its own WebSocket stream and unread badges."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-45-per-mode-streams.tape

# --- Output Settings ---
Output story-45-per-mode-streams.mp4
Output story-45-per-mode-streams.gif

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
# "Start rysh -- per-mode streams explained."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:07  Title
# "Per-Mode Streams and Unread Badges."
# ============================================================
Type "echo 'Per-Mode Streams & Unread Badges'"
Enter
Sleep 0.5s

# ============================================================
# 0:07-0:09  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:09-0:12  Intro
# "Each mode has its own WebSocket stream."
# ============================================================
Type "echo 'Each mode has its own WebSocket stream:'"
Enter
Sleep 0.5s

# ============================================================
# 0:12-0:16  Shell stream
# "Shell mode streams on rysh.pane.{id}.output.shell."
# ============================================================
Type "echo '  Shell  -> rysh.pane.{id}.output.shell'"
Enter
Sleep 0.5s

# ============================================================
# 0:16-0:20  AI stream
# "AI mode streams on rysh.pane.{id}.output.ai."
# ============================================================
Type "echo '  AI     -> rysh.pane.{id}.output.ai'"
Enter
Sleep 0.5s

# ============================================================
# 0:20-0:24  Chat stream
# "Chat mode streams on rysh.pane.{id}.output.chat."
# ============================================================
Type "echo '  Chat   -> rysh.pane.{id}.output.chat'"
Enter
Sleep 0.5s

# ============================================================
# 0:24-0:28  Rysh stream
# "Rysh mode streams on rysh.pane.{id}.output.rysh."
# ============================================================
Type "echo '  Rysh   -> rysh.pane.{id}.output.rysh'"
Enter
Sleep 0.5s

# ============================================================
# 0:28-0:30  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:30-0:34  Unread badges
# "Unread badges show when background modes receive output."
# ============================================================
Type "echo 'Unread badges appear when background modes receive output'"
Enter
Sleep 0.5s

# ============================================================
# 0:34-0:38  Reconnect
# "Pull-to-refresh and auto-reconnect from background."
# ============================================================
Type "echo 'Pull-to-refresh, auto-reconnect from background'"
Enter
Sleep 2s

# ============================================================
# 0:38-0:40  Hold final frame
# "Per-mode streams -- never miss an update."
# ============================================================
Sleep 2s
