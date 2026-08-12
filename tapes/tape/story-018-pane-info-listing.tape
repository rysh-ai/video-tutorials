# Story 18: Pane Info & Listing (##pane) (40s)
# Hook: "Ask rysh about itself -- inspect any pane, list them all, and replay its history."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-018-pane-info-listing.tape

# --- Output Settings ---
Output story-018-pane-info-listing.mp4
Output story-018-pane-info-listing.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:04  Title / Hook
# "Ask rysh about itself -- inspect any pane,
#  list them all, and replay its history."
# ============================================================
Sleep 4.18s

# ============================================================
# 0:04-0:09  Launch rysh and add a pane
# "Start rysh and split so we have more than one pane."
# ============================================================
Type "rysh"
Enter
Sleep 1.99s
Ctrl+p
Sleep 0.66s
Type "n"
Sleep 1.32s
Escape
Sleep 0.66s

# ============================================================
# 0:09-0:17  ##pane info
# "Switch to rysh mode and run ##pane info to see the active
#  pane's id, name, mode, and group."
# ============================================================
Type "##pane info"
Enter
Sleep 7.47s

# ============================================================
# 0:17-0:25  ##pane list
# "##pane list shows every pane in the current tab at a glance."
# ============================================================
Type "##pane list"
Enter
Sleep 7.47s

# ============================================================
# 0:25-0:34  ##pane history
# "Run a couple of commands first, then ##pane history shell
#  replays this pane's shell history. Swap in prompt for AI turns."
# ============================================================
Type "##pane history shell"
Enter
Sleep 7.84s

# ============================================================
# 0:34-0:40  Hold frame
# "info, list, history -- everything you need to understand
#  your panes, right from rysh mode."
# ============================================================
Sleep 6.28s
