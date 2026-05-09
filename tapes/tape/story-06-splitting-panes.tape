# Story 6: Splitting Panes (45s)
# Hook: "Need more terminals? Split your panes -- columns and rows."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-06-splitting-panes.tape

# --- Output Settings ---
Output story-06-splitting-panes.mp4
Output story-06-splitting-panes.gif

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
# 0:00-0:03  Title / Hook
# "Need more terminals? Split your panes -- columns and rows."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:06  Launch rysh
# "Start rysh -- you get one tab, one pane."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:06-0:12  Ctrl+P then n = split right (new column)
# "Ctrl+P enters pane mode. Press n to split right --
#  creating a second column."
# ============================================================
Ctrl+p
Sleep 1s
Type "n"
Sleep 2s

# Exit pane mode
Escape
Sleep 0.5s

# ============================================================
# 0:12-0:18  Type in left pane, Tab, type in right pane
# "Now you have two side-by-side panes. Each is independent."
# ============================================================
Tab
Sleep 0.5s
Type "echo 'Left pane'"
Enter
Sleep 1.5s

Tab
Sleep 0.5s
Type "echo 'Right pane'"
Enter
Sleep 1.5s

# ============================================================
# 0:18-0:25  Ctrl+P then v = split down (vertical split)
# "Ctrl+P again, then v splits down -- a new row in the
#  same column."
# ============================================================
Ctrl+p
Sleep 1s
Type "v"
Sleep 2s

# Exit pane mode
Escape
Sleep 0.5s

Type "echo 'Bottom pane'"
Enter
Sleep 1.5s

# ============================================================
# 0:25-0:33  Create a third column: Tab back, Ctrl+P n
# "Tab back to another pane, then Ctrl+P n again for a
#  third column."
# ============================================================
Tab
Sleep 0.5s
Tab
Sleep 0.5s

Ctrl+p
Sleep 1s
Type "n"
Sleep 2s

# Exit pane mode
Escape
Sleep 0.5s

Type "echo 'Third column'"
Enter
Sleep 1.5s

# ============================================================
# 0:33-0:40  Cycle through all panes to show layout
# "Tab cycles through every pane. You now have a 3-column
#  layout with one column split into rows."
# ============================================================
Tab
Sleep 1s
Tab
Sleep 1s
Tab
Sleep 1s
Tab
Sleep 1s

# ============================================================
# 0:40-0:45  Hold final frame
# "Split horizontally with n, vertically with v. Combine
#  them however you like."
# ============================================================
Sleep 3s
