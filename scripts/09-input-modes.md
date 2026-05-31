# Group 9: Input Modes (Stories 34-38)

Narration scripts for Rysh's four per-pane input modes. This group establishes the core interaction model: shell, prompt, rysh, and chat, cycled with double-Escape.

**Total duration:** ~3 min 40s

---

## Story 34: Four Input Modes (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Four Input Modes" | "One pane, four modes. Double-Escape cycles through them all." |
| 0:03 | Type `rysh`, run `echo shell mode` | "Start rysh and you land in shell mode -- the greater-than prompt runs commands in your PTY." |
| 0:08 | Double-Escape, prompt becomes `<` | "Double-press Escape. The prompt becomes a less-than sign -- that's prompt mode, where input goes to your AI agent with its own output stream." |
| 0:18 | Double-Escape, prompt becomes `##`, type `##help` | "Double-Escape again and the prompt turns to hash-hash. This is rysh mode for built-in system commands." |
| 0:28 | Double-Escape, prompt becomes `@` | "Once more and the prompt shows an at-sign -- chat mode, a separate AI chat with its own buffer." |
| 0:38 | Double-Escape back to `>` | "A final double-Escape brings you full circle back to shell. Greater-than, less-than, hash-hash, at-sign." |
| 0:46 | Hold on shell prompt | "Four markers, one key. Each mode keeps its own stream." |

### Key Moments to Annotate
- [0:03] Overlay: `>` = Shell
- [0:08] Overlay: `<` = Prompt (AI)
- [0:18] Overlay: `##` = Rysh (System)
- [0:28] Overlay: `@` = Chat
- [0:08] Key badge: `Esc Esc`

---

## Story 35: Shell Mode (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Shell Mode" | "Shell mode is a real terminal -- full color, full ANSI, nothing held back." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh and you're already in shell mode. The greater-than marker is your cue." |
| 0:08 | Type `ls -la` | "Every command runs in the pane's own PTY-backed shell, exactly like the terminal you already know." |
| 0:16 | Type `git status`, colored output | "Color and ANSI escapes come through untouched -- git status, ls with color, anything that paints the screen." |
| 0:26 | Type `echo $SHELL && uname -a` | "Pipes, redirects, environment variables -- it's a full shell, not a sandbox." |
| 0:34 | Echo recap line | "Shell mode is home base. Everything else is one double-Escape away." |

### Key Moments to Annotate
- [0:03] Overlay: `>` = Shell mode
- [0:16] Callout: full color + ANSI preserved

---

## Story 36: Prompt Mode AI (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Prompt Mode" | "Prompt mode turns your pane into an AI agent that sees your terminal." |
| 0:03 | Type `rysh`, run `ls -la` | "Start rysh and run a command so the agent has some context to work with." |
| 0:09 | Double-Escape, prompt becomes `<` | "Double-press Escape. The prompt becomes a less-than sign -- input now goes to the configured LLM provider, Claude over the API or the claude CLI." |
| 0:16 | Type "explain what this directory contains" | "Ask it anything. The agent sees your terminal context and answers with rendered markdown -- and it has thirty-five-plus tools for files, git, and the web." |
| 0:32 | Type follow-up question | "Follow up naturally -- the conversation carries forward within the pane's own AI output stream." |
| 0:44 | Press Escape, back to shell | "Press Escape to return to shell mode. Your agent is always one double-Escape away." |

### Key Moments to Annotate
- [0:09] Overlay: `<` = Prompt (AI)
- [0:16] Callout: 35+ tools, sees terminal context, markdown response

---

## Story 37: Rysh Mode (## commands) (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Rysh Mode" | "Hash-hash is rysh mode -- the control panel for your whole workspace." |
| 0:03 | Type `rysh`, double-Escape to `##` | "Start rysh, then double-Escape until the prompt shows hash-hash. System commands inject their output right into the active pane." |
| 0:09 | Type `##help` | "Help lists every system command -- panes, tabs, lanes, sharing, agents, and more." |
| 0:18 | Type `##pane info` | "Try one: pane info reports the active pane's details, all without leaving the keyboard." |
| 0:28 | Type `##tab list` | "One caution: a line starting with hash-hash-greater-than is not a command. Those are pipeline events, forwarded straight to NATS instead of being run." |
| 0:38 | Hold output | "Rysh mode is how you drive the multiplexer itself." |

### Key Moments to Annotate
- [0:03] Overlay: `##` = Rysh (System)
- [0:09] Callout: `##help` lists all commands
- [0:28] Callout: `##>` = pipeline event, NOT a command

---

## Story 38: Chat Mode (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Chat Mode" | "The at-sign prompt is chat mode -- a conversation lane separate from prompt mode." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh in shell mode, then we'll cycle all the way around to chat." |
| 0:09 | Triple double-Escape to `@` | "Double-Escape moves through prompt and rysh, then lands on the at-sign marker -- that's chat mode, for sending messages to AI chat." |
| 0:20 | Type a chat message | "Chat keeps its own per-mode buffer, distinct from prompt mode's stream. Type a message and send it." |
| 0:32 | Double-Escape back to shell | "Chat and prompt are separate streams in the same pane -- one for quick conversation, one for agentic work. Double-Escape returns you to shell." |

### Key Moments to Annotate
- [0:09] Overlay: `@` = Chat mode
- [0:20] Callout: per-mode buffer, separate from prompt mode
