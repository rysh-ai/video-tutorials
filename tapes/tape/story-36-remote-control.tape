# Story 36: Remote Control (45s)
# Hook: "Let a remote user run commands in your terminal -- with guardrails."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-36-remote-control.tape

# --- Output Settings ---
Output story-36-remote-control.mp4
Output story-36-remote-control.gif

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
# "Start rysh -- remote control with safety built in."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Introduce remote control
# "Control mode lets remote users execute commands."
# ============================================================
Type "echo 'Remote Command Execution - Control Mode'"
Enter
Sleep 1s

# ============================================================
# 0:08-0:12  Share step
# "First, share your pane with control access."
# ============================================================
Type "echo 'Share with: ##share pane control'"
Enter
Sleep 0.5s

# ============================================================
# 0:12-0:16  Subscribe step
# "The remote user subscribes to your share ID."
# ============================================================
Type "echo 'Remote subscribes: ##upstream subscribe <shareID>'"
Enter
Sleep 0.5s

# ============================================================
# 0:16-0:20  Send command step
# "Then they can send commands to your terminal."
# ============================================================
Type "echo 'Remote sends: ##upstream send make build'"
Enter
Sleep 0.5s

# ============================================================
# 0:20-0:22  Blank line separator
# ============================================================
Type "echo ''"
Enter
Sleep 0.3s

# ============================================================
# 0:22-0:26  Security header
# "But you stay in control -- security policies apply."
# ============================================================
Type "echo 'Security controls:'"
Enter
Sleep 0.5s

# ============================================================
# 0:26-0:30  Allowed commands
# "Whitelist which actions the remote user can perform."
# ============================================================
Type "echo '  allowed_commands = ['submit_input', 'exec_shell']'"
Enter
Sleep 0.5s

# ============================================================
# 0:30-0:34  Blocklist
# "Block dangerous commands from ever running remotely."
# ============================================================
Type "echo '  command_blocklist = ['rm -rf', 'git push --force']'"
Enter
Sleep 0.5s

# ============================================================
# 0:34-0:38  Approval gate
# "Require manual approval before any remote command runs."
# ============================================================
Type "echo '  command_approval = true'"
Enter
Sleep 2s

# ============================================================
# 0:38-0:45  Hold final frame
# "Remote control with guardrails -- power meets safety."
# ============================================================
Sleep 7s
