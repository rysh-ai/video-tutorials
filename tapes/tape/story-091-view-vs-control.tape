# Story 91: View vs Control Mode (45s)
# Hook: "View lets them watch. Control lets them type. You decide at share time."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - An enabled [upstream] block in rysh.config
#
# Run: vhs story-091-view-vs-control.tape

# --- Output Settings ---
Output story-091-view-vs-control.mp4
Output story-091-view-vs-control.gif

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
# "View lets them watch. Control lets them type.
#  You decide at share time."
# ============================================================
Sleep 3.26s

# ============================================================
# 0:03-0:09  Launch rysh, enter rysh mode
# "Start rysh and double-Escape into rysh mode. Every share
#  command takes an optional mode: view or control."
# ============================================================
Type "rysh"
Enter
Sleep 3.25s
Escape
Sleep 0.33s
Escape
Sleep 0.32s
Escape
Sleep 0.32s
Escape
Sleep 1.62s

# ============================================================
# 0:09-0:18  Share in view mode
# "##share pane view is the default. Remote users observe live
#  output but cannot send any input -- read-only."
# ============================================================
Type "##share pane view"
Enter
Sleep 8.42s

# ============================================================
# 0:18-0:26  Unshare, then re-share in control
# "##unshare pane stops it. Now ##share pane control grants
#  full control: subscribers can send shell commands and prompts."
# ============================================================
Type "##unshare pane"
Enter
Sleep 2.39s
Type "##share pane control"
Enter
Sleep 3.59s

# ============================================================
# 0:26-0:36  Show status
# "##share status reflects the current mode. Control-mode
#  commands are validated server-side against a blocklist."
# ============================================================
Type "##share status"
Enter
Sleep 9.73s

# ============================================================
# 0:36-0:42  Note on safety
# "The default share mode also comes from your [upstream] config,
#  so --shared sessions start in view unless you change it."
# ============================================================
Type "##share list"
Enter
Sleep 5.54s

# ============================================================
# 0:42-0:45  Hold final frame
# "View to demo, control to pair. The choice is yours,
#  pane by pane."
# ============================================================
Sleep 3.26s
