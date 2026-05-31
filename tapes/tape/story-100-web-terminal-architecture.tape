# Story 100: Web Terminal Architecture (45s)
# Hook: "No separate service. The web server is baked right into the rysh binary."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-100-web-terminal-architecture.tape

# --- Output Settings ---
Output story-100-web-terminal-architecture.mp4
Output story-100-web-terminal-architecture.gif

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
# "No separate service. The web server is baked right
#  into the rysh binary."
# ============================================================
Sleep 1s

# ============================================================
# 0:05-0:13  The embedded server
# "When you run rysh web start, an embedded Go web server boots inside the
#  same process -- nothing to install, zero external dependencies."
# ============================================================
Type "echo 'rysh web = embedded Go server + React frontend, in one binary'"
Enter
Sleep 3s

# ============================================================
# 0:13-0:23  Shared bus and actors
# "The frontend does not run a second copy of your session. It connects to the
#  very same embedded NATS bus and the very same actor hierarchy your terminal uses."
# ============================================================
Type "echo 'Browser  <-WebSocket->  embedded NATS bus  <->  Workspace/Tab/Pane actors'"
Enter
Sleep 3s

# ============================================================
# 0:23-0:33  Snapshot streaming
# "State streams to the browser as a snapshot roughly every 200 milliseconds over a
#  WebSocket -- so what you see in the browser stays in lockstep with the terminal."
# ============================================================
Type "echo 'Live snapshot pushed over WebSocket every ~200ms -> React renders the TUI'"
Enter
Sleep 3s

# ============================================================
# 0:33-0:45  Wrap
# "React on the front, Go and NATS on the back, all in one self-contained binary --
#  that is the whole web terminal stack."
# ============================================================
Type "echo 'React frontend | embedded Go web server | shared NATS + actors'"
Enter
Sleep 4s
