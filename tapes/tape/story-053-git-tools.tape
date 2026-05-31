# Story 53: Git Tools (45s)
# Hook: "Summarize your changes and commit -- the agent reads git for free, but the commit waits for you."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Run inside a git repo with some uncommitted changes
#
# Run: vhs story-053-git-tools.tape

# --- Output Settings ---
Output story-053-git-tools.mp4
Output story-053-git-tools.gif

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
# "Summarize your changes and commit -- the agent reads git for free,
#  but the commit waits for you."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh inside a git repository that has a few uncommitted changes."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:13  Switch to prompt mode
# "Double-press Escape to reach prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:13-0:30  Ask the agent to summarize and commit
# "Ask it to summarize your work and commit. The agent calls git_status,
#  git_diff, and git_log -- all read-only -- to understand what changed,
#  then drafts a commit message for you."
# ============================================================
Type "summarize my changes and commit them"
Enter
Sleep 10s

# ============================================================
# 0:30-0:40  Approve the commit
# "The git_commit tool is the one that needs approval. The footer shows the
#  proposed message; press y to approve, and the commit lands. Capital N lets
#  you reject with a reason if you want a different message."
# ============================================================
Type "y"
Sleep 5s

# ============================================================
# 0:40-0:45  Hold final frame
# "Reads are instant, writes are gated -- git, the safe way."
# ============================================================
Sleep 3s
