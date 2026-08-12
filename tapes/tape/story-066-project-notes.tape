# Story 66: Project Notes (40s)
# Hook: "A shared scratchpad your agent reads and writes for the whole project."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-066-project-notes.tape

# --- Output Settings ---
Output story-066-project-notes.mp4
Output story-066-project-notes.gif

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
# "A shared scratchpad your agent reads and writes
#  for the whole project."
# ============================================================
Sleep 3.16s

# ============================================================
# 0:03-0:08  Launch rysh into prompt mode
# "Start rysh and drop into prompt mode."
# ============================================================
Type "rysh"
Enter
Sleep 2.68s
Escape
Sleep 0.27s
Escape
Sleep 1.79s

# ============================================================
# 0:08-0:22  Ask the agent to record a project note
# "Ask the agent to note a project decision. The project_notes
#  tool appends it to a shared .rysh-notes.md file."
# ============================================================
Type "add a project note: we standardized on Go 1.22 and golangci-lint"
Enter
Sleep 9.86s

# ============================================================
# 0:22-0:32  Read the notes file in shell mode
# "Back in shell mode, the notes live in a plain markdown file
#  you can open, edit, and commit alongside your code."
# ============================================================
Escape
Sleep 3.01s
Type "cat .rysh-notes.md"
Enter
Sleep 6.02s

# ============================================================
# 0:32-0:40  Recap
# "project_notes is durable, file-backed memory that every pane
#  and every agent on the project can share."
# ============================================================
Sleep 8.42s
