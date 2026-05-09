# Story 33: Cross-Pane Listening (45s)
# Hook: "Listen to another pane's output in real time -- name, listen, and watch."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-33-cross-pane-listening.tape

# --- Output Settings ---
Output story-33-cross-pane-listening.mp4
Output story-33-cross-pane-listening.gif

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
# 0:04-0:08  Name this pane "builder"
# "Name the current pane 'builder' so others can reference it."
# ============================================================
Type "##pane name builder"
Enter
Sleep 1s

# ============================================================
# 0:08-0:12  Split right and listen to builder
# "Ctrl+P enters pane mode, n splits right.
#  In the new pane, start listening to builder."
# ============================================================
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s
Type "##pane listen builder"
Enter
Sleep 1s

# ============================================================
# 0:12-0:16  Tab back to builder pane
# "Tab cycles back to the builder pane on the left."
# ============================================================
Tab
Sleep 1s

# ============================================================
# 0:16-0:20  Run build commands in builder pane
# "Run commands in builder -- the listener pane mirrors output."
# ============================================================
Type "echo 'Building the project...'"
Enter
Sleep 1s

# ============================================================
# 0:20-0:24  Continue build output
# "Each command's output streams to the listening pane."
# ============================================================
Type "echo 'Compiling main.go'"
Enter
Sleep 1s

# ============================================================
# 0:24-0:30  Build complete
# "The right pane shows all output with [builder] prefix."
# ============================================================
Type "echo 'Build complete!'"
Enter
Sleep 2s

# ============================================================
# 0:30-0:38  Switch to listener and observe
# "Tab to the listener -- all builder output appeared here."
# ============================================================
Tab
Sleep 2s

# ============================================================
# 0:38-0:42  Stop listening
# "##pane unlisten stops the cross-pane stream."
# ============================================================
Type "##pane unlisten"
Enter
Sleep 1s

# ============================================================
# 0:42-0:45  Hold final frame
# "Cross-pane listening -- monitor any pane from anywhere."
# ============================================================
Sleep 3s
