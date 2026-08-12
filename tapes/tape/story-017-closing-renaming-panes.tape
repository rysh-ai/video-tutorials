# Story 17: Closing & Renaming Panes (40s)
# Hook: "Keep your workspace tidy: close panes you're done with and name the ones you keep."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-017-closing-renaming-panes.tape

# --- Output Settings ---
Output story-017-closing-renaming-panes.mp4
Output story-017-closing-renaming-panes.gif

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
# "Keep your workspace tidy:
#  close panes you're done with and name the ones you keep."
# ============================================================
Sleep 4.21s

# ============================================================
# 0:04-0:09  Launch rysh and split
# "Start rysh and split into a couple of panes to work with."
# ============================================================
Type "rysh"
Enter
Sleep 4.88s

# ============================================================
# 0:09-0:14  Add a second pane
# "Ctrl+P, n gives us a second pane."
# ============================================================
Ctrl+p
Sleep 1.7s
Type "n"
Sleep 3.41s

# ============================================================
# 0:14-0:22  Ctrl+P r -- rename
# "Press Ctrl+P then r to rename the active pane.
#  Type the name and press Enter."
# ============================================================
Ctrl+p
Sleep 1.95s
Type "r"
Sleep 1.95s
Type "tests"
Enter
Sleep 3.91s

# ============================================================
# 0:22-0:30  ##pane name command
# "You can also set the given-name from rysh mode.
#  ##pane name keeps it unique per lane."
# ============================================================
Type "##pane name api-server"
Enter
Sleep 6.69s

# ============================================================
# 0:30-0:36  Ctrl+P x -- close
# "When you're finished with a pane, Ctrl+P then x closes it."
# ============================================================
Ctrl+p
Sleep 1.52s
Type "x"
Sleep 3.04s
Escape
Sleep 1.52s

# ============================================================
# 0:36-0:40  Hold frame
# "Rename to stay organized, close to clean up.
#  Your layout, your rules."
# ============================================================
Sleep 4.21s
