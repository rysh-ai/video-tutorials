# Group 19: Autonomous Agents (Stories 73-78)

Narration scripts for autonomous agents -- Rysh's headless AI workers that run without a pane or terminal.

**Total duration:** ~4 min 30s

---

## Story 73: What Are Autonomous Agents? (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Autonomous Agents" | "Headless AI workers. No terminal, no pane -- just a brain with tools." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. Every pane is a shell plus an agent -- but autonomous agents live entirely in the background." |
| 0:08 | Double-Escape into rysh mode (`##` prompt) | "Double-press Escape to reach rysh mode, where the double-hash system commands live." |
| 0:14 | Type `##agent spawn code-reviewer "..."` | "Spawn an agent with a name and a system prompt. It has no PTY -- just its own AgenticActor running independently." |
| 0:24 | Type `##agent list`, status shown | "Check ##agent list to see every agent and its status. Spawned with ##agent spawn, prompted with @name, controlled with @@name." |
| 0:32 | Type `@code-reviewer summarize...` | "Talk to it with the at-sign prefix from any input mode. The agent runs the prompt with full tool access in the background." |
| 0:44 | AI response renders | "Autonomous agents: tireless workers you spawn, prompt, and command -- without ever opening a pane." |

### Key Moments to Annotate
- [0:08] Show prompt change to `##` (rysh mode)
- [0:14] Highlight `##agent spawn`
- [0:32] Show prefix badge: `@name` = prompt

---

## Story 74: Spawning an Agent (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Spawning an Agent" | "One command, one prompt, and your agent is alive." |
| 0:03 | Type `rysh`, double-Escape to rysh mode | "Launch rysh and double-press Escape into rysh mode to run the agent commands." |
| 0:08 | Type `##agent spawn code-reviewer "..."` | "Use ##agent spawn, then a name, then the system prompt in quotes. That prompt defines the agent's whole personality and job." |
| 0:18 | Type `##agent spawn test-writer "..."` | "Spawn as many as you need. Here's a second agent for writing tests." |
| 0:28 | Type `##agent list`, two agents shown | "Then ##agent list shows every agent with its status -- active, deactivated, or working a prompt right now." |
| 0:40 | Hold final frame | "Spawn, name, prompt, list. That's the whole lifecycle of an agent." |

### Key Moments to Annotate
- [0:08] Highlight `##agent spawn <name> <system-prompt>`
- [0:28] Highlight status column in `##agent list`

---

## Story 75: Skill Files (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Skill Files" | "Define an agent once in a file -- name, model, and system prompt -- then spawn it anywhere." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. A skill file is just a markdown file with YAML frontmatter." |
| 0:08 | Create `.rysh/agents/reviewer/SKILL.md` | "The frontmatter sets name, description, and model; everything after it becomes the agent's system prompt." |
| 0:16 | Type `cat .rysh/agents/reviewer/SKILL.md` | "The YAML block sits between the dashes, then the prompt body. With no frontmatter, the whole file is the prompt and the name comes from the filename." |
| 0:26 | Double-Escape, `##agent spawn .../SKILL.md` | "Spawn straight from the file -- point ##agent spawn at the SKILL.md path." |
| 0:36 | Type `##agent list`, agent appears | "##agent list confirms the agent, built entirely from the file -- reusable, version-controlled, shareable across your team." |
| 0:47 | Hold final frame | "Skill files turn agents into code you can commit and reuse." |

### Key Moments to Annotate
- [0:08] Highlight YAML frontmatter fields: `name`, `description`, `model`
- [0:16] Callout: body after `---` = system prompt
- [0:26] Highlight `##agent spawn <file.md>`

---

## Story 76: Spawning From a Directory (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Spawning From a Directory" | "A folder of skill files becomes a whole team of agents in one command." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. Suppose you have a directory of agent skill files." |
| 0:08 | Create `reviewer.md` and `tester.md` in `.rysh/agents` | "Each markdown file in the directory describes one agent." |
| 0:18 | Double-Escape, `##agent spawn-all .rysh/agents` | "Run ##agent spawn-all on the directory. Rysh creates one agent per markdown file -- instantly." |
| 0:28 | Type `##agent list`, both agents shown | "##agent list shows the full roster -- a complete team bootstrapped from one folder." |
| 0:37 | Hold final frame | "spawn-all: version your whole agent team in one directory." |

### Key Moments to Annotate
- [0:18] Highlight `##agent spawn-all <directory>`
- [0:28] Highlight one agent created per `.md` file

---

## Story 77: Talking To & Controlling Agents (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Talking To & Controlling Agents" | "At-name to prompt it, double-at-name to command it." |
| 0:03 | Type `rysh`, double-Escape, spawn reviewer | "Launch rysh, drop into rysh mode, and spawn a reviewer to work with." |
| 0:10 | Type `@code-reviewer what are the top three...` | "A single at-sign plus the name sends a prompt. The agent runs it with its full toolbelt and reports back." |
| 0:22 | Type `@@code-reviewer deactivate` | "Two at-signs send a control command instead. Deactivate pauses the agent -- it keeps its state but ignores prompts." |
| 0:31 | Type `@@code-reviewer activate` | "Activate brings it right back to life." |
| 0:38 | Type `##agent delete code-reviewer` | "And ##agent delete removes it entirely when you're done. Prompt, pause, resume, delete -- you're always in control." |

### Key Moments to Annotate
- [0:10] Show prefix badge: `@name` = prompt
- [0:22] Show prefix badge: `@@name` = control (`stop` / `activate` / `deactivate`)
- [0:38] Highlight `##agent delete <name>`

---

## Story 78: Routing Agent Output (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Routing Agent Output" | "Send a headless agent's replies straight into a pane you can watch." |
| 0:03 | Type `rysh`, double-Escape, `##pane name review-feed` | "Launch rysh and give this pane a name with ##pane name -- that's where we'll route the output." |
| 0:08 | Type `##agent spawn code-reviewer "..."` | "Spawn an agent. Normally its output stays in the background -- it has no pane of its own." |
| 0:16 | Type `##agent register-output code-reviewer review-feed` | "Register its output to a pane and every reply lands in that pane's chat buffer -- a live feed of the agent's work." |
| 0:26 | Type `##agent unregister-output code-reviewer review-feed` | "When you're done watching, ##agent unregister-output stops the routing. The agent keeps running -- you just stop tailing it here." |
| 0:34 | Hold final frame | "register-output turns any pane into a dashboard for your background agents." |

### Key Moments to Annotate
- [0:03] Highlight `##pane name <name>`
- [0:16] Highlight `##agent register-output <agent> <pane>` -> chat buffer
- [0:26] Highlight `##agent unregister-output`
