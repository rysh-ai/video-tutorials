# Story 21: Cross-Pane Coordination (50s)
# Hook: "Name your panes, then let AI inspect and coordinate across them."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-21-cross-pane.tape

# --- Output Settings ---
Output story-21-cross-pane.mp4
Output story-21-cross-pane.gif

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
# 0:00-0:04  Launch rysh
# "Start rysh -- you land in shell mode."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Split right with Ctrl+P n
# "Open a second pane. Ctrl+P enters pane mode,
#  then n splits right."
# ============================================================
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s

# ============================================================
# 0:08-0:13  Name the left pane "builder"
# "We are in the left pane. Name it 'builder'
#  with the ##pane name command."
# ============================================================
Type "##pane name builder"
Enter
Sleep 1s

# ============================================================
# 0:13-0:18  Tab to right pane and name it "tester"
# "Tab moves to the next pane. Name this one 'tester'."
# ============================================================
Tab
Sleep 1s
Type "##pane name tester"
Enter
Sleep 1s

# ============================================================
# 0:18-0:23  Tab back to left pane and run a command
# "Back in the builder pane. Run a build command."
# ============================================================
Tab
Sleep 1s
Type "echo 'Building project...'"
Enter
Sleep 1s

# ============================================================
# 0:23-0:28  Switch to prompt mode with double-Escape
# "Double-press Escape to enter prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:28-0:40  Ask AI to inspect the tester pane
# "Ask the AI to look at another pane by name.
#  It can read the content of any named pane."
# ============================================================
Type "inspect the tester pane"
Enter
Sleep 5s

# ============================================================
# 0:40-0:45  See the cross-pane inspection result
# "The AI reads the tester pane's content and reports back.
#  Cross-pane coordination -- your AI sees the full workspace."
# ============================================================
Sleep 5s

# ============================================================
# 0:45-0:50  Hold final frame
# "Named panes + AI inspection = coordinated workflows."
# ============================================================
Sleep 5s
