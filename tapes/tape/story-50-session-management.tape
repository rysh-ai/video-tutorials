# Story 50: Session Management (45s)
# Hook: "Named sessions -- start, detach, reattach, send, delete."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-50-session-management.tape

# --- Output Settings ---
Output story-50-session-management.mp4
Output story-50-session-management.gif

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
# 0:00-0:03  Title (bare terminal, no rysh)
# "Session Management overview."
# ============================================================
Sleep 1s
Type "echo 'Session Management'"
Enter
Sleep 0.5s

# ============================================================
# 0:03-0:05  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:05-0:09  Start named session
# "rysh my-session starts a named session."
# ============================================================
Type "echo 'rysh my-session          - start named session'"
Enter
Sleep 0.5s

# ============================================================
# 0:09-0:13  Detach
# "Ctrl+O d detaches from the current session."
# ============================================================
Type "echo 'Ctrl+O d                 - detach session'"
Enter
Sleep 0.5s

# ============================================================
# 0:13-0:17  List sessions
# "rysh list-sessions shows all sessions."
# ============================================================
Type "echo 'rysh list-sessions       - list all sessions'"
Enter
Sleep 0.5s

# ============================================================
# 0:17-0:21  Attach
# "rysh attach my-session reattaches to a named session."
# ============================================================
Type "echo 'rysh attach my-session   - reattach'"
Enter
Sleep 0.5s

# ============================================================
# 0:21-0:25  Send
# "rysh send sends a command without attaching."
# ============================================================
Type "echo 'rysh send my-session CMD - send without attaching'"
Enter
Sleep 0.5s

# ============================================================
# 0:25-0:29  Detach from outside
# "rysh detach detaches a session from outside."
# ============================================================
Type "echo 'rysh detach my-session   - detach from outside'"
Enter
Sleep 0.5s

# ============================================================
# 0:29-0:33  Delete
# "rysh delete-session terminates and cleans up."
# ============================================================
Type "echo 'rysh delete-session name - terminate and cleanup'"
Enter
Sleep 1s

# ============================================================
# 0:33-0:35  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:35-0:40  Run list-sessions
# "Let's see the actual sessions."
# ============================================================
Type "rysh list-sessions"
Enter
Sleep 2s

# ============================================================
# 0:40-0:45  Hold final frame
# "Session management -- named sessions, full lifecycle control."
# ============================================================
Sleep 5s
