# Story 34: Cloud Sharing (55s)
# Hook: "Share your panes to the cloud -- view mode or full control."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-34-cloud-sharing.tape

# --- Output Settings ---
Output story-34-cloud-sharing.mp4
Output story-34-cloud-sharing.gif

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
# "Start rysh -- your collaborative terminal."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Show what we are about to do
# "We will share this pane to the cloud."
# ============================================================
Type "echo 'Sharing panes to the cloud'"
Enter
Sleep 1s

# ============================================================
# 0:08-0:14  Share pane in view mode
# "##share pane view creates a read-only cloud link.
#  Remote users can watch but not type."
# ============================================================
Type "##share pane view"
Enter
Sleep 2s

# ============================================================
# 0:14-0:20  List active shares
# "##share list shows all active shares with their IDs."
# ============================================================
Type "##share list"
Enter
Sleep 2s

# ============================================================
# 0:20-0:26  Unshare the view share
# "##unshare pane revokes the cloud link."
# ============================================================
Type "##unshare pane"
Enter
Sleep 2s

# ============================================================
# 0:26-0:32  Share pane in control mode
# "##share pane control allows remote users to type commands.
#  Use this for pair programming or remote assistance."
# ============================================================
Type "##share pane control"
Enter
Sleep 2s

# ============================================================
# 0:32-0:38  List shares again
# "The share list now shows the control share."
# ============================================================
Type "##share list"
Enter
Sleep 2s

# ============================================================
# 0:38-0:44  Unshare control
# "Revoke the control share when done."
# ============================================================
Type "##unshare pane"
Enter
Sleep 2s

# ============================================================
# 0:44-0:48  Clean state
# "All shares removed -- your terminal is private again."
# ============================================================
Sleep 1s

# ============================================================
# 0:48-0:55  Hold final frame
# "Cloud sharing -- view or control, instantly shareable."
# ============================================================
Sleep 7s
