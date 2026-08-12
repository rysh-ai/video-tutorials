# Story 97: Remote Control (45s)
# Hook: "In control mode you don't just watch -- you can drive the remote pane yourself."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - An enabled [upstream] block in rysh.config
#
# Run: vhs story-097-remote-control.tape

# --- Output Settings ---
Output story-097-remote-control.mp4
Output story-097-remote-control.gif

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
# "In control mode you don't just watch --
#  you can drive the remote pane yourself."
# ============================================================
Sleep 3.45s

# ============================================================
# 0:03-0:09  Launch rysh, enter rysh mode
# "Start rysh and double-Escape into rysh mode. First we
#  subscribe to a share in control mode."
# ============================================================
Type "rysh"
Enter
Sleep 3.46s
Escape
Sleep 0.35s
Escape
Sleep 0.35s
Escape
Sleep 0.34s
Escape
Sleep 1.73s

# ============================================================
# 0:09-0:17  Subscribe in control mode
# "##upstream subscribe with control requests two-way access.
#  The owner shared it as control, so commands are allowed."
# ============================================================
Type "##upstream subscribe abc123 control"
Enter
Sleep 6.51s

# ============================================================
# 0:17-0:27  Send a command to the remote pane
# "##upstream send pushes text to the remote pane. The server
#  validates you're a subscriber and checks the blocklist first."
# ============================================================
Type "##upstream send ls -la"
Enter
Sleep 9.79s

# ============================================================
# 0:27-0:37  Run a rysh command remotely with ####
# "Want to run a rysh command on the source pane? Prefix it with
#  four hashes -- ####pane info runs ##pane info remotely."
# ============================================================
Type "####pane info"
Enter
Sleep 10.46s

# ============================================================
# 0:37-0:42  Note on approval
# "If the owner set command_approval, each command waits for their
#  yes before it executes. Safety stays with the pane's owner."
# ============================================================
Type "##upstream send git status"
Enter
Sleep 3.73s

# ============================================================
# 0:42-0:45  Hold final frame
# "Control mode turns a remote share into true pair programming --
#  gated by the owner's rules."
# ============================================================
Sleep 3.45s
