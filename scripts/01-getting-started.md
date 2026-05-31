# Group 1: Getting Started (Stories 1-4)

Narration scripts for the first four stories. These establish Rysh's identity and get viewers installed, built, and configured.

**Total duration:** ~3 min 15s

---

## Story 1: What Is Rysh? (60s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "What Is Rysh?" | "A terminal that thinks. Shell mode runs commands, prompt mode talks to AI -- and every pane is both." |
| 0:04 | Type `rysh`, TUI launches in shell mode (`>`) | "Just type rysh. You land in shell mode -- your familiar terminal, fully PTY-backed." |
| 0:10 | Type `ls -la`, output renders | "In shell mode everything works like a normal terminal. Full color, full ANSI -- run any command you want." |
| 0:18 | Double-press Escape, marker changes to `<` | "Double-press Escape to cycle the input mode. Watch the marker change to a less-than sign -- now you're talking to an AI agent." |
| 0:26 | Type "explain this directory structure", AI responds | "Ask anything. The agent sees your terminal context and answers right inside the pane, rendered as markdown." |
| 0:40 | Escape back through modes to shell | "Escape again brings you back through the modes to shell. One pane, two ways to work." |
| 0:46 | `Ctrl+P` then `n` to split right | "Ctrl+P enters pane mode. Press n to split right -- two independent panes, each its own shell and agent." |
| 0:53 | `Ctrl+T` then `n` for a new tab | "Ctrl+T enters tab mode. Press n for a whole new tab. That's Rysh: every pane is a shell plus an AI agent." |

### Key Moments to Annotate
- [0:18] Show key badge: `Esc Esc` and marker change `>` to `<`
- [0:46] Show key badges: `Ctrl+P` then `n`
- [0:53] Show key badges: `Ctrl+T` then `n`

---

## Story 2: Installing Rysh (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Installing Rysh" | "One command to install -- on every platform Rysh supports." |
| 0:04 | Type `brew tap rysh-works/rysh && brew install rysh` | "On macOS, tap the repo and brew install rysh. Two commands and you're done." |
| 0:12 | Show `sudo apt install rysh` and `sudo dnf install rysh` | "On Debian or Ubuntu, apt install rysh. On Fedora or RHEL, dnf install rysh." |
| 0:20 | Show `winget install RyshWorks.Rysh` | "On Windows, install with WinGet." |
| 0:27 | `git clone ...`, then `make build && make install` | "Or build from source -- it's just Go. make build, then make install." |
| 0:36 | Type `rysh --version`, version prints | "Verify it with rysh --version. You're ready to go." |

### Key Moments to Annotate
- [0:04] Highlight the brew tap + install command
- [0:36] Highlight the version output

---

## Story 3: Building From Source (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Building From Source" | "Rysh is written in Go, so building from source takes just a few commands." |
| 0:04 | Type `git clone ... && cd rysh` | "Start by cloning the repository and stepping in." |
| 0:12 | Type `make build`, then `./rysh --version` | "Run make build. The Go toolchain compiles a local rysh binary right here." |
| 0:20 | Type `make install` | "make install copies it into ~/.local/bin so you can run rysh from anywhere." |
| 0:28 | Type `export PATH="$HOME/.local/bin:$PATH"` | "If needed, add ~/.local/bin to your PATH." |
| 0:36 | Type `rysh --version` | "Confirm with rysh --version and you're building from your own source." |

### Key Moments to Annotate
- [0:12] Highlight the `make build` output and `./rysh` binary
- [0:28] Highlight the PATH export

---

## Story 4: Configuring Rysh (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Configuring Rysh" | "Rysh reads one TOML config file -- and every setting also has an environment-variable override." |
| 0:05 | `cat ~/.config/rysh/rysh.config` | "The config lives at ~/.config/rysh/rysh.config, or rysh.config in your current directory." |
| 0:13 | Highlight `[provider]` block | "The provider section sets your model and API key. Set api_key to call the Anthropic API directly -- otherwise Rysh falls back to the claude CLI." |
| 0:24 | Highlight `[ui]` block | "The ui section controls your shell and how many tabs and panes open on a fresh start." |
| 0:34 | Highlight `[upstream]` block | "The upstream section enables remote sharing -- point it at a rysh-server and drop in an API key." |
| 0:42 | Type `RYSH_API_KEY=sk-ant-xxxx rysh` | "Every value has an env override. Just prefix your launch -- here, RYSH_API_KEY -- and rysh picks it up." |

### Key Moments to Annotate
- [0:13] Highlight `[provider]` section header
- [0:24] Highlight `[ui]` section header
- [0:34] Highlight `[upstream]` section header
- [0:42] Highlight the `RYSH_API_KEY=...` env override
