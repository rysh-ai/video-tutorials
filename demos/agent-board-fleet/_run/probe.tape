Output "_run/probe.mp4"
Set FontSize 14
Set Width 1920
Set Height 1080
Set Framerate 24
Set Theme "Catppuccin Mocha"
Set Padding 90
Set TypingSpeed 30ms
Set Shell "bash"

Sleep 1s
Type "echo PATH_HAS_BIN=$(command -v rysh)"
Enter
Sleep 2s
Screenshot "_run/probe-shell.png"
Type "rysh attach agentfleet"
Enter
Sleep 12s
Screenshot "_run/probe-tui.png"
