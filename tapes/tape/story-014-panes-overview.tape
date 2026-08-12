# Story 14: Panes Overview (45s)
# Hook: "One window, many minds. Every pane is its own shell and its own AI agent."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-014-panes-overview.tape

# --- Output Settings ---
Output story-014-panes-overview.mp4
Output story-014-panes-overview.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:04  Title / Hook
# "One window, many minds.
#  Every pane is its own shell and its own AI agent."
# ============================================================
Sleep 4.13s

# ============================================================
# 0:04-0:09  Launch rysh with one pane
# "Start rysh and you get a single pane --
#  a full terminal backed by its own agent."
# ============================================================
Type "rysh"
Enter
Sleep 4.78s

# ============================================================
# 0:09-0:16  Create a second pane with Ctrl+N
# "Press Ctrl+N to create another pane.
#  Instantly you have two independent terminals side by side."
# ============================================================
Ctrl+n
Sleep 7.15s

# ============================================================
# 0:16-0:23  Create a third pane
# "Add as many as you like. Each pane has its own working
#  directory, its own history, its own AI context."
# ============================================================
Ctrl+n
Sleep 7.15s

# ============================================================
# 0:23-0:33  Cycle panes with Tab
# "Press Tab to cycle through your panes.
#  The focused pane gets a highlighted border."
# ============================================================
Tab
Sleep 3.37s
Tab
Sleep 3.36s
Tab
Sleep 3.36s

# ============================================================
# 0:33-0:40  Run something in the focused pane
# "Whatever you type lands only in the pane you've focused --
#  the others keep running on their own."
# ============================================================
Type "pwd"
Enter
Sleep 6.92s

# ============================================================
# 0:40-0:45  Recap / hold frame
# "Ctrl+N to add a pane, Tab to move between them.
#  That's the foundation of every Rysh layout."
# ============================================================
Sleep 5.16s
