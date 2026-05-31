# Story 32: Batch Commands (##cmd) (45s)
# Hook: "Run the same command across every pane in a scope at once."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-032-batch-commands.tape

# --- Output Settings ---
Output story-032-batch-commands.mp4
Output story-032-batch-commands.gif

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
# "Run the same command across every pane
#  in a scope at once."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:09  Launch rysh and build a stack
# "Start rysh and create a few panes
#  so the batch has something to fan out across."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1s
Type "##new grid 3"
Enter
Sleep 2.5s

# ============================================================
# 0:09-0:20  ##cmd stack pwd
# "The cmd command takes a scope and a shell command.
#  Cmd stack pwd runs pwd in every pane of the stack
#  -- one line in, one line per pane out."
# ============================================================
Type "##cmd stack pwd"
Enter
Sleep 3s

# ============================================================
# 0:20-0:30  Other scopes
# "Scopes range from a single pane up to the whole workspace:
#  pane, pg, stack, lane, tab, and ws.
#  Cmd lane echoes a build into every pane of the lane."
# ============================================================
Type "##cmd lane echo building"
Enter
Sleep 3s

# ============================================================
# 0:30-0:40  Selectors
# "Need to target somewhere you're not focused?
#  Add selectors like --tab, --lane, --pg, or --pane
#  to aim the batch precisely."
# ============================================================
Type "##cmd tab git status"
Enter
Sleep 3s

# ============================================================
# 0:40-0:45  Hold final frame
# "One command, fanned out across your whole layout."
# ============================================================
Sleep 3s
