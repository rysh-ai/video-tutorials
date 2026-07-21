# Story AD-04 (TEAM side): Forge private-API tunneling — the subscriber's machine.
# Master plan: marketing/assets/videos/forge-private-api.md
# Demo prompt: DEMO-PROMPT-forge-video.md
#
# Run via: video-tutorials/tapes/render-ad04.sh AFTER the owner take (the owner
#          daemon must stay up: it executes the tunneled HTTP calls). The runner
#          un-subscribes off-camera first so the on-camera subscribe is fresh.
#
# All commands verified against build v0.1.25-90-g8b75c48 on 2026-07-15.

# --- Output Settings ---
Output story-ad04-forge-team.mp4

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 60
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:10  The teammate's side
# "Now the teammate's side. A different rysh session -- think
#  different machine. No spec file here, no credentials,
#  nothing running on port eighty-ninety-nine."
# ============================================================
Type "ls"
Enter
Sleep 2s
Type "rysh attach story-ad04-team"
Enter
Sleep 6s
# focus insurance (activePane race — ad10 master plan §5)
Ctrl+Space
Sleep 1s
Right
Sleep 1s
Escape
Sleep 1s

# ============================================================
# 0:10-0:28  Subscribe
# "List what the team shares... there's the billing API. One
#  subscribe -- and MY agent now has YOUR localhost API as a
#  set of tools."
# ============================================================
Type "##forge list-remote"
Enter
Sleep 6s
Type "##forge subscribe billing"
Enter
Sleep 6s

# ============================================================
# 0:28-1:25  The remote agent calls it (the money shot)
# "Ask the agent for this month's unpaid invoices. It picks
#  the billing tools, the call tunnels to the owner's machine,
#  executes there, and the answer comes back -- live data from
#  an API this machine could never reach directly."
# ============================================================
Escape
Sleep 500ms
Escape
Sleep 2s
Type "list this month's unpaid invoices and total them"
Enter
Sleep 55s

# ============================================================
# 1:25-2:05  Mutation? Denied. (the posture)
# "Now try to void one. The agent confirms -- then the owner's
#  policy answers: mutating operations are denied by default.
#  The owner decides which writes are ever allowed, and the
#  server enforces it. Paranoid defaults, on purpose."
# ============================================================
Type "void invoice INV-2026-0002"
Enter
Sleep 38s
Type "yes, proceed"
Enter
Sleep 35s

# ============================================================
# 2:05-2:12  Close (end card added in post)
# "Expose your internal API to agents -- not to the internet.
#  rysh, at rysh-dot-A-I -- onboarding design partners now."
# ============================================================
Ctrl+O
Sleep 1s
Type "d"
Sleep 3s
