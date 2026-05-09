# Story 14: System Commands (45s)
# Hook: "System commands start with ##. Manage panes, tabs,
#  snapshots -- all from the input line."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-14-system-commands.tape

# --- Output Settings ---
Output story-14-system-commands.mp4
Output story-14-system-commands.gif

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
# "System commands start with ##. Control rysh from the input line."
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
# 0:06-0:13  ##help -- show available system commands
# "Type ##help to see all available system commands."
# ============================================================
Type "##help"
Enter
Sleep 2s

# ============================================================
# 0:13-0:20  ##pane list -- list all panes
# "##pane list shows all panes in the current tab."
# ============================================================
Type "##pane list"
Enter
Sleep 1s

# ============================================================
# 0:20-0:27  ##tab list -- list all tabs
# "##tab list shows all tabs in the session."
# ============================================================
Type "##tab list"
Enter
Sleep 1s

# ============================================================
# 0:27-0:34  ##pane name -- rename a pane
# "##pane name gives the active pane a descriptive name."
# ============================================================
Type "##pane name my-builder"
Enter
Sleep 1s

# ============================================================
# 0:34-0:41  ##snap -- take a snapshot
# "##snap captures the current session state.
#  Use it to save and restore your workspace."
# ============================================================
Type "##snap"
Enter
Sleep 1s

# ============================================================
# 0:41-0:45  Hold final frame
# "System commands give you full control over rysh internals."
# ============================================================
Sleep 4s
