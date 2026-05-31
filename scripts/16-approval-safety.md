# Group 16: Approval & Safety (Stories 61-64)

Narration scripts for the approval and safety stories. These show how Rysh keeps an autonomous agent under your control: tool gating, remembered decisions, loop detection, and centralized approval routing.

**Total duration:** ~3 min

---

## Story 61: Tool Approval Flow (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Tool Approval Flow" | "Your AI agent never touches a file or runs a destructive command without your say-so." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh. We're in shell mode -- your familiar terminal." |
| 0:08 | Double-Esc to prompt mode, ask to edit README.md | "Double-press Escape for prompt mode, then ask the agent to change a file. Tools like file_edit always need approval." |
| 0:16 | Footer shows action + diff preview | "Before anything is written, the footer shows the action and a diff preview. Nothing changes until you decide." |
| 0:30 | Press `y` to approve | "Press y to approve. The edit applies and the agent continues. Press n to reject and the action is cancelled." |
| 0:40 | Recap the gated tools | "Reads and searches run freely. But writes, patches, commits, and dangerous bash are all gated behind you." |
| 0:47 | End card | "You are always the final approver." |

### Key Moments to Annotate
- [0:16] Highlight the footer action line and diff preview
- [0:30] Show key badges: `y` approve, `n` reject

---

## Story 62: Approve Always & Reject With Reason (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Approve Always & Reject With Reason" | "Approve once and forever, or reject with a reason the agent can learn from." |
| 0:03 | Type `rysh`, switch to prompt mode | "Start rysh and switch into prompt mode to talk to the agent." |
| 0:08 | Ask to create notes.txt, approval appears | "Ask the agent to create a file. file_write is a gated tool, so an approval prompt appears in the footer." |
| 0:16 | Press capital `Y` | "Press capital Y to approve always. Rysh remembers this decision so the same kind of action won't ask again." |
| 0:26 | Ask to delete; press `N`, type reason | "Now ask for something risky. Press capital N to reject with a reason -- type why, and the agent adapts." |
| 0:38 | Recap the five keys | "y approves, capital Y always approves, n rejects, capital N rejects with a reason, and Escape rejects silently." |

### Key Moments to Annotate
- [0:16] Key badge: `Y` (approve always)
- [0:26] Key badge: `N` (reject with reason) + reject-reason input field

---

## Story 63: Loop Detection & Last-Prompt-Wins (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Loop Detection & Last-Prompt-Wins" | "Runaway agents get stopped, and a new prompt always interrupts the old one." |
| 0:03 | Type `rysh`, prompt mode | "Start rysh and drop into prompt mode." |
| 0:08 | Kick off a big analysis prompt | "Give the agent a big task. The orchestrator watches a sliding window of twenty tool calls as it works." |
| 0:20 | Send a new prompt mid-run | "Change your mind mid-thought. Send a new prompt and the in-flight LLM call is cancelled -- last prompt wins." |
| 0:34 | Echo the loop-detection rule | "And if the agent repeats the same tool call three times, loop detection blocks it so it can never spin forever." |
| 0:42 | End card | "Safe by design: no infinite loops, always interruptible." |

### Key Moments to Annotate
- [0:08] Callout: "sliding window of 20 tool calls"
- [0:20] Callout: "last-prompt-wins -- in-flight call cancelled"
- [0:34] Callout: "blocks after 3 identical invocations"

---

## Story 64: Approval Panes (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Approval Panes" | "Route every approval request to one dedicated pane and triage them in one place." |
| 0:03 | Type `rysh`, split a pane with `Ctrl+P n` | "Start rysh, then split a second pane that will collect approvals from across your workspace." |
| 0:08 | Rysh mode, `##pane approval-pane approvals` | "Switch to rysh mode and register this pane as the approval pane. Now tool requests from other panes land right here." |
| 0:18 | `##pane approval-pane list` and `enable-attention` | "List pending approvals, clear the queue, and enable an attention indicator so you never miss a waiting action." |
| 0:30 | `##pane approval-pane clear` | "A quick clear empties the queue when you're caught up." |
| 0:37 | End card | "One pane, every decision, no context switching." |

### Key Moments to Annotate
- [0:08] Highlight `##pane approval-pane <name>` command
- [0:18] Highlight `list` and `enable-attention` subcommands
