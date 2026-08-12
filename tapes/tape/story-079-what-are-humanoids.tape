# Story 79: What Are Humanoids? (50s)
# Hook: "An agent that talks to the outside world -- WhatsApp, Slack, email, phone, chat."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-079-what-are-humanoids.tape

# --- Output Settings ---
Output story-079-what-are-humanoids.mp4
Output story-079-what-are-humanoids.gif

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
# "An agent that talks to the outside world --
#  WhatsApp, Slack, email, phone, chat."
# ============================================================
Sleep 3.25s

# ============================================================
# 0:03-0:09  Launch rysh
# "Launch rysh. A humanoid is an autonomous agent
#  plus bidirectional external communication channels."
# ============================================================
Type "rysh"
Enter
Sleep 6.13s

# ============================================================
# 0:09-0:16  Enter rysh mode
# "An inbound message becomes a prompt; the AI reply goes back out
#  through the same channel. Double-Escape into rysh mode to spawn one."
# ============================================================
Escape
Sleep 0.91s
Escape
Sleep 0.91s
Escape
Sleep 0.91s
Escape
Sleep 4.56s

# ============================================================
# 0:16-0:26  Spawn a humanoid
# "Spawn it just like an agent: a name and a system prompt.
#  Use ##humanoid spawn instead of ##agent spawn."
# ============================================================
Type "##humanoid spawn support 'You are a friendly customer support agent. Answer questions clearly.'"
Enter
Sleep 3.65s

# ============================================================
# 0:26-0:36  List humanoids
# "##humanoid list shows every humanoid, its status,
#  and which channels it has connected."
# ============================================================
Type "##humanoid list"
Enter
Sleep 9.65s

# ============================================================
# 0:36-0:47  Prompt it directly
# "You can still talk to it directly with the at-sign prefix,
#  exactly like any agent -- channels just add external reach on top."
# ============================================================
Type "@support how would you greet a new customer?"
Enter
Sleep 8.56s

# ============================================================
# 0:47-0:50  Hold final frame
# "Humanoids: your AI, reachable wherever your users already are."
# ============================================================
Sleep 3.25s
