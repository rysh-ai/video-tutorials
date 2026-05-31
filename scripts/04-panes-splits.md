# Group 4: Panes & Splits (Stories 14-18)

Narration scripts for working with panes -- creating them, splitting them, closing and renaming, and inspecting them from rysh mode.

**Total duration:** ~3 min 40s

---

## Story 14: Panes Overview (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Panes Overview" | "One window, many minds. Every pane is its own shell and its own AI agent." |
| 0:04 | Type `rysh`, single pane appears | "Start rysh and you get a single pane -- a full terminal backed by its own agent." |
| 0:09 | Press `Ctrl+N`, second pane opens | "Press Ctrl+N to create another pane. Instantly you have two independent terminals side by side." |
| 0:16 | Press `Ctrl+N` again, third pane | "Add as many as you like. Each pane has its own working directory, its own history, its own AI context." |
| 0:23 | Press `Tab` three times, focus border moves | "Press Tab to cycle through your panes. The focused pane gets a highlighted border." |
| 0:33 | Type `pwd` in focused pane | "Whatever you type lands only in the pane you've focused -- the others keep running on their own." |
| 0:40 | Hold on multi-pane layout | "Ctrl+N to add a pane, Tab to move between them. That's the foundation of every Rysh layout." |

### Key Moments to Annotate
- [0:09] Show key badge: `Ctrl+N`
- [0:23] Show key badge: `Tab`; highlight the focus border
- [0:33] Callout: "input goes only to the focused pane"

---

## Story 15: Pane Mode (Ctrl+P) (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pane Mode" | "Ctrl+P is your pane command center -- split, stack, close, and rename without leaving the keyboard." |
| 0:04 | Type `rysh`, TUI launches | "Start rysh, then press Ctrl+P to enter pane mode." |
| 0:09 | Press `Ctrl+P`, footer shows bindings | "The footer shows your pane-mode bindings. Every key now manages panes." |
| 0:14 | Press `n`, splits right | "Press n to split right -- a new pane opens in a new column." |
| 0:20 | `Ctrl+P` then `v`, splits down | "Press v to split down -- a new pane stacks below in the same column." |
| 0:27 | `Ctrl+P` then `s`, stacked pane | "Press s to stack a pane on top of the active group -- like dealing a new card onto the deck." |
| 0:34 | `Ctrl+P` then `r`, type "builder", Enter | "Press r to rename the active pane. Type a name, hit Enter, and it becomes the pane's given-name." |
| 0:42 | `Ctrl+P` then `x`, then Escape | "Press x to close a pane, and Escape to leave pane mode whenever you're done. Split, stack, rename -- all from Ctrl+P." |

### Key Moments to Annotate
- [0:09] Show key badge: `Ctrl+P`; highlight footer binding list
- [0:14] Key badge: `n` (split right)
- [0:20] Key badge: `v` (split down)
- [0:27] Key badge: `s` (stack)
- [0:34] Key badge: `r` (rename)
- [0:42] Key badges: `x` (close), `Esc` (exit)

---

## Story 16: Split Right & Split Down (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Split Right & Split Down" | "Build any layout from two moves: split right for columns, split down for rows." |
| 0:04 | Type `rysh`, single pane | "Start with a single pane in a single column." |
| 0:09 | `Ctrl+P n`, second column | "Ctrl+P then n splits right. That's a second column, and the space divides between them by flex weight." |
| 0:16 | `Ctrl+P n`, third column | "Do it again for a third column. Each new pane shares the width evenly -- a clean three-column layout." |
| 0:23 | `Ctrl+P v`, row added in column | "Now press v to split down. The active column gets a second row, stacked vertically inside that same column." |
| 0:32 | `Ctrl+P v` again, another row | "Split down again and the column packs in another row. Columns grow with n, rows grow with v." |
| 0:40 | Hold on the finished grid | "Two keys, endless layouts. Flex weights keep everything balanced as you build." |

### Key Moments to Annotate
- [0:09] Key badge: `Ctrl+P n`; callout "new column / pane group"
- [0:23] Key badge: `Ctrl+P v`; callout "new row in the same column"
- [0:40] Callout: "flex weight = share of space"

---

## Story 17: Closing & Renaming Panes (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Closing & Renaming Panes" | "Keep your workspace tidy: close panes you're done with and name the ones you keep." |
| 0:04 | Type `rysh`, TUI launches | "Start rysh and split into a couple of panes to work with." |
| 0:09 | `Ctrl+P n`, second pane | "Ctrl+P, n gives us a second pane." |
| 0:14 | `Ctrl+P r`, type "tests", Enter | "Press Ctrl+P then r to rename the active pane. Type the name and press Enter." |
| 0:22 | Type `##pane name api-server`, Enter | "You can also set the given-name from rysh mode. ##pane name keeps it unique per lane." |
| 0:30 | `Ctrl+P x`, pane closes | "When you're finished with a pane, Ctrl+P then x closes it." |
| 0:36 | Hold on remaining panes | "Rename to stay organized, close to clean up. Your layout, your rules." |

### Key Moments to Annotate
- [0:14] Key badge: `Ctrl+P r`
- [0:22] Highlight command: `##pane name api-server`; callout "unique per lane"
- [0:30] Key badge: `Ctrl+P x`

---

## Story 18: Pane Info & Listing (##pane) (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pane Info & Listing" | "Ask rysh about itself -- inspect any pane, list them all, and replay its history." |
| 0:04 | Type `rysh`, `Ctrl+P n`, Escape | "Start rysh and split so we have more than one pane." |
| 0:09 | Type `##pane info`, output shows id/name/mode | "Switch to rysh mode and run ##pane info to see the active pane's id, name, mode, and group." |
| 0:17 | Type `##pane list`, list of panes | "##pane list shows every pane in the current tab at a glance." |
| 0:25 | Type `##pane history shell`, history prints | "Run a couple of commands first, then ##pane history shell replays this pane's shell history. Swap in prompt for AI turns." |
| 0:34 | Hold on output | "info, list, history -- everything you need to understand your panes, right from rysh mode." |

### Key Moments to Annotate
- [0:09] Highlight command: `##pane info`
- [0:17] Highlight command: `##pane list`
- [0:25] Highlight command: `##pane history shell`; note alternate `prompt`
