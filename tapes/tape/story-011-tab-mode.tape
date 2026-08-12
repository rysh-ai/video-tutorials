# Story 11: Tab Mode (Ctrl+T) (45s)
# Hook: "Ctrl+T opens tab mode -- create, jump, and move between tabs without leaving the keyboard."
#
# Run: vhs story-011-tab-mode.tape

# --- Output Settings ---
Output story-011-tab-mode.mp4
Output story-011-tab-mode.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:05  Title / Hook
# "Ctrl+T opens tab mode -- create, jump, and move
#  between tabs without leaving the home row."
# ============================================================
Sleep 1.88s

Type "rysh"
Enter
Sleep 2.82s

# ============================================================
# 0:05-0:18  Enter tab mode and create tabs
# "Press Ctrl+T to enter tab mode. Now n creates a new tab.
#  Press it a few times to build out a row of tabs."
# ============================================================
Ctrl+t
Sleep 2.15s
Type "n"
Sleep 3.22s
Type "n"
Sleep 3.22s
Type "n"
Sleep 4.29s

# ============================================================
# 0:18-0:30  Move with h j k l
# "While in tab mode, h and k move to the previous tab,
#  j and l move to the next -- no arrow keys needed."
# ============================================================
Type "h"
Sleep 3.99s
Type "h"
Sleep 3.98s
Type "l"
Sleep 3.98s

# ============================================================
# 0:30-0:40  Jump by number
# "Press a number from 1 to 9 to jump straight to that tab."
# ============================================================
Type "1"
Sleep 3.31s
Type "3"
Sleep 3.31s
Type "2"
Sleep 3.3s

# ============================================================
# 0:40-0:45  Exit tab mode
# "Escape exits tab mode and drops you back to normal mode."
# ============================================================
Escape
Sleep 5s
