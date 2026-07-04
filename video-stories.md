# Rysh Video Stories

111 short video stories explaining every major feature of the Rysh project, organized into 26 groups.

Rysh is an **agentic terminal multiplexer**: every pane is both a PTY-backed shell and an autonomous AI agent workspace, with cloud sharing, autonomous agents, humanoids, pipelines, a web terminal, desktop & mobile apps, a Chrome extension, and an upstream billing server.

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
**Hook:** "A terminal that thinks. Shell mode runs commands. Prompt mode talks to AI."  
**What to show:**
1. Type `rysh` and land in shell mode (marker `>`) -- a familiar PTY-backed terminal.
2. Run `ls -la` in shell mode with full color and ANSI.
3. Double-press Escape to cycle to prompt mode (marker `<`).
4. Ask the AI "explain this directory structure" and watch the markdown response render in the same pane.
5. Split with `Ctrl+P n`, then create a new tab with `Ctrl+T n`.

**Key takeaway:** Rysh is a terminal multiplexer where every pane is both a shell and an AI agent workspace.

---

### Story 2: Installing Rysh
**Duration:** 45s  
**Hook:** "One command to install. Every platform."  
**What to show:**
1. macOS: `brew tap rysh-works/rysh && brew install rysh`.
2. Debian/Ubuntu: `sudo apt install rysh`.
3. Fedora/RHEL: `sudo dnf install rysh`.
4. Windows: `winget install RyshWorks.Rysh`.
5. From source: `git clone ... && make build && make install`.
6. Verify with `rysh --version`.

**Key takeaway:** Rysh installs via Homebrew, apt, dnf, WinGet, or from source -- it runs anywhere Go runs.

---

### Story 3: Building From Source
**Duration:** 40s  
**Hook:** "Rysh is just Go. Clone it, make build, and run your own binary."  
**What to show:**
1. `git clone https://github.com/rysh-works/rysh && cd rysh`.
2. `make build` -- the Go toolchain produces the local `./rysh` binary.
3. `make install` -- copies it into `~/.local/bin`.
4. Add `~/.local/bin` to your `PATH` if needed.
5. Confirm with `rysh --version`.

**Key takeaway:** Building Rysh from source is a three-step Go build -- clone, make build, make install.

---

### Story 4: Configuring Rysh
**Duration:** 50s  
**Hook:** "One TOML file controls everything -- and every setting has an env-var override."  
**What to show:**
1. Open the config at `~/.config/rysh/rysh.config` (TOML).
2. `[provider]` -- set `model` and `api_key` for the Anthropic API (or fall back to the `claude` CLI).
3. `[ui]` -- set `shell`, `initial_tabs`, and `initial_panes`.
4. `[upstream]` -- enable remote sharing with `url` and `api_key`.
5. Override any value via env, e.g. `RYSH_API_KEY=sk-ant-... rysh`.

**Key takeaway:** Everything is configurable via the TOML file or environment variables -- API keys, shell, layout, and upstream server.

---

## Group 2: Sessions & Daemon (Stories 5-9)

### Story 5: Your First Session
**Duration:** 50s  
**Hook:** "Name a session, work in it, detach -- and it keeps running without you."  
**What to show:**
1. `rysh my-project` -- start a named session.
2. Run commands like `git status`.
3. Detach with `Ctrl+O` then `d`.
4. `rysh list-sessions` -- see it listed as detached with its PID.
5. `rysh attach my-project` -- reattach with output, history, and layout restored.

**Key takeaway:** Sessions are persistent -- detach and reattach without losing any state.

---

### Story 6: Named & Detached Sessions
**Duration:** 45s  
**Hook:** "Create a session attached, or spin one up headless as a background daemon."  
**What to show:**
1. `rysh create my-session` -- create and attach the TUI.
2. `rysh create build-bot --detached` (or `-d`) -- spawn a headless daemon; control returns to the prompt.
3. `rysh list-sessions` -- confirm the headless session is running.
4. `rysh attach build-bot` -- attach to it later.

**Key takeaway:** `rysh create` makes a session attached, or `--detached` runs it headlessly as a daemon you attach to later.

---

### Story 7: Attach, Detach, List, Delete
**Duration:** 45s  
**Hook:** "Four commands manage every session's whole lifecycle from outside."  
**What to show:**
1. `rysh list-sessions` -- name, state, and PID of each session.
2. `rysh attach my-project` -- reopen the TUI.
3. `rysh detach my-project` -- gracefully detach a running session from outside.
4. `rysh delete-session my-project` -- kills the process and purges the NATS data directory.

**Key takeaway:** `attach`, `detach`, `list-sessions`, and `delete-session` give you full lifecycle control from the shell.

---

### Story 8: Sending Input Remotely
**Duration:** 45s  
**Hook:** "Drive a session from the outside -- no attach required."  
**What to show:**
1. `rysh send my-session "ls -la"` -- run in the active pane without attaching.
2. `--pane abc123` -- target a specific pane by ID.
3. `--mode prompt` -- send an AI prompt instead of a command.
4. `--mode shell` -- force shell execution; omit `--mode` to use the pane's current mode.

**Key takeaway:** `rysh send` injects commands or prompts into any pane of a running session without opening its TUI.

---

### Story 9: Session Persistence
**Duration:** 45s  
**Hook:** "Detach, reattach -- your panes come back exactly as you left them."  
**What to show:**
1. State is stored at `~/.local/state/rysh/nats/{session}`.
2. The `rysh-workspace` JetStream KV bucket holds tab structure, pane references, and active indices.
3. The `rysh-panes` KV bucket holds each pane's output buffer, mode, and last command.
4. On attach, the WorkspaceActor restores everything straight from KV.

**Key takeaway:** Session state lives in JetStream KV buckets and is restored on attach, so nothing is ever lost.

---

## Group 3: Tabs (Stories 10-13)

### Story 10: Tabs Overview
**Duration:** 45s  
**Hook:** "Tabs hold panes, panes hold agents -- and switching between them is one keystroke."  
**What to show:**
1. Start `rysh` -- one tab with one pane by default.
2. Add tabs with `Ctrl+T n`.
3. Switch tabs with `[` (previous) and `]` (next).
4. Switch tabs with `Alt+Left` / `Alt+Right`.

**Key takeaway:** Tabs are independent workspaces of panes and agents, and you switch between them with a single key.

---

### Story 11: Tab Mode (Ctrl+T)
**Duration:** 45s  
**Hook:** "Ctrl+T opens tab mode -- create, jump, and move without leaving the keyboard."  
**What to show:**
1. Press `Ctrl+T` to enter tab mode.
2. Press `n` to create new tabs.
3. Move with `h`/`k` (previous) and `j`/`l` (next).
4. Jump by index with `1`-`9`.
5. Exit with `Esc`.

**Key takeaway:** Tab mode (`Ctrl+T`) is a modal hub for creating, navigating, and jumping between tabs from the home row.

---

### Story 12: Jump & Rename Tabs
**Duration:** 40s  
**Hook:** "Jump to any tab by number, and give your tabs real names."  
**What to show:**
1. In tab mode, jump by index with `1`-`9`.
2. Rename the active tab with `##tab name <name>`.
3. Rename any tab by id with `##tab name <id> <name>`.

**Key takeaway:** Jump to tabs instantly by number, and name them with `##tab name` so layouts stay readable.

---

### Story 13: Managing Tabs (##tab)
**Duration:** 40s  
**Hook:** "The ##tab command is your full tab control center."  
**What to show:**
1. `##tab list` -- list tabs with IDs and pane counts.
2. `##tab list-panes` -- list the panes inside the active tab.
3. `##tab delete <id>` -- remove a tab.
4. `##tab pipeline enable` / `disable` -- toggle pipeline mode for a tab.

**Key takeaway:** `##tab` is the command center for listing, inspecting, deleting, and pipelining your tabs.

---
## Group 4: Panes & Splits (stories 14-18)

### Story 14: Panes Overview
**Duration:** 45s  
**Hook:** "One window, many minds. Every pane is its own shell and its own AI agent."  
**What to show:**
1. Start `rysh` -- a single pane backed by its own agent.
2. Press `Ctrl+N` to create a second pane side by side.
3. Press `Ctrl+N` again for a third -- each with its own directory, history, and AI context.
4. Press `Tab` to cycle focus; the focused pane gets a highlighted border.
5. Type `pwd` to show input lands only in the focused pane.

**Key takeaway:** A pane is an independent shell-plus-agent; `Ctrl+N` adds one and `Tab` moves between them.

---

### Story 15: Pane Mode (Ctrl+P)
**Duration:** 50s  
**Hook:** "Ctrl+P is your pane command center -- split, stack, close, and rename without leaving the keyboard."  
**What to show:**
1. Start `rysh` and press `Ctrl+P` to enter pane mode (footer shows the bindings).
2. Press `n` to split right (new column).
3. Press `v` to split down (new row in the same column).
4. Press `s` to stack a pane on top of the active group.
5. Press `r` to rename the active pane, type a name, press Enter.
6. Press `x` to close a pane, then `Esc` to exit pane mode.

**Key takeaway:** Pane mode under `Ctrl+P` is the single hub for splitting, stacking, closing, and renaming panes.

---

### Story 16: Split Right & Split Down
**Duration:** 45s  
**Hook:** "Build any layout from two moves: split right for columns, split down for rows."  
**What to show:**
1. Start `rysh` with one pane in one column.
2. `Ctrl+P n` splits right into a second column; space divides by flex weight.
3. `Ctrl+P n` again for a third, evenly shared column.
4. `Ctrl+P v` splits down, adding a row inside the active column.
5. `Ctrl+P v` again to pack in another row.

**Key takeaway:** `n` grows columns, `v` grows rows, and flex weights keep the layout balanced.

---

### Story 17: Closing & Renaming Panes
**Duration:** 40s  
**Hook:** "Keep your workspace tidy: close panes you're done with and name the ones you keep."  
**What to show:**
1. Start `rysh` and `Ctrl+P n` to add a second pane.
2. `Ctrl+P r`, type `tests`, Enter -- rename via pane mode.
3. `##pane name api-server` -- set the given-name from rysh mode (unique per lane).
4. `Ctrl+P x` to close the active pane.

**Key takeaway:** Rename panes with `Ctrl+P r` or `##pane name`, and close them with `Ctrl+P x`.

---

### Story 18: Pane Info & Listing (##pane)
**Duration:** 40s  
**Hook:** "Ask rysh about itself -- inspect any pane, list them all, and replay its history."  
**What to show:**
1. Start `rysh`, split into multiple panes.
2. `##pane info` -- the active pane's id, name, mode, and group.
3. `##pane list` -- every pane in the current tab.
4. `##pane history shell` -- replay this pane's shell history (or `prompt` for AI turns).

**Key takeaway:** The `##pane` commands -- `info`, `list`, and `history` -- let you inspect panes from rysh mode.

---

## Group 5: Stacked Panes & Groups (stories 19-22)

### Story 19: Stacked Panes
**Duration:** 45s  
**Hook:** "Stack panes like a deck of cards -- many terminals in the footprint of one."  
**What to show:**
1. Start `rysh` with a single pane.
2. `Ctrl+P s` stacks a pane on top of the group; border title reads `[1/2]`.
3. `Ctrl+P s` again; title shows `[1/3]`, only the front pane full-size.
4. Background panes appear as grey title bars at the bottom of the active pane.

**Key takeaway:** Stacking layers panes into one slot like a deck of cards, shown by a `[1/N]` border title.

---

### Story 20: Stack Mode (Ctrl+S)
**Duration:** 40s  
**Hook:** "Ctrl+S turns a stack into a flip-book -- rotate through your panes with j and k."  
**What to show:**
1. Start `rysh` and build a 3-pane stack with `Ctrl+P s` twice (`[1/3]`).
2. Press `Ctrl+S` to enter stack mode.
3. Press `j` to rotate to the next pane; the counter ticks forward.
4. Press `k` to rotate back the other way.
5. Press `Esc` to exit stack mode.

**Key takeaway:** Stack mode (`Ctrl+S`) uses `j` and `k` to rotate the front pane through a stacked group.

---

### Story 21: Pane Groups & Lanes
**Duration:** 45s  
**Hook:** "Beneath every layout is a tree -- lanes hold groups, groups hold panes."  
**What to show:**
1. Start `rysh` and `Ctrl+P n` twice; each column is a pane group with a flex weight.
2. `##pg list` (panegroup) -- every group in the tab and its flex share.
3. `##pg info` -- detail on the group holding the active pane.
4. `##lane list` -- the lanes that tile the tab and the panes they contain.

**Key takeaway:** Tabs are made of lanes containing flex-weighted pane groups, inspectable via `##pg` and `##lane`.

---

### Story 22: Layout Tree (##pg layout)
**Duration:** 40s  
**Hook:** "See your whole tab at once -- ##pg layout draws the entire structure as a tree."  
**What to show:**
1. Start `rysh` and build depth: `Ctrl+P n`, then `v`, then `s`.
2. `##pg layout` -- the full tree of lanes, groups, and stacked panes.
3. `##pg info` -- drill into just the active pane's group.

**Key takeaway:** `##pg layout` prints the entire tab structure -- lanes to groups to stacked panes -- as one tree.

---

## Group 6: Layout & Resize (stories 23-26)

### Story 23: Layout Mode (Ctrl+L)
**Duration:** 45s  
**Hook:** "Ctrl+L is where you shape your workspace -- resize, equalize, swap, and fullscreen."  
**What to show:**
1. Start `rysh` and `Ctrl+P n` a couple of times for columns.
2. Press `Ctrl+L` to enter layout mode (footer lists the keys).
3. Arrow keys resize the active pane (`Right`/`Left` width, `Up`/`Down` height).
4. Press `=` to equalize widths, `m` to fullscreen.
5. Press `m` again to restore, then `Esc` to exit.

**Key takeaway:** Layout mode (`Ctrl+L`) is the hub for resizing, equalizing, swapping, and fullscreening panes.

---

### Story 24: Resizing Panes
**Duration:** 40s  
**Hook:** "Give the important pane more room -- arrow keys in layout mode flex the space."  
**What to show:**
1. Start `rysh`, `Ctrl+P n` then `Ctrl+P v` for a column plus a row.
2. Press `Ctrl+L` to enter layout mode.
3. `Right`/`Left` grow and shrink width; neighbors trade flex weight.
4. `Up`/`Down` adjust height within the column, staying proportional.
5. Press `Esc` when it looks right.

**Key takeaway:** In layout mode the arrow keys flex pane size -- width with Left/Right, height with Up/Down.

---

### Story 25: Equalize, Swap & Fullscreen
**Duration:** 45s  
**Hook:** "Three quick moves to reset chaos: equalize, swap lanes, and go fullscreen."  
**What to show:**
1. Start `rysh`, split into columns, and grow one pane wide for an uneven layout.
2. In layout mode press `h` or `=` to equalize widths.
3. Press `v` to equalize heights.
4. Press `s` to swap lane positions.
5. Press `m` to fullscreen the active pane (same as `Alt+P f`); press again to restore.

**Key takeaway:** Layout mode resets layouts fast -- `h`/`=` and `v` equalize, `s` swaps lanes, `m` fullscreens.

---

### Story 26: Navigate Mode (Ctrl+Space)
**Duration:** 40s  
**Hook:** "Move by direction, not by order -- Ctrl+Space lets you focus panes with arrows."  
**What to show:**
1. Start `rysh` and build a grid: `Ctrl+P n` then `Ctrl+P v`.
2. Press `Ctrl+Space` to enter navigate mode.
3. Arrow keys or `h`/`j`/`k`/`l` move focus by direction to the pane that's there.
4. Press `Esc` to leave with that pane focused, then type into it.

**Key takeaway:** Navigate mode (`Ctrl+Space`) focuses panes directionally with `hjkl`/arrows, unlike `Tab`'s cyclic order.

---
## Group 7: Navigation & Mouse (stories 27-29)

### Story 27: Pane & Tab Navigation
**Duration:** 45s  
**Hook:** "Move through your workspace without lifting your hands from the keyboard."  
**What to show:**
1. Launch rysh, split a pane (`Ctrl+P n`) and open a new tab (`Ctrl+T n`).
2. Cycle panes with `Tab`, and step between them with `Alt+Up` / `Alt+Down`.
3. Switch tabs with `[` / `]` and `Alt+Left` / `Alt+Right`.
4. Show the macOS-friendly `Alt+B` / `Alt+F` for previous / next tab.

**Key takeaway:** Two key habits -- one for panes, one for tabs -- cover all of workspace navigation.

---

### Story 28: Scrollback & Scrolling
**Duration:** 40s  
**Hook:** "Long output scrolls off the top? Walk back through every line."  
**What to show:**
1. Launch rysh and flood the pane with output (`seq 1 200`).
2. Page through history with `PageUp` / `PageDown`.
3. Nudge line-by-line with `Shift+Up` / `Shift+Down`.
4. Jump to the top with `Home` and back to the live prompt with `End`.

**Key takeaway:** Each pane keeps its own scrollback, navigable by page, line, top, or bottom.

---

### Story 29: Mouse Support
**Duration:** 40s  
**Hook:** "Keyboard-first, but the mouse is right there when you want it."  
**What to show:**
1. Launch rysh and split into two panes; click a pane to focus it.
2. Explain click-drag selection and that releasing copies to the clipboard.
3. Show wheel scrolling through the scrollback (3 lines per step).
4. Recap: click to focus, drag to select, release to copy, wheel to scroll.

**Key takeaway:** Full mouse support -- focus, select-and-copy, and scroll -- complements the keyboard.

---

## Group 8: Grid & Bulk Ops (stories 30-33)

### Story 30: Instant Grids (##new grid)
**Duration:** 50s  
**Hook:** "Spin up a whole grid of agent panes with a single command."  
**What to show:**
1. Launch rysh and enter rysh mode (double-Escape to `##`).
2. `##new grid 4` -- stack four panes into the current lane.
3. `##new grid 3x4` -- three lanes, each with four panes.
4. `##new grid 2x3x4` -- two tabs, each with three lanes of four panes.

**Key takeaway:** `##new grid` builds one-, two-, or three-dimensional pane layouts in a single command.

---

### Story 31: Stacks & Pane Groups (##new)
**Duration:** 40s  
**Hook:** "The new command isn't just grids -- it builds any piece of layout."  
**What to show:**
1. Enter rysh mode and run `##new stack 3` to deck three stacked panes.
2. `##new pg 2` to create pane groups (columns).
3. `##new pane` to add a single pane, optionally targeting a tab and lane.
4. `##new tab` to open a fresh tab.

**Key takeaway:** One `##new` verb creates every structural building block: stacks, groups, panes, and tabs.

---

### Story 32: Batch Commands (##cmd)
**Duration:** 45s  
**Hook:** "Run the same command across every pane in a scope at once."  
**What to show:**
1. Build a few panes (`##new grid 3`).
2. `##cmd stack pwd` -- run a command in every pane of the stack.
3. Show the scope range: pane / pg / stack / lane / tab / ws.
4. Use selectors `--tab` / `--lane` / `--pg` / `--pane` to target precisely.

**Key takeaway:** `##cmd <scope> <command>` fans one shell command out across every pane in the chosen scope.

---

### Story 33: Lanes (##lane / ##new lane)
**Duration:** 40s  
**Hook:** "Lanes are the columns that organize your panes -- manage them directly."  
**What to show:**
1. `##new lane` adds a new column to the tab.
2. `##lane list` shows every lane in the active tab.
3. `##lane info` details the lane holding the active pane.
4. `##lane name` labels a lane, and `##lane delete` removes one.

**Key takeaway:** Lanes give a tab horizontal structure, and the `##lane` commands list, inspect, name, and delete them.

---

## Group 9: Input Modes (stories 34-38)

### Story 34: Four Input Modes
**Duration:** 50s  
**Hook:** "One pane, four modes. Double-Escape cycles through them all."  
**What to show:**
1. Land in shell mode (`>`) and run a command.
2. Double-Escape to prompt mode (`<`), the AI agent stream.
3. Double-Escape to rysh mode (`##`); run `##help`.
4. Double-Escape to chat mode (`@`), then once more back to shell.

**Key takeaway:** Every pane has four input modes -- shell, prompt, rysh, chat -- each with its own marker and output stream, cycled by double-Escape.

---

### Story 35: Shell Mode
**Duration:** 40s  
**Hook:** "Shell mode is a real terminal -- full color, full ANSI, nothing held back."  
**What to show:**
1. Launch rysh in shell mode (`>` marker).
2. Run `ls -la` in the pane's PTY-backed shell.
3. Run `git status` to show color and ANSI passing through untouched.
4. Show pipes and env vars (`echo $SHELL && uname -a`).

**Key takeaway:** Shell mode runs commands in a full PTY-backed shell with complete color and ANSI fidelity.

---

### Story 36: Prompt Mode AI
**Duration:** 50s  
**Hook:** "Prompt mode turns your pane into an AI agent that sees your terminal."  
**What to show:**
1. Run a command for context, then double-Escape to prompt mode (`<`).
2. Note the LLM provider: Claude API or the claude CLI.
3. Ask "explain what this directory contains"; response renders as markdown.
4. Follow up naturally; press Escape to return to shell.

**Key takeaway:** Prompt mode sends input to the LLM provider with terminal context and 40+ tools, rendering markdown responses in the pane's AI stream.

---

### Story 37: Rysh Mode (## commands)
**Duration:** 40s  
**Hook:** "Hash-hash is rysh mode -- the control panel for your whole workspace."  
**What to show:**
1. Enter rysh mode (`##`); explain output injects into the active pane.
2. Run `##help` to list every system command.
3. Run `##pane info` and `##tab list` as examples.
4. Clarify that `##>` lines are pipeline events to NATS, not commands.

**Key takeaway:** Rysh mode runs `##` system commands to drive the multiplexer, while `##>` lines are pipeline events instead.

---

### Story 38: Chat Mode
**Duration:** 40s  
**Hook:** "The at-sign prompt is chat mode -- a conversation lane separate from prompt mode."  
**What to show:**
1. Launch rysh and cycle (double-Escape) around to chat mode (`@`).
2. Send a message to AI chat.
3. Note that chat keeps its own per-mode buffer, distinct from prompt mode.
4. Double-Escape back to shell.

**Key takeaway:** Chat mode (`@`) is a separate AI conversation stream with its own per-mode buffer, distinct from prompt mode.

---
## Group 10: System Commands (stories 39-41)

### Story 39: Help & History
**Duration:** 40s  
**Hook:** "Forget a command? Rysh tells you. ##help lists everything, ##history recalls what you typed."  
**What to show:**
1. Launch rysh and run a couple of shell commands (`ls -la`, `pwd`) to build history.
2. Double-Escape into rysh mode (prompt becomes `##`).
3. Run `##help` to list every built-in system command.
4. Run `##history` (alias `##h`) to show the current input mode's command history.

**Key takeaway:** `##help` and `##history` are your in-pane reference and recall for every system command.

---

### Story 40: Inspecting Your Workspace
**Duration:** 45s  
**Hook:** "Lost track of your layout? A handful of ## commands map your entire workspace."  
**What to show:**
1. Launch rysh and split a pane with `Ctrl+P n` to create structure.
2. Double-Escape into rysh mode.
3. Run `##pane info` for the active pane's id, mode, name, and status.
4. Run `##tab list` and `##lane list` to enumerate tabs and columns.
5. Run `##pg list`, then `##pg layout` to print the full tab tree (lanes -> groups -> stacked panes).

**Key takeaway:** A short set of `##` introspection commands reveals your whole workspace structure at a glance.

---

### Story 41: Snapshots & Clipboard
**Duration:** 45s  
**Hook:** "Grab a pane's output to your clipboard -- raw for you, redacted for sharing."  
**What to show:**
1. Launch rysh and produce buffer output (`env | head -n 5`).
2. Double-Escape into rysh mode.
3. Run `##snap` (alias `##snap private`) to copy the raw buffer to the clipboard.
4. Run `##snap public` to copy the redacted buffer, with secrets stripped.
5. Show `##private pane print` and `##public pane print` to view raw vs redacted output inline.

**Key takeaway:** Snapshots copy or print pane output either raw for yourself or redacted for safe sharing.

---

## Group 11: Interactive Terminal (stories 42-45)

### Story 42: Running Vim & Htop
**Duration:** 50s  
**Hook:** "vim, htop, less, nano -- full-screen programs just work, right inside a Rysh pane."  
**What to show:**
1. Launch rysh; a pane is a full PTY-backed shell.
2. Open `vim hello.go` -- the alternate screen triggers automatic raw mode.
3. Insert text, then `:wq` to save and quit.
4. Run `htop`; the vt10x emulator renders the live process view.
5. Press `q` to quit back to the shell.

**Key takeaway:** Interactive, alternate-screen programs run seamlessly in a pane with no configuration.

---

### Story 43: Raw Mode & Escape Hatch
**Duration:** 45s  
**Hook:** "In raw mode every key goes to the program. Ctrl+O is your escape hatch back to Rysh."  
**What to show:**
1. Launch rysh and open `vim notes.txt`, entering raw mode automatically.
2. Show that all keys (Tab, brackets, Escape) are forwarded straight to vim.
3. Press `Ctrl+O` to reach prefix mode -- the one reserved escape hatch.
4. From prefix mode, note `d` detaches or any other key cancels back into the program.
5. Quit vim with `:q!`.

**Key takeaway:** Raw mode forwards every keystroke to the program, while `Ctrl+O` always reaches Rysh's prefix mode.

---

### Story 44: Toggling Raw Mode (##raw)
**Duration:** 35s  
**Hook:** "Need raw mode without an interactive program? ##raw flips it on and off by hand."  
**What to show:**
1. Launch rysh and double-Escape into rysh mode.
2. Run `##raw` to manually turn raw mode on (keystrokes forwarded as raw bytes).
3. Press `Ctrl+O` to step out to prefix mode.
4. Run `##raw` again to toggle raw mode back off.

**Key takeaway:** `##raw` gives you manual on/off control over raw mode for programs Rysh doesn't auto-detect.

---

### Story 45: PTY Resize
**Duration:** 40s  
**Hook:** "Resize the window and your programs follow -- SIGWINCH propagates and the emulator reflows."  
**What to show:**
1. Launch rysh and print the size with `echo cols=$(tput cols) rows=$(tput lines)`.
2. Split with `Ctrl+P n`, changing pane geometry and firing SIGWINCH.
3. Re-run the `tput` echo in the narrower pane to show the reduced column count.
4. Launch `htop` to show an interactive program reflowing, then `q` to quit.

**Key takeaway:** Window and pane resizes propagate SIGWINCH so shells and full-screen apps reflow live.

---

## Group 12: Voice (stories 46-47)

### Story 46: Voice Prompting (Ctrl+R)
**Duration:** 45s  
**Hook:** "Talk to your terminal. Press Ctrl+R, speak your prompt, and Rysh transcribes it for you."  
**What to show:**
1. Show the `[voice]` config block: `enabled = true`, `hotkey = "ctrl+r"`, `recorder = "auto"`.
2. Launch rysh in normal mode with voice enabled.
3. Narrate pressing `Ctrl+R` to start recording -- footer shows `● REC m:ss`.
4. Narrate pressing `Ctrl+R` again to stop and transcribe; text fills the input field.
5. Review and press `Enter` to submit (or `Esc` while recording to cancel).

**Key takeaway:** Voice prompting fills the input field via `Ctrl+R`, so it works anywhere typing does -- including remote-controlled panes.

---

### Story 47: Configuring Voice Providers
**Duration:** 40s  
**Hook:** "Deepgram or Whisper, sox or ffmpeg -- pick your transcription provider and recorder."  
**What to show:**
1. Show `[voice_control]` with `tts_provider_name = "deepgram"` (or `"whisper"`) and `api_key`.
2. Show `[voice]` `recorder = "auto"` (sox/ffmpeg/afrecord/arecord) and `max_seconds`.
3. Show env-var overrides like `RYSH_VOICE_CONTROL_API_KEY` and `RYSH_VOICE_RECORDER`.
4. Note the macOS Microphone permission requirement on first use.

**Key takeaway:** Choose the transcription provider and audio recorder via config or env vars, then grant mic access to start dictating.

---
## Group 13: Tools: File & Shell (stories 48-52)

### Story 48: The Agentic Toolbelt
**Duration:** 50s  
**Hook:** "Every prompt-mode pane carries 40+ tools -- files, git, code, tests, build, web, and cross-pane coordination."  
**What to show:**
1. Launch `rysh`; double-Esc to prompt mode (`<`).
2. Type a prompt asking the agent to list its tools (invokes `list_tools`, no approval).
3. Agent reports the categories: file & shell, git, code intelligence, testing/build, background, web, workspace awareness.
4. Narrate the rule: read-only tools run freely; writes, commits, and dangerous bash are approval-gated.

**Key takeaway:** Every prompt-mode pane is backed by an AgenticActor with 40+ tools, gated by an approval flow for anything destructive.

---

### Story 49: Reading & Searching Files
**Duration:** 45s  
**Hook:** "Point the agent at your code -- ls, file_read, glob, and grep find anything, no approval required."  
**What to show:**
1. Launch `rysh` in a project; double-Esc to prompt mode.
2. Prompt: "find all the TODO comments in this project."
3. Agent uses `grep` (regex), `glob` (`**` patterns), `ls`, `file_read`, and `tree` -- all read-only.
4. Results render in the pane with no approval prompt.

**Key takeaway:** The file-read toolset (`ls`, `file_read`, `glob`, `grep`, `tree`) lets the agent explore a whole codebase from a single natural-language request, with no approval needed.

---

### Story 50: Editing Files
**Duration:** 50s  
**Hook:** "When the agent edits a file, you see the diff first -- every write waits for your yes."  
**What to show:**
1. Launch `rysh`; in shell mode create a small sample file.
2. Double-Esc to prompt mode; ask the agent to change a line.
3. Agent picks `file_edit` (exact-string replace), `multi_edit` (atomic hunks), `file_write`, or `apply_patch` (unified diff) -- each generates a diff and requires approval.
4. Footer shows the diff preview; press `y` to approve (or `Y` approve-always, `n` reject, `N` reject-with-reason).

**Key takeaway:** All file-writing tools are approval-gated and show a diff preview, so nothing changes on disk until you confirm.

---

### Story 51: Running Bash
**Duration:** 40s  
**Hook:** "Ask in plain English, and the agent runs the shell for you -- dangerous patterns ask first."  
**What to show:**
1. Launch `rysh`; double-Esc to prompt mode.
2. Prompt: "what's my disk usage in this directory."
3. Agent calls the `bash` tool to run a real shell command and reads the output back.
4. Narrate: safe commands run; commands matching dangerous patterns require approval before executing.

**Key takeaway:** The `bash` tool turns natural language into real shell commands, with an approval gate on dangerous patterns.

---

### Story 52: Symbol Search & Code Intelligence
**Duration:** 40s  
**Hook:** "Ask where something is defined -- symbol_search and tree map your code instantly."  
**What to show:**
1. Launch `rysh` in a codebase; double-Esc to prompt mode.
2. Prompt: "where is the main function defined."
3. Agent uses `symbol_search` to locate declarations (functions, types) and `tree` for structure -- both read-only.
4. Agent returns the precise file and line with surrounding context.

**Key takeaway:** `symbol_search` and `tree` give conversational code intelligence -- a vague question becomes a precise file and line, no approval required.

---

## Group 14: Tools: Git/Build/Test (stories 53-56)

### Story 53: Git Tools
**Duration:** 45s  
**Hook:** "Summarize your changes and commit -- the agent reads git for free, but the commit waits for you."  
**What to show:**
1. Launch `rysh` in a git repo with uncommitted changes; double-Esc to prompt mode.
2. Prompt: "summarize my changes and commit them."
3. Agent calls `git_status`, `git_diff`, `git_log` (all read-only) to understand the changes, then drafts a message.
4. `git_commit` triggers an approval prompt showing the message; press `y` to commit (or `N` to reject with a reason).

**Key takeaway:** Git reads (`git_status`/`git_diff`/`git_log`) run instantly; only `git_commit` is approval-gated.

---

### Story 54: Building Your Project
**Duration:** 40s  
**Hook:** "Ask the agent to build -- it compiles, parses the errors, and fixes them."  
**What to show:**
1. Launch `rysh` in a buildable project; double-Esc to prompt mode.
2. Prompt: "build the project and fix any compile errors."
3. The `build` tool compiles and returns structured, parsed errors (file/line/message); no approval to build.
4. Any proposed code fix is a `file_edit`, which is approval-gated -- review the diff, approve, build again.

**Key takeaway:** The `build` tool returns structured errors the agent can act on; the build runs freely, but the fixes are approval-gated edits.

---

### Story 55: Running Tests
**Duration:** 45s  
**Hook:** "Run the tests and fix the failures -- test_run gives structured pass/fail the agent can act on."  
**What to show:**
1. Launch `rysh` in a project with tests; double-Esc to prompt mode.
2. Prompt: "run the tests and fix any failures."
3. The `test_run` tool executes the suite and returns structured pass/fail results; no approval to run.
4. Proposed fixes are approval-gated file edits; after approving, the agent reruns to confirm green.

**Key takeaway:** `test_run` provides structured pass/fail results so the agent can fix failures and re-verify, with edits gated by approval.

---

### Story 56: Linting
**Duration:** 40s  
**Hook:** "Lint and fix -- the agent runs go vet, staticcheck, and golangci-lint, then cleans up."  
**What to show:**
1. Launch `rysh` in a Go project; double-Esc to prompt mode.
2. Prompt: "lint this project and fix the warnings."
3. The `lint` tool runs go vet, staticcheck, and golangci-lint and returns each finding; no approval to lint.
4. Fixes are approval-gated file edits; after approving, the agent re-lints to verify.

**Key takeaway:** The `lint` tool runs the standard Go linters and the agent fixes findings, with edits gated by approval.

---

## Group 15: Tools: Background & Web (stories 57-60)

### Story 57: Background Bash
**Duration:** 45s  
**Hook:** "Long-running jobs don't block the agent -- bash_background returns a session id and keeps running."  
**What to show:**
1. Launch `rysh`; double-Esc to prompt mode.
2. Prompt: "start a long-running command in the background."
3. The `bash_background` tool launches it and returns a session id; starting it is approval-gated -- press `y`.
4. Narrate: output is captured in a 256KB ring buffer; the session persists until killed or the pane closes.

**Key takeaway:** `bash_background` runs long-lived jobs (dev servers, watchers) off the main loop, returning a session id, with a 256KB ring buffer for output.

---

### Story 58: Reading Background Output / Killing
**Duration:** 40s  
**Hook:** "Check on a background job with bash_output, and shut it down with kill_shell."  
**What to show:**
1. Launch `rysh` (a background session already running); double-Esc to prompt mode.
2. Prompt: "list my background sessions and show their latest output" -- `bash_output` reads the ring buffer or lists sessions (no approval).
3. Prompt: "kill that background session" -- `kill_shell` terminates it and returns the final output.
4. `kill_shell` is approval-gated; press `y` to confirm.

**Key takeaway:** `bash_output` reads or lists background sessions freely; `kill_shell` terminates and returns final output but is approval-gated.

---

### Story 59: Web Search
**Duration:** 40s  
**Hook:** "Ask the agent to search the web -- web_search hits the Brave Search API, no approval needed."  
**What to show:**
1. Launch `rysh` (with `brave_api_key` set); double-Esc to prompt mode.
2. Prompt: "search the web for the latest Go release version."
3. The `web_search` tool queries the Brave Search API and the agent summarizes results in the pane; read-only, no approval.
4. Narrate: web_search is enabled only when `brave_api_key` (or `RYSH_BRAVE_API_KEY`) is configured.

**Key takeaway:** `web_search` brings live internet results into any pane via the Brave Search API, enabled by `brave_api_key`, with no approval required.

---

### Story 60: Web Fetch
**Duration:** 40s  
**Hook:** "Point the agent at a URL -- web_fetch pulls the page and summarizes it for you."  
**What to show:**
1. Launch `rysh`; double-Esc to prompt mode.
2. Prompt: "fetch <URL> and summarize what the page is about."
3. The `web_fetch` tool pulls the URL's content and the agent distills it; read-only, no approval.
4. Narrate: pairs with `web_search` so the agent can find a source, open it, and bring details back.

**Key takeaway:** `web_fetch` pulls a URL's content for the agent to summarize, pairing with `web_search` to research from inside your terminal -- no approval required.

---
## Group 16: Approval & Safety (stories 61-64)

### Story 61: Tool Approval Flow
**Duration:** 50s  
**Hook:** "Your AI agent never touches a file or runs a destructive command without your say-so."  
**What to show:**
1. Launch `rysh` and double-press Escape into prompt mode.
2. Ask the agent to edit a file (e.g. "add a comment to the top of README.md").
3. The footer displays the pending action and a diff preview before anything is written.
4. Press `y` to approve -- the edit applies and the agent continues; `n` would cancel it.
5. Note which tools are gated: file_edit, file_write, multi_edit, apply_patch, git_commit, and dangerous bash; reads and searches run freely.

**Key takeaway:** Destructive or file-mutating tools always pause for your approval, with a diff preview, before they run.

---

### Story 62: Approve Always & Reject With Reason
**Duration:** 45s  
**Hook:** "Approve once and forever, or reject with a reason the agent can learn from."  
**What to show:**
1. In prompt mode, ask the agent to create a file so an approval prompt appears.
2. Press capital `Y` to approve always -- Rysh remembers the decision and won't re-ask for that action.
3. Trigger a second, riskier action (e.g. "delete that file").
4. Press capital `N` to reject with a reason, type the reason, and press Enter -- the agent adapts.
5. Recap the keys: `y` approve, `Y` approve-always, `n` reject, `N` reject-with-reason, `Esc` reject silently.

**Key takeaway:** Approval is fast and expressive -- remember a yes, or reject with feedback the agent uses to change course.

---

### Story 63: Loop Detection & Last-Prompt-Wins
**Duration:** 45s  
**Hook:** "Runaway agents get stopped, and a new prompt always interrupts the old one."  
**What to show:**
1. In prompt mode, kick off a large task that makes many tool calls.
2. The orchestrator tracks a sliding window of the last 20 tool calls.
3. Send a new prompt mid-run -- the in-flight LLM call is cancelled immediately ("last-prompt-wins").
4. Explain loop detection: after 3 identical tool invocations in the window, the call is blocked.

**Key takeaway:** Rysh prevents infinite loops and keeps the agent interruptible -- your latest prompt always takes over.

---

### Story 64: Approval Panes
**Duration:** 40s  
**Hook:** "Route every approval request to one dedicated pane and triage them in one place."  
**What to show:**
1. Launch `rysh` and split a second pane with `Ctrl+P n`.
2. In rysh mode, run `##pane approval-pane approvals` to register it as the approval pane.
3. Tool requests from other panes now surface here.
4. Use `##pane approval-pane list` to see pending items and `enable-attention` for a notification indicator.
5. Run `##pane approval-pane clear` to empty the queue.

**Key takeaway:** An approval pane centralizes every gated action so you decide from one place without switching focus.

---

## Group 17: Context & Memory (stories 65-68)

### Story 65: Context Store
**Duration:** 45s  
**Hook:** "Give your agent a memory that survives across the whole session."  
**What to show:**
1. Launch `rysh` and switch to prompt mode.
2. Tell the agent to remember a fact (e.g. a staging DB host and port) -- the `context_store` tool writes key-value data to JetStream KV.
3. In a later turn, ask the agent to recall it.
4. The value is read back from the store without re-explaining.

**Key takeaway:** `context_store` is durable, session-wide key-value memory any prompt can read and write.

---

### Story 66: Project Notes
**Duration:** 40s  
**Hook:** "A shared scratchpad your agent reads and writes for the whole project."  
**What to show:**
1. Launch `rysh` and switch to prompt mode.
2. Ask the agent to record a project decision -- the `project_notes` tool appends it to `.rysh-notes.md`.
3. Back in shell mode, `cat .rysh-notes.md` to show the plain markdown file.
4. Note it can be edited and committed alongside your code.

**Key takeaway:** `project_notes` is file-backed memory in `.rysh-notes.md` that every pane and agent on the project shares.

---

### Story 67: Todo Lists
**Duration:** 40s  
**Hook:** "Watch your agent break a big job into tracked, checkable steps."  
**What to show:**
1. Launch `rysh` and switch to prompt mode.
2. Hand the agent a multi-step task and ask it to plan it as a todo list.
3. The `todo` tool adds items, then updates and completes them as work proceeds.
4. Note the list is stored per-pane in JetStream KV (add/update/complete/remove).

**Key takeaway:** The `todo` tool gives the agent a per-pane checklist so long, multi-step work stays organized and visible.

---

### Story 68: Conversation History & Memory
**Duration:** 45s  
**Hook:** "Recall any pane's conversation, and let old turns compact into summaries."  
**What to show:**
1. Launch `rysh` and split a second pane so there are two agents with separate conversations.
2. From prompt mode, ask the agent to retrieve the other pane's conversation -- the `session_history` tool reads any pane's turns.
3. In rysh mode, run `##pane history prompt` to print this pane's own history.
4. Explain memory compaction: old turns fold into compact MemoryEntry summaries to keep context small.

**Key takeaway:** `session_history` exposes any pane's conversation, and memory compaction keeps long sessions lean.

---

## Group 18: Cross-Pane Coordination (stories 69-72)

### Story 69: Pane Listening
**Duration:** 50s  
**Hook:** "Pipe one pane's live output straight into another -- secrets redacted automatically."  
**What to show:**
1. Launch `rysh` and split a second pane with `Ctrl+P n`.
2. In the source pane, run `##pane name builder` to give it an alias.
3. In the other pane, run `##pane listen builder` -- the builder's shared output now flows in, prefixed `[builder]`.
4. Run a command in the builder; its output appears live in the listener, with secrets redacted first.
5. Run `##pane unlisten` to stop.

**Key takeaway:** `##pane listen` forwards another pane's redacted output in real time so panes stay aware of each other.

---

### Story 70: Inspecting & Sending Across Panes
**Duration:** 45s  
**Hook:** "Your agent can read another pane's state and even type into it -- with approval."  
**What to show:**
1. Launch `rysh` and split a second pane.
2. In prompt mode, ask the agent to list panes -- the `agents_list` tool shows every pane and its status.
3. Ask it to inspect the other pane -- `pane_inspect` reads that pane's state and recent output.
4. Ask it to send a command to the other pane -- `pane_send` injects input and requires approval; press `y`.

**Key takeaway:** `pane_inspect`, `pane_send`, and `agents_list` let an agent observe and act on other panes, with cross-pane writes gated by approval.

---

### Story 71: The Hop Command
**Duration:** 50s  
**Hook:** "Hop a pane's output into another and let a fresh agent pick up right where you left off."  
**What to show:**
1. Launch `rysh` and split a target pane; name it with `##pane name reviewer`.
2. In the source pane, generate some output, then run `##hop reviewer` to transfer this pane's output to the reviewer.
3. Run `##hop status` to confirm the hop state.
4. In the reviewer pane, run `##hop resume` -- the agent continues with the copied text.
5. Run `##hop clear` to wipe the hopped content.

**Key takeaway:** `##hop` hands a pane's output to another pane so a fresh agent can resume the work seamlessly.

---

### Story 72: Cross-Pane AI Workflows
**Duration:** 40s  
**Hook:** "Combine listening, inspection, and sending to solve problems across many panes at once."  
**What to show:**
1. Launch `rysh` and create a couple of panes -- e.g. a server pane and a coordinator pane.
2. From the coordinator, the agent uses `agents_list` and `pane_inspect` to survey every pane's state.
3. It identifies a failing pane and uses `pane_send` to apply a fix there; approve with `y`.
4. One prompt drives a full multi-pane investigation and fix.

**Key takeaway:** Listening, inspection, and sending combine into coordinated multi-pane AI workflows from a single prompt.

---
## Group 19: Autonomous Agents (stories 73-78)

### Story 73: What Are Autonomous Agents?
**Duration:** 50s  
**Hook:** "Headless AI workers. No terminal, no pane -- just a brain with tools."  
**What to show:**
1. Launch `rysh`; explain every pane is shell + agent, but autonomous agents are headless.
2. Double-Escape into rysh mode (`##` prompt).
3. `##agent spawn code-reviewer "You review code for quality, correctness, and best practices."` -- no PTY, its own AgenticActor.
4. `##agent list` shows each agent and its status.
5. `@code-reviewer summarize what a good code review checks for` -- prompt it with the `@name` prefix; it runs with full tool access in the background.

**Key takeaway:** Autonomous agents are headless actors with their own AgenticActor -- created with `##agent spawn`, prompted with `@name`, controlled with `@@name`.

---

### Story 74: Spawning an Agent
**Duration:** 45s  
**Hook:** "One command, one prompt, and your agent is alive."  
**What to show:**
1. Launch `rysh`; double-Escape into rysh mode.
2. `##agent spawn code-reviewer "You are a meticulous code reviewer focused on bugs and clarity."` -- the system prompt defines the agent's job.
3. `##agent spawn test-writer "You write thorough unit tests for Go code."` -- spawn as many as you need.
4. `##agent list` shows both agents with status (active / deactivated / working).

**Key takeaway:** `##agent spawn <name> <system-prompt>` creates an agent inline, and `##agent list` shows every agent's status.

---

### Story 75: Skill Files
**Duration:** 50s  
**Hook:** "Define an agent once in a file -- name, model, and system prompt -- then spawn it anywhere."  
**What to show:**
1. Launch `rysh`; create `.rysh/agents/reviewer/SKILL.md` with YAML frontmatter (`name`, `description`, `model`) and a prompt body.
2. `cat .rysh/agents/reviewer/SKILL.md` -- show the `---` frontmatter then the body; no frontmatter means the whole file is the prompt and the name comes from the filename.
3. Double-Escape into rysh mode; `##agent spawn .rysh/agents/reviewer/SKILL.md`.
4. `##agent list` confirms the agent was built entirely from the file.

**Key takeaway:** A skill file is markdown with optional YAML frontmatter (`name`/`description`/`model`) plus a system-prompt body, making agents reusable and version-controlled.

---

### Story 76: Spawning From a Directory
**Duration:** 40s  
**Hook:** "A folder of skill files becomes a whole team of agents in one command."  
**What to show:**
1. Launch `rysh`; create `.rysh/agents/reviewer.md` and `.rysh/agents/tester.md`, each describing one agent.
2. Double-Escape into rysh mode; `##agent spawn-all .rysh/agents` -- one agent per `.md` file.
3. `##agent list` shows the full roster.

**Key takeaway:** `##agent spawn-all <directory>` creates one agent per `.md` file, bootstrapping a whole team from one folder.

---

### Story 77: Talking To & Controlling Agents
**Duration:** 45s  
**Hook:** "@name to prompt it, @@name to command it."  
**What to show:**
1. Launch `rysh`; double-Escape into rysh mode; spawn `code-reviewer`.
2. `@code-reviewer what are the top three things you check in a pull request?` -- single `@` sends a prompt.
3. `@@code-reviewer deactivate` -- double `@@` sends a control command; deactivate keeps state but ignores prompts.
4. `@@code-reviewer activate` -- bring it back.
5. `##agent delete code-reviewer` -- remove it entirely.

**Key takeaway:** `@name <prompt>` prompts an agent; `@@name <stop|activate|deactivate>` controls it; `##agent delete` removes it.

---

### Story 78: Routing Agent Output
**Duration:** 40s  
**Hook:** "Send a headless agent's replies straight into a pane you can watch."  
**What to show:**
1. Launch `rysh`; double-Escape into rysh mode; `##pane name review-feed`.
2. `##agent spawn code-reviewer "You review code and report findings clearly."` -- output normally stays in the background.
3. `##agent register-output code-reviewer review-feed` -- replies land in that pane's chat buffer.
4. `##agent unregister-output code-reviewer review-feed` -- stop routing; the agent keeps running.

**Key takeaway:** `##agent register-output <agent> <pane>` routes a headless agent's output into a pane's chat buffer; `unregister-output` stops it.

---

## Group 20: Humanoids (stories 79-84)

### Story 79: What Are Humanoids?
**Duration:** 50s  
**Hook:** "An agent that talks to the outside world -- WhatsApp, Slack, email, phone, chat."  
**What to show:**
1. Launch `rysh`; explain a humanoid is an agent plus bidirectional external channels (inbound message -> prompt -> reply via channel).
2. Double-Escape into rysh mode.
3. `##humanoid spawn support "You are a friendly customer support agent. Answer questions clearly."`.
4. `##humanoid list` shows status and connected channels.
5. `@support how would you greet a new customer?` -- talk to it directly, exactly like any agent.

**Key takeaway:** Humanoids are autonomous agents with external channels (whatsapp/slack/email/phone/chatbot); inbound messages become prompts and replies return through the channel.

---

### Story 80: Spawning a Humanoid
**Duration:** 45s  
**Hook:** "Inline prompt or a skill file with a contacts block -- either way, it's one command."  
**What to show:**
1. Launch `rysh`; mention the inline `##humanoid spawn support "..."` form.
2. Write `.rysh/humanoids/support.md` with `name`/`description`/`model` and a `contacts.slack` block (`bot_token`, `app_token`, `channels`).
3. `cat` it -- the `contacts:` section extends the agent format; `${ENV_VAR}` resolves secrets at parse time.
4. Double-Escape into rysh mode; `##humanoid spawn .rysh/humanoids/support.md`.
5. `##humanoid list` shows it running with its Slack channel.

**Key takeaway:** A humanoid skill file adds a `contacts:` YAML section to the agent format, with `${ENV_VAR}` secrets resolved at parse time.

---

### Story 81: Slack Channel
**Duration:** 45s  
**Hook:** "Drop your humanoid into Slack and let it answer threads on its own."  
**What to show:**
1. Launch `rysh`; write/show a skill file with `contacts.slack` (`bot_token`, `app_token`, `channels`) using `${ENV_VAR}` tokens.
2. Double-Escape into rysh mode; `##humanoid spawn .rysh/humanoids/support.md`.
3. `##humanoid channel start support slack` -- start the Slack adapter explicitly.
4. `##humanoid channels support` -- show connection details and which channels it joined.

**Key takeaway:** Configure `contacts.slack` with bot/app tokens and channels, then `##humanoid channel start <name> slack`; inspect with `##humanoid channels <name>`.

---

### Story 82: Email Channel
**Duration:** 45s  
**Hook:** "Give your humanoid an inbox -- it reads incoming mail and writes the replies."  
**What to show:**
1. Launch `rysh`; write/show a skill file with `contacts.email` (`address`, `imap_host`/`imap_port`, `smtp_host`/`smtp_port`, `username`/`password` as `${ENV_VAR}`).
2. Double-Escape into rysh mode; `##humanoid spawn .rysh/humanoids/support.md` -- gains email_list / email_read / email_send tools.
3. `##humanoid channel start support email` -- begins polling the inbox, replying via SMTP.
4. `##humanoid channels support` -- confirm the inbox is live.

**Key takeaway:** `contacts.email` configures IMAP (read) and SMTP (send); the humanoid uses email_list/email_read/email_send and `##humanoid channel start <name> email` to go live.

---

### Story 83: WhatsApp & Phone Channels
**Duration:** 45s  
**Hook:** "WhatsApp Cloud API and Twilio phone -- your humanoid reaches everyone's pocket."  
**What to show:**
1. Launch `rysh`; write/show a skill file with `contacts.whatsapp` (`phone`, `api_key`, `business_id` -- Cloud API) and `contacts.phone` (`number`, `provider: twilio`, `account_sid`, `auth_token`), all secrets via `${ENV_VAR}`.
2. Double-Escape into rysh mode; `##humanoid spawn .rysh/humanoids/support.md`.
3. `##humanoid channel start support whatsapp` and `##humanoid channel start support phone`.
4. `##humanoid channels support` lists both channels, now live.

**Key takeaway:** WhatsApp uses the Cloud API and phone uses Twilio; both are configured in `contacts` with `${ENV_VAR}` secrets and started/stopped per channel type.

---

### Story 84: Humanoids vs Agents
**Duration:** 40s  
**Hook:** "Same brain, same skill format -- agents face inward, humanoids face the world."  
**What to show:**
1. Launch `rysh`; double-Escape into rysh mode.
2. `##agent spawn worker "You are an internal task worker."` -- an internal worker, no external reach.
3. `##humanoid spawn support "You are an external-facing support agent."` -- the same agent plus external channels, same skill format with a `contacts` block.
4. `@@worker deactivate` and `@@support deactivate` -- `@`/`@@` work for both; Rysh resolves the name across both registries.

**Key takeaway:** Agents are internal workers; humanoids are external-facing; they share the same skill format (plus `contacts:` for humanoids) and the same `@`/`@@` interaction.

---
## Group 21: Pipelines & Events (stories 85-89)

### Story 85: Pipeline Mode
**Duration:** 45s  
**Hook:** "A tab can become a pipeline. One key flips it on and your events start flowing."  
**What to show:**
1. Launch `rysh`.
2. Press `Ctrl+P` then `p` to toggle pipeline mode for the active tab.
3. Double-Escape into rysh mode and run `##tab pipeline enable` to turn it on explicitly.
4. Run `##tab list` to confirm the tab is pipeline-enabled.
5. Run `##tab pipeline disable` (or double-Escape, which toggles pipeline mode off).

**Key takeaway:** Pipeline mode is the per-tab on-switch for event-driven orchestration, toggled by `Ctrl+P p`, `##tab pipeline enable/disable`, or double-Escape.

---

### Story 86: Loading & Running Pipelines (##pipe)
**Duration:** 50s  
**Hook:** "Define a pipeline in a file, load it, run it -- ##pipe drives the whole lifecycle."  
**What to show:**
1. Launch `rysh` and double-Escape into rysh mode.
2. Run `##pipe help` to see all pipeline subcommands.
3. `##pipe load build.pipeline` reads the file from `.rysh/pipelines`.
4. `##pipe list` shows loaded pipelines; `##pipe show build` prints its details.
5. `##pipe run build` executes it (defaults to the first loaded pipeline if no name).
6. `##pipe status` reports phase-by-phase progress; `##pipe clear` wipes output.

**Key takeaway:** `##pipe` loads pipelines from `.rysh/pipelines`, then list, show, run, status, and clear manage their full lifecycle.

---

### Story 87: Pipeline Events (##>)
**Duration:** 45s  
**Hook:** "Lines starting with double-hash-greater-than bypass the shell and fly straight to NATS."  
**What to show:**
1. Launch `rysh` and split a worker pane with `Ctrl+P n`.
2. In the worker's rysh mode, run `##pane listen orchestrator` to forward the source pane's shared output.
3. `Tab` to the orchestrator pane and double-Escape into rysh mode.
4. Emit `##>event:print:Build started at 10:30 AM` -- it bypasses the PTY and publishes to the pane's NATS output topic.
5. Emit `##>event:print:Compiling module auth`; the payload reaches listeners without an alias prefix.

**Key takeaway:** `##>` lines are pipeline events that skip the PTY and publish clean lines to NATS, visible to every listening pane.

---

### Story 88: The Softdev Pipeline
**Duration:** 50s  
**Hook:** "One event line can trigger an AI agent to plan, build, lint, and test -- automatically."  
**What to show:**
1. Launch `rysh`, split a worker pane, and have it `##pane listen orchestrator`.
2. `Tab` back to the orchestrator and double-Escape into rysh mode.
3. Fire `##>event:ai:softdev:golang:planning` -- triggers the worker's AgenticActor to analyze and plan.
4. Fire `##>event:sh:softdev:golang:development` -- runs `go build ./...` on the listening pane.
5. Fire `##>event:ai:softdev:golang:unit_testing` -- the agent runs tests and fixes failures.

**Key takeaway:** Softdev events follow `ai|sh:softdev:<lang>:<phase>` across phases (planning, development, linting, unit_testing, integration_testing, deployment, monitoring) -- `ai:` drives the AgenticActor, `sh:` runs commands.

---

### Story 89: Pipeline Placeholders
**Duration:** 40s  
**Hook:** "Placeholders are lanes reserved for pipeline output -- name them, add them, watch results land."  
**What to show:**
1. Launch `rysh` and double-Escape into rysh mode.
2. `##pipe name release-flow` labels the current pipeline.
3. `##pipe placeholder add` creates a new placeholder lane for pipeline output.
4. Add another, then `##pipe placeholder list` shows every placeholder defined.

**Key takeaway:** Placeholders are named lanes that receive pipeline output, managed with `##pipe placeholder add/list` and labeled via `##pipe name`.

---

## Group 22: Collaboration & Sharing (stories 90-94)

### Story 90: Sharing a Pane
**Duration:** 50s  
**Hook:** "One command publishes a live pane to your workspace -- teammates watch it in real time."  
**What to show:**
1. Launch `rysh` with an enabled `[upstream]` block.
2. Double-Escape into rysh mode and run `##share status` to check the upstream connection.
3. `##share pane view` publishes the pane; the ShareRegistry spawns an UpstreamShareActor that registers it on the server.
4. Back in shell mode, run `ls -la` so redacted output streams to subscribers.
5. `##share list` shows every active share with its share ID.

**Key takeaway:** `##share pane [view|control]` registers a pane on the upstream server via the ShareRegistry/UpstreamShareActor and streams its redacted output live.

---

### Story 91: View vs Control Mode
**Duration:** 45s  
**Hook:** "View lets them watch. Control lets them type. You decide at share time."  
**What to show:**
1. Launch `rysh` and double-Escape into rysh mode.
2. `##share pane view` -- the default; remote users observe but cannot send input.
3. `##unshare pane`, then `##share pane control` -- subscribers can send shell commands and prompts.
4. `##share status` reflects the current mode; control commands are validated server-side against a blocklist.
5. Note the default mode comes from `[upstream] default_share_mode`.

**Key takeaway:** Share mode is chosen per share -- `view` is read-only observation, `control` lets remote subscribers send input, validated against the command blocklist.

---

### Story 92: Sharing Groups, Lanes & Tabs
**Duration:** 45s  
**Hook:** "Share one pane, or a whole tab. Each level brings its children along."  
**What to show:**
1. Launch `rysh` and build a layout with `Ctrl+P n` and `Ctrl+P v`.
2. Double-Escape into rysh mode.
3. `##share panegroup control` shares the active group, including its stacked panes.
4. `##share lane view` shares the whole column -- all groups and panes in the lane.
5. `##share tab view` publishes the entire tab; `##share list` shows all shares together.

**Key takeaway:** Sharing works at four scopes -- `##share pane|panegroup|lane|tab` -- each automatically including its child panes.

---

### Story 93: Listing & Unsharing
**Duration:** 40s  
**Hook:** "See everything you're sharing, and pull any of it back with one command."  
**What to show:**
1. Launch `rysh`, double-Escape into rysh mode, and `##share pane control` to have an active share.
2. `##share list` shows every active share with its scope, mode, and share ID.
3. `##unshare pane` stops sharing the active pane (matching `panegroup|lane|tab` commands exist).
4. `##share list` again confirms the share is gone; the UpstreamShareActor is torn down and the server notified.

**Key takeaway:** `##share list` audits active shares and `##unshare pane|panegroup|lane|tab` revokes them, tearing down the UpstreamShareActor.

---

### Story 94: Secret Redaction
**Duration:** 45s  
**Hook:** "Your secrets never leave your machine -- redaction happens before output is shared."  
**What to show:**
1. Launch `rysh` and `echo API_KEY=sk-ant-secret-123456` to put a secret in the buffer.
2. Double-Escape into rysh mode and run `##private pane print` to show the raw buffer with the secret visible locally.
3. `##public pane print` shows the redacted version -- the same output the SharedOutputActor forwards upstream.
4. `##share pane view`; the SharedOutputActor redacts before output leaves the session, so the server never sees raw secrets.

**Key takeaway:** The SharedOutputActor redacts secrets before output leaves the local session -- `##public` shows what gets shared, and a command blocklist guards control-mode input.

---

## Group 23: Upstream & Remote (stories 95-98)

### Story 95: Connecting to Upstream
**Duration:** 50s  
**Hook:** "Point Rysh at a workspace URL and an API key -- now your session can join the hub."  
**What to show:**
1. `cat rysh.config` to show the `[upstream]` block: `enabled`, `url`, `api_key`.
2. Launch `rysh --shared` to auto-share the first pane on boot.
3. Double-Escape into rysh mode and run `##upstream status` to see config and live connection state.
4. `##upstream my-shares` lists what this session has published; the client connects over NATS-over-WebSocket to rysh-server.
5. Note env overrides: `RYSH_UPSTREAM_ENABLED`, `RYSH_UPSTREAM_URL`, `RYSH_UPSTREAM_API_KEY`.

**Key takeaway:** The `[upstream]` config (or env overrides plus `--shared`) connects a session to rysh-server over NATS-over-WebSocket, surfaced by `##upstream status`.

---

### Story 96: Subscribing to a Remote Share
**Duration:** 45s  
**Hook:** "Discover what your teammates are sharing, then subscribe to watch it live."  
**What to show:**
1. Launch `rysh` connected to a workspace and double-Escape into rysh mode.
2. `##upstream list-remote` queries the server for every share in the workspace.
3. `##upstream subscribe abc123 view` -- a RemoteShareListenerActor pipes the share's output into the local pane.
4. `##upstream my-shares` reflects connections plus anything you publish.
5. `##upstream unsubscribe` stops the stream and tears down the listener.

**Key takeaway:** `##upstream list-remote`, `subscribe <shareID> [view|control]`, `my-shares`, and `unsubscribe` form the remote-viewing loop, backed by the RemoteShareListenerActor.

---

### Story 97: Remote Control
**Duration:** 45s  
**Hook:** "In control mode you don't just watch -- you can drive the remote pane yourself."  
**What to show:**
1. Launch `rysh` and double-Escape into rysh mode.
2. `##upstream subscribe abc123 control` requests two-way access to a control-mode share.
3. `##upstream send ls -la` pushes text to the remote pane; the server validates subscriber, mode, and blocklist.
4. `####pane info` runs the `##pane info` rysh command on the source pane (four-hash prefix).
5. With `command_approval` set, each command waits for the owner's approval before executing.

**Key takeaway:** A control-mode subscriber uses `##upstream send <text>` for input and `####<command>` to run `##<command>` on the source pane, all gated by server validation and optional owner approval.

---

### Story 98: Workspaces (##ws)
**Duration:** 40s  
**Hook:** "A workspace is your shared space -- API-key-scoped, and managed right from rysh mode."  
**What to show:**
1. Launch `rysh` and double-Escape into rysh mode.
2. `##ws list` shows reachable workspaces; each API key is scoped to exactly one workspace.
3. `##ws create team-rocket sk-ws-abc123` registers a new workspace with a name and API key.
4. `##ws list` again confirms the new workspace, ready for shares and subscribers.

**Key takeaway:** `##ws list` and `##ws create <name> <api_key>` manage workspaces, each API-key-scoped to a single workspace for isolated collaboration.

---
## Group 24: Web & Desktop (stories 99-102)

### Story 99: Web Terminal (##rysh web)
**Duration:** 50s  
**Hook:** "Your whole rysh workspace, in a browser tab. One command starts it."  
**What to show:**
1. Launch `rysh` into shell mode.
2. Run `##rysh web start` -- starts the web UI server on the default port 23232.
3. Run `##rysh web start 23232` and note opening http://localhost:23232 gives the full TUI in the browser.
4. Run `##rysh web status` to confirm it is running.
5. Explain the browser session shares the same NATS bus and actors -- the same live workspace, not a copy.
6. Run `##rysh web stop` to shut it down.

**Key takeaway:** One command exposes your entire rysh workspace as a full-parity terminal in the browser on port 23232.

---

### Story 100: Web Terminal Architecture
**Duration:** 45s  
**Hook:** "No separate service. The web server is baked right into the rysh binary."  
**What to show:**
1. The web server is an embedded Go server running inside the same rysh process -- zero external dependencies.
2. The React frontend connects to the same embedded NATS bus and the same actor hierarchy the terminal uses.
3. State streams to the browser as a snapshot roughly every 200ms over a WebSocket, keeping browser and terminal in lockstep.
4. Summarize the stack: React frontend, embedded Go web server, shared NATS and actors -- one self-contained binary.

**Key takeaway:** The web terminal is an embedded Go server plus React frontend over the session's own NATS bus, streaming ~200ms snapshots with no external dependencies.

---

### Story 101: The Desktop App
**Duration:** 45s  
**Hook:** "The same rysh multiplexer, as a native desktop app."  
**What to show:**
1. Introduce rysh-cli-app: an Electron + React desktop client wrapping the same multiplexer.
2. It offers every input mode, full mouse support, and the same tabs and panes in a resizable window.
3. It adds dedicated side panels for Agents, Humanoids, and Shares.
4. Wrap: full rysh power with point-and-click GUI access.

**Key takeaway:** rysh-cli-app is an Electron/React desktop client with the full multiplexer plus side panels for Agents, Humanoids, and Shares.

---

### Story 102: Multi-Workspace in Desktop
**Duration:** 40s  
**Hook:** "Many workspaces, one window. The desktop app stacks them two rows high."  
**What to show:**
1. The two-row header: workspaces on the top row, tabs of the active workspace on the row below.
2. Clicking a workspace switches the entire context -- project, upstream, tabs, and panes.
3. The desktop app surfaces voice prompting and a dedicated pipeline output panel beside the panes.
4. Wrap: one window built for juggling multiple projects.

**Key takeaway:** The desktop app's two-row header lets you switch whole workspaces in one window, with voice and a pipeline output panel.

---

## Group 25: Mobile App (stories 103-106)

### Story 103: The Mobile App
**Duration:** 50s  
**Hook:** "rysh in your pocket. Reach your panes from iOS or Android."  
**What to show:**
1. Introduce rysh-mobile: native iOS/Android app; log in to reach your workspaces.
2. Drill-down navigation: workspace list -> pane list -> live pane view.
3. Panes render with XTerm.js for full color and ANSI.
4. Shared panes are fully interactive -- run vim or htop from the phone.
5. Wrap: your agentic terminal, anywhere.

**Key takeaway:** rysh-mobile brings workspaces to iOS/Android with XTerm.js rendering and an interactive terminal on shared panes.

---

### Story 104: Per-Mode Streams & Scrollback
**Duration:** 45s  
**Hook:** "Shell, AI, Chat, Rysh -- four streams, one pane, all on your phone."  
**What to show:**
1. Bottom mode tabs for Shell, AI, Chat, and Rysh -- each an independent output stream.
2. Background output (e.g. an AI reply) raises an unread badge on its mode tab.
3. Scrollback is tracked per pane and per mode, so threads never mix.
4. Wrap: tap to switch modes, scroll each independently -- the full four-mode model on a small screen.

**Key takeaway:** Mobile gives each pane four independent mode streams with unread badges and per-pane, per-mode scrollback.

---

### Story 105: Overflow Menu & Pane Actions
**Duration:** 40s  
**Hook:** "Long-press a pane on mobile and the full action menu opens up."  
**What to show:**
1. Long-press / overflow menu exposes pane actions: copy output, rename, share.
2. A terminal focus control decides when keystrokes go to the pane versus scrolling to read.
3. Landscape uses keyboard avoidance so the on-screen keyboard never covers the active pane.
4. Wrap: pane management is one press away.

**Key takeaway:** The overflow menu offers copy/rename/share plus terminal focus control and landscape keyboard avoidance.

---

### Story 106: Viewing Shared Tabs on Mobile
**Duration:** 45s  
**Hook:** "A teammate shares a tab -- you open the whole multi-pane layout on your phone."  
**What to show:**
1. The owner runs `##share tab`, publishing the tab and all its panes to the workspace.
2. Mobile subscribes and receives the tab as a full multi-pane layout, not a flat list.
3. Read each shared pane; in control mode, send input back into it from the phone.
4. Wrap: shared tabs become a live window into a teammate's workspace.

**Key takeaway:** Mobile can subscribe to shared tabs and view them as real multi-pane layouts, interacting with control-mode shares.

---

## Group 26: Chrome, Server & Billing (stories 107-111)

### Story 107: Chrome Extension Browser Automation
**Duration:** 50s  
**Hook:** "A rysh pane that lives in your browser's side panel and drives the page."  
**What to show:**
1. The extension's side panel is a real rysh pane -- same modes and AI agent -- targeting the browser.
2. It connects to the session over a NATS-over-WebSocket link, like every other client.
3. Because the agent lives in the pane (not the page), the conversation persists across navigations.
4. Wrap: ask the agent to fill a form or pull data and it acts on the live tab -- a browser copilot.

**Key takeaway:** The Chrome side panel is a rysh pane connected over NATS WebSocket whose agent drives the browser and keeps context across navigations.

---

### Story 108: Browser Tools
**Duration:** 45s  
**Hook:** "Navigate, click, type, screenshot -- the agent's browser toolbelt."  
**What to show:**
1. `browser_action` navigates to URLs, types into fields, and clicks elements.
2. `get_text` pulls page content; `screenshot` captures the view as a base64 image.
3. `execute_js` runs page JavaScript (approval required); tab tools: get_tabs, switch_tab, new_tab, close_tab.
4. Six selector strategies make element targeting robust on messy pages.

**Key takeaway:** Browser tools cover navigate/type/click, get_text, screenshot, approval-gated execute_js, tab management, and six selector strategies.

---

### Story 109: The Upstream Server
**Duration:** 50s  
**Hook:** "rysh-server: the hub that routes shares between machines."  
**What to show:**
1. rysh-server is the optional collaboration hub local sessions connect to for sharing panes, groups, and tabs.
2. Stack: Go/Gin API, PostgreSQL persistence, embedded NATS for real-time messaging, nginx in front.
3. It handles JWT/Firebase auth and owns workspaces, members, API keys, and share routing/access control.
4. Deploys as a Docker Compose stack: `make dev-up` for development, `make prod-up` for production.

**Key takeaway:** rysh-server is a Go/Gin + PostgreSQL + embedded NATS + nginx hub for auth, workspaces, and share routing, deployed via Docker Compose.

---

### Story 110: Stripe Billing & Plans
**Duration:** 50s  
**Hook:** "Four tiers, Stripe checkout, and limits enforced in three places."  
**What to show:**
1. Four plans: Free, Solo $19/mo, Team $49/mo, Enterprise (custom).
2. Limits cap workspaces, sessions, and panes -- Free 1/3/30, Team 20/200/2000.
3. Stripe integration: Checkout, Billing Portal, and webhooks; monthly or yearly intervals.
4. Limits enforced at three layers: workspaces (server-side at creation), sessions (server-side at WebSocket upgrade), panes (daemon-side in the WorkspaceActor).

**Key takeaway:** Four Stripe-billed tiers (Free/Solo $19/Team $49/Enterprise) cap workspaces, sessions, and panes, enforced across three layers.

---

### Story 111: Chatbot Widget & Connections
**Duration:** 45s  
**Hook:** "Drop a rysh-powered chatbot on your website with one script tag."  
**What to show:**
1. Each workspace has its own chatbot config: system prompt, model, and allowed origins.
2. Embed it with a single script, `/chatbot/widget.js`, and the widget appears on the site.
3. Each visitor gets their own session, and a human can take over the conversation at any time.
4. The same workspace can connect external channels -- Slack, WhatsApp, Email -- into one inbox.

**Key takeaway:** A per-workspace chatbot embeds via /chatbot/widget.js with per-visitor sessions, human takeover, and external Slack/WhatsApp/Email connections.

---
