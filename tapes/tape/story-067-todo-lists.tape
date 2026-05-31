# Story 67: Todo Lists (40s)
# Hook: "Watch your agent break a big job into tracked, checkable steps."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-067-todo-lists.tape

# --- Output Settings ---
Output story-067-todo-lists.mp4
Output story-067-todo-lists.gif

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
# "Watch your agent break a big job
#  into tracked, checkable steps."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh into prompt mode
# "Start rysh and switch to prompt mode."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:08-0:24  Give a multi-step task
# "Hand the agent a multi-step task. It uses the todo tool to
#  add items, then marks each one complete as it goes."
# ============================================================
Type "plan how to add a health-check endpoint: list the steps as a todo list"
Enter
Sleep 12s

# ============================================================
# 0:24-0:34  Show progress tracking
# "The list lives in per-pane JetStream KV. Add, update,
#  complete, or remove items -- the agent tracks its own work."
# ============================================================
Sleep 6s

# ============================================================
# 0:34-0:40  Recap
# "The todo tool keeps long, multi-step work organized
#  and visible from start to finish."
# ============================================================
Sleep 4s
