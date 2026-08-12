# Story 78: Routing Agent Output (40s)
# Hook: "Send a headless agent's replies straight into a pane you can watch."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-078-routing-agent-output.tape

# --- Output Settings ---
Output story-078-routing-agent-output.mp4
Output story-078-routing-agent-output.gif

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
# "Send a headless agent's replies
#  straight into a pane you can watch."
# ============================================================
Sleep 3.28s

# ============================================================
# 0:03-0:08  Launch rysh and name the pane
# "Launch rysh and give this pane a name with ##pane name --
#  that's where we'll route the agent's output."
# ============================================================
Type "rysh"
Enter
Sleep 1.21s
Escape
Sleep 0.12s
Escape
Sleep 0.12s
Escape
Sleep 0.12s
Escape
Sleep 0.61s
Type "##pane name review-feed"
Enter
Sleep 0.81s

# ============================================================
# 0:08-0:16  Spawn an agent
# "Spawn an agent. Normally its output stays in the background --
#  it has no pane of its own."
# ============================================================
Type "##agent spawn code-reviewer 'You review code and report findings clearly.'"
Enter
Sleep 3.12s

# ============================================================
# 0:16-0:26  Register output to the pane
# "Register its output to a pane and every reply lands
#  in that pane's chat buffer -- a live feed of the agent's work."
# ============================================================
Type "##agent register-output code-reviewer review-feed"
Enter
Sleep 7.18s

# ============================================================
# 0:26-0:34  Unregister
# "When you're done watching, ##agent unregister-output stops the routing.
#  The agent keeps running -- you just stop tailing it here."
# ============================================================
Type "##agent unregister-output code-reviewer review-feed"
Enter
Sleep 4.84s

# ============================================================
# 0:34-0:40  Hold final frame
# "register-output turns any pane into a dashboard for your background agents."
# ============================================================
Sleep 6.56s
