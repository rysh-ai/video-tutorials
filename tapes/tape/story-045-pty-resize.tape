# Story 45: PTY Resize (40s)
# Hook: "Resize the window and your programs follow -- SIGWINCH propagates and the emulator reflows."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - htop installed
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-045-pty-resize.tape

# --- Output Settings ---
Output story-045-pty-resize.mp4
Output story-045-pty-resize.gif

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
# "Resize the window and your programs follow --
#  SIGWINCH propagates and the emulator reflows."
# ============================================================
Sleep 3.33s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh and check the terminal dimensions."
# ============================================================
Type "rysh"
Enter
Sleep 5.18s

# ============================================================
# 0:08-0:15  Show current size
# "Run tput to read the current columns and rows --
#  the values the PTY is reporting to your shell."
# ============================================================
Type "echo cols=$(tput cols) rows=$(tput lines)"
Enter
Sleep 4.63s

# ============================================================
# 0:15-0:23  Split a pane
# "Split a pane with Ctrl+P n. Splitting changes each pane's geometry,
#  and Rysh sends a SIGWINCH so the shell learns its new size."
# ============================================================
Ctrl+p
Sleep 2.17s
Type "n"
Sleep 4.33s
Escape
Sleep 2.16s

# ============================================================
# 0:23-0:30  Re-check size in the narrower pane
# "Check again in the narrower pane -- the column count has dropped.
#  The PTY was resized live, no restart needed."
# ============================================================
Type "echo cols=$(tput cols) rows=$(tput lines)"
Enter
Sleep 4.63s

# ============================================================
# 0:30-0:37  Interactive program adapts
# "Interactive programs adapt too. Launch htop -- the vt10x emulator
#  reflows its layout to whatever space the pane currently has."
# ============================================================
Type "htop"
Enter
Sleep 4.89s
Type "q"
Sleep 2.44s

# ============================================================
# 0:37-0:40  Hold final frame
# "Resize freely. Your shells and full-screen apps reflow to fit."
# ============================================================
Sleep 3.33s
