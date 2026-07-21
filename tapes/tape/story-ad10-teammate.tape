# ad10 Take B (v2) — teammate session subscribes to the shared pane (second session)
# v2: Padding 90 (FIX 1 — commands clear of frame edge + overlay bands).
# v3: FontSize 16 -> 32 (founder: commands unreadably small at 1080p; size fix).
# Share ID below is replaced with take A's real printed ID before running.
Output story-ad10-teammate.mp4
Set FontSize 32
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 90
Set TypingSpeed 60ms
Set Shell "bash"
Sleep 1s
Type "rysh"
Enter
Sleep 10s
Ctrl+Space
Sleep 1s
Right
Sleep 1s
Escape
Sleep 1s
Type "##upstream subscribe e9780ee4-acfb-4a05-968c-438113b6239a view"
Enter
Sleep 8s
# owner-side motion arrives here (driven off camera via rysh send)
Sleep 16s
Sleep 5s
