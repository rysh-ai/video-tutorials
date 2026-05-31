# Group 13: Tools — File & Shell (Stories 48-52)

Narration scripts for the file and shell tools. These show prompt mode (`<`) invoking the agent's toolbelt: reading, searching, editing, running bash, and code intelligence. Read-only tools run freely; writes and dangerous commands are approval-gated.

**Total duration:** ~3 min 45s

---

## Story 48: The Agentic Toolbelt (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "The Agentic Toolbelt" | "Every prompt-mode pane carries thirty-five-plus tools." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. In any pane, the AI agent already has a full toolbelt wired up." |
| 0:08 | Double-press Escape, prompt becomes `<` | "Double-press Escape to enter prompt mode -- the marker turns into a less-than sign." |
| 0:16 | Type "list all the tools you have available" | "Ask it to list its tools. Under the hood it calls the list_tools tool and reports every capability -- no approval needed." |
| 0:30 | AI response lists categories | "The tools fall into clear categories: file and shell, git, code intelligence, testing and build, background execution, and web." |
| 0:40 | Highlight approval note | "Read-only tools run freely; anything that writes, commits, or runs dangerous commands asks for approval first." |
| 0:45 | End card | "One agent, one toolbelt, in every pane you open." |

### Key Moments to Annotate
- [0:08] Show prompt marker change: `>` to `<`
- [0:16] Highlight the `list_tools` tool
- [0:40] Callout: read-only vs approval-gated

---

## Story 49: Reading & Searching Files (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Reading & Searching Files" | "Point the agent at your code -- ls, file_read, glob, and grep find anything." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh in a project directory you want to explore." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape to talk to the agent." |
| 0:14 | Type "find all the TODO comments..." | "Ask it to find all the TODO comments. It reaches for grep with a regex, glob with double-star patterns, and file_read to peek inside." |
| 0:24 | AI runs tools, lists matches | "These are read-only tools, so they run without asking for approval." |
| 0:30 | Highlight the toolset | "Behind that request: ls for listings, glob for patterns, grep for content, file_read for contents, and tree for structure." |
| 0:42 | End card | "Read and search the whole codebase, just by asking." |

### Key Moments to Annotate
- [0:14] Highlight `grep`, `glob`, `file_read`
- [0:24] Callout: "No approval — read-only"

---

## Story 50: Editing Files (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Editing Files" | "When the agent edits a file, you see the diff first -- every write waits for your yes." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh and drop in a small file we can edit." |
| 0:08 | Shell mode: create `notes.txt` | "In shell mode, create a quick file so there's something to change." |
| 0:14 | Double-press Escape to prompt mode | "Double-press Escape to enter prompt mode." |
| 0:20 | Type "in notes.txt change world to rysh" | "Ask it to change a line. It uses file_edit for exact-string replace, multi_edit for atomic hunks, file_write for new files, or apply_patch for a unified diff." |
| 0:30 | Approval footer with diff preview | "Each of these is approval-gated. The footer shows the action with a diff preview." |
| 0:36 | Press `y` to approve | "Press y to approve, capital Y to approve always, n to reject, or capital N to reject with a reason." |
| 0:45 | End card | "Nothing touches your files until you approve the diff." |

### Key Moments to Annotate
- [0:20] Highlight `file_edit`, `multi_edit`, `file_write`, `apply_patch`
- [0:30] Show diff preview in footer
- [0:36] Show approval key badges: `y` `Y` `n` `N`

---

## Story 51: Running Bash (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Running Bash" | "Ask in plain English, and the agent runs the shell for you." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh and switch over to the agent." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape for prompt mode." |
| 0:13 | Type "what is my disk usage..." | "Ask what's using your disk. The agent calls the bash tool to run a real shell command and reads the output back." |
| 0:24 | AI shows result | "Safe, read-only commands just run -- but anything matching a dangerous pattern needs your approval first." |
| 0:30 | Highlight safety net | "That gate is what makes bash safe: deletes, force-pushes, and risky commands stop and wait for a yes." |
| 0:37 | End card | "Natural language in, real shell commands out -- with a safety net." |

### Key Moments to Annotate
- [0:13] Highlight the `bash` tool
- [0:24] Callout: "Dangerous patterns require approval"

---

## Story 52: Symbol Search & Code Intelligence (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Symbol Search & Code Intelligence" | "Ask where something is defined -- symbol_search and tree map your code instantly." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh inside a codebase you want to understand." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape to talk to the agent." |
| 0:13 | Type "where is the main function defined" | "Ask where a function or type lives. The agent uses symbol_search to find declarations and tree to show the structure around it." |
| 0:24 | AI returns file and line | "Both are read-only, so they run without approval." |
| 0:30 | Highlight the value | "Instead of grepping by hand, you just ask -- a vague question becomes a precise file and line." |
| 0:37 | End card | "Find any declaration, understand any tree -- conversationally." |

### Key Moments to Annotate
- [0:13] Highlight `symbol_search` and `tree`
- [0:24] Callout: "No approval — read-only"
