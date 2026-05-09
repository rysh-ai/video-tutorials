# Story 48: Upstream Server (55s)
# Hook: "The collaboration hub -- Go + PostgreSQL + NATS + React."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-48-upstream-server.tape

# --- Output Settings ---
Output story-48-upstream-server.mp4
Output story-48-upstream-server.gif

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
# "Start rysh -- let's explore the upstream server."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:07  Title
# "The Upstream Server -- your collaboration hub."
# ============================================================
Type "echo 'The Upstream Server - Collaboration Hub'"
Enter
Sleep 0.5s

# ============================================================
# 0:07-0:09  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:09-0:14  Stack
# "Full stack: Go + Gin, PostgreSQL, Embedded NATS, React, nginx."
# ============================================================
Type "echo 'Stack: Go + Gin | PostgreSQL | Embedded NATS | React | nginx'"
Enter
Sleep 1s

# ============================================================
# 0:14-0:16  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:16-0:19  Services header
# "Docker Compose services."
# ============================================================
Type "echo 'Docker Compose services:'"
Enter
Sleep 0.5s

# ============================================================
# 0:19-0:23  Postgres
# "rysh_postgres for the database."
# ============================================================
Type "echo '  rysh_postgres  - database'"
Enter
Sleep 0.5s

# ============================================================
# 0:23-0:27  Migrate
# "rysh_migrate runs schema migrations."
# ============================================================
Type "echo '  rysh_migrate   - schema migrations'"
Enter
Sleep 0.5s

# ============================================================
# 0:27-0:31  Backend
# "rysh_backend is the Go API server."
# ============================================================
Type "echo '  rysh_backend   - Go API server'"
Enter
Sleep 0.5s

# ============================================================
# 0:31-0:35  Frontend
# "rysh_frontend is the React dashboard."
# ============================================================
Type "echo '  rysh_frontend  - React dashboard'"
Enter
Sleep 0.5s

# ============================================================
# 0:35-0:39  Nginx
# "rysh_nginx is the reverse proxy."
# ============================================================
Type "echo '  rysh_nginx     - reverse proxy'"
Enter
Sleep 1s

# ============================================================
# 0:39-0:41  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:41-0:46  Docker command
# "One command to bring it all up."
# ============================================================
Type "echo 'docker compose up -d'"
Enter
Sleep 2s

# ============================================================
# 0:46-0:55  Hold final frame
# "Upstream server -- five services, one compose file."
# ============================================================
Sleep 9s
