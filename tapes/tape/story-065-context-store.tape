# Story 65: Context Store (45s)
# Hook: "Give your agent a memory that survives across the whole session."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-065-context-store.tape

# --- Output Settings ---
Output story-065-context-store.mp4
Output story-065-context-store.gif

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
# "Give your agent a memory that survives
#  across the whole session."
# ============================================================
Sleep 3.13s

# ============================================================
# 0:03-0:08  Launch rysh into prompt mode
# "Start rysh and switch to prompt mode."
# ============================================================
Type "rysh"
Enter
Sleep 2.66s
Escape
Sleep 0.27s
Escape
Sleep 1.77s

# ============================================================
# 0:08-0:22  Store a key-value fact
# "Tell the agent to remember something. The context_store tool
#  writes a key and value into JetStream KV for this session."
# ============================================================
Type "remember that our staging database is db-staging.internal on port 5432"
Enter
Sleep 9.29s

# ============================================================
# 0:22-0:38  Recall it later
# "Later -- in any turn -- ask it back. The agent recalls the
#  value straight from the store, no re-explaining needed."
# ============================================================
Type "what was our staging database host and port?"
Enter
Sleep 13.33s

# ============================================================
# 0:38-0:45  Recap
# "context_store is durable key-value memory that any prompt
#  in the session can read and write."
# ============================================================
Sleep 7.31s
