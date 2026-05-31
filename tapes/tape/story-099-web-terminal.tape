# Story 99: Web Terminal (##rysh web) (50s)
# Hook: "Your whole rysh workspace, in a browser tab. One command starts it."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-099-web-terminal.tape

# --- Output Settings ---
Output story-099-web-terminal.mp4
Output story-099-web-terminal.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:04  Title / Hook
# "Your whole rysh workspace, in a browser tab.
#  One command starts it."
# ============================================================
Sleep 1s

# ============================================================
# 0:04-0:09  Launch rysh
# "Start rysh as usual -- you land in shell mode."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:09-0:16  Enter rysh mode and start the web server
# "Type the rysh-mode command to start the web UI server.
#  With no port, it listens on the default: 23232."
# ============================================================
Type "##rysh web start"
Enter
Sleep 3s

# ============================================================
# 0:16-0:24  Show the URL to open
# "Now open your browser to localhost on port 23232.
#  You get the full TUI -- tabs, panes, every input mode -- in the browser."
# ============================================================
Type "##rysh web start 23232"
Enter
Sleep 3s

# ============================================================
# 0:24-0:34  Check status
# "Check the server any time with web status."
# ============================================================
Type "##rysh web status"
Enter
Sleep 3s

# ============================================================
# 0:34-0:42  Explain parity
# "The browser session shares the same NATS bus and the same actors as your
#  terminal -- it is not a copy, it is the same workspace, live."
# ============================================================
Type "echo 'Browser at http://localhost:23232 -> same session, same panes, live'"
Enter
Sleep 3s

# ============================================================
# 0:42-0:50  Stop the server
# "When you are done, stop it with web stop. One binary, no external dependencies."
# ============================================================
Type "##rysh web stop"
Enter
Sleep 4s
