# Story 86: Loading & Running Pipelines (50s)
# Hook: "Define a pipeline in a file, load it, run it -- ##pipe drives the whole lifecycle."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - A pipeline file at .rysh/pipelines/build.pipeline
#
# Run: vhs story-086-loading-running-pipelines.tape

# --- Output Settings ---
Output story-086-loading-running-pipelines.mp4
Output story-086-loading-running-pipelines.gif

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
# "Define a pipeline in a file, load it, run it --
#  ##pipe drives the whole lifecycle."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh. Pipelines live as files under
#  .rysh/pipelines in your project."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:14  Enter rysh mode and show help
# "Double-Escape into rysh mode. ##pipe help lists
#  everything the pipeline command can do."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s
Type "##pipe help"
Enter
Sleep 3s

# ============================================================
# 0:14-0:22  Load a pipeline from .rysh/pipelines
# "##pipe load build.pipeline reads the file from
#  .rysh/pipelines and registers it in this tab."
# ============================================================
Type "##pipe load build.pipeline"
Enter
Sleep 3s

# ============================================================
# 0:22-0:28  List and show
# "##pipe list shows what's loaded; ##pipe show prints
#  a pipeline's steps and details."
# ============================================================
Type "##pipe list"
Enter
Sleep 2s
Type "##pipe show build"
Enter
Sleep 3s

# ============================================================
# 0:28-0:38  Run the pipeline
# "##pipe run executes it -- defaulting to the first
#  loaded pipeline when you omit the name."
# ============================================================
Type "##pipe run build"
Enter
Sleep 4s

# ============================================================
# 0:38-0:45  Check status
# "##pipe status reports execution progress phase by phase."
# ============================================================
Type "##pipe status"
Enter
Sleep 3s

# ============================================================
# 0:45-0:50  Clear and hold
# "And ##pipe clear wipes the pipeline output when you're done.
#  Load, run, status, clear -- the full loop."
# ============================================================
Type "##pipe clear"
Enter
Sleep 3s
