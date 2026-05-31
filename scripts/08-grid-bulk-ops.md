# Group 8: Grid & Bulk Ops (Stories 30-33)

Narration scripts for building layouts and acting on many panes at once. This group covers the `##new` family, batch commands, and lanes.

**Total duration:** ~2 min 55s

---

## Story 30: Instant Grids (##new grid) (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Instant Grids" | "Spin up a whole grid of agent panes with a single command." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh. Building layouts by hand is fine, but the new grid command does it in one shot." |
| 0:08 | Double-Escape to `##` mode | "Double-press Escape until the prompt shows hash-hash -- that's rysh mode for system commands." |
| 0:14 | Type `##new grid 4` | "Give it a single number and it stacks that many panes into the current lane. New grid four builds a four-pane stack instantly." |
| 0:24 | Type `##new grid 3x4` | "Add a dimension. Three by four lays out three lanes, each holding four panes -- a twelve-pane wall in one keystroke." |
| 0:36 | Type `##new grid 2x3x4` | "Go further with three dimensions: tabs, then lanes, then panes. Two by three by four creates two tabs, each with three lanes of four panes." |
| 0:46 | Hold full grid | "From one pane to a whole agent grid -- instantly." |

### Key Moments to Annotate
- [0:14] Overlay: `##new grid 4` = stack of 4
- [0:24] Overlay: `##new grid 3x4` = 3 lanes x 4 panes
- [0:36] Overlay: `##new grid 2x3x4` = tabs x lanes x panes

---

## Story 31: Stacks & Pane Groups (##new) (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Stacks & Pane Groups" | "The new command isn't just grids -- it builds any piece of layout." |
| 0:03 | Type `rysh`, double-Escape to `##` | "Start rysh and cycle into rysh mode with double-Escape." |
| 0:08 | Type `##new stack 3` | "New stack with a count adds that many stacked panes on top of the active group -- like dealing cards into a deck." |
| 0:16 | Type `##new pg 2` | "New pg builds pane groups -- the columns that hold your panes. Pass a count for several at once." |
| 0:24 | Type `##new pane` | "New pane adds a single pane, optionally targeting a specific tab and lane." |
| 0:32 | Type `##new tab` | "And new tab opens a fresh tab. One verb, every structural building block." |

### Key Moments to Annotate
- [0:08] Overlay: `##new stack <N>`
- [0:16] Overlay: `##new pg <N>`
- [0:24] Overlay: `##new pane [tab] [lane]`
- [0:32] Overlay: `##new tab`

---

## Story 32: Batch Commands (##cmd) (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Batch Commands" | "Run the same command across every pane in a scope at once." |
| 0:03 | Type `rysh`, `##new grid 3` | "Start rysh and create a few panes so the batch has something to fan out across." |
| 0:09 | Type `##cmd stack pwd` | "The cmd command takes a scope and a shell command. Cmd stack pwd runs pwd in every pane of the stack -- one line in, one line per pane out." |
| 0:20 | Type `##cmd lane echo building` | "Scopes range from a single pane up to the whole workspace: pane, pg, stack, lane, tab, and ws. Cmd lane echoes a build into every pane of the lane." |
| 0:30 | Type `##cmd tab git status` | "Need to target somewhere you're not focused? Add selectors like --tab, --lane, --pg, or --pane to aim the batch precisely." |
| 0:40 | Hold output | "One command, fanned out across your whole layout." |

### Key Moments to Annotate
- [0:09] Overlay: scope = pane / pg / stack / lane / tab / ws
- [0:30] Overlay: selectors `--tab` `--lane` `--pg` `--pane`

---

## Story 33: Lanes (##lane / ##new lane) (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Lanes" | "Lanes are the columns that organize your panes -- manage them directly." |
| 0:03 | Type `rysh`, double-Escape to `##` | "Start rysh and cycle into rysh mode with double-Escape." |
| 0:09 | Type `##new lane` | "New lane adds a fresh column to the tab, ready to hold its own panes." |
| 0:16 | Type `##lane list` | "Lane list shows every lane in the active tab with its identifier and contents." |
| 0:24 | Type `##lane info` | "Lane info zooms into the lane holding your active pane -- its panes, groups, and flex weight." |
| 0:31 | Type `##lane name backend`, then `##lane list` | "Lane name gives a lane a readable label, and lane delete removes one you no longer need. Lanes give your layout real structure." |

### Key Moments to Annotate
- [0:09] Overlay: `##new lane`
- [0:16] Overlay: `##lane list`
- [0:24] Overlay: `##lane info`
- [0:31] Overlay: `##lane name` / `##lane delete`
