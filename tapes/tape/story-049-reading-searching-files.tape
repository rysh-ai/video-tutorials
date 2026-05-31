# Story 49: Reading & Searching Files (45s)
# Hook: "Point the agent at your code -- ls, file_read, glob, and grep find anything, no approval required."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-049-reading-searching-files.tape

# --- Output Settings ---
Output story-049-reading-searching-files.mp4
Output story-049-reading-searching-files.gif

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
# "Point the agent at your code -- ls, file_read, glob, and grep
#  find anything, no approval required."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh in a project directory you want to explore."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:14  Switch to prompt mode
# "Double-press Escape to switch to prompt mode and talk to the agent."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:14-0:30  Ask it to find TODO comments
# "Ask it to find all the TODO comments. It reaches for grep with a regex,
#  glob to walk the tree with double-star patterns, and file_read to peek inside.
#  These are read-only tools, so they run without asking for approval."
# ============================================================
Type "find all the TODO comments in this project and list the files"
Enter
Sleep 10s

# ============================================================
# 0:30-0:42  Narrate the toolset
# "Behind that single request: ls for quick listings, glob for pattern matching,
#  grep for content search, file_read for contents, and tree for structure --
#  the agent picks whichever fits, and shows you exactly what it found."
# ============================================================
Sleep 4s

# ============================================================
# 0:42-0:45  Hold final frame
# "Read and search the whole codebase, just by asking."
# ============================================================
Sleep 3s
