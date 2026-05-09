# Story 17: PTY Resize (30s)
# Hook: "Resize panes, resize the terminal -- the PTY adjusts
#  automatically. No restarts needed."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-17-pty-resize.tape

# --- Output Settings ---
Output story-17-pty-resize.mp4
Output story-17-pty-resize.gif

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
# "PTY resize is automatic. Resize panes freely."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:06  Launch rysh
# "Start rysh."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:06-0:10  Create a second pane with Ctrl+P n
# "Split into two panes with Ctrl+P then n."
# ============================================================
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s

# Exit pane mode
Escape
Sleep 0.5s

# ============================================================
# 0:10-0:14  Type in left pane (Tab to get to it)
# "Type a command in the left pane."
# ============================================================
Tab
Sleep 0.5s
Type "echo 'PTY resize is automatic'"
Enter
Sleep 1.5s

# ============================================================
# 0:14-0:18  Tab to right pane and type
# "Switch to the right pane and type there."
# ============================================================
Tab
Sleep 0.5s
Type "echo 'Resize panes or terminal window'"
Enter
Sleep 1.5s

# ============================================================
# 0:18-0:25  Ctrl+L for layout mode, resize panes
# "Ctrl+L enters layout mode. Use arrow keys to resize.
#  Right grows the active pane, Left shrinks it."
# ============================================================
Ctrl+l
Sleep 0.5s
Right
Sleep 0.5s
Right
Sleep 0.5s
Right
Sleep 0.5s
Left
Sleep 0.5s

# ============================================================
# 0:25-0:28  Exit layout mode
# "Press Escape to exit layout mode. The PTY adjusts
#  automatically -- no restart needed."
# ============================================================
Escape
Sleep 1s

# ============================================================
# 0:28-0:30  Hold final frame
# ============================================================
Sleep 2s
