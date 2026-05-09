# Story 27: Multi-Agent Orchestration (55s)
# Hook: "Spawn multiple agents and orchestrate them -- planner, builder, tester working together."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-27-multi-agent.tape

# --- Output Settings ---
Output story-27-multi-agent.mp4
Output story-27-multi-agent.gif

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
# "Start rysh -- we'll build a multi-agent pipeline."
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
# 0:06-0:10  Spawn the planner agent
# "First agent: a planner that creates implementation plans."
# ============================================================
Type "##agent spawn planner You are a project planner. Create implementation plans."
Enter
Sleep 1s

# ============================================================
# 0:10-0:14  Spawn the builder agent
# "Second agent: a builder that writes code."
# ============================================================
Type "##agent spawn builder You are a code builder. Implement plans by writing code."
Enter
Sleep 1s

# ============================================================
# 0:14-0:18  Spawn the tester agent
# "Third agent: a tester that validates the code."
# ============================================================
Type "##agent spawn tester You are a tester. Run tests and report results."
Enter
Sleep 1s

# ============================================================
# 0:18-0:22  List all agents
# "##agent list shows the full roster -- three agents ready."
# ============================================================
Type "##agent list"
Enter
Sleep 2s

# ============================================================
# 0:22-0:34  Send task to planner
# "Ask the planner to create a plan.
#  Each agent works independently with its own context."
# ============================================================
Type "@planner create a plan for adding a hello world function"
Enter
Sleep 8s

# ============================================================
# 0:34-0:38  Wait for planner response
# "The planner drafts a step-by-step implementation plan."
# ============================================================
Sleep 4s

# ============================================================
# 0:38-0:50  Send task to builder
# "Now hand off to the builder -- implement the plan."
# ============================================================
Type "@builder implement a simple hello world function in Go"
Enter
Sleep 8s

# ============================================================
# 0:50-0:55  Hold final frame
# "Multiple agents, each with a role -- orchestrate as you wish."
# ============================================================
Sleep 5s
