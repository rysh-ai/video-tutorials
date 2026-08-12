# Story 81: Slack Channel (45s)
# Hook: "Drop your humanoid into Slack and let it answer threads on its own."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-081-slack-channel.tape

# --- Output Settings ---
Output story-081-slack-channel.mp4
Output story-081-slack-channel.gif

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
# "Drop your humanoid into Slack
#  and let it answer threads on its own."
# ============================================================
Sleep 0.1s

# ============================================================
# 0:03-0:10  Show the Slack contacts block
# "Launch rysh. The Slack channel is configured under contacts.slack:
#  a bot token, an app token, and the channels to join."
# ============================================================
Type "rysh"
Enter
Sleep 0.1s
Type "mkdir -p .rysh/humanoids"
Enter
Sleep 0.1s

# ============================================================
# 0:10-0:20  Write and show the skill file
# "Tokens use the ENV_VAR syntax so they never sit in plaintext.
#  Channels list the rooms the humanoid listens and replies in."
# ============================================================
Type "echo '---' > .rysh/humanoids/support.md"
Enter
Type "echo 'name: support' >> .rysh/humanoids/support.md"
Enter
Type "echo 'contacts:' >> .rysh/humanoids/support.md"
Enter
Type "echo '  slack:' >> .rysh/humanoids/support.md"
Enter
Type "echo '    bot_token: SLACK_BOT_TOKEN' >> .rysh/humanoids/support.md"
Enter
Type "echo '    app_token: SLACK_APP_TOKEN' >> .rysh/humanoids/support.md"
Enter
Type "echo '    channels: [ #support, #engineering ]' >> .rysh/humanoids/support.md"
Enter
Type "echo '---' >> .rysh/humanoids/support.md"
Enter
Type "echo 'You are a Slack support bot.' >> .rysh/humanoids/support.md"
Enter
Sleep 0.1s
Type "cat .rysh/humanoids/support.md"
Enter
Sleep 0.1s

# ============================================================
# 0:20-0:28  Spawn the humanoid
# "Double-Escape into rysh mode and spawn it from the file."
# ============================================================
Escape
Sleep 0.1s
Escape
Sleep 0.1s
Escape
Sleep 0.1s
Escape
Sleep 0.1s
Type "##humanoid spawn .rysh/humanoids/support.md"
Enter
Sleep 0.1s

# ============================================================
# 0:28-0:36  Start the Slack channel
# "Start the Slack adapter explicitly with ##humanoid channel start,
#  the humanoid's name, and the channel type slack."
# ============================================================
Type "##humanoid channel start support slack"
Enter
Sleep 0.1s

# ============================================================
# 0:36-0:45  Inspect channels
# "##humanoid channels support shows the connection details --
#  which channels it joined and whether the adapter is live."
# ============================================================
Type "##humanoid channels support"
Enter
Sleep 0.1s
