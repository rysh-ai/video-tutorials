# Story 41: Web Terminal (55s)
# Hook: "Full TUI in the browser -- same shortcuts, same modes."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-41-web-terminal.tape

# --- Output Settings ---
Output story-41-web-terminal.mp4
Output story-41-web-terminal.gif

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
# "Start rysh -- the embedded web terminal awaits."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Introduce the web terminal
# "The embedded web terminal brings rysh to your browser."
# ============================================================
Type "echo 'The Embedded Web Terminal'"
Enter
Sleep 1s

# ============================================================
# 0:08-0:12  Explain browser parity
# "Full TUI in the browser -- same shortcuts, same modes."
# ============================================================
Type "echo 'Full TUI in the browser - same shortcuts, same modes'"
Enter
Sleep 1s

# ============================================================
# 0:12-0:18  Start web server
# "##rysh web start launches the web terminal server."
# ============================================================
Type "##rysh web start"
Enter
Sleep 3s

# ============================================================
# 0:18-0:22  Show the URL
# "Open localhost:23232 in your browser to access rysh."
# ============================================================
Type "echo 'Open http://localhost:23232 in your browser'"
Enter
Sleep 1s

# ============================================================
# 0:22-0:26  All modes work
# "All 13 interaction modes work in the browser."
# ============================================================
Type "echo 'All 13 interaction modes work in the browser'"
Enter
Sleep 1s

# ============================================================
# 0:26-0:32  Check status
# "##rysh web status shows whether the web server is running."
# ============================================================
Type "##rysh web status"
Enter
Sleep 2s

# ============================================================
# 0:32-0:38  Stop web server
# "##rysh web stop gracefully shuts down the web server."
# ============================================================
Type "##rysh web stop"
Enter
Sleep 2s

# ============================================================
# 0:38-0:55  Hold final frame
# "Web terminal -- your full rysh TUI, accessible from any browser."
# ============================================================
Sleep 17s
