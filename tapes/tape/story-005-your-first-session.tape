# Story 5: Your First Session (50s)
# Hook: "Name a session, work in it, detach -- and it keeps running without you."
#
# Run: vhs story-005-your-first-session.tape

# --- Output Settings ---
Output story-005-your-first-session.mp4
Output story-005-your-first-session.gif

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
# "Name a session, work in it, then detach --
#  and it keeps running without you."
# ============================================================
Sleep 5s

# ============================================================
# 0:05-0:13  Start a named session
# "Pass a name to rysh and you get a named session.
#  Here we open one called my-project."
# ============================================================
Type "rysh my-project"
Enter
Sleep 6.8s

# ============================================================
# 0:13-0:21  Do some work
# "Work as usual -- run commands, build, test.
#  This pane is a normal shell."
# ============================================================
Type "git status"
Enter
Sleep 7.17s

# ============================================================
# 0:21-0:30  Detach with Ctrl+O d
# "Press Ctrl+O for prefix mode, then d to detach.
#  You drop back to your shell, but the session lives on."
# ============================================================
Ctrl+o
Sleep 2.21s
Type "d"
Sleep 6.64s

# ============================================================
# 0:30-0:39  List sessions
# "rysh list-sessions shows it -- still alive,
#  marked detached, with its process ID."
# ============================================================
Type "rysh list-sessions"
Enter
Sleep 7.58s

# ============================================================
# 0:39-0:50  Reattach
# "Reattach any time with rysh attach my-project.
#  Your output, history, and pane layout are all restored."
# ============================================================
Type "rysh attach my-project"
Enter
Sleep 9.28s
