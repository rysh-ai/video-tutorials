# Story 69: Pane Listening (50s)
# Hook: "Pipe one pane's live output straight into another -- secrets redacted automatically."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-069-pane-listening.tape

# --- Output Settings ---
Output story-069-pane-listening.mp4
Output story-069-pane-listening.gif

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
# "Pipe one pane's live output straight into another --
#  secrets redacted automatically."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh and split a pane
# "Start rysh and split a second pane. We'll have one pane
#  listen to the other."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s
Escape
Sleep 1s

# ============================================================
# 0:08-0:18  Name the source pane
# "In the left pane, switch to rysh mode and give it a name
#  so the listener has an alias to attach to."
# ============================================================
Tab
Sleep 1s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 2s
Type "##pane name builder"
Enter
Sleep 3s

# ============================================================
# 0:18-0:28  Start listening from the other pane
# "Move to the other pane and run pane listen builder.
#  Now the builder's shared output flows here, prefixed [builder]."
# ============================================================
Tab
Sleep 1s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 2s
Type "##pane listen builder"
Enter
Sleep 3s

# ============================================================
# 0:28-0:40  Generate output in the source pane
# "Back in the builder, run a command. Its output appears in
#  the listening pane in real time -- secrets stripped first."
# ============================================================
Tab
Sleep 1s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 2s
Type "echo 'build started'; ls"
Enter
Sleep 4s

# ============================================================
# 0:40-0:47  Stop listening
# "When you're done, the listening pane runs pane unlisten
#  to detach the stream."
# ============================================================
Tab
Sleep 1s
Type "##pane unlisten"
Enter
Sleep 3s

# ============================================================
# 0:47-0:50  Hold final frame
# "Cross-pane awareness with redaction built in."
# ============================================================
Sleep 3s
