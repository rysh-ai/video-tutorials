# Story 82: Email Channel (45s)
# Hook: "Give your humanoid an inbox -- it reads incoming mail and writes the replies."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-082-email-channel.tape

# --- Output Settings ---
Output story-082-email-channel.mp4
Output story-082-email-channel.gif

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
# "Give your humanoid an inbox --
#  it reads incoming mail and writes the replies."
# ============================================================
Sleep 0.1s

# ============================================================
# 0:03-0:10  Launch rysh
# "Launch rysh. The email channel lives under contacts.email
#  with IMAP for reading and SMTP for sending."
# ============================================================
Type "rysh"
Enter
Sleep 0.1s
Type "mkdir -p .rysh/humanoids"
Enter
Sleep 0.1s

# ============================================================
# 0:10-0:22  Write and show the email skill file
# "Set the address, IMAP host and port, SMTP host and port,
#  and the username and password as ENV_VARs. Cat it to see the shape."
# ============================================================
Type "echo '---' > .rysh/humanoids/support.md"
Enter
Type "echo 'name: support' >> .rysh/humanoids/support.md"
Enter
Type "echo 'contacts:' >> .rysh/humanoids/support.md"
Enter
Type "echo '  email:' >> .rysh/humanoids/support.md"
Enter
Type "echo '    address: support@example.com' >> .rysh/humanoids/support.md"
Enter
Type "echo '    imap_host: imap.example.com' >> .rysh/humanoids/support.md"
Enter
Type "echo '    smtp_host: smtp.example.com' >> .rysh/humanoids/support.md"
Enter
Type "echo '    username: EMAIL_USER' >> .rysh/humanoids/support.md"
Enter
Type "echo '    password: EMAIL_PASS' >> .rysh/humanoids/support.md"
Enter
Type "echo '---' >> .rysh/humanoids/support.md"
Enter
Type "echo 'You answer support email professionally.' >> .rysh/humanoids/support.md"
Enter
Sleep 0.1s
Type "cat .rysh/humanoids/support.md"
Enter
Sleep 0.1s

# ============================================================
# 0:22-0:31  Spawn the humanoid
# "Double-Escape into rysh mode and spawn it.
#  The humanoid gains email_list, email_read, and email_send tools."
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
# 0:31-0:39  Start the email channel
# "Start the email adapter and the humanoid begins polling the inbox,
#  turning each new message into a prompt and mailing back its answer."
# ============================================================
Type "##humanoid channel start support email"
Enter
Sleep 0.1s

# ============================================================
# 0:39-0:45  Show channels
# "##humanoid channels support confirms the inbox is connected and live."
# ============================================================
Type "##humanoid channels support"
Enter
Sleep 0.1s
