# Story 111: Chatbot Widget & Connections (45s)
# Hook: "Drop a rysh-powered chatbot on your website with one script tag."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-111-chatbot-widget-connections.tape

# --- Output Settings ---
Output story-111-chatbot-widget-connections.mp4
Output story-111-chatbot-widget-connections.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:05  Title / Hook
# "Drop a rysh-powered chatbot on your website
#  with one script tag."
# ============================================================
Sleep 5.11s

# ============================================================
# 0:05-0:15  Per-workspace config
# "Each workspace has its own chatbot config -- a system prompt, a model, and a
#  list of allowed origins that may embed it."
# ============================================================
Type "echo 'Chatbot config (per workspace): system prompt | model | allowed origins'"
Enter
Sleep 4.3s

# ============================================================
# 0:15-0:25  The embeddable widget
# "You embed it with a single script -- chatbot slash widget dot js -- and the
#  widget appears on your site."
# ============================================================
Type "echo '<script src=https://rysh.works/chatbot/widget.js></script>'"
Enter
Sleep 5.27s

# ============================================================
# 0:25-0:35  Per-visitor sessions and takeover
# "Every visitor gets their own session, and at any point a human can step in and
#  take over the conversation from the bot."
# ============================================================
Type "echo 'Per-visitor sessions + human takeover at any time'"
Enter
Sleep 5.95s

# ============================================================
# 0:35-0:45  External connections
# "Beyond the website, the same workspace can connect external channels --
#  Slack, WhatsApp, Email -- so every conversation lands in one place."
# ============================================================
Type "echo 'External connections: Slack | WhatsApp | Email -> one inbox'"
Enter
Sleep 5.2s
