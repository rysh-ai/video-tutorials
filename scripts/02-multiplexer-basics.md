# Group 2: Terminal Multiplexer Basics (Stories 5-10)

Narration scripts for core navigation and layout features. These show that Rysh is a first-class terminal multiplexer.

**Total duration:** ~4 min 20s

---

## Story 5: Tabs and Panes (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Tabs and Panes" | "Tabs hold panes. Panes hold agents. It's that simple." |
| 0:03 | Rysh open, one tab, one pane | "When you start rysh, you get one tab with one pane." |
| 0:06 | Show key badge `Ctrl+T` | "Ctrl+T enters tab mode." |
| 0:08 | Press `n` in tab mode | "Press n to create a new tab." |
| 0:10 | New tab appears, tab bar updates | "There's your second tab." |
| 0:13 | Press `[` to go back | "Square brackets switch tabs. Left bracket goes back..." |
| 0:15 | Press `]` to go forward | "...right bracket goes forward." |
| 0:18 | Show key badge `Ctrl+P` | "Ctrl+P enters pane mode." |
| 0:20 | Press `n` in pane mode | "Press n to split right -- a new pane in a new column." |
| 0:23 | Two panes side by side | "Now you've got two panes side by side." |
| 0:26 | Press `Tab` key | "The Tab key cycles between panes." |
| 0:29 | Focus shifts, border color changes | "Watch the border highlight change." |
| 0:32 | Show `Alt+Left` and `Alt+Right` | "Alt plus arrow keys navigate globally." |
| 0:35 | `Alt+Left/Right` switches tabs | "Alt Left/Right switches tabs." |
| 0:38 | `Alt+Up/Down` switches panes | "Alt Up/Down switches panes." |
| 0:42 | Show 3 tabs with multiple panes | "Mix and match. Each tab is an independent workspace." |
| 0:46 | End card | "Tabs organize your workspace. Each pane is an independent terminal with its own AI agent." |

### Key Moments to Annotate
- [0:06] Key badge: `Ctrl+T`
- [0:18] Key badge: `Ctrl+P`
- [0:13] Key badge: `[` and `]`
- [0:32] Key badge: `Alt+Arrow`

---

## Story 6: Splitting Panes -- Columns and Rows (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Splitting Panes" | "Horizontal, vertical, or stacked -- panes go wherever you need them." |
| 0:03 | One pane, enter pane mode `Ctrl+P` | "Start with one pane. Enter pane mode." |
| 0:06 | Press `n` -- split right | "Press n to split right. That creates a new column." |
| 0:09 | Two columns visible | "Two columns, equal width." |
| 0:12 | Focus left pane, press `v` | "Press v to split down -- a vertical split in the same column." |
| 0:15 | Left column now has two rows | "The left column now has two rows." |
| 0:18 | Create another split right | "Split right again for a third column." |
| 0:21 | 3-column layout, left column has 2 rows | "Three columns. The left one is split vertically." |
| 0:25 | Type commands in each pane | "Each pane has its own shell, its own AI, its own history." |
| 0:30 | Show flex weights concept | "Flex weights control proportions. A pane with flex 2 gets twice the space of flex 1." |
| 0:37 | End card | "Ctrl+P n splits horizontally. Ctrl+P v splits vertically. Flex weights control the proportions." |

### Key Moments to Annotate
- [0:06] Key badge: `Ctrl+P n` -- "Split Right"
- [0:12] Key badge: `Ctrl+P v` -- "Split Down"
- [0:30] Overlay: "Flex 1 | Flex 2 | Flex 1"

---

## Story 7: Stacked Panes (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Stacked Panes" | "Stack panes like a deck of cards. Only the top one is visible." |
| 0:03 | One pane, type a command | "You're in a pane running some tests." |
| 0:06 | Enter pane mode, press `s` | "Press s in pane mode to create a stacked pane." |
| 0:09 | New pane appears on top | "A new pane appears on top of the current one." |
| 0:12 | Border shows `[1/2]` | "The border shows 1 of 2 -- your stack depth." |
| 0:15 | Grey title bar at bottom | "The background pane shows as a grey title bar." |
| 0:18 | Create another stack: `Ctrl+P s` | "Stack another one. Now you have three." |
| 0:21 | Border shows `[1/3]` | "One of three visible." |
| 0:24 | Show key badge `Ctrl+S` | "Ctrl+S enters stack mode." |
| 0:26 | Press `j` to rotate next | "Press j to rotate next -- the front pane moves to the back." |
| 0:29 | Different pane visible | "Now pane 2 is on top." |
| 0:32 | Press `k` to rotate previous | "Press k to rotate previous -- the back pane comes to front." |
| 0:35 | Rotate through all three | "Cycle through your entire stack." |
| 0:40 | End card | "Stacked panes let you layer multiple agents in the same visual space." |

### Key Moments to Annotate
- [0:06] Key badge: `Ctrl+P s` -- "Stack Pane"
- [0:12] Callout arrow to `[1/2]` badge
- [0:24] Key badge: `Ctrl+S`
- [0:26] Key badge: `j` -- "Next"
- [0:32] Key badge: `k` -- "Previous"

---

## Story 8: Navigating Panes with Navigate Mode (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Navigate Mode" | "Arrow-key pane traversal. No memorizing pane numbers." |
| 0:03 | Create 2x2 grid of panes | "Here's a 2x2 grid -- two columns, each split down." |
| 0:08 | Show key badge `Ctrl+Space` | "Ctrl+Space enters navigate mode." |
| 0:10 | Mode indicator shows "NAVIGATE" | "The footer shows NAVIGATE." |
| 0:13 | Press arrow keys to move | "Arrow keys or h/j/k/l move focus directionally." |
| 0:16 | Border highlights follow cursor | "Watch the border highlight follow your cursor." |
| 0:22 | Move right, down, left, up | "Right, down, left, up -- spatial navigation." |
| 0:30 | Press `Esc` to exit | "Escape exits navigate mode." |
| 0:33 | Press `.` to exit (alternative) | "Or press dot -- it works as Escape in all modes." |
| 0:36 | End card | "Navigate mode gives you spatial, directional pane focus." |

### Key Moments to Annotate
- [0:08] Key badge: `Ctrl+Space`
- [0:13] Key badges as arrows are pressed

---

## Story 9: Layout Mode (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Layout Mode" | "Resize panes by pressing arrow keys. Equalize with one keystroke." |
| 0:03 | 3-pane layout with uneven widths | "Three panes. Different widths." |
| 0:06 | Show key badge `Ctrl+L` | "Ctrl+L enters layout mode." |
| 0:08 | Press `Right` to grow width | "Right arrow grows the active pane's width." |
| 0:11 | Press `Left` to shrink | "Left arrow shrinks it." |
| 0:14 | Press `Down` to grow height | "Down arrow grows height." |
| 0:17 | Press `Up` to shrink height | "Up arrow shrinks it." |
| 0:20 | Panes are uneven | "Now they're uneven. Let's fix that." |
| 0:23 | Press `=` or `h` | "Press equals to equalize all widths." |
| 0:26 | All columns equal | "Perfectly even." |
| 0:28 | Press `v` | "Press v to equalize heights." |
| 0:31 | Press `s` | "Press s to swap two pane positions." |
| 0:35 | Press `m` | "Press m to toggle fullscreen on the active pane." |
| 0:38 | Pane fills the screen | "Full-screen focus. Press m again to restore." |
| 0:42 | Press `m` again, layout restored | |
| 0:44 | End card | "Layout mode: resize, equalize, swap, and fullscreen." |

### Key Moments to Annotate
- [0:06] Key badge: `Ctrl+L`
- [0:23] Key badge: `=` -- "Equalize"
- [0:31] Key badge: `s` -- "Swap"
- [0:35] Key badge: `m` -- "Fullscreen"

---

## Story 10: Mouse Support (30s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Mouse Support" | "Click to focus. Drag to select. Release to copy." |
| 0:03 | 3-pane layout | "Three panes with different content." |
| 0:06 | Click on right pane | "Click on a pane to focus it." |
| 0:08 | Border highlights | "The border highlight follows your click." |
| 0:10 | Click on left pane | "Click another one." |
| 0:12 | Click-drag across text | "Click and drag to select text." |
| 0:16 | Release mouse | "Release -- the text is copied to your clipboard." |
| 0:19 | Scroll wheel | "Scroll wheel moves through output. Three lines per step." |
| 0:24 | End card | "Full mouse support. Click, drag, copy, scroll." |

### Key Moments to Annotate
- [0:06] Callout: "Click to focus"
- [0:16] Callout: "Copied to clipboard"
- [0:19] Callout: "Scroll wheel"
