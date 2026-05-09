# Story 19: Tool Approval (50s)
# Hook: "Every destructive tool call needs your approval. You stay in control."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#   - No hello.txt in the current directory
#
# Run: vhs story-19-tool-approval.tape

# --- Output Settings ---
Output story-19-tool-approval.mp4
Output story-19-tool-approval.gif

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
# "Start rysh -- you land in shell mode."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Switch to prompt mode with double-Escape
# "Double-press Escape to enter prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:08-0:18  Ask AI to create a file
# "Ask the AI to write a file. It will propose a file_write
#  tool call -- but first, it needs your approval."
# ============================================================
Type "create a file called hello.txt with the content 'Hello World'"
Enter
Sleep 5s

# ============================================================
# 0:18-0:23  Approval dialog appears
# "The approval dialog shows exactly what tool the AI wants
#  to run and what arguments it will use. No surprises."
# ============================================================
Sleep 3s

# ============================================================
# 0:23-0:27  Approve the tool call
# "Type y to approve. The file gets created."
# ============================================================
Type "y"
Enter
Sleep 2s

# ============================================================
# 0:27-0:32  Wait for confirmation
# "The AI confirms the file was created successfully."
# ============================================================
Sleep 3s

# ============================================================
# 0:32-0:40  Verify by asking AI to read the file
# "Now ask the AI to show the contents -- read tools
#  are non-destructive, so they run without approval."
# ============================================================
Type "show me the contents of hello.txt"
Enter
Sleep 3s

# ============================================================
# 0:40-0:45  See the file contents
# "There it is -- Hello World. Written by AI, approved by you."
# ============================================================
Sleep 3s

# ============================================================
# 0:45-0:50  Hold final frame
# "Every write, delete, and execute needs your say-so.
#  You stay in control."
# ============================================================
Sleep 5s
