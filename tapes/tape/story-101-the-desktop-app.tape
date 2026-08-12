# Story 101: The Desktop App (45s)
# Hook: "The same rysh multiplexer, as a native desktop app."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-101-the-desktop-app.tape

# --- Output Settings ---
Output story-101-the-desktop-app.mp4
Output story-101-the-desktop-app.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:05  Title / Hook
# "The same rysh multiplexer, as a native desktop app."
# ============================================================
Sleep 5.12s

# ============================================================
# 0:05-0:13  Introduce rysh-cli-app
# "rysh-cli-app is the desktop client -- an Electron and React app that wraps the
#  exact same multiplexer you run in the terminal."
# ============================================================
Type "echo 'rysh-cli-app: Electron + React desktop client'"
Enter
Sleep 4.21s

# ============================================================
# 0:13-0:23  Same engine, native feel
# "You get every mode, full mouse support, and the same tabs and panes -- just
#  in a resizable window instead of a terminal emulator."
# ============================================================
Type "echo 'Same modes, mouse, tabs, panes -- in a native window'"
Enter
Sleep 5.73s

# ============================================================
# 0:23-0:34  Side panels
# "What the desktop app adds is dedicated side panels: one for Agents, one for
#  Humanoids, one for Shares -- so you can manage them without typing a command."
# ============================================================
Type "echo 'Side panels: Agents | Humanoids | Shares'"
Enter
Sleep 7.65s

# ============================================================
# 0:34-0:45  Wrap
# "If you prefer a GUI, the desktop app gives you the full power of rysh
#  with point-and-click access to its actors."
# ============================================================
Type "echo 'Desktop app = full rysh power, GUI-first'"
Enter
Sleep 7.65s
