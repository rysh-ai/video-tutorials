# ad10 Take C (v2) — manage the session from a second shell: send, attach, stop, unshare
# v2: Padding 90 (FIX 1 — commands clear of frame edge + overlay bands).
# v3: FontSize 16 -> 32 (founder: commands unreadably small at 1080p; size fix).
Output story-ad10-remote-mgmt.mp4
Set FontSize 32
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 90
Set TypingSpeed 60ms
Set Shell "bash"
Sleep 1s
Type "rysh list-sessions"
Enter
Sleep 4s
Type "rysh send northwind '##humanoid channels support-bot' --mode shell"
Enter
Sleep 4s
Type "rysh attach northwind"
Enter
Sleep 9s
Ctrl+Space
Sleep 1s
Right
Sleep 1s
Escape
Sleep 2s
Type "##humanoid channel stop support-bot slack"
Enter
Sleep 5s
Type "##unshare pane"
Enter
Sleep 6s
Sleep 4s
