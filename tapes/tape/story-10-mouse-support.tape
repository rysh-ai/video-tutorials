# Story 10: Mouse Support (30s)
# Hook: "Your mouse works too -- click, drag, scroll."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Note: VHS cannot simulate mouse events. This tape demonstrates
#   mouse support through explanatory text in multiple panes.
#
# Run: vhs story-10-mouse-support.tape

# --- Output Settings ---
Output story-10-mouse-support.mp4
Output story-10-mouse-support.gif

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
# "Your mouse works too -- click, drag, scroll."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:06  Launch rysh
# "Rysh has full mouse support out of the box."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:06-0:12  Create 2 panes side by side
# "Create two panes so we can demonstrate."
# ============================================================
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 1.5s
Escape
Sleep 0.5s

# ============================================================
# 0:12-0:18  Explain click-to-focus in left pane
# "Click any pane to focus it -- no keyboard shortcut needed."
# ============================================================
Tab
Sleep 0.5s
Type "echo 'Mouse feature 1: Click to focus a pane'"
Enter
Sleep 1s
Type "echo 'Just click any pane to switch to it'"
Enter
Sleep 1.5s

# ============================================================
# 0:18-0:24  Explain drag-to-select and scroll in right pane
# "Drag to select text, scroll to browse history."
# ============================================================
Tab
Sleep 0.5s
Type "echo 'Mouse feature 2: Drag to select text'"
Enter
Sleep 1s
Type "echo 'Mouse feature 3: Scroll wheel browses history'"
Enter
Sleep 1s
Type "echo 'Mouse feature 4: Release selection to copy'"
Enter
Sleep 1.5s

# ============================================================
# 0:24-0:30  Final summary
# "Click, drag, scroll -- it all just works. No config needed."
# ============================================================
Tab
Sleep 0.5s
Type "echo 'Mouse support: zero config, just works!'"
Enter
Sleep 3s
