# Story 94: Secret Redaction (45s)
# Hook: "Your secrets never leave your machine -- redaction happens before output is shared."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - An enabled [upstream] block in rysh.config
#
# Run: vhs story-094-secret-redaction.tape

# --- Output Settings ---
Output story-094-secret-redaction.mp4
Output story-094-secret-redaction.gif

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
# "Your secrets never leave your machine --
#  redaction happens before output is shared."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:09  Launch rysh and print something sensitive
# "Start rysh. Suppose your terminal output contains an API key
#  or token -- exactly the thing you don't want to broadcast."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Type "echo API_KEY=sk-ant-secret-123456"
Enter
Sleep 3s

# ============================================================
# 0:09-0:18  Show private vs public output in rysh mode
# "Double-Escape into rysh mode. ##private pane print shows the
#  raw buffer -- everything, secrets included, on your screen."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s
Type "##private pane print"
Enter
Sleep 3s

# ============================================================
# 0:18-0:28  Show the redacted public view
# "##public pane print shows the redacted version -- the same
#  view the SharedOutputActor forwards upstream. Secrets are masked."
# ============================================================
Type "##public pane print"
Enter
Sleep 4s

# ============================================================
# 0:28-0:38  Explain the guarantee
# "When you share a pane, the SharedOutputActor redacts before
#  output leaves the session, so the server never sees raw secrets."
# ============================================================
Type "##share pane view"
Enter
Sleep 4s

# ============================================================
# 0:38-0:45  Hold final frame
# "Redaction plus a command blocklist means collaboration without
#  leaking credentials. Share with confidence."
# ============================================================
Sleep 3s
