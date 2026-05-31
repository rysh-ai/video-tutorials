# Story 106: Viewing Shared Tabs on Mobile (45s)
# Hook: "A teammate shares a tab -- you open the whole multi-pane layout on your phone."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-106-viewing-shared-tabs-mobile.tape

# --- Output Settings ---
Output story-106-viewing-shared-tabs-mobile.mp4
Output story-106-viewing-shared-tabs-mobile.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:05  Title / Hook
# "A teammate shares a tab -- you open the whole
#  multi-pane layout on your phone."
# ============================================================
Sleep 1s

# ============================================================
# 0:05-0:14  Sharing a tab from the desktop
# "It starts on the desktop: a teammate runs share tab, which publishes the tab
#  and every pane inside it to the workspace."
# ============================================================
Type "echo 'Owner runs: ##share tab   -> publishes the tab and all its panes'"
Enter
Sleep 3s

# ============================================================
# 0:14-0:25  Receiving as a layout
# "On mobile you subscribe to that share and the tab arrives as a full multi-pane
#  layout -- not a flat list, the real arrangement of panes."
# ============================================================
Type "echo 'Mobile subscribes -> receives the tab as its real multi-pane layout'"
Enter
Sleep 3s

# ============================================================
# 0:25-0:36  Interacting
# "Then you interact: read each shared pane, and if the share is in control mode,
#  send input straight back into it from your phone."
# ============================================================
Type "echo 'Read each shared pane; control-mode shares accept your input'"
Enter
Sleep 3s

# ============================================================
# 0:36-0:45  Wrap
# "Shared tabs turn your phone into a live window onto a teammate's whole workspace."
# ============================================================
Type "echo 'Shared tabs on mobile: a live window into a teammate workspace'"
Enter
Sleep 4s
