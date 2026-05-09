# Story 40: Pipeline Commands (40s)
# Hook: "Manage your pipelines -- load, list, run, and monitor from the terminal."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-40-pipeline-commands.tape

# --- Output Settings ---
Output story-40-pipeline-commands.mp4
Output story-40-pipeline-commands.gif

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
# "Start rysh -- pipelines are first-class citizens."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Introduce pipeline commands
# "The ##pipe family of commands manages your pipelines."
# ============================================================
Type "echo 'Pipeline Commands'"
Enter
Sleep 0.5s

# ============================================================
# 0:08-0:12  pipe help
# "##pipe help shows all available pipeline sub-commands."
# ============================================================
Type "echo '##pipe help    - show all pipeline commands'"
Enter
Sleep 0.5s

# ============================================================
# 0:12-0:16  pipe load
# "##pipe load reads a pipeline definition from a YAML file."
# ============================================================
Type "echo '##pipe load    - load a pipeline YAML'"
Enter
Sleep 0.5s

# ============================================================
# 0:16-0:20  pipe list
# "##pipe list shows all loaded pipelines and their state."
# ============================================================
Type "echo '##pipe list    - list loaded pipelines'"
Enter
Sleep 0.5s

# ============================================================
# 0:20-0:24  pipe show
# "##pipe show inspects the steps inside a pipeline."
# ============================================================
Type "echo '##pipe show    - inspect pipeline steps'"
Enter
Sleep 0.5s

# ============================================================
# 0:24-0:28  pipe run
# "##pipe run kicks off the pipeline execution."
# ============================================================
Type "echo '##pipe run     - execute the pipeline'"
Enter
Sleep 0.5s

# ============================================================
# 0:28-0:32  pipe status
# "##pipe status shows which steps have completed or failed."
# ============================================================
Type "echo '##pipe status  - check execution progress'"
Enter
Sleep 2s

# ============================================================
# 0:32-0:40  Hold final frame
# "Six commands to control the full pipeline lifecycle."
# ============================================================
Sleep 8s
