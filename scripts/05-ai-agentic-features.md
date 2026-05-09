# Group 5: AI Agentic Features (Stories 18-23)

Narration scripts for the AI agentic tool system. This is the core differentiator -- what makes Rysh more than a terminal multiplexer.

**Total duration:** ~4 min 35s

---

## Story 18: The 35+ Agentic Tools (60s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "35+ Agentic Tools" | "Your AI agent has 35 tools. Files, git, bash, web search, and more." |
| 0:04 | Prompt mode, type "list all available tools" | "Let's ask the AI what tools it has." |
| 0:08 | AI lists tools by category | "Here they are, organized by category." |
| 0:12 | Highlight: Core tools | "Core tools: bash, file_read, file_edit, file_write, glob, grep." |
| 0:17 | Highlight: Git tools | "Git tools: status, diff, log, commit." |
| 0:20 | Highlight: Code tools | "Code intelligence: tree for directory structure, symbol_search for declarations." |
| 0:24 | Highlight: Testing tools | "Testing: test_run with structured results, lint, build." |
| 0:28 | Highlight: Web tools | "Web: search the internet, fetch pages." |
| 0:31 | Highlight: Workspace tools | "Workspace: inspect other panes, send commands, todo lists, clipboard." |
| 0:35 | Type "read the first 20 lines of main.go" | "Let's see it in action. Read a file." |
| 0:38 | AI uses file_read tool | "The AI used the file_read tool." |
| 0:42 | Type "add a comment to line 5" | "Now edit it." |
| 0:45 | AI uses file_edit, shows diff | "The AI proposes an edit with file_edit. You see the diff." |
| 0:50 | Approve the edit | "Approve, and the change is made." |
| 0:54 | End card | "35+ tools. Deep access to your entire development environment." |

### Key Moments to Annotate
- [0:12] Tool category overlay: "Core"
- [0:17] Tool category overlay: "Git"
- [0:24] Tool category overlay: "Testing"
- [0:31] Tool category overlay: "Workspace"
- [0:38] Callout: "file_read tool"
- [0:45] Callout: "file_edit tool"

---

## Story 19: Tool Approval Workflow (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Tool Approval" | "The AI wants to edit your file. You get to approve or reject." |
| 0:04 | Prompt mode, type "fix the bug in main.go" | "Ask the AI to fix something." |
| 0:07 | AI reads file (auto-approved) | "It reads the file first -- read-only tools are auto-approved." |
| 0:11 | AI proposes file_edit | "Now it proposes an edit with file_edit." |
| 0:14 | Approval dialog appears in footer | "The approval dialog appears at the bottom." |
| 0:17 | Show colored diff | "You see a colored diff: green for additions, red for deletions." |
| 0:21 | Show options: `y/Y/n/N` | "y to approve this one. Capital Y to approve all future uses of this tool." |
| 0:26 | Press `y` | "Approve." |
| 0:28 | Edit is applied | "The change is applied." |
| 0:30 | New scenario: AI wants to run bash | "Now the AI wants to run a bash command." |
| 0:33 | Pre-approval dialog | "This is pre-approval -- you approve before it executes." |
| 0:36 | Show the command to be executed | "You see what it wants to run before it runs." |
| 0:39 | Press `n` to reject | "Press n to reject." |
| 0:41 | Press `N` to reject with reason | "Or capital N to reject with a reason." |
| 0:43 | Type reason, press Enter | "Tell the AI why. It adjusts its approach." |
| 0:46 | End card | "Preview-first for edits. Pre-approval for commands. You're always in control." |

### Key Moments to Annotate
- [0:14] Callout arrow to footer approval dialog
- [0:17] Highlight diff colors
- [0:21] Key options: `y` `Y` `n` `N`
- [0:33] Overlay: "Pre-approval strategy"

---

## Story 20: Background Bash Sessions (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Background Bash" | "Start a long-running process. Check its output anytime." |
| 0:04 | Prompt mode, type "run the integration tests in the background" | "Ask the AI to run tests in the background." |
| 0:08 | AI uses bash_background tool | "It uses the bash_background tool." |
| 0:11 | Returns session ID: "bg-abc123" | "A background session is created with an ID." |
| 0:14 | Explain: "256KB ring buffer captures output" | "Output is captured in a 256KB ring buffer -- nothing is lost." |
| 0:18 | Type "check the background session" | "Check on it anytime." |
| 0:21 | AI uses bash_output | "The AI uses bash_output to read the buffer." |
| 0:24 | Shows test output so far | "Here's the output so far." |
| 0:28 | Type "kill the background session" | "When you're done, kill it." |
| 0:31 | AI uses kill_shell | "kill_shell terminates the process and returns the final output." |
| 0:35 | Final output shown | |
| 0:38 | End card | "Background sessions for long-running processes. Check or kill anytime." |

### Key Moments to Annotate
- [0:08] Tool badge: "bash_background"
- [0:21] Tool badge: "bash_output"
- [0:31] Tool badge: "kill_shell"
- [0:14] Callout: "256KB ring buffer"

---

## Story 21: Cross-Pane Coordination (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Cross-Pane Coordination" | "Your AI agents can talk to each other. Across panes." |
| 0:04 | Two panes side by side | "Two panes. Name the left one 'builder', the right one 'tester'." |
| 0:08 | Name panes: `##pane name builder`, `##pane name tester` | |
| 0:12 | In builder pane, prompt mode | "In the builder pane, let's inspect the tester." |
| 0:15 | Type "inspect the tester pane's output" | |
| 0:18 | AI uses pane_inspect tool | "The AI uses pane_inspect to read the other pane's state." |
| 0:22 | Shows tester's output | "It sees the tester's output, mode, and status." |
| 0:25 | Type "send 'go test ./...' to the tester pane" | "Now let's send a command to the tester." |
| 0:28 | AI uses pane_send tool | "pane_send injects a command into the other pane." |
| 0:31 | Tester pane runs tests | "Watch the tester pane run the tests." |
| 0:35 | Type "list all agents" | "agents_list shows all panes and their status." |
| 0:38 | AI uses agents_list | |
| 0:42 | End card | "AI agents can inspect, send, and coordinate across panes." |

### Key Moments to Annotate
- [0:18] Tool badge: "pane_inspect"
- [0:28] Tool badge: "pane_send"
- [0:31] Callout arrow from builder to tester pane
- [0:38] Tool badge: "agents_list"

---

## Story 22: Loop Detection (30s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Loop Detection" | "What if the AI gets stuck in a loop? Rysh stops it." |
| 0:03 | Diagram: sliding window of 20 entries | "The orchestrator tracks the last 20 tool calls as name-plus-params hashes." |
| 0:08 | Show 3 identical calls highlighted | "If the same exact call appears 3 times..." |
| 0:12 | Red X appears | "...execution is blocked." |
| 0:14 | Warning message in output | "The AI sees a warning: 'Loop detected. Try a different approach.'" |
| 0:18 | AI adjusts strategy | "The AI adjusts -- tries a different tool or different parameters." |
| 0:22 | Diagram: sliding window resets | "The window slides forward. No permanent penalty." |
| 0:26 | End card | "Automatic loop detection. Three identical calls and you're blocked." |

### Key Moments to Annotate
- [0:03] Diagram overlay: sliding window
- [0:12] Callout: "Blocked after 3 identical calls"

---

## Story 23: Context Store and Project Notes (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Context Store & Notes" | "Give your AI a memory. Persist across conversations." |
| 0:04 | Prompt mode | "Let's store some context." |
| 0:06 | Type "store this: the database is PostgreSQL on port 5433" | |
| 0:09 | AI uses context_store | "context_store saves it to JetStream KV." |
| 0:12 | "Now imagine it's a new session..." | |
| 0:14 | Type "recall the database info" | "Recall it anytime." |
| 0:17 | AI uses context_recall | "context_recall retrieves it." |
| 0:20 | Shows the stored info | "There it is. Persisted across sessions." |
| 0:23 | Type "check the project notes" | "project_notes reads a shared .rysh-notes.md file." |
| 0:27 | AI reads .rysh-notes.md | "Great for team-wide context that everyone's AI can access." |
| 0:30 | Type "what's on my todo list?" | "And there's a per-pane todo list backed by JetStream KV." |
| 0:34 | AI uses todo tool | |
| 0:36 | End card | "Context store, project notes, and todo lists. Persistent AI memory." |

### Key Moments to Annotate
- [0:09] Tool badge: "context_store"
- [0:17] Tool badge: "context_recall"
- [0:23] Tool badge: "project_notes"
- [0:30] Tool badge: "todo"
