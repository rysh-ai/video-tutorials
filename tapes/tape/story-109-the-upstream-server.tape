# Story 109: The Upstream Server (50s)
# Hook: "rysh-server: the hub that routes shares between machines."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-109-the-upstream-server.tape

# --- Output Settings ---
Output story-109-the-upstream-server.mp4
Output story-109-the-upstream-server.gif

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
# "rysh-server: the hub that routes shares
#  between machines."
# ============================================================
Sleep 5.1s

# ============================================================
# 0:05-0:15  What the server is
# "rysh-server is the optional upstream hub. Local sessions connect to it to
#  share panes, groups, and tabs with collaborators on other machines."
# ============================================================
Type "echo 'rysh-server: collaboration hub -- routes shares across machines'"
Enter
Sleep 4.87s

# ============================================================
# 0:15-0:26  Tech stack
# "Under the hood it is Go and Gin for the API, PostgreSQL for persistence,
#  an embedded NATS server for real-time messaging, and nginx out front."
# ============================================================
Type "echo 'Stack: Go/Gin + PostgreSQL + embedded NATS + nginx'"
Enter
Sleep 6.87s

# ============================================================
# 0:26-0:37  What it manages
# "The server handles authentication with JWT or Firebase, and it owns workspaces,
#  members, API keys, and the routing and access control for every share."
# ============================================================
Type "echo 'Auth (JWT/Firebase) | workspaces | members | API keys | share routing'"
Enter
Sleep 5.45s

# ============================================================
# 0:37-0:50  Deployment
# "It ships as a Docker Compose stack -- make dev-up for development, make prod-up
#  for production -- so you can stand up your own hub in minutes."
# ============================================================
Type "echo 'Docker Compose: make dev-up (dev) / make prod-up (prod)'"
Enter
Sleep 8.54s
