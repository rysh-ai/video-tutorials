# Story 7: Attach, Detach, List, Delete (45s)
# Hook: "Four commands manage every session's whole lifecycle from outside."
#
# Run: vhs story-007-attach-detach-list-delete.tape

# --- Output Settings ---
Output story-007-attach-detach-list-delete.mp4
Output story-007-attach-detach-list-delete.gif

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
# "Four commands manage a session's whole lifecycle
#  from outside the TUI."
# ============================================================
Sleep 5s

# ============================================================
# 0:05-0:14  List
# "rysh list-sessions shows every session,
#  its state, and its process ID."
# ============================================================
Type "rysh list-sessions"
Enter
Sleep 7.58s

# ============================================================
# 0:14-0:22  Attach
# "rysh attach reopens a session's TUI exactly
#  where you left it."
# ============================================================
Type "rysh attach my-project"
Sleep 1.75s
Enter
Sleep 1.75s
# Detach again from inside
Ctrl+o
Sleep 0.87s
Type "d"
Sleep 1.75s

# ============================================================
# 0:22-0:31  Detach from outside
# "And rysh detach gracefully detaches a running session
#  from outside -- no need to be inside it."
# ============================================================
Type "rysh detach my-project"
Enter
Sleep 7.28s

# ============================================================
# 0:31-0:45  Delete
# "rysh delete-session tears it all down: it kills the
#  process and purges the session's NATS data directory."
# ============================================================
Type "rysh delete-session my-project"
Enter
Sleep 4.39s
Type "rysh list-sessions"
Enter
Sleep 5.86s
