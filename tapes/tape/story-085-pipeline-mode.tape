# Story 85: Pipeline Mode (45s)
# Hook: "A tab can become a pipeline. One key flips it on and your events start flowing."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-085-pipeline-mode.tape

# --- Output Settings ---
Output story-085-pipeline-mode.mp4
Output story-085-pipeline-mode.gif

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
# "A tab can become a pipeline. One key flips it on
#  and your events start flowing."
# ============================================================
Sleep 3.25s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh. Any tab can be promoted into a pipeline tab,
#  where events orchestrate work across panes."
# ============================================================
Type "rysh"
Enter
Sleep 5.04s

# ============================================================
# 0:08-0:16  Toggle pipeline mode with Ctrl+P p
# "Press Ctrl+P to enter pane mode, then p to toggle
#  pipeline mode for this tab."
# ============================================================
Ctrl+p
Sleep 2.84s
Type "p"
Sleep 5.68s

# ============================================================
# 0:16-0:24  Enable via rysh command
# "You can also do it from rysh mode. Double-Escape over,
#  then ##tab pipeline enable turns it on explicitly."
# ============================================================
Escape
Sleep 0.38s
Escape
Sleep 0.37s
Escape
Sleep 0.37s
Escape
Sleep 1.87s
Type "##tab pipeline enable"
Enter
Sleep 3.73s

# ============================================================
# 0:24-0:32  Confirm with ##tab list
# "##tab list confirms the tab is now pipeline-enabled,
#  ready to load and run pipelines."
# ============================================================
Type "##tab list"
Enter
Sleep 7.85s

# ============================================================
# 0:32-0:40  Disable pipeline mode
# "When you're done, ##tab pipeline disable turns it back off --
#  or just double-Escape, which toggles pipeline mode off."
# ============================================================
Type "##tab pipeline disable"
Enter
Sleep 6.95s

# ============================================================
# 0:40-0:45  Hold final frame
# "Pipeline mode is the on-switch for event-driven
#  orchestration across your panes."
# ============================================================
Sleep 5.42s
