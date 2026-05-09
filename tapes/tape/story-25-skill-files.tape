# Story 25: Skill Files (45s)
# Hook: "Define agents as Markdown skill files -- version-controlled, reusable, shareable."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-25-skill-files.tape

# --- Output Settings ---
Output story-25-skill-files.mp4
Output story-25-skill-files.gif

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
# "Start rysh -- we'll create a skill file for an agent."
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
# 0:06-0:08  Create agents directory
# "First, create a directory for your skill files."
# ============================================================
Type "mkdir -p .rysh/agents"
Enter
Sleep 0.5s

# ============================================================
# 0:08-0:22  Create a skill file using heredoc
# "Write a Markdown skill file with YAML frontmatter.
#  Name, description, and system prompt -- all in one file."
# ============================================================
Type "cat > .rysh/agents/reviewer.md << 'EOF'"
Enter
Type "---"
Enter
Type "name: reviewer"
Enter
Type "description: Code reviewer agent"
Enter
Type "---"
Enter
Type "You are a code reviewer. Review code for quality."
Enter
Type "EOF"
Enter
Sleep 1s

# ============================================================
# 0:22-0:30  Spawn agent from skill file
# "Spawn the agent directly from the skill file.
#  All config comes from the Markdown frontmatter."
# ============================================================
Type "##agent spawn .rysh/agents/reviewer.md"
Enter
Sleep 2s

# ============================================================
# 0:30-0:36  List agents to verify
# "##agent list confirms the agent is running."
# ============================================================
Type "##agent list"
Enter
Sleep 2s

# ============================================================
# 0:36-0:45  Hold final frame
# "Skill files: portable, version-controlled agent definitions."
# ============================================================
Sleep 9s
