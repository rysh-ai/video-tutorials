# Group 5: Stacked Panes & Groups (Stories 19-22)

Narration scripts for stacking panes, rotating through them, and understanding the lane / group / pane hierarchy that underlies every tab.

**Total duration:** ~2 min 50s

---

## Story 19: Stacked Panes (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Stacked Panes" | "Stack panes like a deck of cards -- many terminals in the footprint of one." |
| 0:04 | Type `rysh`, single pane | "Start rysh with a single pane." |
| 0:09 | `Ctrl+P s`, title reads `[1/2]` | "Press Ctrl+P then s to stack a new pane on top of the group. The border title now reads one of two." |
| 0:17 | `Ctrl+P s` again, title `[1/3]` | "Stack another and the title shows one of three. Only the front pane is full-size." |
| 0:25 | Escape, type `echo front of the stack` | "The panes behind it sit in the same slot, showing up as grey title bars at the bottom -- a deck you flip through." |
| 0:35 | Hold on the stacked group | "Stacking keeps related terminals together without crowding your screen. Next up: rotating through the stack." |

### Key Moments to Annotate
- [0:09] Key badge: `Ctrl+P s`; highlight border title `[1/2]`
- [0:17] Highlight border title `[1/3]`
- [0:25] Callout: "background panes = grey title bars"

---

## Story 20: Stack Mode (Ctrl+S) (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Stack Mode" | "Ctrl+S turns a stack into a flip-book -- rotate through your panes with j and k." |
| 0:04 | Type `rysh`, `Ctrl+P s` twice, `[1/3]` | "Start rysh, then stack three panes with Ctrl+P, s -- twice over -- so the title reads one of three." |
| 0:14 | Press `Ctrl+S`, footer shows stack bindings | "Press Ctrl+S to enter stack mode. Now j and k rotate the deck." |
| 0:19 | Press `j` twice, front pane advances | "Press j to bring the next pane to the front. The counter ticks forward." |
| 0:26 | Press `k` twice, rotates back | "Press k to rotate back the other way. You can fan through every pane in the group." |
| 0:33 | Press Escape, hold | "Escape leaves stack mode. j and k -- that's all it takes to navigate a deck of stacked panes." |

### Key Moments to Annotate
- [0:14] Key badge: `Ctrl+S`
- [0:19] Key badge: `j` (rotate next); highlight counter change
- [0:26] Key badge: `k` (rotate previous)

---

## Story 21: Pane Groups & Lanes (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pane Groups & Lanes" | "Beneath every layout is a tree -- lanes hold groups, groups hold panes." |
| 0:04 | Type `rysh`, `Ctrl+P n` twice | "Start rysh and split right a couple of times. Each column you create is a pane group with its own flex weight." |
| 0:14 | Type `##pg list`, groups listed | "Switch to rysh mode and run ##pg list -- short for panegroup -- to see every group in the tab and its flex share." |
| 0:23 | Type `##pg info`, active group detail | "##pg info zooms in on the group holding the active pane." |
| 0:32 | Type `##lane list`, lanes listed | "Lanes are the rows of columns that tile your tab. ##lane list shows them, with the panes they contain." |
| 0:40 | Hold on output | "Lanes, groups, panes -- a tidy hierarchy you can inspect any time from rysh mode." |

### Key Moments to Annotate
- [0:14] Highlight command: `##pg list`; callout "panegroup = column"
- [0:23] Highlight command: `##pg info`
- [0:32] Highlight command: `##lane list`

---

## Story 22: Layout Tree (##pg layout) (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Layout Tree" | "See your whole tab at once -- ##pg layout draws the entire structure as a tree." |
| 0:04 | Type `rysh`; `Ctrl+P n`, `v`, `s` | "Start rysh and build something with depth: split right for a column, split down for a row, then stack a pane on top." |
| 0:16 | Type `##pg layout`, tree prints | "In rysh mode, ##pg layout prints the full tree: lanes, then groups, then the stacked panes inside them." |
| 0:28 | Type `##pg info`, active group detail | "Pair it with ##pg info to drill into just the group your active pane lives in." |
| 0:36 | Hold on the tree output | "One command, the whole picture. ##pg layout is your map of any tab." |

### Key Moments to Annotate
- [0:16] Highlight command: `##pg layout`; annotate the lanes -> groups -> panes tree
- [0:28] Highlight command: `##pg info`
