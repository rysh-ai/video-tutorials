# Story 103: The Mobile App (50s)
# Hook: "rysh in your pocket. Reach your panes from iOS or Android."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-103-the-mobile-app.tape

# --- Output Settings ---
Output story-103-the-mobile-app.mp4
Output story-103-the-mobile-app.gif

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
# "rysh in your pocket.
#  Reach your panes from iOS or Android."
# ============================================================
Sleep 5.1s

# ============================================================
# 0:05-0:14  Introduce rysh-mobile
# "rysh-mobile is the native app for iOS and Android. You log in once, and your
#  workspaces are right there on your phone."
# ============================================================
Type "echo 'rysh-mobile: native iOS / Android client -- login, then your workspaces'"
Enter
Sleep 3.25s

# ============================================================
# 0:14-0:25  Navigation drill-down
# "The flow is a simple drill-down: pick a workspace, see its list of panes,
#  tap a pane to open the live pane view."
# ============================================================
Type "echo 'Workspace list  ->  pane list  ->  pane view'"
Enter
Sleep 7.32s

# ============================================================
# 0:25-0:36  Rendering
# "Each pane renders with XTerm.js, so colors and ANSI look exactly like your
#  desktop terminal."
# ============================================================
Type "echo 'Panes rendered with XTerm.js -> full color, full ANSI on mobile'"
Enter
Sleep 5.9s

# ============================================================
# 0:36-0:45  Interactive on shared panes
# "On shared panes you even get a fully interactive terminal -- run vim or htop
#  from your phone and the keystrokes flow straight through."
# ============================================================
Type "echo 'Shared panes are interactive: vim, htop, anything -- from your phone'"
Enter
Sleep 3.48s

# ============================================================
# 0:45-0:50  Wrap
# "Your agentic terminal, anywhere you are."
# ============================================================
Type "echo 'rysh-mobile: your agentic terminal, anywhere'"
Enter
Sleep 1.2s
