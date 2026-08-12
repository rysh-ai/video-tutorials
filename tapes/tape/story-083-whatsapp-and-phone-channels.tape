# Story 83: WhatsApp & Phone Channels (45s)
# Hook: "WhatsApp Cloud API and Twilio phone -- your humanoid reaches everyone's pocket."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-083-whatsapp-and-phone-channels.tape

# --- Output Settings ---
Output story-083-whatsapp-and-phone-channels.mp4
Output story-083-whatsapp-and-phone-channels.gif

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
# "WhatsApp Cloud API and Twilio phone --
#  your humanoid reaches everyone's pocket."
# ============================================================
Sleep 0.1s

# ============================================================
# 0:03-0:10  Launch rysh
# "Launch rysh. WhatsApp uses the Cloud API; phone uses Twilio.
#  Both go in the contacts block of the skill file."
# ============================================================
Type "rysh"
Enter
Sleep 0.1s
Type "mkdir -p .rysh/humanoids"
Enter
Sleep 0.1s

# ============================================================
# 0:10-0:24  Write and show the skill file
# "WhatsApp needs a phone, an api_key, and a business_id.
#  Phone needs a number, the provider twilio, an account_sid, and an auth_token --
#  every secret pulled in with the ENV_VAR syntax."
# ============================================================
Type "echo '---' > .rysh/humanoids/support.md"
Enter
Type "echo 'name: support' >> .rysh/humanoids/support.md"
Enter
Type "echo 'contacts:' >> .rysh/humanoids/support.md"
Enter
Type "echo '  whatsapp:' >> .rysh/humanoids/support.md"
Enter
Type "echo '    phone: +1234567890' >> .rysh/humanoids/support.md"
Enter
Type "echo '    api_key: WHATSAPP_API_KEY' >> .rysh/humanoids/support.md"
Enter
Type "echo '    business_id: 123456' >> .rysh/humanoids/support.md"
Enter
Type "echo '  phone:' >> .rysh/humanoids/support.md"
Enter
Type "echo '    number: +1234567890' >> .rysh/humanoids/support.md"
Enter
Type "echo '    provider: twilio' >> .rysh/humanoids/support.md"
Enter
Type "echo '    account_sid: TWILIO_SID' >> .rysh/humanoids/support.md"
Enter
Type "echo '    auth_token: TWILIO_TOKEN' >> .rysh/humanoids/support.md"
Enter
Type "echo '---' >> .rysh/humanoids/support.md"
Enter
Type "echo 'You help customers over WhatsApp and phone.' >> .rysh/humanoids/support.md"
Enter
Sleep 0.1s
Type "cat .rysh/humanoids/support.md"
Enter
Sleep 0.1s

# ============================================================
# 0:24-0:33  Spawn and start WhatsApp
# "Double-Escape into rysh mode, spawn the humanoid,
#  then start the WhatsApp channel."
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
Type "##humanoid channel start support whatsapp"
Enter
Sleep 0.1s

# ============================================================
# 0:33-0:40  Start phone
# "Start the phone channel the same way -- name, then the channel type."
# ============================================================
Type "##humanoid channel start support phone"
Enter
Sleep 0.1s

# ============================================================
# 0:40-0:45  Show channels
# "##humanoid channels support lists both channels, now live."
# ============================================================
Type "##humanoid channels support"
Enter
Sleep 0.1s
