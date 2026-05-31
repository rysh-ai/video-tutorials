# Story 50: Editing Files (50s)
# Hook: "When the agent edits a file, you see the diff first -- every write waits for your yes."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-050-editing-files.tape

# --- Output Settings ---
Output story-050-editing-files.mp4
Output story-050-editing-files.gif

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
# "When the agent edits a file, you see the diff first --
#  every write waits for your yes."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh and create a file
# "Launch rysh and drop in a small file we can have the agent edit."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:14  Make a sample file in shell mode
# "In shell mode, create a quick README so there's something to change."
# ============================================================
Type "printf 'hello\\nworld\\n' > notes.txt"
Enter
Sleep 2s

# ============================================================
# 0:14-0:20  Switch to prompt mode
# "Double-press Escape to enter prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:20-0:36  Ask the agent to edit the file
# "Ask it to change a line. The agent uses file_edit for an exact-string replace,
#  multi_edit for several atomic hunks, file_write to create files, or apply_patch
#  for a unified diff. Each of these is approval-gated."
# ============================================================
Type "in notes.txt change the word world to rysh"
Enter
Sleep 9s

# ============================================================
# 0:36-0:45  Approve the edit
# "The footer shows the action with a diff preview. Press y to approve,
#  capital Y to approve always, n to reject, or capital N to reject with a reason."
# ============================================================
Type "y"
Sleep 4s

# ============================================================
# 0:45-0:50  Hold final frame
# "Nothing touches your files until you approve the diff."
# ============================================================
Sleep 3s
