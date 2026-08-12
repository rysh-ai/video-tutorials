# Story 9: Session Persistence (45s)
# Hook: "Detach, reboot, reattach -- your panes come back exactly as you left them."
#
# Run: vhs story-009-session-persistence.tape

# --- Output Settings ---
Output story-009-session-persistence.mp4
Output story-009-session-persistence.gif

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
# "Detach, reattach -- your panes come back
#  exactly as you left them."
# ============================================================
Sleep 5s

# ============================================================
# 0:05-0:15  Where state lives
# "Every session's state lives on disk under
#  ~/.local/state/rysh/nats, one directory per session."
# ============================================================
Type "ls ~/.local/state/rysh/nats/"
Sleep 3.13s
Enter
Sleep 4.69s

# ============================================================
# 0:15-0:26  JetStream KV buckets
# "Inside, two JetStream key-value buckets hold everything:
#  rysh-workspace stores your tab and pane layout..."
# ============================================================
Type "ls ~/.local/state/rysh/nats/my-project/"
Sleep 3.2s
Enter
Sleep 4.8s

# ============================================================
# 0:26-0:36  Panes bucket
# "...and rysh-panes stores each pane's output buffer,
#  mode, and last command, keyed by pane ID."
# ============================================================
Type "echo 'rysh-workspace -> layout   |   rysh-panes -> per-pane state'"
Sleep 1.99s
Enter
Sleep 2.98s

# ============================================================
# 0:36-0:45  Restore on attach
# "On attach, the workspace restores straight from KV.
#  Detach freely -- nothing is lost."
# ============================================================
Type "rysh attach my-project"
Enter
Sleep 7.28s
