# Story 27: Pane & Tab Navigation (45s)
# Hook: "Move through your workspace without lifting your hands from the keyboard."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-027-pane-tab-navigation.tape

# --- Output Settings ---
Output story-027-pane-tab-navigation.mp4
Output story-027-pane-tab-navigation.gif

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
# "Move through your workspace without lifting
#  your hands from the keyboard."
# ============================================================
Sleep 3.16s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh. We'll build out a few panes and tabs
#  so there is something to navigate."
# ============================================================
Type "rysh"
Enter
Sleep 4.89s

# ============================================================
# 0:08-0:15  Build panes and a tab
# "Ctrl+P then n splits a pane to the right.
#  Ctrl+T then n opens a fresh tab."
# ============================================================
Ctrl+p
Sleep 0.63s
Type "n"
Sleep 1.89s
Escape
Sleep 0.63s
Ctrl+t
Sleep 0.63s
Type "n"
Sleep 1.88s
Escape
Sleep 1.26s

# ============================================================
# 0:15-0:24  Cycle panes with Tab and Alt arrows
# "Press Tab to cycle to the next pane.
#  Alt+Up and Alt+Down step between panes too."
# ============================================================
Tab
Sleep 2.78s
Tab
Sleep 2.77s
Tab
Sleep 3.7s

# ============================================================
# 0:24-0:34  Switch tabs with brackets and Alt arrows
# "Brackets move between tabs -- left bracket back,
#  right bracket forward. Alt+Left and Alt+Right do the same."
# ============================================================
Type "["
Sleep 2.36s
Type "]"
Sleep 2.36s
Type "["
Sleep 2.36s
Type "]"
Sleep 3.15s

# ============================================================
# 0:34-0:42  macOS-friendly Alt+B / Alt+F
# "On macOS, Option plus arrow can be tricky,
#  so Alt+B and Alt+F also walk between your tabs."
# ============================================================
Alt+b
Sleep 3.55s
Alt+f
Sleep 4.73s

# ============================================================
# 0:42-0:45  Hold final frame
# "One muscle memory for panes, one for tabs.
#  That is your whole workspace."
# ============================================================
Sleep 3.16s
