# Story 43: Web Commands (30s)
# Hook: "Three commands to manage the web terminal."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-43-web-commands.tape

# --- Output Settings ---
Output story-43-web-commands.mp4
Output story-43-web-commands.gif

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
# "Start rysh -- web terminal commands."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:07  Title
# "Web Terminal Commands overview."
# ============================================================
Type "echo 'Web Terminal Commands'"
Enter
Sleep 0.5s

# ============================================================
# 0:07-0:10  Start default
# "##rysh web start uses the default port 23232."
# ============================================================
Type "echo '##rysh web start        - default port 23232'"
Enter
Sleep 0.5s

# ============================================================
# 0:10-0:13  Start custom port
# "Pass a port number for a custom port."
# ============================================================
Type "echo '##rysh web start 9090   - custom port'"
Enter
Sleep 0.5s

# ============================================================
# 0:13-0:16  Status
# "##rysh web status checks if the server is running."
# ============================================================
Type "echo '##rysh web status       - check if running'"
Enter
Sleep 0.5s

# ============================================================
# 0:16-0:19  Stop
# "##rysh web stop performs a graceful shutdown."
# ============================================================
Type "echo '##rysh web stop         - graceful shutdown'"
Enter
Sleep 0.5s

# ============================================================
# 0:19-0:24  Auto-shutdown
# "The web server stops automatically when rysh exits."
# ============================================================
Type "echo 'Auto-shutdown when rysh session exits'"
Enter
Sleep 2s

# ============================================================
# 0:24-0:30  Hold final frame
# "Three commands -- start, status, stop. That's it."
# ============================================================
Sleep 6s
