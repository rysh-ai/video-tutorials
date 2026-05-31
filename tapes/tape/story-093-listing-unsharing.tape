# Story 93: Listing & Unsharing (40s)
# Hook: "See everything you're sharing, and pull any of it back with one command."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - An enabled [upstream] block in rysh.config
#
# Run: vhs story-093-listing-unsharing.tape

# --- Output Settings ---
Output story-093-listing-unsharing.mp4
Output story-093-listing-unsharing.gif

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
# "See everything you're sharing, and pull any of it back
#  with one command."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:09  Launch rysh, enter rysh mode, share a pane
# "Start rysh, double-Escape into rysh mode, and share a pane
#  so we have something to manage."
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
Type "##share pane control"
Enter
Sleep 2s

# ============================================================
# 0:09-0:18  List all shares
# "##share list is your single source of truth -- every active
#  share in the session, with its scope, mode, and share ID."
# ============================================================
Type "##share list"
Enter
Sleep 4s

# ============================================================
# 0:18-0:28  Unshare the pane
# "##unshare pane stops sharing the active pane. The matching
#  commands exist for panegroup, lane, and tab."
# ============================================================
Type "##unshare pane"
Enter
Sleep 4s

# ============================================================
# 0:28-0:37  Confirm it's gone
# "List again -- the share is gone. Unregistering tears down
#  the UpstreamShareActor and notifies the server."
# ============================================================
Type "##share list"
Enter
Sleep 4s

# ============================================================
# 0:37-0:40  Hold final frame
# "List to audit, unshare to revoke. You stay in control
#  of what leaves your session."
# ============================================================
Sleep 3s
