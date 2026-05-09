# Story 39: Softdev Pipeline (55s)
# Hook: "A full software development pipeline -- planning, coding, linting, testing."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-39-softdev-pipeline.tape

# --- Output Settings ---
Output story-39-softdev-pipeline.mp4
Output story-39-softdev-pipeline.gif

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
# "Start rysh -- orchestrate a full dev pipeline."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Name this pane "orchestrator"
# "The orchestrator pane drives the pipeline."
# ============================================================
Type "##pane name orchestrator"
Enter
Sleep 1s

# ============================================================
# 0:08-0:14  Split right and listen
# "A listener pane watches the pipeline progress."
# ============================================================
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s
Type "##pane listen orchestrator"
Enter
Sleep 1s

# ============================================================
# 0:14-0:18  Tab back to orchestrator
# "Switch back to the orchestrator to run the pipeline."
# ============================================================
Tab
Sleep 1s

# ============================================================
# 0:18-0:22  Introduce the pipeline
# "The softdev pipeline has four phases."
# ============================================================
Type "echo 'Software Development Pipeline'"
Enter
Sleep 1s

# ============================================================
# 0:22-0:28  Phase 1 - Planning
# "Phase 1 triggers the AI planning event.
#  The AI analyzes requirements and creates a plan."
# ============================================================
Type "echo 'Phase 1: ##>event:ai:softdev:golang:planning'"
Enter
Sleep 1s

# ============================================================
# 0:28-0:34  Phase 2 - Development
# "Phase 2 triggers AI-driven code generation."
# ============================================================
Type "echo 'Phase 2: ##>event:ai:softdev:golang:development'"
Enter
Sleep 1s

# ============================================================
# 0:34-0:40  Phase 3 - Linting
# "Phase 3 runs shell-based linting on the generated code."
# ============================================================
Type "echo 'Phase 3: ##>event:sh:softdev:golang:linting'"
Enter
Sleep 1s

# ============================================================
# 0:40-0:46  Phase 4 - Unit Testing
# "Phase 4 runs shell-based unit tests."
# ============================================================
Type "echo 'Phase 4: ##>event:sh:softdev:golang:unit_testing'"
Enter
Sleep 1s

# ============================================================
# 0:46-0:50  Context buffer
# "Each phase builds on context from previous phases.
#  A 50KB buffer carries state across the pipeline."
# ============================================================
Type "echo 'Each phase builds on accumulated context (50KB buffer)'"
Enter
Sleep 2s

# ============================================================
# 0:50-0:55  Hold final frame
# "Softdev pipeline -- plan, code, lint, test, all orchestrated."
# ============================================================
Sleep 5s
