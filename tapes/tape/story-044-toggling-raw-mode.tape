# Story 44: Toggling Raw Mode (##raw) (35s)
# Hook: "Need raw mode without an interactive program? ##raw flips it on and off by hand."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-044-toggling-raw-mode.tape

# --- Output Settings ---
Output story-044-toggling-raw-mode.mp4
Output story-044-toggling-raw-mode.gif

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
# "Need raw mode without an interactive program?
#  ##raw flips it on and off by hand."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:07  Launch rysh
# "Raw mode usually engages automatically -- but you can control it directly."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:07-0:13  Enter rysh mode
# "Double-Escape to rysh mode, where ## system commands live."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s

# ============================================================
# 0:13-0:22  Toggle raw on
# "Type ##raw to turn raw mode on manually.
#  Now keystrokes are forwarded as raw bytes to the PTY --
#  handy for stubborn programs Rysh didn't auto-detect."
# ============================================================
Type "##raw"
Enter
Sleep 4s

# ============================================================
# 0:22-0:30  Toggle raw off
# "##raw is a toggle. Press Ctrl+O to step out to prefix mode,
#  then run ##raw again to turn it back off."
# ============================================================
Ctrl+o
Sleep 1s
Type "##raw"
Enter
Sleep 3s

# ============================================================
# 0:30-0:35  Hold final frame
# "One command, full manual control over the interactive terminal."
# ============================================================
Sleep 3s
