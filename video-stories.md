# Rysh Video Stories

50 short video stories explaining every major feature of the Rysh project, organized by category.

Each story includes:
- **Title** -- the video headline
- **Duration** -- suggested length
- **Hook** -- the opening line to grab attention
- **What to show** -- a step-by-step walkthrough
- **Key takeaway** -- the one thing viewers should remember

---

## Group 1: Getting Started (Stories 1-4)

### Story 1: What Is Rysh?
**Duration:** 60s  
**Hook:** "What if every terminal pane was an autonomous AI agent?"  
**What to show:**
1. Open a terminal -- type `rysh`.
2. Show the TUI launching with tabs and panes.
3. Type a shell command in one pane (`ls -la`), then double-press Escape to switch to prompt mode.
4. Type an AI prompt ("explain this directory structure") and show the LLM response rendering in the same pane.
5. Quick montage: split panes, create tabs, run vim inside a pane.

**Key takeaway:** Rysh is a terminal multiplexer where every pane is both a shell and an AI agent workspace.

---

### Story 2: Installing Rysh
**Duration:** 45s  
**Hook:** "One command to install. Every platform."  
**What to show:**
1. macOS: `brew tap rysh-works/rysh && brew install rysh`
2. Ubuntu/Debian: `sudo apt install rysh` (after adding the repo)
3. Fedora/RHEL: `sudo dnf install rysh`
4. Windows (WSL2): `winget install RyshWorks.Rysh`
5. From source: `git clone ... && make build && make install`
6. Run `rysh --version` to verify.

**Key takeaway:** Rysh installs via Homebrew, apt, dnf, WinGet, Chocolatey, or from source -- it runs anywhere Go runs.

---

### Story 3: Your First Session
**Duration:** 50s  
**Hook:** "Start a session, name it, come back to it later."  
**What to show:**
1. `rysh my-project` -- start a named session.
2. Run a few commands, create some panes.
3. Press `Ctrl+O d` to detach.
4. `rysh list-sessions` -- see it listed as "detached".
5. `rysh attach my-project` -- reattach, everything is right where you left it.
6. Show session state is persisted via JetStream KV.

**Key takeaway:** Sessions are persistent. Detach and reattach without losing state -- like tmux, but with AI built in.

---

### Story 4: Configuring Rysh
**Duration:** 45s  
**Hook:** "One config file. Every setting has an environment variable override."  
**What to show:**
1. Open `~/.config/rysh/rysh.config` (TOML file).
2. Show the `[provider]` section -- set `api_key` for direct Anthropic API access.
3. Show the `[ui]` section -- `initial_tabs`, `initial_panes`, `shell`.
4. Show the `[upstream]` section -- enable remote sharing.
5. Demonstrate overriding with env vars: `RYSH_API_KEY=sk-ant-... rysh`.

**Key takeaway:** Everything is configurable via TOML file or environment variables -- API keys, shell, layout, upstream server.

---

## Group 2: Terminal Multiplexer Basics (Stories 5-10)

### Story 5: Tabs and Panes
**Duration:** 50s  
**Hook:** "Tabs hold panes. Panes hold agents. It's that simple."  
**What to show:**
1. Start rysh -- one tab, one pane by default.
2. `Ctrl+T` enters tab mode -- press `n` to create a new tab.
3. Use `[` and `]` to switch between tabs.
4. `Ctrl+P` enters pane mode -- press `n` to split right (new pane in a new column).
5. `Tab` key cycles between panes.
6. Show `Alt+Left/Right` to switch tabs, `Alt+Up/Down` to switch panes.

**Key takeaway:** Tabs organize your workspace. Each pane is an independent terminal with its own shell and AI agent.

---

### Story 6: Splitting Panes -- Columns and Rows
**Duration:** 45s  
**Hook:** "Horizontal, vertical, or stacked -- panes go wherever you need them."  
**What to show:**
1. `Ctrl+P n` -- split right (new column).
2. `Ctrl+P v` -- split down (new row in the same column).
3. Show how flex weights distribute space.
4. Create a 3-column layout with one column split vertically.
5. Brief view of `##panegroup layout` showing the tree structure.

**Key takeaway:** `Ctrl+P n` splits horizontally, `Ctrl+P v` splits vertically. Flex weights control the proportions.

---

### Story 7: Stacked Panes
**Duration:** 45s  
**Hook:** "Stack panes like a deck of cards. Only the top one is visible."  
**What to show:**
1. `Ctrl+P s` to create a stacked pane on top of the active group.
2. The border title shows `[1/2]` indicating stack depth.
3. Background panes appear as grey title bars at the bottom.
4. `Ctrl+S` enters stack mode -- press `j` to rotate next, `k` to rotate previous.
5. Show rotating through 3 stacked panes.

**Key takeaway:** Stacked panes let you layer multiple agents in the same visual space -- like browser tabs within a pane.

---

### Story 8: Navigating Panes with Navigate Mode
**Duration:** 40s  
**Hook:** "Arrow-key pane traversal. No memorizing pane numbers."  
**What to show:**
1. Create a 2x2 grid of panes (two columns, each split down).
2. Press `Ctrl+Space` to enter navigate mode.
3. Use `h/j/k/l` or arrow keys to move focus between panes directionally.
4. The active pane border highlights as you move.
5. Press `Esc` or `.` to exit navigate mode.

**Key takeaway:** Navigate mode gives you spatial, directional pane focus -- like moving a cursor across your workspace.

---

### Story 9: Layout Mode -- Resize, Equalize, Swap
**Duration:** 50s  
**Hook:** "Resize panes by pressing arrow keys. Equalize with one keystroke."  
**What to show:**
1. Create a 3-pane layout with uneven widths.
2. Press `Ctrl+L` to enter layout mode.
3. Use `Right/Left` to grow/shrink the active pane's width.
4. Use `Up/Down` to grow/shrink height.
5. Press `h` or `=` to equalize all pane widths.
6. Press `v` to equalize heights.
7. Press `s` to swap two pane positions.
8. Press `m` to toggle fullscreen on the active pane.

**Key takeaway:** Layout mode gives you full control over pane geometry -- resize, equalize, swap, and fullscreen with single keystrokes.

---

### Story 10: Mouse Support
**Duration:** 30s  
**Hook:** "Click to focus. Drag to select. Release to copy."  
**What to show:**
1. Click on different panes to focus them.
2. Click-drag to select text in a pane.
3. Release the mouse -- text is copied to clipboard.
4. Scroll wheel to scroll pane output (3 lines per step).

**Key takeaway:** Full mouse support -- click to focus, drag to select and copy, scroll wheel for output.

---

## Group 3: Input Modes (Stories 11-14)

### Story 11: Four Input Modes -- Shell, Prompt, Rysh, Chat
**Duration:** 50s  
**Hook:** "One pane, four modes. Double-Escape to cycle."  
**What to show:**
1. Show the `>` prompt (shell mode) -- type `ls -la`, output appears.
2. Double-press Escape -- prompt changes to `<` (prompt mode). Type a question for the AI.
3. Double-press Escape again -- prompt changes to `##` (rysh mode). Type `##help`.
4. Double-press Escape again -- prompt changes to `@` (chat mode). Send a chat message.
5. Double-press Escape one more time -- back to `>` (shell mode).

**Key takeaway:** Every pane cycles through shell, prompt, rysh, and chat modes. Each mode has its own output buffer.

---

### Story 12: Shell Mode -- Your Regular Terminal
**Duration:** 35s  
**Hook:** "It's just a regular terminal. PTY-backed, full color."  
**What to show:**
1. Run standard commands: `git status`, `docker ps`, `npm run build`.
2. Show ANSI colors rendering properly.
3. Run a long-running command and watch output stream.
4. Press `Ctrl+C` to cancel.
5. Show command history with up/down arrows.

**Key takeaway:** Shell mode is a full PTY terminal -- everything you'd run in bash works here, with full color support.

---

### Story 13: Prompt Mode -- Talk to Your AI Agent
**Duration:** 50s  
**Hook:** "Switch to prompt mode. Ask the AI anything about your codebase."  
**What to show:**
1. Double-press Escape to enter prompt mode (`<` prompt).
2. Type: "explain the architecture of this project".
3. Show the AI response rendering as formatted markdown.
4. The AI has access to 35+ tools -- it can read files, search code, run tests.
5. Type: "find all TODO comments in the codebase".
6. Show the AI using `grep` tool to search, then presenting results.

**Key takeaway:** In prompt mode, your pane becomes an AI coding assistant with full tool access -- file editing, bash, git, and more.

---

### Story 14: System Commands (## Mode)
**Duration:** 45s  
**Hook:** "Everything starting with ## is a built-in command."  
**What to show:**
1. Type `##help` -- show the full command list.
2. `##pane list` -- list all panes in the active tab.
3. `##tab list` -- list all tabs.
4. `##pane name my-builder` -- give a name to the pane.
5. `##snap` -- copy the pane's output to clipboard.
6. `##history` -- show command history for the current mode.

**Key takeaway:** System commands starting with `##` let you manage tabs, panes, names, clipboard, and more without leaving the terminal.

---

## Group 4: Interactive Terminal (Stories 15-17)

### Story 15: Running Vim Inside Rysh
**Duration:** 50s  
**Hook:** "Type vim. It just works. No configuration needed."  
**What to show:**
1. Type `vim main.go` in shell mode.
2. Vim opens -- the pane automatically enters raw mode.
3. Navigate, edit, write -- all vim commands work.
4. Show the `RAW` indicator in the pane border.
5. Save and quit (`:wq`) -- pane automatically exits raw mode.
6. Explain: vt10x virtual terminal emulator handles all ANSI sequences.

**Key takeaway:** Interactive programs like vim, htop, less, and nano work seamlessly via auto-detected raw mode and a virtual terminal emulator.

---

### Story 16: Raw Mode and the Escape Hatch
**Duration:** 40s  
**Hook:** "Every keystroke goes to the PTY. Except one: Ctrl+O."  
**What to show:**
1. Run `htop` -- pane enters raw mode automatically.
2. All keys are forwarded directly to htop.
3. Press `Ctrl+O` -- the escape hatch. Enters prefix mode.
4. From prefix mode, press `d` to detach, or any other key to cancel and return to raw mode.
5. Demonstrate switching panes while an interactive program runs in the background.
6. Show `##raw` for manual raw mode toggling.

**Key takeaway:** `Ctrl+O` is the universal escape hatch from raw mode -- it lets you switch panes, tabs, or detach while interactive programs run.

---

### Story 17: PTY Resize and Terminal Dimensions
**Duration:** 30s  
**Hook:** "Resize a pane. The PTY resizes too. Automatically."  
**What to show:**
1. Run `htop` in a pane.
2. Resize the pane (layout mode `Ctrl+L`, then arrows).
3. Show htop redrawing to fit the new dimensions.
4. Resize the terminal window -- all panes and their PTYs adapt.
5. Show `TERM=xterm-256color` is set for full capability reporting.

**Key takeaway:** PTY resize is fully propagated -- resize panes or your terminal window and interactive programs adapt instantly.

---

## Group 5: AI Agentic Features (Stories 18-23)

### Story 18: The 35+ Agentic Tools
**Duration:** 60s  
**Hook:** "Your AI agent has 35 tools. Files, git, bash, web search, and more."  
**What to show:**
1. In prompt mode, ask: "list all available tools".
2. Walk through categories:
   - Core: `bash`, `file_read`, `file_edit`, `file_write`, `glob`, `grep`
   - Git: `git_status`, `git_diff`, `git_log`, `git_commit`
   - Code: `tree`, `symbol_search`
   - Testing: `test_run`, `lint`, `build`
   - Web: `web_search`, `web_fetch`
   - Workspace: `pane_inspect`, `pane_send`, `todo`, `clipboard`
3. Show the AI using `file_read` and `file_edit` to make a code change.

**Key takeaway:** The AI agent has deep access to your development environment -- files, git, testing, web, and cross-pane coordination.

---

### Story 19: Tool Approval Workflow
**Duration:** 50s  
**Hook:** "The AI wants to edit your file. You get to approve or reject."  
**What to show:**
1. Ask the AI: "fix the bug in main.go".
2. The AI reads the file, proposes a change using `file_edit`.
3. The approval dialog appears in the footer with a colored diff.
4. Press `y` to approve, `Y` to approve always, `n` to reject.
5. Press `N` to reject with a reason -- type why and press Enter.
6. Show preview-first strategy (edit → diff → approve) vs pre-approval (approve → execute).

**Key takeaway:** Destructive tools require human approval. You see the diff before anything changes. Reject with a reason to guide the AI.

---

### Story 20: Background Bash Sessions
**Duration:** 45s  
**Hook:** "Start a long-running process. Check its output anytime."  
**What to show:**
1. Ask the AI: "run the integration tests in the background".
2. The AI uses `bash_background` tool -- returns a session ID.
3. Ask: "check the background session output".
4. AI uses `bash_output` to read the ring buffer (256KB).
5. Ask: "kill the background session".
6. AI uses `kill_shell` to terminate and return final output.

**Key takeaway:** Background bash sessions let the AI start long-running processes, check on them, and clean up -- without blocking the conversation.

---

### Story 21: Cross-Pane Coordination
**Duration:** 50s  
**Hook:** "Your AI agents can talk to each other. Across panes."  
**What to show:**
1. Set up two panes side by side: "builder" and "tester".
2. In builder pane, ask the AI: "inspect the tester pane's output".
3. AI uses `pane_inspect` to read the other pane's state.
4. Then: "send 'go test ./...' to the tester pane".
5. AI uses `pane_send` to inject a command into the other pane.
6. Show `agents_list` tool listing all panes and their status.

**Key takeaway:** AI agents can inspect and send commands to other panes -- enabling multi-agent workflows across your workspace.

---

### Story 22: Loop Detection
**Duration:** 30s  
**Hook:** "What if the AI gets stuck in a loop? Rysh stops it."  
**What to show:**
1. Explain the sliding window of 20 `(toolName, paramsHash)` entries.
2. After 3 identical tool calls, execution is blocked.
3. Show the warning message when a loop is detected.
4. The AI is told to try a different approach.

**Key takeaway:** The orchestrator detects infinite tool-use loops and stops them automatically after 3 identical calls.

---

### Story 23: Context Store and Project Notes
**Duration:** 40s  
**Hook:** "Give your AI a memory. Persist across conversations."  
**What to show:**
1. Ask the AI: "store this context: the database is PostgreSQL on port 5433".
2. AI uses `context_store` to save to JetStream KV.
3. In a new conversation, ask: "recall the database info".
4. AI uses `context_recall` to retrieve it.
5. Show `project_notes` tool -- shared `.rysh-notes.md` file for team-wide context.
6. Show `todo` tool -- per-pane task list backed by JetStream KV.

**Key takeaway:** Context store, project notes, and todo lists give your AI agents persistent memory across conversations and sessions.

---

## Group 6: Autonomous Agents (Stories 24-28)

### Story 24: Spawning an Autonomous Agent
**Duration:** 50s  
**Hook:** "A headless AI agent. No terminal. Just a brain with tools."  
**What to show:**
1. Type: `##agent spawn code-reviewer You are a code reviewer. Review code for quality and correctness.`
2. The agent is created -- no pane, no PTY, just an AgenticActor.
3. Type: `@code-reviewer review the changes in the last commit`.
4. The agent runs, uses git tools, and produces a review.
5. Show `##agent list` -- the agent appears with "active" status.
6. Show `@@code-reviewer deactivate` to pause it, `@@code-reviewer activate` to resume.

**Key takeaway:** Autonomous agents are headless AI workers you can prompt anytime with `@name` -- they have full tool access but no terminal UI.

---

### Story 25: Skill Files for Agents
**Duration:** 45s  
**Hook:** "Define an agent in a Markdown file. Name, model, system prompt."  
**What to show:**
1. Show a `.md` skill file with YAML frontmatter:
   ```
   ---
   name: code-reviewer
   description: Reviews code for quality
   model: claude-sonnet-4-20250514
   ---
   You are a code reviewer...
   ```
2. Spawn it: `##agent spawn code-reviewer.md`.
3. Show `##agent spawn-all .rysh/agents/` -- batch-spawn all agents from a directory.
4. No frontmatter? Name is derived from filename, entire file is the system prompt.

**Key takeaway:** Skill files let you define reusable agent personas in Markdown -- version control them, share with your team.

---

### Story 26: Agent Output Routing
**Duration:** 40s  
**Hook:** "Route agent output to any pane's chat buffer."  
**What to show:**
1. Spawn an agent: `##agent spawn monitor Watch for build failures and report.`
2. Register output: `##agent register-output monitor my-pane`.
3. Send a prompt to the agent: `@monitor check the last build`.
4. The agent's response appears in the target pane's chat buffer (switch to chat mode to see it).
5. Unregister: `##agent unregister-output monitor my-pane`.

**Key takeaway:** Agent output can be routed to any pane's chat buffer -- so you see agent responses right where you're working.

---

### Story 27: Multi-Agent Orchestration
**Duration:** 55s  
**Hook:** "Planner, builder, tester -- three agents, one workflow."  
**What to show:**
1. Spawn three agents from a directory: `##agent spawn-all .rysh/agents/`.
2. Agents: `planner`, `builder`, `tester`.
3. Send to planner: `@planner create an implementation plan for adding user authentication`.
4. Planner responds with a plan.
5. Send to builder: `@builder implement the plan from the planner agent`.
6. Builder writes code using tools.
7. Send to tester: `@tester run the tests and report results`.
8. Each agent works independently with its own context.

**Key takeaway:** Multiple autonomous agents can be orchestrated together -- each with its own role, tools, and system prompt.

---

### Story 28: Agent Control Commands (@@)
**Duration:** 30s  
**Hook:** "Stop, pause, or resume any agent with @@."  
**What to show:**
1. `@@code-reviewer stop` -- stops and deletes the agent.
2. `@@builder deactivate` -- pauses the agent (keeps state, ignores prompts).
3. `@@builder activate` -- resumes the agent.
4. `##agent list` -- see status of all agents.
5. `##agent delete builder` -- remove an agent.

**Key takeaway:** Control commands with `@@` give you quick lifecycle management -- stop, pause, resume any agent instantly.

---

## Group 7: Humanoids -- AI with External Channels (Stories 29-32)

### Story 29: What Are Humanoids?
**Duration:** 55s  
**Hook:** "An AI agent that answers your Slack, email, WhatsApp, and phone."  
**What to show:**
1. Explain: humanoids = autonomous agents + external communication channels.
2. Show the architecture diagram: External Platform -> ChannelAdapter -> HumanoidActor -> AgenticActor -> LLM.
3. Five supported channels: WhatsApp, Slack, Email, Phone (SMS), Chatbot.
4. Inbound messages become LLM prompts. LLM responses go back to the channel.
5. Per-thread conversation context with 20-turn history and 24-hour TTL.

**Key takeaway:** Humanoids bridge the gap between your AI agents and the outside world -- every message from Slack, email, or WhatsApp becomes an AI prompt.

---

### Story 30: Spawning a Humanoid from a Skill File
**Duration:** 50s  
**Hook:** "A Markdown file that connects your AI to Slack and email."  
**What to show:**
1. Show a humanoid skill file with `contacts` YAML:
   ```yaml
   ---
   name: support-agent
   contacts:
     slack:
       bot_token: "${SLACK_BOT_TOKEN}"
       channels: ["#support"]
     email:
       address: "support@example.com"
   ---
   You are a customer support agent...
   ```
2. `${ENV_VAR}` syntax resolves at parse time -- secrets never in plaintext.
3. Spawn: `##humanoid spawn support-agent.md`.
4. `##humanoid list` -- see the humanoid with channel status.
5. `##humanoid channels support-agent` -- detailed channel info.

**Key takeaway:** Humanoid skill files define both the AI persona and its communication channels -- secrets come from environment variables.

---

### Story 31: Managing Humanoid Channels
**Duration:** 40s  
**Hook:** "Start and stop channels individually. Full control."  
**What to show:**
1. `##humanoid channel start support-agent slack` -- start the Slack adapter.
2. `##humanoid channel stop support-agent email` -- stop the email adapter.
3. `##humanoid channels support-agent` -- see which channels are connected.
4. Show that inbound messages from connected channels trigger the AI.
5. `@support-agent what's the status?` -- send a direct prompt too.

**Key takeaway:** Each communication channel can be started and stopped independently -- mix and match as needed.

---

### Story 32: Humanoid vs Agent -- When to Use Which
**Duration:** 35s  
**Hook:** "Agent for internal work. Humanoid for external communication."  
**What to show:**
1. Side-by-side comparison table:
   - Agents: no PTY, no channels, LLM tools only, internal workspace.
   - Humanoids: no PTY, yes channels, LLM tools + channel adapters, external + internal.
2. Use agent for: code review, testing, monitoring, planning.
3. Use humanoid for: customer support, Slack bots, email auto-responders, chatbots.
4. Both use `@name` for prompts and `@@name` for control.

**Key takeaway:** Agents work inside your workspace. Humanoids work with the outside world. Both are powered by the same AI engine.

---

## Group 8: Collaboration & Sharing (Stories 33-37)

### Story 33: Cross-Pane Listening
**Duration:** 45s  
**Hook:** "Pane B watches everything Pane A does. Live."  
**What to show:**
1. Name pane A: `##pane name builder`.
2. In pane B, type: `##pane listen builder`.
3. Run commands in pane A -- output appears in pane B prefixed with `[builder]`.
4. Secret redaction: SharedOutputActor strips sensitive data before forwarding.
5. `##pane unlisten` to stop.

**Key takeaway:** Cross-pane listening lets panes observe each other in real time -- with automatic secret redaction for safety.

---

### Story 34: Sharing Panes to the Cloud
**Duration:** 55s  
**Hook:** "Share your pane with anyone. View-only or full control."  
**What to show:**
1. Configure upstream: show `[upstream]` section in rysh.config.
2. `##share pane view` -- start sharing the active pane (view-only).
3. `##share pane control` -- share with full control (remote users can send commands).
4. `##share list` -- see active shares.
5. Remote user: `##upstream subscribe <shareID>` -- subscribe to the shared output.
6. `##unshare pane` -- stop sharing.

**Key takeaway:** Share your pane to the upstream server for real-time collaboration -- view-only for observation, control for pair programming.

---

### Story 35: Sharing at Every Level -- Pane, Group, Lane, Tab
**Duration:** 40s  
**Hook:** "Share one pane. Or a whole tab. Your choice."  
**What to show:**
1. `##share pane view` -- share a single pane.
2. `##share panegroup control` -- share all stacked panes in a group.
3. `##share lane view` -- share an entire column.
4. `##share tab control` -- share everything in a tab.
5. Each level includes all child panes in the share.

**Key takeaway:** Sharing granularity lets you expose exactly what you want -- from a single pane up to an entire tab.

---

### Story 36: Remote Command Execution (Control Mode)
**Duration:** 45s  
**Hook:** "A remote user sends a command to your pane. You control what's allowed."  
**What to show:**
1. Share a pane in control mode: `##share pane control`.
2. Remote user subscribes and runs `##upstream send make build`.
3. Show the command executing in the local pane.
4. Configure allowed commands: `allowed_commands = ["submit_input", "exec_shell"]`.
5. Configure blocklist: `command_blocklist = ["rm -rf", "git push --force"]`.
6. Optional: `command_approval = true` -- requires local approval before execution.

**Key takeaway:** Control mode lets remote users run commands, but the owner controls the whitelist, blocklist, and optional approval.

---

### Story 37: The Hop Command
**Duration:** 45s  
**Hook:** "Copy one pane's context into another. Then resume the AI conversation."  
**What to show:**
1. Work in pane A -- run commands, get AI responses, accumulate context.
2. Type: `##hop pane-B-name` -- copies pane A's full output to pane B.
3. Switch to pane B -- see the confirmation: "received 142 lines from pane-A-name".
4. Type: `##hop resume` -- the AI in pane B gets the full context wrapped in `<copied-text>` tags.
5. The AI acknowledges and summarizes what it sees from pane A.

**Key takeaway:** The hop command transfers context between panes -- the destination AI gets full awareness of what happened in the source pane.

---

## Group 9: Pipelines & Events (Stories 38-40)

### Story 38: Pipeline Events (##>)
**Duration:** 45s  
**Hook:** "Lines starting with ##> bypass the shell. They go straight to NATS."  
**What to show:**
1. Type: `##>event:print:Build started at 10:30 AM`.
2. The event bypasses the PTY -- no shell echo -- and is published directly to NATS.
3. A listening pane receives the event payload without the `[alias]` prefix.
4. Show `##>event:ai:softdev:golang:development` triggering the AI in a listening pane.
5. Show `##>event:sh:softdev:golang:unit_testing` running `go test -v ./...` in a listening pane.

**Key takeaway:** Pipeline events are a messaging layer between panes -- print messages, trigger AI prompts, or run shell commands on listeners.

---

### Story 39: Software Development Pipeline
**Duration:** 55s  
**Hook:** "A complete dev pipeline: plan, code, lint, test, deploy -- orchestrated across panes."  
**What to show:**
1. Set up two panes: orchestrator and worker.
2. Worker listens to orchestrator: `##pane listen orchestrator`.
3. In orchestrator, send: `##>event:ai:softdev:golang:planning` -- worker's AI creates a plan.
4. Send: `##>event:ai:softdev:golang:development` -- worker's AI writes code.
5. Send: `##>event:sh:softdev:golang:linting` -- runs `go vet ./...`.
6. Send: `##>event:sh:softdev:golang:unit_testing` -- runs `go test -v ./...`.
7. Each phase builds on accumulated context from the previous one.

**Key takeaway:** Softdev events orchestrate a full development pipeline across panes -- planning, coding, linting, testing, and deployment.

---

### Story 40: Pipeline Commands
**Duration:** 40s  
**Hook:** "Load, run, and manage multi-step pipelines."  
**What to show:**
1. `##pipe help` -- show pipeline commands.
2. `##pipe load my-pipeline.yaml` -- load a pipeline definition.
3. `##pipe list` -- list loaded pipelines.
4. `##pipe show my-pipeline` -- see pipeline details.
5. `##pipe run my-pipeline` -- execute the pipeline.
6. `##pipe status` -- check execution progress.
7. `Ctrl+P p` -- toggle pipeline mode for the active tab.

**Key takeaway:** Pipeline commands let you define, load, and execute multi-step workflows -- turning your terminal into a CI/CD dashboard.

---

## Group 10: Web Terminal (Stories 41-43)

### Story 41: The Embedded Web Terminal
**Duration:** 55s  
**Hook:** "Your full terminal. In a browser. Same shortcuts, same modes, same everything."  
**What to show:**
1. Type `##rysh web start` -- web server starts on port 23232.
2. Open `http://localhost:23232` in a browser.
3. Show the full TUI replicated: tabs, panes, input modes, layout.
4. All 13 interaction modes work: tab, pane, navigate, stack, layout, resize, prefix, Alt+P, rename, raw, approval, rejection.
5. Show approval workflow in the browser -- diff display, clickable choices.
6. Show VT screen rendering for raw mode (vim running in the browser view).

**Key takeaway:** The web terminal is a full-fidelity browser replica of the TUI -- same shortcuts, same modes, embedded in the rysh binary.

---

### Story 42: Web Terminal Architecture
**Duration:** 40s  
**Hook:** "It's not a separate service. It's the same NATS bus."  
**What to show:**
1. Architecture diagram: Browser <-> web.Server <-> NATS Bus <-> Actor System <-> TUI.
2. Snapshots pushed every 200ms via WebSocket.
3. Commands from browser published to the same NATS inbox as the TUI.
4. React + TypeScript frontend embedded via `//go:embed`.
5. No external dependencies at runtime -- it's all in the binary.

**Key takeaway:** The web terminal shares the exact same NATS bus and actor system as the TUI -- it's a second frontend, not a separate service.

---

### Story 43: Web Terminal Commands
**Duration:** 30s  
**Hook:** "Start, stop, and check status. Three commands."  
**What to show:**
1. `##rysh web start` -- start on default port 23232.
2. `##rysh web start 9090` -- start on a custom port.
3. `##rysh web status` -- check if running.
4. `##rysh web stop` -- graceful shutdown.
5. Auto-shutdown when the rysh session exits.

**Key takeaway:** The web server is controlled via `##rysh web` commands and auto-shuts-down when your session ends.

---

## Group 11: Mobile App (Stories 44-45)

### Story 44: Rysh on Your Phone
**Duration:** 55s  
**Hook:** "Manage your AI workspace from your phone. Shell, AI, chat -- all four modes."  
**What to show:**
1. Open the Rysh mobile app (React + Capacitor).
2. Login screen -- same auth as web dashboard.
3. Workspace list -- tap a workspace to see its panes.
4. Pane list -- flat view of all panes (no tab/group hierarchy on mobile).
5. Tap a pane -- see terminal output with XTerm.js rendering.
6. Mode tab bar at bottom: Shell, AI, Chat, Rysh -- tap to switch.
7. Type a command in the input field -- submit with send button.
8. Haptic feedback on mode switch.

**Key takeaway:** The mobile app gives you read-write access to all your panes on the go -- switch modes, send commands, watch output live.

---

### Story 45: Mobile Features -- Per-Mode Streams and Unread Badges
**Duration:** 40s  
**Hook:** "Each mode has its own WebSocket stream. Unread badges tell you what's new."  
**What to show:**
1. Switch between Shell and AI mode tabs -- each shows its own output stream.
2. While viewing Shell mode, AI mode receives new output -- an unread badge appears.
3. Tap AI to see the new output -- badge clears.
4. Pull-to-refresh on workspace and pane lists.
5. Auto-reconnect when the app returns from background.
6. Virtual keyboard management -- terminal resizes, mode bar hides.

**Key takeaway:** Per-mode streaming with unread badges ensures you never miss important output, even when viewing a different mode.

---

## Group 12: Chrome Extension & Browser Automation (Stories 46-47)

### Story 46: Chrome Extension -- Your Browser as a Pane
**Duration:** 50s  
**Hook:** "The Chrome extension IS a pane. Same protocol. Same tools."  
**What to show:**
1. Install the Rysh Chrome extension.
2. Open the side panel -- it connects to rysh-server via NATS WebSocket.
3. Type a prompt: "What am I looking at?" -- the AI reads the current tab's page context.
4. The extension speaks the same NATSEnvelope protocol as every other actor.
5. Approval dialogs appear in the extension for tool approvals.
6. Show conversation history persisting across page navigations.

**Key takeaway:** The Chrome extension turns your browser into a rysh pane -- the AI sees your active tab and uses the same tools as any other agent.

---

### Story 47: Browser Automation -- AI Controls Your Browser
**Duration:** 60s  
**Hook:** "Navigate, click, type, screenshot -- the AI drives your browser."  
**What to show:**
1. Ask: "Go to GitHub and search for 'rysh terminal multiplexer'".
2. AI uses `browser_action` with `navigate`, then `type`, then `click`.
3. Ask: "What are the first 3 results?" -- AI uses `get_text`.
4. Ask: "Take a screenshot" -- AI captures the visible tab.
5. Show the element selection strategies: CSS, XPath, `text:`, `aria:`, `role:`, `testid:`.
6. `execute_js` requires approval -- arbitrary code execution is gated.
7. Tab management: `get_tabs`, `switch_tab`, `new_tab`, `close_tab`.

**Key takeaway:** Browser automation gives the AI full browser control -- navigate, interact with forms, extract data, and manage tabs.

---

## Group 13: Server, Deployment & Billing (Stories 48-50)

### Story 48: The Upstream Server -- Collaboration Hub
**Duration:** 55s  
**Hook:** "A Go server that bridges rysh sessions. PostgreSQL, NATS, Docker."  
**What to show:**
1. Architecture: Go + Gin, PostgreSQL (GORM), embedded NATS, nginx, React frontend.
2. `docker compose up -d` -- start the full stack.
3. Services: rysh_postgres, rysh_migrate, rysh_backend, rysh_frontend, rysh_nginx.
4. Register a user, create a workspace, get an API key.
5. Configure local rysh with the API key.
6. Share a pane -- output flows through the server to remote subscribers.
7. Dev mode (`make dev-up`) vs production (`make prod-up`).

**Key takeaway:** The upstream server is a self-hosted collaboration hub -- share panes, manage workspaces, and connect remote sessions.

---

### Story 49: Subscription Billing with Stripe
**Duration:** 45s  
**Hook:** "Four tiers. Free to Enterprise. Stripe Checkout built in."  
**What to show:**
1. Pricing tiers: Free (1 ws, 3 sessions, 30 panes), Solo ($19/mo), Team ($49/mo), Enterprise (custom).
2. Web dashboard billing page -- monthly/yearly toggle.
3. Click "Upgrade" -- Stripe Checkout session opens.
4. "Manage Billing" -- Stripe Billing Portal (change plan, update payment, cancel).
5. Resource limits enforced at three levels: workspaces (server), sessions (WebSocket upgrade), panes (daemon).
6. Webhook handling: checkout.completed, subscription.updated, invoice.paid.

**Key takeaway:** Stripe billing is fully integrated -- checkout, portal, webhooks, and resource limit enforcement across the entire stack.

---

### Story 50: Session Management -- Attach, Detach, Send
**Duration:** 45s  
**Hook:** "Control sessions from the command line. Even without a TUI."  
**What to show:**
1. `rysh my-session` -- start a session.
2. `Ctrl+O d` -- detach (session keeps running in background).
3. `rysh list-sessions` -- see all sessions with state and PID.
4. `rysh attach my-session` -- reattach with full state restoration from JetStream KV.
5. `rysh send my-session "go test ./..."` -- send a command without attaching.
6. `rysh send my-session "explain the test failures" --mode prompt` -- send an AI prompt.
7. `rysh send my-session "##pane list" --pane abc123` -- send to a specific pane.
8. `rysh detach my-session` -- detach from outside (sends SIGUSR1).
9. `rysh delete-session my-session` -- terminate process, remove record, delete NATS data.

**Key takeaway:** Full session lifecycle from the CLI -- start, detach, reattach, send commands remotely, and clean up when done.

---

## Story Index by Group

| Group | Stories | Topic |
|-------|---------|-------|
| 1. Getting Started | 1-4 | Installation, first session, configuration |
| 2. Terminal Multiplexer Basics | 5-10 | Tabs, panes, splits, navigation, layout, mouse |
| 3. Input Modes | 11-14 | Shell, prompt, rysh, chat modes |
| 4. Interactive Terminal | 15-17 | Vim, raw mode, PTY resize |
| 5. AI Agentic Features | 18-23 | Tools, approval, background, cross-pane, loop detection, context |
| 6. Autonomous Agents | 24-28 | Spawn, skill files, output routing, multi-agent, control |
| 7. Humanoids | 29-32 | External channels, skill files, channel management, comparison |
| 8. Collaboration & Sharing | 33-37 | Listening, cloud sharing, granularity, control mode, hop |
| 9. Pipelines & Events | 38-40 | Pipeline events, softdev pipeline, pipe commands |
| 10. Web Terminal | 41-43 | Browser TUI, architecture, commands |
| 11. Mobile App | 44-45 | Phone interface, per-mode streams |
| 12. Chrome Extension | 46-47 | Browser pane, browser automation |
| 13. Server & Billing | 48-50 | Upstream server, Stripe billing, session management |

---

## Production Notes

### Recommended Recording Order

Record in this order to build on previous footage:

1. Stories 1-4 (Getting Started) -- establishes the baseline
2. Stories 5-10 (Multiplexer Basics) -- shows core navigation
3. Stories 11-14 (Input Modes) -- demonstrates the mode system
4. Stories 15-17 (Interactive Terminal) -- shows vim/htop support
5. Stories 18-23 (AI Features) -- the agentic core
6. Stories 24-28 (Agents) -- autonomous agents
7. Stories 29-32 (Humanoids) -- external channels
8. Stories 33-37 (Collaboration) -- sharing features
9. Stories 38-40 (Pipelines) -- event orchestration
10. Stories 41-43 (Web Terminal) -- browser interface
11. Stories 44-45 (Mobile) -- mobile app
12. Stories 46-47 (Chrome) -- browser automation
13. Stories 48-50 (Server) -- infrastructure and billing

### Visual Style Guide

- **Terminal recordings**: Use a dark theme with good contrast (e.g., Catppuccin Mocha, Dracula)
- **Font**: JetBrains Mono or Fira Code, 14-16px
- **Window size**: 1920x1080 or 2560x1440 for 4K
- **Annotations**: Use on-screen callouts for key bindings (e.g., "Ctrl+P" appears as a floating badge)
- **Transitions**: Simple fade between sections -- no flashy effects
- **Music**: Subtle lo-fi or ambient -- never louder than narration
- **Pacing**: Show the action, then pause briefly for the viewer to read output

### Suggested Platforms

- YouTube (full-length playlist)
- TikTok/Instagram Reels (30-60s cuts)
- X/Twitter (30s highlights)
- Product website (embedded on feature pages)
