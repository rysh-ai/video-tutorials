# Group 1: Getting Started (Stories 1-4)

Narration scripts for the first four stories. These establish Rysh's identity and get viewers up and running.

**Total duration:** ~3 min 20s

---

## Story 1: What Is Rysh? (60s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Black screen, title card: "What Is Rysh?" | "What if every terminal pane was an autonomous AI agent?" |
| 0:03 | Terminal opens, cursor blinks | "Rysh is a terminal multiplexer -- like tmux or Zellij -- but built from the ground up for AI-assisted development." |
| 0:08 | Type `rysh`, press Enter | "Just type rysh to start." |
| 0:10 | TUI launches with one tab, one pane | "You get tabs, panes, and a full PTY-backed shell." |
| 0:15 | Type `ls -la`, output appears | "In shell mode, it's a regular terminal. Full color, full ANSI." |
| 0:20 | Double-press Escape, prompt changes to `<` | "Double-press Escape to switch to prompt mode." |
| 0:25 | Type "explain this directory structure" | "Now you're talking to an AI agent. It has access to 35 tools -- files, git, bash, web search." |
| 0:30 | AI response renders as markdown | "The response renders as formatted markdown right in the pane." |
| 0:38 | `Ctrl+P n` to split, `Ctrl+T n` to create tab | "Split panes, create tabs -- organize your workspace however you want." |
| 0:45 | Type `vim main.go` in one pane | "Run vim, htop, nano -- interactive programs just work." |
| 0:50 | Quick montage of features | "AI agents, autonomous bots, shared panes, pipeline orchestration." |
| 0:55 | End card: "Rysh -- your agentic terminal" | "Rysh. A terminal multiplexer where every pane is an AI workspace." |

### Key Moments to Annotate
- [0:20] Show key badge: `Esc Esc`
- [0:25] Show prompt character change: `>` to `<`
- [0:38] Show key badges: `Ctrl+P`, `Ctrl+T`

---

## Story 2: Installing Rysh (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Installing Rysh" | "One command to install. Every platform." |
| 0:03 | macOS terminal | "On macOS, use Homebrew." |
| 0:05 | Type `brew tap rysh-works/rysh && brew install rysh` | "Tap the repo, install rysh." |
| 0:10 | Ubuntu terminal (or text overlay) | "On Ubuntu or Debian..." |
| 0:12 | Show `sudo apt install rysh` | "apt install after adding the repository." |
| 0:16 | Fedora text overlay | "Fedora and RHEL use dnf." |
| 0:18 | Show `sudo dnf install rysh` | |
| 0:20 | Windows text overlay | "Windows? WinGet or Chocolatey under WSL2." |
| 0:22 | Show `winget install RyshWorks.Rysh` | |
| 0:26 | Terminal with git clone | "Or build from source -- it's just Go." |
| 0:28 | Type `git clone ... && make build && make install` | |
| 0:35 | Type `rysh --version` | "Verify with rysh --version." |
| 0:38 | Output shows version | "You're ready to go." |
| 0:40 | End card: package manager logos | "Homebrew, apt, dnf, WinGet, Chocolatey, or source. Rysh runs anywhere Go runs." |

### Key Moments to Annotate
- [0:05] Highlight the brew command
- [0:35] Highlight version output

---

## Story 3: Your First Session (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Your First Session" | "Start a session, name it, come back to it later." |
| 0:03 | Terminal, type `rysh my-project` | "Give your session a name when you start it." |
| 0:06 | TUI opens | "Rysh launches with a named session called my-project." |
| 0:09 | Run `git status`, `npm install` | "Work as usual. Run commands, create files." |
| 0:15 | `Ctrl+P n` to split | "Split a pane, run some tests." |
| 0:20 | Show key badge `Ctrl+O`, then `d` | "Press Ctrl+O, then d to detach." |
| 0:23 | Back to bare terminal | "You're back at your shell. But the session is still alive." |
| 0:27 | Type `rysh list-sessions` | "List sessions to see it." |
| 0:30 | Output shows `my-project  detached  PID 12345` | "There it is -- detached, with its PID." |
| 0:34 | Type `rysh attach my-project` | "Reattach with rysh attach." |
| 0:37 | TUI reopens, same state | "Everything is right where you left it." |
| 0:40 | Callout arrow to output | "Output, history, pane layout -- all restored from JetStream KV." |
| 0:45 | End card | "Sessions are persistent. Detach and reattach without losing state." |

### Key Moments to Annotate
- [0:20] Show key badge: `Ctrl+O d`
- [0:30] Highlight session state: "detached"
- [0:37] Callout: "State restored from JetStream KV"

---

## Story 4: Configuring Rysh (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Configuring Rysh" | "One config file. Every setting has an environment variable override." |
| 0:03 | Open `~/.config/rysh/rysh.config` in editor | "The config file is TOML. Clean and simple." |
| 0:07 | Highlight `[provider]` section | "Set your API key here for direct Anthropic API access." |
| 0:12 | Highlight `api_key = "sk-ant-..."` | "Or use the Claude CLI as a fallback if no key is set." |
| 0:16 | Highlight `[ui]` section | "Configure initial tabs, panes, and your preferred shell." |
| 0:20 | Show `initial_tabs = 2`, `initial_panes = 1` | |
| 0:24 | Highlight `[upstream]` section | "The upstream section enables remote sharing." |
| 0:28 | Show `enabled = true`, `url = "..."` | |
| 0:32 | Back to terminal | "Every config value has an environment variable override." |
| 0:35 | Type `RYSH_API_KEY=sk-ant-... rysh` | "Just prefix your session with the env var." |
| 0:40 | End card | "TOML config or env vars -- your choice." |

### Key Moments to Annotate
- [0:07] Highlight `[provider]` section header
- [0:16] Highlight `[ui]` section header
- [0:24] Highlight `[upstream]` section header
- [0:35] Highlight env var override
