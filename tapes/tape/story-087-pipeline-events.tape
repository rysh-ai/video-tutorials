# Story 87: Pipeline Events (##>) (45s)
# Hook: "Lines starting with double-hash-greater-than bypass the shell and fly straight to NATS."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-087-pipeline-events.tape

# --- Output Settings ---
Output story-087-pipeline-events.mp4
Output story-087-pipeline-events.gif

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
# "Lines starting with double-hash-greater-than bypass the shell
#  and fly straight to NATS."
# ============================================================
Sleep 3.24s

# ============================================================
# 0:03-0:09  Launch rysh, split a worker pane
# "Start rysh and split a second pane. We'll have this worker
#  listen to the first pane's shared output."
# ============================================================
Type "rysh"
Enter
Sleep 2.52s
Ctrl+p
Sleep 0.84s
Type "n"
Sleep 1.68s
Escape
Sleep 0.84s

# ============================================================
# 0:09-0:18  Worker listens to the orchestrator
# "In rysh mode, ##pane listen forwards another pane's shared
#  output here. Event payloads arrive without an alias prefix."
# ============================================================
Escape
Sleep 0.51s
Escape
Sleep 0.5s
Escape
Sleep 0.5s
Escape
Sleep 2.52s
Type "##pane listen orchestrator"
Enter
Sleep 3.36s

# ============================================================
# 0:18-0:25  Back to orchestrator, switch to rysh mode
# "Hop to the orchestrator pane and switch it to rysh mode
#  so we can emit a pipeline event."
# ============================================================
Tab
Sleep 2.76s
Escape
Sleep 0.56s
Escape
Sleep 0.55s
Escape
Sleep 0.55s
Escape
Sleep 2.76s

# ============================================================
# 0:25-0:34  Emit a print event
# "##>event:print: takes a payload. This line never touches the
#  PTY -- it publishes straight to the pane's NATS output topic."
# ============================================================
Type "##>event:print:Build started at 10:30 AM"
Enter
Sleep 6.64s

# ============================================================
# 0:34-0:42  Emit another event
# "Send as many as you like. Each event is a clean line in the
#  shared output buffer, visible to every listening pane."
# ============================================================
Type "##>event:print:Compiling module auth"
Enter
Sleep 5.86s

# ============================================================
# 0:42-0:45  Hold final frame
# "##> is your event bus -- shell-free messages between panes."
# ============================================================
Sleep 3.24s
