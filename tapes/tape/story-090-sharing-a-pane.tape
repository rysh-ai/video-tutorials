# Story 90: Sharing a Pane (50s)
# Hook: "One command publishes a live pane to your workspace -- teammates watch it in real time."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - An enabled [upstream] block in rysh.config
#
# Run: vhs story-090-sharing-a-pane.tape

# --- Output Settings ---
Output story-090-sharing-a-pane.mp4
Output story-090-sharing-a-pane.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:03  Title / Hook
# "One command publishes a live pane to your workspace --
#  teammates watch it in real time."
# ============================================================
Sleep 3.29s

# ============================================================
# 0:03-0:09  Launch rysh
# "Start rysh with an upstream workspace configured. Sharing
#  registers your pane on the server for remote collaborators."
# ============================================================
Type "rysh"
Enter
Sleep 6.21s

# ============================================================
# 0:09-0:16  Check upstream status
# "Double-Escape into rysh mode. ##share status shows whether
#  you're connected to the upstream server."
# ============================================================
Escape
Sleep 0.35s
Escape
Sleep 0.35s
Escape
Sleep 0.35s
Escape
Sleep 1.74s
Type "##share status"
Enter
Sleep 3.47s

# ============================================================
# 0:16-0:26  Share the pane
# "##share pane view publishes this pane. The ShareRegistry
#  spawns an UpstreamShareActor that registers it on the server."
# ============================================================
Type "##share pane view"
Enter
Sleep 9.63s

# ============================================================
# 0:26-0:34  Run a command so the share carries output
# "Now anything you do here streams to subscribers. Redacted
#  output forwards to the share's output topic continuously."
# ============================================================
Escape
Sleep 0.42s
Escape
Sleep 0.42s
Escape
Sleep 0.41s
Escape
Sleep 0.41s
Escape
Sleep 2.07s
Type "ls -la"
Enter
Sleep 4.15s

# ============================================================
# 0:34-0:44  List shares
# "Back in rysh mode, ##share list shows every active share
#  in this session, each with its own share ID."
# ============================================================
Escape
Sleep 0.46s
Escape
Sleep 0.46s
Escape
Sleep 0.45s
Escape
Sleep 2.27s
Type "##share list"
Enter
Sleep 6.06s

# ============================================================
# 0:44-0:50  Hold final frame
# "From local pane to shared workspace in a single command.
#  Your collaborators are now watching live."
# ============================================================
Sleep 6.59s
