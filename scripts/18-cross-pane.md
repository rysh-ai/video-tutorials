# Group 18: Cross-Pane Coordination (Stories 69-72)

Narration scripts for the cross-pane coordination stories. These show how panes work together: live output listening with redaction, cross-pane inspection and input, the hop command for handoffs, and full multi-pane AI workflows.

**Total duration:** ~3 min 5s

---

## Story 69: Pane Listening (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pane Listening" | "Pipe one pane's live output straight into another -- secrets redacted automatically." |
| 0:03 | Type `rysh`, split with `Ctrl+P n` | "Start rysh and split a second pane. We'll have one pane listen to the other." |
| 0:08 | Source pane, `##pane name builder` | "In the left pane, switch to rysh mode and give it a name so the listener has an alias to attach to." |
| 0:18 | Other pane, `##pane listen builder` | "Move to the other pane and run pane listen builder. Now the builder's shared output flows here, prefixed [builder]." |
| 0:28 | Builder pane runs a command | "Back in the builder, run a command. Its output appears in the listening pane in real time -- secrets stripped first." |
| 0:40 | `##pane unlisten` | "When you're done, the listening pane runs pane unlisten to detach the stream." |
| 0:47 | End card | "Cross-pane awareness with redaction built in." |

### Key Moments to Annotate
- [0:08] Highlight `##pane name builder`
- [0:18] Highlight `##pane listen builder`
- [0:28] Highlight the `[builder]` output prefix in the listening pane

---

## Story 70: Inspecting & Sending Across Panes (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Inspecting & Sending Across Panes" | "Your agent can read another pane's state and even type into it -- with approval." |
| 0:03 | Type `rysh`, split with `Ctrl+P n` | "Start rysh and split a second pane so the agent has a neighbor to inspect and drive." |
| 0:09 | Prompt: list panes and status | "From prompt mode, ask the agent who else is around. The agents_list tool shows every pane and its status." |
| 0:20 | Prompt: inspect the other pane | "Ask it to inspect that other pane. pane_inspect reads the pane's recent output and state without you switching focus." |
| 0:32 | Prompt: send `pwd`; approve with `y` | "Now have it send a command into that pane. pane_send injects input -- and because it acts elsewhere, it asks for approval." |
| 0:42 | End card | "Inspect, coordinate, and act across panes -- safely." |

### Key Moments to Annotate
- [0:09] Highlight the `agents_list` tool
- [0:20] Highlight the `pane_inspect` tool
- [0:32] Highlight the `pane_send` tool + approval prompt

---

## Story 71: The Hop Command (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "The Hop Command" | "Hop a pane's output into another and let a fresh agent pick up right where you left off." |
| 0:03 | Type `rysh`, split with `Ctrl+P n` | "Start rysh and split a target pane to hop into." |
| 0:08 | Target pane, `##pane name reviewer` | "Name the right-hand pane so we can hop to it by name." |
| 0:18 | Source pane: run a command, then `##hop reviewer` | "Back in the source pane, generate some work, then run hop reviewer to transfer this pane's output to that one." |
| 0:30 | `##hop status`, then reviewer `##hop resume` | "Check hop status to confirm. In the reviewer pane, run hop resume and the agent continues with the copied text." |
| 0:40 | `##hop clear` | "When the handoff is done, hop clear wipes the copied content from the pane." |
| 0:47 | End card | "Hand work from pane to pane in one command." |

### Key Moments to Annotate
- [0:18] Highlight `##hop reviewer`
- [0:30] Highlight `##hop status` and `##hop resume`
- [0:40] Highlight `##hop clear`

---

## Story 72: Cross-Pane AI Workflows (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Cross-Pane AI Workflows" | "Combine listening, inspection, and sending to solve problems across many panes at once." |
| 0:03 | Type `rysh`, build a couple of panes | "Start rysh and create a couple of panes -- think of one as a server and one as a coordinator." |
| 0:10 | Coordinator: list and inspect every pane | "From the coordinator pane, the agent lists every pane with agents_list to see what's running and where." |
| 0:18 | Drive a fix across panes; approve with `y` | "Now it inspects a failing pane and uses pane_send to apply a fix there -- a full multi-pane workflow from one prompt." |
| 0:32 | End card | "Listen, inspect, and send -- together they turn separate panes into one coordinated agentic team." |

### Key Moments to Annotate
- [0:10] Highlight `agents_list` + `pane_inspect`
- [0:18] Highlight `pane_send` + approval gate
