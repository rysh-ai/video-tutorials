# Group 17: Context & Memory (Stories 65-68)

Narration scripts for the context and memory stories. These show how Rysh agents remember things: durable key-value context, shared project notes, per-pane todo lists, and conversation history with memory compaction.

**Total duration:** ~2 min 50s

---

## Story 65: Context Store (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Context Store" | "Give your agent a memory that survives across the whole session." |
| 0:03 | Type `rysh`, switch to prompt mode | "Start rysh and switch to prompt mode." |
| 0:08 | Ask to remember a staging DB fact | "Tell the agent to remember something. The context_store tool writes a key and value into JetStream KV for this session." |
| 0:22 | Ask it back in a later turn | "Later -- in any turn -- ask it back. The agent recalls the value straight from the store, no re-explaining needed." |
| 0:38 | End card | "context_store is durable key-value memory that any prompt in the session can read and write." |

### Key Moments to Annotate
- [0:08] Highlight the `context_store` tool call (store)
- [0:22] Highlight the `context_store` tool call (recall)

---

## Story 66: Project Notes (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Project Notes" | "A shared scratchpad your agent reads and writes for the whole project." |
| 0:03 | Type `rysh`, prompt mode | "Start rysh and drop into prompt mode." |
| 0:08 | Ask to record a project decision | "Ask the agent to note a project decision. The project_notes tool appends it to a shared .rysh-notes.md file." |
| 0:22 | Shell mode, `cat .rysh-notes.md` | "Back in shell mode, the notes live in a plain markdown file you can open, edit, and commit alongside your code." |
| 0:32 | End card | "project_notes is durable, file-backed memory that every pane and every agent on the project can share." |

### Key Moments to Annotate
- [0:08] Highlight the `project_notes` tool (write)
- [0:22] Highlight the `.rysh-notes.md` file path

---

## Story 67: Todo Lists (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Todo Lists" | "Watch your agent break a big job into tracked, checkable steps." |
| 0:03 | Type `rysh`, prompt mode | "Start rysh and switch to prompt mode." |
| 0:08 | Ask for a multi-step plan as a todo list | "Hand the agent a multi-step task. It uses the todo tool to add items, then marks each one complete as it goes." |
| 0:24 | Show items completing | "The list lives in per-pane JetStream KV. Add, update, complete, or remove items -- the agent tracks its own work." |
| 0:34 | End card | "The todo tool keeps long, multi-step work organized and visible from start to finish." |

### Key Moments to Annotate
- [0:08] Highlight `todo` tool calls (add)
- [0:24] Highlight `todo` tool calls (complete) -- per-pane KV

---

## Story 68: Conversation History & Memory (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Conversation History & Memory" | "Recall any pane's conversation, and let old turns compact into summaries." |
| 0:03 | Type `rysh`, split a pane with `Ctrl+P n` | "Start rysh and split a second pane so we have two agents with separate conversations." |
| 0:09 | Ask agent to pull the other pane's history | "From prompt mode, ask the agent to retrieve the other pane's conversation. The session_history tool reads any pane's turns." |
| 0:22 | Rysh mode, `##pane history prompt` | "Drop into rysh mode to print this pane's history directly -- shell and prompt turns are all kept." |
| 0:36 | Explain memory compaction | "As conversations grow, memory compaction folds old turns into compact MemoryEntry summaries -- context stays small and sharp." |

### Key Moments to Annotate
- [0:09] Highlight the `session_history` tool call
- [0:22] Highlight `##pane history prompt`
- [0:36] Callout: "MemoryEntry summaries"
