# Story 42: Web Architecture (40s)
# Hook: "Browser to NATS to actors -- one binary, zero runtime deps."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-42-web-architecture.tape

# --- Output Settings ---
Output story-42-web-architecture.mp4
Output story-42-web-architecture.gif

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
# "Start rysh -- let's explore the web architecture."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:07  Title
# "Web Terminal Architecture overview."
# ============================================================
Type "echo 'Web Terminal Architecture'"
Enter
Sleep 0.5s

# ============================================================
# 0:07-0:12  Data flow
# "Browser connects via WebSocket through the full actor pipeline."
# ============================================================
Type "echo 'Browser <-> WebSocket <-> web.Server <-> NATS Bus <-> Actors'"
Enter
Sleep 1s

# ============================================================
# 0:12-0:17  Snapshot frequency
# "Snapshots are pushed every 200ms for smooth rendering."
# ============================================================
Type "echo 'Snapshots pushed every 200ms via WebSocket'"
Enter
Sleep 1s

# ============================================================
# 0:17-0:22  Frontend stack
# "React + TypeScript frontend embedded via go:embed."
# ============================================================
Type "echo 'React + TypeScript frontend embedded via go:embed'"
Enter
Sleep 1s

# ============================================================
# 0:22-0:27  Single binary
# "CLI, web server, and React frontend in one binary."
# ============================================================
Type "echo 'Single binary - CLI + web server + React frontend'"
Enter
Sleep 1s

# ============================================================
# 0:27-0:32  No deps
# "No external dependencies at runtime."
# ============================================================
Type "echo 'No external dependencies at runtime'"
Enter
Sleep 2s

# ============================================================
# 0:32-0:40  Hold final frame
# "One binary, full architecture -- browser to actors."
# ============================================================
Sleep 8s
