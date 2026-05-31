# Story 54: Building Your Project (40s)
# Hook: "Ask the agent to build -- it compiles, parses the errors, and fixes them."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Run inside a buildable project
#
# Run: vhs story-054-building-your-project.tape

# --- Output Settings ---
Output story-054-building-your-project.mp4
Output story-054-building-your-project.gif

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
# "Ask the agent to build -- it compiles, parses the errors, and fixes them."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Launch rysh inside a project you can compile."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:13  Switch to prompt mode
# "Double-press Escape for prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:13-0:30  Ask the agent to build and fix
# "Ask it to build and fix any errors. The build tool compiles your project
#  and returns structured, parsed errors -- file, line, and message --
#  so the agent knows exactly what broke. The build tool itself needs no approval."
# ============================================================
Type "build the project and fix any compile errors"
Enter
Sleep 10s

# ============================================================
# 0:30-0:37  Narrate the loop
# "If it proposes a code change to fix an error, that file edit is the part
#  that asks for approval -- you review the diff, approve, and it builds again."
# ============================================================
Sleep 4s

# ============================================================
# 0:37-0:40  Hold final frame
# "Build, read the errors, fix, repeat -- hands on the wheel."
# ============================================================
Sleep 3s
