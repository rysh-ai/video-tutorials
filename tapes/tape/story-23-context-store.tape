# Story 23: Context Store (40s)
# Hook: "Store project context once, recall it anytime. Your AI remembers."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-23-context-store.tape

# --- Output Settings ---
Output story-23-context-store.mp4
Output story-23-context-store.gif

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
# "Start rysh -- you land in shell mode."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Switch to prompt mode with double-Escape
# "Double-press Escape to enter prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:08-0:18  Store context
# "Tell the AI to store important project context.
#  It saves to a persistent context store."
# ============================================================
Type "store this context: the database is PostgreSQL on port 5433"
Enter
Sleep 5s

# ============================================================
# 0:18-0:23  Wait for confirmation
# "The AI confirms the context is stored."
# ============================================================
Sleep 3s

# ============================================================
# 0:23-0:33  Recall the context
# "Now recall it. The AI retrieves from the context store
#  and gives you the info back."
# ============================================================
Type "recall the database info"
Enter
Sleep 5s

# ============================================================
# 0:33-0:38  See the recalled context
# "There it is -- PostgreSQL on port 5433.
#  Stored once, available anytime."
# ============================================================
Sleep 2s

# ============================================================
# 0:38-0:43  Check project notes
# "You can also check all stored project notes at once."
# ============================================================
Type "check the project notes"
Enter
Sleep 3s

# ============================================================
# 0:43-0:48  Hold final frame
# "Context store -- your AI's persistent memory."
# ============================================================
Sleep 5s
