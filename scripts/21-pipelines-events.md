# Group 21: Pipelines & Events (Stories 85-89)

Narration scripts for pipeline mode, loading and running pipelines, pipeline events, the softdev orchestration pipeline, and placeholders.

**Total duration:** ~3 min 50s

---

## Story 85: Pipeline Mode (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pipeline Mode" | "A tab can become a pipeline. One key flips it on and your events start flowing." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh. Any tab can be promoted into a pipeline tab, where events orchestrate work across panes." |
| 0:08 | `Ctrl+P` then `p` | "Press Ctrl+P to enter pane mode, then p to toggle pipeline mode for this tab." |
| 0:16 | Double-Escape to rysh mode, type `##tab pipeline enable` | "You can also do it from rysh mode -- ##tab pipeline enable turns it on explicitly." |
| 0:24 | Type `##tab list` | "##tab list confirms the tab is now pipeline-enabled, ready to load and run pipelines." |
| 0:32 | Type `##tab pipeline disable` | "When you're done, ##tab pipeline disable turns it back off -- or just double-Escape, which toggles pipeline mode off." |
| 0:40 | Hold frame | "Pipeline mode is the on-switch for event-driven orchestration across your panes." |

### Key Moments to Annotate
- [0:08] Key badges: `Ctrl+P`, then `p`
- [0:16] Highlight `##tab pipeline enable`
- [0:32] Note: double-Escape toggles pipeline mode off

---

## Story 86: Loading & Running Pipelines (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Loading & Running Pipelines" | "Define a pipeline in a file, load it, run it -- ##pipe drives the whole lifecycle." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh. Pipelines live as files under .rysh/pipelines in your project." |
| 0:08 | Double-Escape, type `##pipe help` | "Double-Escape into rysh mode. ##pipe help lists everything the pipeline command can do." |
| 0:14 | Type `##pipe load build.pipeline` | "##pipe load build.pipeline reads the file from .rysh/pipelines and registers it in this tab." |
| 0:22 | Type `##pipe list`, then `##pipe show build` | "##pipe list shows what's loaded; ##pipe show prints a pipeline's steps and details." |
| 0:28 | Type `##pipe run build` | "##pipe run executes it -- defaulting to the first loaded pipeline when you omit the name." |
| 0:38 | Type `##pipe status` | "##pipe status reports execution progress phase by phase." |
| 0:45 | Type `##pipe clear` | "And ##pipe clear wipes the pipeline output when you're done. Load, run, status, clear -- the full loop." |

### Key Moments to Annotate
- [0:14] Highlight path `.rysh/pipelines/build.pipeline`
- [0:28] Highlight `##pipe run` default behavior
- [0:38] Highlight phase-by-phase status

---

## Story 87: Pipeline Events (##>) (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pipeline Events (##>)" | "Lines starting with double-hash-greater-than bypass the shell and fly straight to NATS." |
| 0:03 | Type `rysh`, `Ctrl+P n` to split worker | "Start rysh and split a second pane. We'll have this worker listen to the first pane's shared output." |
| 0:09 | Worker in rysh mode: `##pane listen orchestrator` | "In rysh mode, ##pane listen forwards another pane's shared output here. Event payloads arrive without an alias prefix." |
| 0:18 | `Tab` to orchestrator, double-Escape to rysh mode | "Hop to the orchestrator pane and switch it to rysh mode so we can emit a pipeline event." |
| 0:25 | Type `##>event:print:Build started at 10:30 AM` | "##>event:print: takes a payload. This line never touches the PTY -- it publishes straight to the pane's NATS output topic." |
| 0:34 | Type `##>event:print:Compiling module auth` | "Send as many as you like. Each event is a clean line in the shared output buffer, visible to every listening pane." |
| 0:42 | Hold frame | "##> is your event bus -- shell-free messages between panes." |

### Key Moments to Annotate
- [0:09] Highlight `##pane listen`
- [0:25] Callout: "Bypasses PTY -> publishes to NATS output topic"
- [0:34] Note: payload forwarded without alias prefix

---

## Story 88: The Softdev Pipeline (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "The Softdev Pipeline" | "One event line can trigger an AI agent to plan, build, lint, and test -- automatically." |
| 0:03 | Type `rysh`, `Ctrl+P n` to split worker | "Start rysh and split a worker pane. The worker will listen and react to software-development events." |
| 0:09 | Worker: `##pane listen orchestrator` | "In rysh mode, the worker listens to the orchestrator pane, so softdev events fire its AgenticActor." |
| 0:16 | `Tab` to orchestrator, double-Escape rysh mode | "Back on the orchestrator, switch to rysh mode. The softdev schema is ai or sh, softdev, language, then phase." |
| 0:24 | Type `##>event:ai:softdev:golang:planning` | "ai softdev golang planning triggers the worker's agent to analyze the codebase and draft an implementation plan." |
| 0:33 | Type `##>event:sh:softdev:golang:development` | "The sh prefix runs a real command instead. sh softdev golang development runs go build across the listening pane." |
| 0:41 | Type `##>event:ai:softdev:golang:unit_testing` | "ai softdev golang unit_testing has the agent run go test and fix any failures. Phases run from planning to monitoring." |
| 0:47 | Hold frame | "Planning, development, linting, testing, deployment, monitoring -- an autonomous build pipeline, one event at a time." |

### Key Moments to Annotate
- [0:24] Callout: AI event -> AgenticActor with contextual prompt
- [0:33] Callout: `sh:` event -> runs `go build ./...`
- [0:41] List the seven phases: planning, development, linting, unit_testing, integration_testing, deployment, monitoring

---

## Story 89: Pipeline Placeholders (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pipeline Placeholders" | "Placeholders are lanes reserved for pipeline output -- name them, add them, watch results land." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh. A pipeline can route its output into named placeholder lanes so each phase has a home." |
| 0:08 | Double-Escape, type `##pipe name release-flow` | "Double-Escape into rysh mode. ##pipe name labels the current pipeline so its output is easy to identify." |
| 0:15 | Type `##pipe placeholder add` | "##pipe placeholder add creates a new placeholder lane -- a dedicated column for one slice of pipeline output." |
| 0:24 | Type `##pipe placeholder add`, then `##pipe placeholder list` | "Add as many as your pipeline needs, then ##pipe placeholder list shows every placeholder currently defined." |
| 0:32 | Hold frame | "Placeholders turn a pipeline into a structured dashboard -- one lane per stage, output flowing into place." |

### Key Moments to Annotate
- [0:08] Highlight `##pipe name`
- [0:15] Callout: placeholder = a lane for pipeline output
- [0:24] Highlight `##pipe placeholder list`
