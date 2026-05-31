# Story 43: Raw Mode & Escape Hatch (45s)
# Hook: "In raw mode every key goes to the program. Ctrl+O is your escape hatch back to Rysh."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - vim installed
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-043-raw-mode-escape-hatch.tape

# --- Output Settings ---
Output story-043-raw-mode-escape-hatch.mp4
Output story-043-raw-mode-escape-hatch.gif

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
# "In raw mode every key goes to the program.
#  Ctrl+O is your escape hatch back to Rysh."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:07  Launch rysh
# "Start rysh, then open an interactive program."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:07-0:15  Open vim, raw mode engages
# "Open vim. On the alternate screen, the pane enters raw mode --
#  Tab, brackets, Escape, every key is forwarded straight to vim."
# ============================================================
Type "vim notes.txt"
Enter
Sleep 3s
Type "i"
Sleep 0.5s
Type "raw mode forwards every keystroke"
Sleep 2s
Escape
Sleep 1.5s

# ============================================================
# 0:15-0:27  The escape hatch
# "So how do you reach Rysh's own shortcuts? Ctrl+O.
#  It's the one key raw mode reserves -- the escape hatch out
#  to prefix mode, even while a program owns the screen."
# ============================================================
Ctrl+o
Sleep 2s

# ============================================================
# 0:27-0:34  From prefix mode
# "From prefix mode you can detach with d, or press any other key
#  to cancel and drop right back into the program."
# ============================================================
Type "q"
Sleep 2s

# ============================================================
# 0:34-0:42  Quit vim normally
# "Back in vim, quit the usual way -- colon-q-bang to discard."
# ============================================================
Type ":q!"
Enter
Sleep 3s

# ============================================================
# 0:42-0:45  Hold final frame
# "Raw mode keeps programs happy; Ctrl+O keeps you in control."
# ============================================================
Sleep 3s
