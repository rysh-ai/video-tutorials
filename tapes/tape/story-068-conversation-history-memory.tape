# Story 68: Conversation History & Memory (45s)
# Hook: "Recall any pane's conversation, and let old turns compact into summaries."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-068-conversation-history-memory.tape

# --- Output Settings ---
Output story-068-conversation-history-memory.mp4
Output story-068-conversation-history-memory.gif

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
# "Recall any pane's conversation, and let old turns
#  compact into summaries."
# ============================================================
Sleep 3.16s

# ============================================================
# 0:03-0:09  Launch rysh and split a second pane
# "Start rysh and split a second pane so we have two agents
#  with separate conversations."
# ============================================================
Type "rysh"
Enter
Sleep 2.65s
Ctrl+p
Sleep 0.44s
Type "n"
Sleep 1.76s
Escape
Sleep 0.88s

# ============================================================
# 0:09-0:22  Ask one agent to pull another pane's history
# "From prompt mode, ask the agent to retrieve the other pane's
#  conversation. The session_history tool reads any pane's turns."
# ============================================================
Escape
Sleep 0.19s
Escape
Sleep 1.29s
Type "use session_history to summarize what the other pane has discussed"
Enter
Sleep 7.06s

# ============================================================
# 0:22-0:36  Inspect this pane's own history
# "Drop into rysh mode to print this pane's history directly --
#  shell and prompt turns are all kept."
# ============================================================
Escape
Sleep 0.59s
Escape
Sleep 0.58s
Escape
Sleep 3.91s
Type "##pane history prompt"
Enter
Sleep 7.81s

# ============================================================
# 0:36-0:45  Memory compaction
# "As conversations grow, memory compaction folds old turns into
#  compact MemoryEntry summaries -- context stays small and sharp."
# ============================================================
Sleep 9.49s
