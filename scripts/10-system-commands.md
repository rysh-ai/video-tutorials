# Group 10: System Commands (Stories 39-41)

Narration scripts for Rysh's built-in `##` system commands -- the introspection and
clipboard tools that let you inspect a workspace and capture pane output without ever
leaving the keyboard.

**Total duration:** ~2 min 10s

---

## Story 39: Help & History (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Help & History" | "Forget a command? Rysh tells you. ##help lists everything, ##history recalls what you typed." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh and run a couple of shell commands to build up some history." |
| 0:07 | Run `ls -la`, then `pwd` | "Every command you run is remembered, per input mode." |
| 0:14 | Double-Escape to rysh mode (`##`) | "Double-press Escape to reach rysh mode -- the prompt becomes a double-hash, ready for system commands." |
| 0:20 | Type `##help`, list scrolls | "Type ##help to list every system command Rysh understands -- tabs, panes, lanes, sharing, snapshots, and more." |
| 0:28 | Type `##history` | "Type ##history -- or just ##h -- to see the command history for the current input mode. Nothing gets lost." |
| 0:37 | Hold final frame | "Help and history: your two-command safety net inside any pane." |

### Key Moments to Annotate
- [0:14] Show prompt change: `>` to `##`
- [0:20] Highlight `##help`
- [0:28] Show alias badge: `##history` = `##h`

---

## Story 40: Inspecting Your Workspace (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Inspecting Your Workspace" | "Lost track of your layout? A handful of ## commands map your entire workspace." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh and build a small layout to inspect." |
| 0:07 | `Ctrl+P n` splits right | "Ctrl+P then n splits right, giving us a second pane in a new group." |
| 0:13 | Double-Escape to rysh mode | "Double-Escape over to rysh mode so we can issue inspection commands." |
| 0:18 | Type `##pane info` | "##pane info shows the active pane's details -- id, mode, given-name, and status." |
| 0:24 | Type `##tab list`, then `##lane list` | "##tab list shows every tab with its pane count; ##lane list shows the columns in this tab." |
| 0:30 | Type `##pg list` | "##pg list -- short for panegroup list -- enumerates every pane group in the active tab." |
| 0:36 | Type `##pg layout`, tree renders | "And ##pg layout prints the full tab tree: lanes, groups, and stacked panes, all in one view." |
| 0:42 | Hold final frame | "Five commands, and you can see your whole workspace at a glance." |

### Key Moments to Annotate
- [0:18] Highlight `##pane info`
- [0:30] Show alias: `##pg` = `##panegroup`
- [0:36] Callout: "Full tab tree: lanes -> groups -> stacked panes"

---

## Story 41: Snapshots & Clipboard (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Snapshots & Clipboard" | "Grab a pane's output to your clipboard -- raw for you, redacted for sharing." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh and generate some output worth capturing." |
| 0:07 | Run `env \| head -n 5` | "Run a command -- its output fills the pane's buffer." |
| 0:13 | Double-Escape to rysh mode | "Double-Escape over to rysh mode for the snapshot commands." |
| 0:18 | Type `##snap` | "##snap -- the same as ##snap private -- copies the pane's raw buffer straight to your clipboard." |
| 0:25 | Type `##snap public` | "##snap public copies the redacted version -- secrets are stripped before they ever hit the clipboard." |
| 0:32 | Type `##private pane print`, then `##public pane print` | "Prefer to see it inline? ##private pane print shows raw output; ##public pane print shows the redacted version right in the pane." |
| 0:39 | Hold final frame | "Snapshots make it easy to copy, paste, and share -- safely." |

### Key Moments to Annotate
- [0:18] Show alias: `##snap` = `##snap private`
- [0:25] Callout: "Secret redaction before clipboard"
- [0:32] Contrast: private (raw) vs public (redacted)
