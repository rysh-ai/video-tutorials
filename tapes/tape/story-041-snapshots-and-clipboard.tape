# Story 41: Snapshots & Clipboard (45s)
# Hook: "Grab a pane's output to your clipboard -- raw for you, redacted for sharing."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-041-snapshots-and-clipboard.tape

# --- Output Settings ---
Output story-041-snapshots-and-clipboard.mp4
Output story-041-snapshots-and-clipboard.gif

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
# "Grab a pane's output to your clipboard --
#  raw for you, redacted for sharing."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:07  Launch rysh
# "Launch rysh and generate some output worth capturing."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:07-0:13  Produce output
# "Run a command -- its output fills the pane's buffer."
# ============================================================
Type "env | head -n 5"
Enter
Sleep 3s

# ============================================================
# 0:13-0:18  Enter rysh mode
# "Double-Escape over to rysh mode for the snapshot commands."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s

# ============================================================
# 0:18-0:25  ##snap
# "##snap -- the same as ##snap private --
#  copies the pane's raw buffer straight to your clipboard."
# ============================================================
Type "##snap"
Enter
Sleep 3s

# ============================================================
# 0:25-0:32  ##snap public
# "##snap public copies the redacted version --
#  secrets are stripped before they ever hit the clipboard."
# ============================================================
Type "##snap public"
Enter
Sleep 3s

# ============================================================
# 0:32-0:39  Print commands
# "Prefer to see it inline? ##private pane print shows raw output;
#  ##public pane print shows the redacted version right in the pane."
# ============================================================
Type "##private pane print"
Enter
Sleep 2s
Type "##public pane print"
Enter
Sleep 3s

# ============================================================
# 0:39-0:45  Hold final frame
# "Snapshots make it easy to copy, paste, and share -- safely."
# ============================================================
Sleep 3s
