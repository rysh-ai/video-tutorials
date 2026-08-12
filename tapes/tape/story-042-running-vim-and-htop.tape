# Story 42: Running Vim & Htop (50s)
# Hook: "vim, htop, less, nano -- full-screen programs just work, right inside a Rysh pane."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - vim and htop installed
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-042-running-vim-and-htop.tape

# --- Output Settings ---
Output story-042-running-vim-and-htop.mp4
Output story-042-running-vim-and-htop.gif

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
# "vim, htop, less, nano --
#  full-screen programs just work, right inside a Rysh pane."
# ============================================================
Sleep 3.2s

# ============================================================
# 0:03-0:07  Launch rysh
# "Start rysh -- a pane is a full PTY-backed shell."
# ============================================================
Type "rysh"
Enter
Sleep 3.89s

# ============================================================
# 0:07-0:14  Open vim
# "Open a file in vim. The moment vim switches to its alternate screen,
#  Rysh detects it and enters raw mode automatically."
# ============================================================
Type "vim hello.go"
Enter
Sleep 6.49s

# ============================================================
# 0:14-0:24  Edit in vim
# "Now every keystroke flows straight to the terminal emulator.
#  Insert mode, normal mode -- vim behaves exactly as it should."
# ============================================================
Type "i"
Sleep 2.1s
Type "package main"
Enter
Enter
Type "func main() {}"
Sleep 4.21s
Escape
Sleep 2.1s

# ============================================================
# 0:24-0:30  Save and quit
# "Write and quit with colon-w-q. Back to the shell, no surprises."
# ============================================================
Type ":wq"
Enter
Sleep 6.1s

# ============================================================
# 0:30-0:40  Launch htop
# "Run htop -- another alternate-screen program.
#  Rysh's vt10x emulator renders the live process view inside the pane."
# ============================================================
Type "htop"
Enter
Sleep 10.29s

# ============================================================
# 0:40-0:47  Quit htop
# "Press q to quit htop and return to your shell prompt."
# ============================================================
Type "q"
Sleep 7.39s

# ============================================================
# 0:47-0:50  Hold final frame
# "Interactive terminal apps, no configuration, no caveats."
# ============================================================
Sleep 3.2s
