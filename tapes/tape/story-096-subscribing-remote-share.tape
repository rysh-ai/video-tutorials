# Story 96: Subscribing to a Remote Share (45s)
# Hook: "Discover what your teammates are sharing, then subscribe to watch it live."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - An enabled [upstream] block in rysh.config
#
# Run: vhs story-096-subscribing-remote-share.tape

# --- Output Settings ---
Output story-096-subscribing-remote-share.mp4
Output story-096-subscribing-remote-share.gif

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
# "Discover what your teammates are sharing,
#  then subscribe to watch it live."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:09  Launch rysh, enter rysh mode
# "Start rysh connected to your workspace and double-Escape
#  into rysh mode."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s

# ============================================================
# 0:09-0:18  List remote shares
# "##upstream list-remote asks the server for every share in
#  the workspace -- not just yours, but your teammates' too."
# ============================================================
Type "##upstream list-remote"
Enter
Sleep 4s

# ============================================================
# 0:18-0:28  Subscribe to a share
# "Pick a share ID and ##upstream subscribe with view or control.
#  A RemoteShareListenerActor pipes its output into your pane."
# ============================================================
Type "##upstream subscribe abc123 view"
Enter
Sleep 4s

# ============================================================
# 0:28-0:36  Check my-shares
# "##upstream my-shares now reflects what you're connected to,
#  alongside anything you're publishing."
# ============================================================
Type "##upstream my-shares"
Enter
Sleep 4s

# ============================================================
# 0:36-0:42  Unsubscribe
# "Done watching? ##upstream unsubscribe stops the stream and
#  tears down the listener."
# ============================================================
Type "##upstream unsubscribe"
Enter
Sleep 3s

# ============================================================
# 0:42-0:45  Hold final frame
# "List, subscribe, unsubscribe -- the full remote-viewing loop."
# ============================================================
Sleep 3s
