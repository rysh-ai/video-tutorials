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
Sleep 2s

Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:05-0:18  Enter tab mode and create tabs
# "Press Ctrl+T to enter tab mode. Now n creates a new tab.
#  Press it a few times to build out a row of tabs."
# ============================================================
Ctrl+t
Sleep 1s
Type "n"
Sleep 1.5s
Type "n"
Sleep 1.5s
Type "n"
Sleep 2s

# ============================================================
# 0:18-0:30  Move with h j k l
# "While in tab mode, h and k move to the previous tab,
#  j and l move to the next -- no arrow keys needed."
# ============================================================
Type "h"
Sleep 1.5s
Type "h"
Sleep 1.5s
Type "l"
Sleep 1.5s

# ============================================================
# 0:30-0:40  Jump by number
# "Press a number from 1 to 9 to jump straight to that tab."
# ============================================================
Type "1"
Sleep 1.5s
Type "3"
Sleep 1.5s
Type "2"
Sleep 1.5s

# ============================================================
# 0:40-0:45  Exit tab mode
# "Escape exits tab mode and drops you back to normal mode."
# ============================================================
Escape
Sleep 4s
