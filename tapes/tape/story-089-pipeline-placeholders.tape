# Story 89: Pipeline Placeholders (40s)
# Hook: "Placeholders are lanes reserved for pipeline output -- name them, add them, watch results land."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-089-pipeline-placeholders.tape

# --- Output Settings ---
Output story-089-pipeline-placeholders.mp4
Output story-089-pipeline-placeholders.gif

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
# "Placeholders are lanes reserved for pipeline output --
#  name them, add them, watch results land."
# ============================================================
Sleep 3.36s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh. A pipeline can route its output into named
#  placeholder lanes so each phase has a home."
# ============================================================
Type "rysh"
Enter
Sleep 5.23s

# ============================================================
# 0:08-0:15  Enter rysh mode and name the pipeline
# "Double-Escape into rysh mode. ##pipe name labels the
#  current pipeline so its output is easy to identify."
# ============================================================
Escape
Sleep 0.32s
Escape
Sleep 0.32s
Escape
Sleep 0.31s
Escape
Sleep 1.57s
Type "##pipe name release-flow"
Enter
Sleep 3.15s

# ============================================================
# 0:15-0:24  Add a placeholder
# "##pipe placeholder add creates a new placeholder lane --
#  a dedicated column for one slice of pipeline output."
# ============================================================
Type "##pipe placeholder add"
Enter
Sleep 8.36s

# ============================================================
# 0:24-0:32  Add another and list
# "Add as many as your pipeline needs, then ##pipe placeholder
#  list shows every placeholder currently defined."
# ============================================================
Type "##pipe placeholder add"
Enter
Sleep 2.18s
Type "##pipe placeholder list"
Enter
Sleep 3.26s

# ============================================================
# 0:32-0:40  Hold final frame
# "Placeholders turn a pipeline into a structured dashboard --
#  one lane per stage, output flowing into place."
# ============================================================
Sleep 8.96s
