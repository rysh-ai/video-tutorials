# Story 80: Spawning a Humanoid (45s)
# Hook: "Inline prompt or a skill file with a contacts block -- either way, it's one command."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-080-spawning-a-humanoid.tape

# --- Output Settings ---
Output story-080-spawning-a-humanoid.mp4
Output story-080-spawning-a-humanoid.gif

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
# "Inline prompt or a skill file with a contacts block --
#  either way, it's one command."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Launch rysh. The quickest way is an inline system prompt."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:18  Write a humanoid skill file
# "For real channels, write a skill file. It looks like an agent skill file
#  but adds a contacts section -- here, a Slack block with tokens and channels."
# ============================================================
Type "mkdir -p .rysh/humanoids"
Enter
Sleep 1s
Type "echo '---' > .rysh/humanoids/support.md"
Enter
Type "echo 'name: support' >> .rysh/humanoids/support.md"
Enter
Type "echo 'model: claude-sonnet-4-20250514' >> .rysh/humanoids/support.md"
Enter
Type "echo 'contacts:' >> .rysh/humanoids/support.md"
Enter
Type "echo '  slack:' >> .rysh/humanoids/support.md"
Enter
Type "echo '    channels: [ #support ]' >> .rysh/humanoids/support.md"
Enter
Type "echo '---' >> .rysh/humanoids/support.md"
Enter
Type "echo 'You are a customer support agent. Help users professionally.' >> .rysh/humanoids/support.md"
Enter
Sleep 2s

# ============================================================
# 0:18-0:28  Show the skill file
# "Cat it: name, description, model, then the contacts block.
#  The ENV_VAR syntax pulls secrets from the environment at parse time."
# ============================================================
Type "cat .rysh/humanoids/support.md"
Enter
Sleep 4s

# ============================================================
# 0:28-0:38  Spawn from the file
# "Double-Escape into rysh mode and spawn from the file with ##humanoid spawn.
#  Rysh wires up every channel in the contacts block."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s
Type "##humanoid spawn .rysh/humanoids/support.md"
Enter
Sleep 3s

# ============================================================
# 0:38-0:45  List with channel info
# "##humanoid list shows it running, with its Slack channel attached."
# ============================================================
Type "##humanoid list"
Enter
Sleep 3s
