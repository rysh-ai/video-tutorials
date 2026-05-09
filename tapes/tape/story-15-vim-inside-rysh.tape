# Story 15: Running Vim Inside Rysh (50s)
# Hook: "Vim works inside rysh. Full raw mode, full key handling.
#  Your editor, your workflow, no compromises."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - vim installed
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-15-vim-inside-rysh.tape

# --- Output Settings ---
Output story-15-vim-inside-rysh.mp4
Output story-15-vim-inside-rysh.gif

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
# "Vim works inside rysh. Full raw mode, full key handling."
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
# "Open vim -- rysh detects the TUI app and switches
#  to raw mode automatically."
# ============================================================
Type "vim test.txt"
Enter
Sleep 2s

# ============================================================
# 0:12-0:15  Enter insert mode
# "Press i to enter insert mode. All keys pass through to vim."
# ============================================================
Type "i"
Sleep 1s

# ============================================================
# 0:15-0:25  Type text in vim
# "Type normally. Every keystroke goes to vim, not rysh."
# ============================================================
Type "Hello from vim inside rysh!"
Sleep 2s

# ============================================================
# 0:25-0:30  Exit insert mode
# "Press Escape to return to vim normal mode."
# ============================================================
Escape
Sleep 2s

# ============================================================
# 0:30-0:36  Save and quit vim
# "Save and quit with :wq -- standard vim workflow."
# ============================================================
Type ":wq"
Enter
Sleep 1s

# ============================================================
# 0:36-0:43  Verify the file
# "Back in shell mode. Cat the file to verify the content."
# ============================================================
Sleep 2s
Type "cat test.txt"
Enter
Sleep 3s

# ============================================================
# 0:43-0:50  Hold final frame
# "Vim, nano, htop, any TUI app -- they all work inside rysh."
# ============================================================
Sleep 4s
