# Story 88: The Softdev Pipeline (50s)
# Hook: "One event line can trigger an AI agent to plan, build, lint, and test -- automatically."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-088-softdev-pipeline.tape

# --- Output Settings ---
Output story-088-softdev-pipeline.mp4
Output story-088-softdev-pipeline.gif

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
# "One event line can trigger an AI agent to plan, build,
#  lint, and test -- automatically."
# ============================================================
Sleep 3.44s

# ============================================================
# 0:03-0:09  Launch rysh and split a worker
# "Start rysh and split a worker pane. The worker will listen
#  and react to software-development events."
# ============================================================
Type "rysh"
Enter
Sleep 2.69s
Ctrl+p
Sleep 0.9s
Type "n"
Sleep 1.8s
Escape
Sleep 0.9s

# ============================================================
# 0:09-0:16  Worker listens
# "In rysh mode, the worker listens to the orchestrator pane,
#  so softdev events fire its AgenticActor."
# ============================================================
Escape
Sleep 0.39s
Escape
Sleep 0.39s
Escape
Sleep 0.39s
Escape
Sleep 1.95s
Type "##pane listen orchestrator"
Enter
Sleep 2.59s

# ============================================================
# 0:16-0:24  Back to orchestrator, rysh mode
# "Back on the orchestrator, switch to rysh mode. The softdev
#  schema is ai or sh, softdev, language, then phase."
# ============================================================
Tab
Sleep 3.39s
Escape
Sleep 0.68s
Escape
Sleep 0.68s
Escape
Sleep 0.67s
Escape
Sleep 3.39s

# ============================================================
# 0:24-0:33  Fire the planning AI event
# "ai softdev golang planning triggers the worker's agent to
#  analyze the codebase and draft an implementation plan."
# ============================================================
Type "##>event:ai:softdev:golang:planning"
Enter
Sleep 7.63s

# ============================================================
# 0:33-0:41  Fire a shell build event
# "The sh prefix runs a real command instead. sh softdev golang
#  development runs go build across the listening pane."
# ============================================================
Type "##>event:sh:softdev:golang:development"
Enter
Sleep 6.26s

# ============================================================
# 0:41-0:47  Fire unit testing
# "ai softdev golang unit_testing has the agent run go test and
#  fix any failures. Phases run from planning to monitoring."
# ============================================================
Type "##>event:ai:softdev:golang:unit_testing"
Enter
Sleep 3.89s

# ============================================================
# 0:47-0:50  Hold final frame
# "Planning, development, linting, testing, deployment, monitoring --
#  an autonomous build pipeline, one event at a time."
# ============================================================
Sleep 3.44s
