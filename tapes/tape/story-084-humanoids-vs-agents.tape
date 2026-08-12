# Story 84: Humanoids vs Agents (40s)
# Hook: "Same brain, same skill format -- agents face inward, humanoids face the world."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-084-humanoids-vs-agents.tape

# --- Output Settings ---
Output story-084-humanoids-vs-agents.mp4
Output story-084-humanoids-vs-agents.gif

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
# "Same brain, same skill format --
#  agents face inward, humanoids face the world."
# ============================================================
Sleep 3.22s

# ============================================================
# 0:03-0:09  Launch rysh and enter rysh mode
# "Launch rysh and drop into rysh mode.
#  Let's spawn one of each and compare them side by side."
# ============================================================
Type "rysh"
Enter
Sleep 3.2s
Escape
Sleep 0.32s
Escape
Sleep 0.32s
Escape
Sleep 0.32s
Escape
Sleep 1.6s

# ============================================================
# 0:09-0:17  Spawn an agent
# "An agent is an internal worker -- no terminal, no external reach.
#  Perfect for reviewing code or running tasks inside the workspace."
# ============================================================
Type "##agent spawn worker 'You are an internal task worker.'"
Enter
Sleep 4.38s

# ============================================================
# 0:17-0:25  Spawn a humanoid
# "A humanoid is the same agent plus external channels.
#  Same skill file format -- it just adds a contacts block."
# ============================================================
Type "##humanoid spawn support 'You are an external-facing support agent.'"
Enter
Sleep 3.4s

# ============================================================
# 0:25-0:34  Both respond to @ / @@
# "And the at-sign and double-at-sign prefixes work for both --
#  Rysh resolves the name across both registries automatically."
# ============================================================
Type "@@worker deactivate"
Enter
Sleep 3.29s
Type "@@support deactivate"
Enter
Sleep 3.28s

# ============================================================
# 0:34-0:40  Hold final frame
# "Agents are your internal team; humanoids are your public face.
#  One format, two reaches."
# ============================================================
Sleep 6.43s
