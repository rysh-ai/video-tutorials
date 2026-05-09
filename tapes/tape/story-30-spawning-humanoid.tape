# Story 30: Spawning a Humanoid (50s)
# Hook: "Create a humanoid from a skill file -- define channels right in the Markdown."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-30-spawning-humanoid.tape

# --- Output Settings ---
Output story-30-spawning-humanoid.mp4
Output story-30-spawning-humanoid.gif

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
# "Start rysh -- we'll spawn a humanoid with a chatbot channel."
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
# 0:06-0:24  Create a humanoid skill file
# "Write a skill file with channel config in the frontmatter.
#  The contacts section defines which channels the humanoid uses."
# ============================================================
Type "cat > support-agent.md << 'EOF'"
Enter
Type "---"
Enter
Type "name: support-agent"
Enter
Type "description: Customer support humanoid"
Enter
Type "contacts:"
Enter
Type "  chatbot:"
Enter
Type "    listen_port: 23300"
Enter
Type "---"
Enter
Type "You are a customer support agent. Help users concisely."
Enter
Type "EOF"
Enter
Sleep 1s

# ============================================================
# 0:24-0:32  Spawn the humanoid from skill file
# "##humanoid spawn reads the file and creates the humanoid.
#  Channel configuration is parsed from the frontmatter."
# ============================================================
Type "##humanoid spawn support-agent.md"
Enter
Sleep 2s

# ============================================================
# 0:32-0:40  List humanoids
# "##humanoid list shows the new humanoid and its channels."
# ============================================================
Type "##humanoid list"
Enter
Sleep 2s

# ============================================================
# 0:40-0:50  Hold final frame
# "Humanoid spawned -- channels defined, ready to connect."
# ============================================================
Sleep 10s
