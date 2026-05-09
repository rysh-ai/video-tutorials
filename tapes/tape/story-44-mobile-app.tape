# Story 44: Mobile App (55s)
# Hook: "Rysh in your pocket -- React + Capacitor mobile app."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-44-mobile-app.tape

# --- Output Settings ---
Output story-44-mobile-app.mp4
Output story-44-mobile-app.gif

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
# "Start rysh -- let's explore the mobile app."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:07  Title
# "Rysh Mobile App built with React and Capacitor."
# ============================================================
Type "echo 'Rysh Mobile App (React + Capacitor)'"
Enter
Sleep 0.5s

# ============================================================
# 0:07-0:09  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:09-0:12  Features header
# "Key features of the mobile app."
# ============================================================
Type "echo 'Features:'"
Enter
Sleep 0.5s

# ============================================================
# 0:12-0:16  Auth
# "Login with same auth as web dashboard."
# ============================================================
Type "echo '  - Login with same auth as web dashboard'"
Enter
Sleep 0.5s

# ============================================================
# 0:16-0:20  Navigation
# "Drill down from workspaces to panes to terminal."
# ============================================================
Type "echo '  - Workspace list -> Pane list -> Terminal view'"
Enter
Sleep 0.5s

# ============================================================
# 0:20-0:24  XTerm.js
# "XTerm.js renders terminal output on mobile."
# ============================================================
Type "echo '  - XTerm.js rendering for terminal output'"
Enter
Sleep 0.5s

# ============================================================
# 0:24-0:28  Mode tabs
# "Switch modes via the tab bar."
# ============================================================
Type "echo '  - Mode tab bar: Shell | AI | Chat | Rysh'"
Enter
Sleep 0.5s

# ============================================================
# 0:28-0:32  Send commands
# "Type commands and tap send."
# ============================================================
Type "echo '  - Type commands, tap send'"
Enter
Sleep 0.5s

# ============================================================
# 0:32-0:36  Haptic
# "Haptic feedback on mode switch for tactile response."
# ============================================================
Type "echo '  - Haptic feedback on mode switch'"
Enter
Sleep 0.5s

# ============================================================
# 0:36-0:40  Read-write
# "Full read-write access to all panes on the go."
# ============================================================
Type "echo '  - Read-write access to all panes on the go'"
Enter
Sleep 2s

# ============================================================
# 0:40-0:55  Hold final frame
# "Your terminal, always in your pocket."
# ============================================================
Sleep 15s
