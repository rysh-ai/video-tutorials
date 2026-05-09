# Group 6: Autonomous Agents (Stories 24-28)

Narration scripts for autonomous agents. These show Rysh's headless AI workers.

**Total duration:** ~3 min 40s

---

## Story 24: Spawning an Autonomous Agent (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Autonomous Agents" | "A headless AI agent. No terminal. Just a brain with tools." |
| 0:04 | Shell/rysh mode | "Let's create an agent." |
| 0:06 | Type `##agent spawn code-reviewer You are a code reviewer...` | "Spawn it with a name and a system prompt." |
| 0:10 | Output: "Agent code-reviewer created" | "Done. No pane, no PTY -- just an AgenticActor running in the background." |
| 0:14 | Switch to chat mode (`@` prompt) or type with @ prefix | "To talk to it, use the at-sign prefix." |
| 0:17 | Type `@code-reviewer review the changes in the last commit` | |
| 0:21 | Agent runs, uses git_diff, git_log | "The agent runs. It has full tool access -- git diff, file read, everything." |
| 0:27 | Review appears in chat output | "The review appears in your pane's chat buffer." |
| 0:31 | Type `##agent list` | "List all agents." |
| 0:34 | Output shows agent name, status: active | "code-reviewer, active." |
| 0:37 | Type `@@code-reviewer deactivate` | "Deactivate with @@." |
| 0:40 | Type `@@code-reviewer activate` | "Activate again." |
| 0:43 | End card | "Autonomous agents are headless AI workers you prompt with @name." |

### Key Moments to Annotate
- [0:06] Highlight `##agent spawn`
- [0:17] Highlight `@code-reviewer` prefix
- [0:37] Highlight `@@` control prefix

---

## Story 25: Skill Files for Agents (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Agent Skill Files" | "Define an agent in a Markdown file. Name, model, system prompt." |
| 0:04 | Show a .md file in editor | "A skill file is just Markdown with YAML frontmatter." |
| 0:07 | Highlight frontmatter: name, description, model | "Name, description, and optional model." |
| 0:12 | Highlight body: system prompt | "Everything below the frontmatter is the system prompt." |
| 0:16 | Back to terminal | "Spawn it from the file." |
| 0:18 | Type `##agent spawn code-reviewer.md` | |
| 0:21 | Agent created | "Created from file." |
| 0:24 | Show a directory of .md files | "Got a whole team? Put them in a directory." |
| 0:27 | Type `##agent spawn-all .rysh/agents/` | "spawn-all creates agents from every .md file." |
| 0:31 | Multiple agents created | "Three agents spawned at once." |
| 0:34 | Show file without frontmatter | "No frontmatter? The name comes from the filename." |
| 0:37 | Show: `reviewer.md` -> agent named "reviewer" | "reviewer.md becomes agent reviewer." |
| 0:40 | End card | "Skill files: version-controlled, shareable agent definitions." |

### Key Moments to Annotate
- [0:04] Code block: YAML frontmatter
- [0:18] Highlight: `##agent spawn <file>`
- [0:27] Highlight: `##agent spawn-all <dir>`

---

## Story 26: Agent Output Routing (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Agent Output Routing" | "Route agent output to any pane's chat buffer." |
| 0:04 | Spawn an agent | "Spawn an agent called monitor." |
| 0:07 | Type `##agent register-output monitor my-pane` | "Register its output to a pane." |
| 0:11 | Callout arrow from agent to pane | "Now the agent's output flows to that pane's chat buffer." |
| 0:15 | Type `@monitor check the last build` | "Send the agent a prompt." |
| 0:19 | Agent response appears in pane | "The response appears right in your pane." |
| 0:23 | Double-Escape to chat mode | "Switch to chat mode to see the chat buffer." |
| 0:26 | Chat output visible | "There's the agent's output alongside any other chat messages." |
| 0:30 | Type `##agent unregister-output monitor my-pane` | "Unregister when done." |
| 0:34 | End card | "Route agent output to any pane. Work with agents right where you are." |

### Key Moments to Annotate
- [0:07] Highlight: `##agent register-output`
- [0:11] Diagram: Agent -> Pane chat buffer
- [0:30] Highlight: `##agent unregister-output`

---

## Story 27: Multi-Agent Orchestration (55s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Multi-Agent Orchestration" | "Planner, builder, tester -- three agents, one workflow." |
| 0:04 | Show directory with 3 .md files | "Three skill files: planner.md, builder.md, tester.md." |
| 0:08 | Type `##agent spawn-all .rysh/agents/` | "Spawn them all at once." |
| 0:11 | Output: 3 agents created | "Three agents, three roles." |
| 0:14 | Type `@planner create a plan for adding user auth` | "Start with the planner." |
| 0:18 | Planner responds with a structured plan | "The planner creates a step-by-step implementation plan." |
| 0:24 | Type `@builder implement the auth plan` | "Send the plan to the builder." |
| 0:27 | Builder starts coding, uses file_write, file_edit | "The builder writes code using tools." |
| 0:33 | Type `@tester run tests and report` | "Finally, the tester." |
| 0:36 | Tester runs test_run, reports results | "Tests run, results reported." |
| 0:40 | Show all three outputs in chat | "Each agent works independently with its own context and tools." |
| 0:45 | Type `##agent list` | "All three visible in the agent list." |
| 0:49 | End card | "Multi-agent orchestration. Each agent has its own role, tools, and context." |

### Key Moments to Annotate
- [0:14] `@planner` highlighted
- [0:24] `@builder` highlighted
- [0:33] `@tester` highlighted
- [0:40] Diagram: three agents working in parallel

---

## Story 28: Agent Control Commands @@ (30s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Agent Control (@@)" | "Stop, pause, or resume any agent with @@." |
| 0:03 | Type `@@code-reviewer stop` | "Stop deletes the agent entirely." |
| 0:06 | Output: "Agent stopped" | |
| 0:08 | Type `@@builder deactivate` | "Deactivate pauses -- keeps state, ignores prompts." |
| 0:12 | Type `@@builder activate` | "Activate resumes." |
| 0:15 | Type `##agent list` | "List shows the status of every agent." |
| 0:18 | Output: agents with active/inactive status | |
| 0:21 | Type `##agent delete builder` | "Or delete from the ## command." |
| 0:24 | End card | "@ for prompts, @@ for control. Simple lifecycle management." |

### Key Moments to Annotate
- [0:03] Highlight: `@@` prefix
- [0:08] Status overlay: "deactivated"
- [0:12] Status overlay: "active"
