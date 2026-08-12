# Story 75: Skill Files (50s)
# Hook: "Define an agent once in a file -- name, model, and system prompt -- then spawn it anywhere."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-075-skill-files.tape

# --- Output Settings ---
Output story-075-skill-files.mp4
Output story-075-skill-files.gif

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
# "Define an agent once in a file -- name, model, and system prompt --
#  then spawn it anywhere."
# ============================================================
Sleep 2.37s

# ============================================================
# 0:03-0:08  Launch rysh
# "Launch rysh. A skill file is just a markdown file
#  with YAML frontmatter."
# ============================================================
Type "rysh"
Enter
Sleep 3.57s

# ============================================================
# 0:08-0:16  Create a skill file
# "Let's write one. The frontmatter sets name, description, and model;
#  everything after it becomes the agent's system prompt."
# ============================================================
Type "mkdir -p .rysh/agents/reviewer"
Enter
Sleep 0.1s
Type "printf -- '---\\nname: code-reviewer\\ndescription: Reviews code for quality\\nmodel: claude-sonnet-4-20250514\\n---\\nYou are a code reviewer. Review code for quality, correctness, and adherence to best practices.\\n' > .rysh/agents/reviewer/SKILL.md"
Enter
Sleep 0.1s

# ============================================================
# 0:16-0:26  Show the skill file
# "Cat the file to see the format: the YAML block between the dashes,
#  then the prompt body. With no frontmatter, the whole file is the prompt
#  and the name comes from the filename."
# ============================================================
Type "cat .rysh/agents/reviewer/SKILL.md"
Enter
Sleep 5.27s

# ============================================================
# 0:26-0:36  Spawn from the skill file
# "Spawn straight from the file. Double-Escape into rysh mode,
#  then point ##agent spawn at the SKILL.md path."
# ============================================================
Escape
Sleep 0.24s
Escape
Sleep 0.24s
Escape
Sleep 0.23s
Escape
Sleep 1.17s
Type "##agent spawn .rysh/agents/reviewer/SKILL.md"
Enter
Sleep 2.34s

# ============================================================
# 0:36-0:47  Confirm it spawned
# "##agent list confirms the agent, built entirely from the file --
#  reusable, version-controlled, shareable across your team."
# ============================================================
Type "##agent list"
Enter
Sleep 7.71s

# ============================================================
# 0:47-0:50  Hold final frame
# "Skill files turn agents into code you can commit and reuse."
# ============================================================
Sleep 2.37s
