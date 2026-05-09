# Group 3: Input Modes (Stories 11-14)

Narration scripts for the four input modes. This group establishes the core interaction model that makes Rysh unique.

**Total duration:** ~3 min

---

## Story 11: Four Input Modes (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Four Input Modes" | "One pane, four modes. Double-Escape to cycle." |
| 0:03 | Pane with `>` prompt | "This is shell mode. The greater-than prompt. Type a command, it runs in your shell." |
| 0:08 | Type `ls -la`, output appears | |
| 0:12 | Double-press Escape | "Double-press Escape to switch modes." |
| 0:14 | Prompt changes to `<` | "Now the prompt is less-than. This is prompt mode -- your AI agent." |
| 0:18 | Type "what files are here?" | "Ask the AI anything." |
| 0:22 | AI responds | |
| 0:26 | Double-press Escape again | "Double-Escape again." |
| 0:28 | Prompt changes to `##` | "Hash-hash prompt. This is rysh mode for built-in system commands." |
| 0:31 | Type `##help` | "Type help to see all available system commands." |
| 0:35 | Double-press Escape again | "One more time." |
| 0:37 | Prompt changes to `@` | "At-sign prompt. Chat mode -- for talking to autonomous agents." |
| 0:40 | Double-press Escape | "And one more Double-Escape brings you back to shell." |
| 0:42 | Prompt back to `>` | "Full circle. Shell, prompt, rysh, chat." |
| 0:45 | Show 4 prompt characters side by side | "Each mode has its own output buffer, its own history." |

### Key Moments to Annotate
- [0:03] Overlay: `>` = Shell
- [0:14] Overlay: `<` = Prompt (AI)
- [0:28] Overlay: `##` = Rysh (System)
- [0:37] Overlay: `@` = Chat (Agents)
- [0:12] Key badge: `Esc Esc`

---

## Story 12: Shell Mode (35s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Shell Mode" | "It's just a regular terminal. PTY-backed, full color." |
| 0:03 | `>` prompt visible | "Shell mode. The default. Everything you type runs in your shell." |
| 0:06 | Type `git status` | "Git status..." |
| 0:09 | Colored output appears | "Full ANSI color. Exactly like your regular terminal." |
| 0:12 | Type `docker ps` | "Docker ps..." |
| 0:15 | Type a long command: `npm run build` | "A build command. Watch the output stream." |
| 0:20 | Output streaming | "Output streams line by line from the PTY." |
| 0:23 | Press `Ctrl+C` | "Ctrl+C cancels, just like any terminal." |
| 0:26 | Up arrow for history | "Up arrow for command history." |
| 0:30 | End card | "Shell mode is a full PTY terminal. Everything works." |

### Key Moments to Annotate
- [0:03] Highlight `>` prompt character
- [0:09] Callout: "Full ANSI color"

---

## Story 13: Prompt Mode -- AI Agent (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Prompt Mode" | "Switch to prompt mode. Ask the AI anything about your codebase." |
| 0:03 | Double-Escape, prompt changes to `<` | "Double-Escape to enter prompt mode." |
| 0:06 | Callout on `<` prompt | "The less-than prompt means you're talking to your AI agent." |
| 0:09 | Type "explain the architecture of this project" | "Ask a high-level question." |
| 0:13 | AI response renders as markdown | "The response renders as formatted markdown with syntax highlighting." |
| 0:20 | Scroll through response | "The AI has access to 35 tools. It read your files to answer that." |
| 0:25 | Type "find all TODO comments in the codebase" | "Ask it to search your codebase." |
| 0:29 | AI uses grep tool, shows results | "It used the grep tool, searched your files, and presented the results." |
| 0:35 | Type "fix the bug in config.go line 42" | "Ask it to fix something." |
| 0:39 | AI reads file, proposes edit, approval dialog | "It reads the file, proposes an edit, and shows you the diff for approval." |
| 0:45 | End card | "Prompt mode turns your pane into an AI coding assistant with full tool access." |

### Key Moments to Annotate
- [0:03] Key badge: `Esc Esc`
- [0:06] Callout: `<` = "Talking to AI"
- [0:29] Callout: "grep tool in action"
- [0:39] Callout: "Approval required for edits"

---

## Story 14: System Commands (## Mode) (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "System Commands" | "Everything starting with ## is a built-in command." |
| 0:03 | Type `##help` | "Hash-hash help shows the full command list." |
| 0:06 | Output: categorized command list | "Commands are organized by category: pane, tab, pane group, sharing, agents." |
| 0:12 | Type `##pane list` | "List all panes in the active tab." |
| 0:15 | Output shows pane IDs and names | "Each pane has a UUID and an optional name." |
| 0:18 | Type `##tab list` | "List all tabs." |
| 0:21 | Type `##pane name my-builder` | "Give your pane a name." |
| 0:24 | Border title updates to "my-builder" | "The border title updates immediately." |
| 0:27 | Type `##snap` | "Snap copies the pane's entire output to your clipboard." |
| 0:30 | Type `##history` | "History shows your command history for the current mode." |
| 0:34 | Type `##public` and `##private` | "Toggle the pane's privacy setting for shared output." |
| 0:38 | End card | "System commands manage tabs, panes, clipboard, history, and more." |

### Key Moments to Annotate
- [0:03] Highlight `##` prefix
- [0:21] Callout: pane border title change
- [0:27] Callout: "Copied to clipboard"
