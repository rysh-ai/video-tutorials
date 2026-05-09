# Story 29: What Are Humanoids (55s)
# Hook: "Humanoids = Autonomous Agents + External Channels. They talk to the outside world."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-29-what-are-humanoids.tape

# --- Output Settings ---
Output story-29-what-are-humanoids.mp4
Output story-29-what-are-humanoids.gif

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
# "Start rysh -- let's learn about humanoids."
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
# 0:06-0:12  Explain what humanoids are
# "Humanoids extend agents with external communication channels."
# ============================================================
Type "echo 'Humanoids = Autonomous Agents + External Channels'"
Enter
Sleep 1s

# ============================================================
# 0:12-0:18  List supported channels
# "Five channel types: WhatsApp, Slack, Email, Phone, Chatbot."
# ============================================================
Type "echo 'Supported channels: WhatsApp, Slack, Email, Phone, Chatbot'"
Enter
Sleep 1s

# ============================================================
# 0:18-0:24  Explain the message flow
# "Inbound messages hit the LLM, responses go back out."
# ============================================================
Type "echo 'Inbound messages -> LLM prompt -> Response -> Channel'"
Enter
Sleep 1s

# ============================================================
# 0:24-0:30  Explain conversation context
# "Each thread keeps 20 turns of context with 24-hour TTL."
# ============================================================
Type "echo 'Per-thread conversation context (20 turns, 24h TTL)'"
Enter
Sleep 1s

# ============================================================
# 0:30-0:40  List humanoids
# "##humanoid list shows all spawned humanoids."
# ============================================================
Type "##humanoid list"
Enter
Sleep 2s

# ============================================================
# 0:40-0:55  Hold final frame
# "Humanoids: your AI agents that face the outside world."
# ============================================================
Sleep 15s
