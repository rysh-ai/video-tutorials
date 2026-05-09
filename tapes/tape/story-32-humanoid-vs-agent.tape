# Story 32: Humanoid vs Agent (35s)
# Hook: "Agents work internally. Humanoids face the outside world. Same engine, different reach."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-32-humanoid-vs-agent.tape

# --- Output Settings ---
Output story-32-humanoid-vs-agent.mp4
Output story-32-humanoid-vs-agent.gif

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
# "Start rysh -- let's compare agents and humanoids."
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
# 0:06-0:08  Header
# "A quick comparison of the two entity types."
# ============================================================
Type "echo '=== Agent vs Humanoid ==='"
Enter
Sleep 0.5s

# ============================================================
# 0:08-0:12  Agent description
# "Agents handle internal work -- no external channels."
# ============================================================
Type "echo 'Agent: Internal work, no external channels'"
Enter
Sleep 0.5s

# ============================================================
# 0:12-0:16  Humanoid description
# "Humanoids connect to external channels."
# ============================================================
Type "echo 'Humanoid: External channels (Slack, Email, WhatsApp, Phone, Chatbot)'"
Enter
Sleep 0.5s

# ============================================================
# 0:16-0:20  Shared engine
# "Both use the same AI engine and the same 35+ tools."
# ============================================================
Type "echo 'Both: Same AI engine, same 35+ tools'"
Enter
Sleep 0.5s

# ============================================================
# 0:20-0:24  Shared interaction
# "Both use @ for prompts and @@ for control."
# ============================================================
Type "echo 'Both: @name for prompts, @@name for control'"
Enter
Sleep 0.5s

# ============================================================
# 0:24-0:28  Agent commands
# "Agents are managed with ##agent commands."
# ============================================================
Type "echo 'Agent: ##agent commands'"
Enter
Sleep 0.5s

# ============================================================
# 0:28-0:32  Humanoid commands
# "Humanoids are managed with ##humanoid commands."
# ============================================================
Type "echo 'Humanoid: ##humanoid commands'"
Enter
Sleep 1s

# ============================================================
# 0:32-0:35  Hold final frame
# "Same power, different scope -- choose the right tool."
# ============================================================
Sleep 3s
