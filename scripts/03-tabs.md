# Group 3: Tabs (Stories 10-13)

Narration scripts for working with tabs: the model, tab mode, jumping and renaming, and the `##tab` command center.

**Total duration:** ~2 min 50s

---

## Story 10: Tabs Overview (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Tabs Overview" | "Tabs hold panes, panes hold agents -- and switching between tabs is one keystroke." |
| 0:05 | Type `rysh`, one tab + one pane | "Start rysh and you get one tab with one pane. That's your starting point." |
| 0:13 | `Ctrl+T n` twice to add tabs | "Let's add a tab so we have something to move between -- Ctrl+T, then n." |
| 0:22 | Press `[`, `[`, `]` | "The bracket keys move between tabs: left bracket for previous, right bracket for next." |
| 0:32 | `Alt+Left`, `Alt+Right` | "Alt plus the left and right arrows do the same thing. Each tab is its own workspace of panes and agents." |

### Key Moments to Annotate
- [0:22] Show key badges: `[` and `]`
- [0:32] Show key badges: `Alt+Left` / `Alt+Right`

---

## Story 11: Tab Mode (Ctrl+T) (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Tab Mode" | "Ctrl+T opens tab mode -- create, jump, and move between tabs without leaving the home row." |
| 0:05 | `Ctrl+T`, then `n` three times | "Press Ctrl+T to enter tab mode. Now n creates a new tab. Press it a few times to build out a row of tabs." |
| 0:18 | `h`, `h`, `l` to move | "While in tab mode, h and k move to the previous tab, j and l move to the next -- no arrow keys needed." |
| 0:30 | `1`, `3`, `2` to jump | "Press a number from 1 to 9 to jump straight to that tab." |
| 0:40 | `Esc` to exit | "Escape exits tab mode and drops you back to normal mode." |

### Key Moments to Annotate
- [0:05] Show key badge: `Ctrl+T` then `n`
- [0:18] Show key badges: `h` / `j` / `k` / `l`
- [0:40] Show key badge: `Esc`

---

## Story 12: Jump & Rename Tabs (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Jump & Rename Tabs" | "Jump to any tab by number, and give your tabs real, memorable names." |
| 0:04 | In tab mode, press `1`, `4`, `2` | "In tab mode, the number keys 1 through 9 jump directly to a tab by its index." |
| 0:16 | Switch to rysh mode, `##tab name backend` | "Switch to rysh mode and name the active tab with ##tab name. Here we call it backend." |
| 0:28 | `##tab name 2 frontend` | "Add a tab ID before the name to rename any tab, not just the active one -- ##tab name, id, then name." |

### Key Moments to Annotate
- [0:04] Show key badges: number keys `1`-`9`
- [0:16] Highlight the `##tab name <name>` command
- [0:28] Highlight the `##tab name <id> <name>` form

---

## Story 13: Managing Tabs (##tab) (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Managing Tabs" | "The ##tab command is your tab control center -- list, inspect, delete, and toggle pipelines." |
| 0:04 | `##tab list` | "##tab list shows every tab with its ID and how many panes it holds." |
| 0:14 | `##tab list-panes` | "##tab list-panes drills into the active tab and lists the panes inside it." |
| 0:23 | `##tab delete 3` | "##tab delete with an ID removes a tab you no longer need." |
| 0:31 | `##tab pipeline enable` | "And ##tab pipeline enable turns on pipeline mode for the tab; disable turns it back off." |

### Key Moments to Annotate
- [0:04] Highlight `##tab list` output (IDs + pane counts)
- [0:23] Highlight `##tab delete <id>`
- [0:31] Highlight `##tab pipeline enable` / `disable`
