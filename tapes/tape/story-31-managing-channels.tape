# Story 31: Managing Channels (40s)
# Hook: "Start and stop channels, check status -- full control over humanoid communication."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - support-agent.md skill file exists (created in Story 30)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-31-managing-channels.tape

# --- Output Settings ---
Output story-31-managing-channels.mp4
Output story-31-managing-channels.gif

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
# "Start rysh -- we'll manage humanoid channels."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:06  Switch to prompt mode
# "Double-press Escape to enter prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:06-0:10  Spawn the humanoid
# "Spawn the support-agent humanoid from its skill file."
# ============================================================
Type "##humanoid spawn support-agent.md"
Enter
Sleep 2s

# ============================================================
# 0:10-0:16  Check channel status
# "##humanoid channels shows the status of each channel."
# ============================================================
Type "##humanoid channels support-agent"
Enter
Sleep 2s

# ============================================================
# 0:16-0:22  Start the chatbot channel
# "##humanoid channel start activates the chatbot listener."
# ============================================================
Type "##humanoid channel start support-agent chatbot"
Enter
Sleep 2s

# ============================================================
# 0:22-0:28  Check channels again
# "Channels command confirms the chatbot is now running."
# ============================================================
Type "##humanoid channels support-agent"
Enter
Sleep 2s

# ============================================================
# 0:28-0:36  Send a prompt to the humanoid
# "Use @name to talk directly to the humanoid."
# ============================================================
Type "@support-agent what services do you offer?"
Enter
Sleep 5s

# ============================================================
# 0:36-0:40  Hold final frame
# "Channels managed -- start, stop, and monitor at will."
# ============================================================
Sleep 4s
