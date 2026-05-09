# Story 28: Agent Control @@ (30s)
# Hook: "Full lifecycle control with @@ -- activate, deactivate, and stop agents."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-28-agent-control.tape

# --- Output Settings ---
Output story-28-agent-control.mp4
Output story-28-agent-control.gif

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
# "Start rysh -- we'll explore agent lifecycle control."
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
# 0:06-0:10  Spawn a helper agent
# "Spawn a simple helper agent."
# ============================================================
Type "##agent spawn helper You are a helpful assistant."
Enter
Sleep 1s

# ============================================================
# 0:10-0:13  List agents -- active
# "List agents -- helper is active and running."
# ============================================================
Type "##agent list"
Enter
Sleep 1s

# ============================================================
# 0:13-0:16  Deactivate the agent
# "@@helper deactivate pauses the agent -- it stays in memory
#  but won't process new prompts."
# ============================================================
Type "@@helper deactivate"
Enter
Sleep 1s

# ============================================================
# 0:16-0:19  List agents -- deactivated
# "List again -- status shows deactivated."
# ============================================================
Type "##agent list"
Enter
Sleep 1s

# ============================================================
# 0:19-0:22  Reactivate the agent
# "@@helper activate brings it back online."
# ============================================================
Type "@@helper activate"
Enter
Sleep 1s

# ============================================================
# 0:22-0:25  Stop the agent permanently
# "@@helper stop terminates the agent entirely."
# ============================================================
Type "@@helper stop"
Enter
Sleep 1s

# ============================================================
# 0:25-0:28  List agents -- gone
# "List agents -- helper is gone. Stopped agents are removed."
# ============================================================
Type "##agent list"
Enter
Sleep 1s

# ============================================================
# 0:28-0:30  Hold final frame
# "@@: deactivate, activate, stop -- full lifecycle control."
# ============================================================
Sleep 2s
