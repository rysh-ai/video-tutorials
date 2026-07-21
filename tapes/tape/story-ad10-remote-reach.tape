# Story AD-10: Remote Reach in Minutes (hero take A, v2) — terminal side
# Master plan: marketing/assets/videos/remote-reach.md
# Filmed against the PUBLIC brew binary (rysh-ai/rysh 0.1.25) — install beat included.
# Timer overlay added in post from this take's own PTS (real time, single take),
# wall-time-scaled (VHS mp4 clock runs ~11% fast); disclosure line on screen.
# v2 changes (founder review): Set Padding 90 (was 20) so typed commands never
# touch the frame edge and post overlays (step label top-left, timer top-right,
# disclosure bottom) live in the padding bands, never over terminal content.
# Slack hold lengthened 42s -> 45s. Session hygiene + focus insurance: plan §5.
# v3 (founder review x2, same complaint): FontSize 16 -> 32. Root cause of the
# "first command not visible" rejection was SIZE, not position — 16px glyphs are
# microscopic in a 1920x1080 frame. 32px gives ~90 cols x ~23 rows; Padding stays
# 90 so the first typed line sits well below the burned step label (y<70).
Output story-ad10-remote-reach.mp4
Set FontSize 32
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 90
Set TypingSpeed 60ms
Set Shell "bash"
Sleep 1s
# ============ 0:00 Step 1 · one binary, no daemon zoo ============
Type "brew install rysh-ai/rysh/rysh"
Enter
Sleep 22s
Type "rysh"
Enter
Sleep 10s
# focus insurance (activePane race under load — master plan §5)
Ctrl+Space
Sleep 1s
Right
Sleep 1s
Escape
Sleep 1s
# ============ Step 2 · your agent is a .md file ============
Type "##pane name support"
Enter
Sleep 3s
Type "##humanoid spawn support-bot"
Enter
Sleep 5s
Type "##humanoid channel start support-bot slack"
Enter
Sleep 6s
Type "##humanoid channels support-bot"
Enter
Sleep 5s
# ============ Step 3 · Slack window: teammate asks, bot replies ============
Sleep 45s
# ============ Step 4 · share the actual terminal ============
Type "##share pane view"
Enter
Sleep 9s
Sleep 5s
