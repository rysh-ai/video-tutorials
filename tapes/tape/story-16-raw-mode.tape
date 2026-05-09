# Story 16: Raw Mode Escape Hatch (40s)
# Hook: "Stuck in vim inside rysh? Ctrl+O is your escape hatch.
#  It breaks out to prefix mode without closing your editor."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - vim installed
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-16-raw-mode.tape

# --- Output Settings ---
Output story-16-raw-mode.mp4
Output story-16-raw-mode.gif

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
# "Ctrl+O is the escape hatch from raw mode."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:06  Launch rysh
# "Start rysh in shell mode."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:06-0:12  Open vim
# "Open vim -- rysh enters raw mode automatically."
# ============================================================
Type "vim test.txt"
Enter
Sleep 2s

# ============================================================
# 0:12-0:15  Enter insert mode
# "Press i for insert mode and type some text."
# ============================================================
Type "i"
Sleep 1s

# ============================================================
# 0:15-0:21  Type text
# "Type normally -- all keys go to vim."
# ============================================================
Type "Editing in vim..."
Sleep 2s

# ============================================================
# 0:21-0:24  Exit insert mode
# "Press Escape to return to vim normal mode."
# ============================================================
Escape
Sleep 1s

# ============================================================
# 0:24-0:29  Ctrl+O -- escape hatch to prefix mode
# "Now press Ctrl+O. This is the escape hatch --
#  it breaks out of raw mode into prefix mode."
# ============================================================
Ctrl+o
Sleep 1s

# ============================================================
# 0:29-0:33  Show prefix mode, then cancel back
# "You're in prefix mode now. You could detach with d,
#  switch panes, or do anything else.
#  Press Escape to cancel and return to raw mode."
# ============================================================
Sleep 1s
Escape
Sleep 1s

# ============================================================
# 0:33-0:37  Quit vim
# "Back in vim. Quit with :q! to discard changes."
# ============================================================
Type ":q!"
Enter
Sleep 1s

# ============================================================
# 0:37-0:40  Hold final frame
# "Ctrl+O -- your safety net when running TUI apps in rysh."
# ============================================================
Sleep 3s
