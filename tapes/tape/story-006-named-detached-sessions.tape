# Story 6: Named & Detached Sessions (45s)
# Hook: "Create a session attached, or spin one up headless as a background daemon."
#
# Run: vhs story-006-named-detached-sessions.tape

# --- Output Settings ---
Output story-006-named-detached-sessions.mp4
Output story-006-named-detached-sessions.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:05  Title / Hook
# "Create a session attached, or spin one up headless
#  as a background daemon."
# ============================================================
Sleep 2s

# ============================================================
# 0:05-0:15  Create and attach
# "rysh create my-session builds a fresh session
#  and attaches its TUI right away."
# ============================================================
Type "rysh create my-session"
Sleep 2s
Enter
Sleep 3s

# Detach so we can show the headless variant
Ctrl+o
Sleep 1s
Type "d"
Sleep 2s

# ============================================================
# 0:15-0:27  Create detached / headless
# "Add --detached, or just -d, and the daemon spawns
#  headlessly -- no TUI, control returns to your prompt."
# ============================================================
Type "rysh create build-bot --detached"
Sleep 2s
Enter
Sleep 3s

# ============================================================
# 0:27-0:36  Confirm it's running
# "List your sessions and the headless one is right there,
#  running in the background."
# ============================================================
Type "rysh list-sessions"
Enter
Sleep 4s

# ============================================================
# 0:36-0:45  Attach later
# "Attach to it whenever you like with rysh attach.
#  Detached now, fully interactive when you need it."
# ============================================================
Type "rysh attach build-bot"
Enter
Sleep 4s
