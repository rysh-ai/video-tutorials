# Story AD-07: An Agent on Slack, With a Human in the Loop (~90s raw; trim in edit) — HERO CUT
# Hook: "Agents on your channels. Humans in the loop."
# Master plan: marketing/assets/videos/humanoids-governance.md
# Demo prompt: DEMO-PROMPT-slack-humanoid-video.md
# Gates + E2E record: video-tutorials/demos/slack-humanoid/FOUNDER-GATES.md
#
# Run via: video-tutorials/tapes/render-ad07.sh (session hygiene, daemon
#          pre-create from render-sandbox-ad07 with SLACK_* env, vhs launch).
#          LIVE take: operator posts the teammate questions at the
#          [SLACK-DRIVER] offsets; Slack window region-captured in parallel
#          (capture-slack-ad07.sh — never the full desktop).
#
# Dry-run QC (2026-07-15, take 2-3):
# - Fresh-session TUI bootstrap race ate ALL typed input in take 1 — fixed by
#   the tabReady patch (ported from rysh-cli uncommitted fix). If input dies
#   again: check the daemon was created by the SAME patched binary.
# - ## commands only execute from shell mode (in prompt mode they go to the
#   LLM!). All ## lines below are typed in shell mode.
# - The TUI's DYNAMIC per-humanoid mode is display/input-broken (falls back
#   to the merged buffer; typed input is dropped) — use the fixed EXTERNAL
#   mode instead: the humanoid mirrors its stream to the external buffer
#   (streamToPane) and external-mode input routes to the registered humanoid
#   through the enriched governed path. Pin the cycle by deleting
#   prompt/chat/rysh and enabling external → shell → external → support-bot.
#   ONE esc-pair into external; TWO pairs back to shell (skip the broken
#   dynamic mode — never stop on it on camera).
# - Be in external mode BEFORE the teammate question lands.
#
# ⚠️ Before ANY take: pause the desktop app's own slack-bot
#    (rysh --humanoid --session rysh channel stop slack-bot slack) — same
#    Slack app, ai mode; it answers over the scene. Restore after the take.

# --- Output Settings ---
Output story-ad07-slack-humanoid.mp4

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:12  Hook (title card overlays 0-3s; plumbing runs fast)
# "Everyone wants an AI agent answering on the company Slack.
#  Nobody wants to explain the day it answered wrong. Here's
#  how you get the first -- without risking the second."
# ============================================================
Type "rysh attach story-ad07"
Enter
Sleep 5s
Type@40ms "##pane name main"
Enter
Sleep 1.5s
Type@40ms "##mode delete prompt"
Enter
Sleep 1.2s
Type@40ms "##mode delete chat"
Enter
Sleep 1.2s
Type@40ms "##mode delete rysh"
Enter
Sleep 1.2s
Type@40ms "##mode new external"
Enter
Sleep 1.2s

# ============================================================
# 0:12-0:26  Spawn, connect, scope
# "A humanoid is an agent from a markdown file -- wired to a
#  real channel. Spawn it, start its Slack channel, and scope
#  it: it only replies when mentioned."
# ============================================================
Type "##humanoid spawn support-bot"
Enter
Sleep 2.5s
Type@40ms "##humanoid register-output support-bot main"
Enter
Sleep 1.5s
Type "##humanoid channel start support-bot slack"
Enter
Sleep 4.5s
Type "##humanoid reply-to support-bot mentions"
Enter
Sleep 2s

# ============================================================
# 0:26-0:54  Governance: human — THE MONEY SHOT
# "Governance: human. Now every reply is a draft. A teammate
#  asks -- and Slack stays silent. The agent does the work;
#  the draft waits in your terminal. A person approves the
#  words before they leave the building. Type send -- and only
#  then, it posts. Your team stays accountable for every
#  message, on day one."
# ============================================================
Type "##humanoid governance support-bot human"
Enter
Sleep 2.5s
# Enter the humanoid view (shell → external; one esc-pair). The external
# mode is the fixed humanoid surface: live-streamed, input routes to the
# registered humanoid through the enriched governed-prompt path.
Escape
Escape
Sleep 1s
# [SLACK-DRIVER] teammate posts right after governance flips (wall ~T0+60):
#   "@Rysh when does the staging release freeze start?"
# Inbound echo + auto-draft stream into this pane. Slack stays silent.
# Take-4 QC: Socket Mode delivery can lag 10s+ — the 30s buffer absorbs it
# (send fired before the inbound arrived at 15s; draft was never sendable).
Sleep 30s
Type "send"
Enter
Sleep 8s

# ============================================================
# 0:54-1:12  Governance: ai — the dial, not a leap
# "When it's earned trust -- flip the switch. Governance: A I.
#  Same agent, now autonomous on that channel. And every
#  exchange still lands in a pane you can read. Autonomy is a
#  dial, not a leap."
# ============================================================
# Back to shell mode for the ## command (external → support-bot → shell).
Escape
Escape
Sleep 400ms
Escape
Escape
Sleep 500ms
Type "##humanoid governance support-bot ai"
Enter
Sleep 2s
# Back into the humanoid view to watch the autonomous exchange.
Escape
Escape
Sleep 500ms
# [SLACK-DRIVER] teammate posts after the ai flip (wall ~T0+106):
#   "@Rysh how do I install nwcli?"
# Auto-reply posts to the thread; the exchange stays visible here.
Sleep 22s

# ============================================================
# 1:12-1:20  Close (end card added in post)
# "Slack today -- email and website chat too. Same engine as
#  your terminal agents, same skill files, same observability.
#  rysh, at rysh dot A I. We're onboarding design partners now."
# ============================================================
Sleep 5s
