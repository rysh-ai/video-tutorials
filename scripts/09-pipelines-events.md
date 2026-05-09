# Group 9: Pipelines & Events (Stories 38-40)

Narration scripts for pipeline events and softdev orchestration.

**Total duration:** ~2 min 20s

---

## Story 38: Pipeline Events (##>) (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pipeline Events" | "Lines starting with ##> bypass the shell. They go straight to NATS." |
| 0:04 | Two panes: orchestrator (left), worker (right) | "Two panes. The worker is listening to the orchestrator." |
| 0:08 | Worker pane: `##pane listen orchestrator` | |
| 0:11 | In orchestrator, type `##>event:print:Build started at 10:30 AM` | "The double-hash-greater-than prefix is a pipeline event." |
| 0:15 | Event bypasses shell, no echo | "Notice: no shell echo. It bypasses the PTY entirely." |
| 0:19 | Worker pane receives the payload | "The worker receives the payload -- without the alias prefix." |
| 0:23 | In orchestrator, type `##>event:ai:softdev:golang:development` | "Now an AI event." |
| 0:27 | Worker's AI activates with a development prompt | "The worker's AI agent activates with a contextual software development prompt." |
| 0:32 | In orchestrator, type `##>event:sh:softdev:golang:unit_testing` | "A shell event." |
| 0:35 | Worker runs `go test -v ./...` | "The worker runs go test automatically." |
| 0:39 | End card | "Pipeline events: print messages, trigger AI, or run commands on listeners." |

### Key Moments to Annotate
- [0:11] Highlight: `##>` prefix
- [0:15] Callout: "Bypasses PTY"
- [0:23] Callout: "AI softdev event"
- [0:32] Callout: "Shell softdev event"

---

## Story 39: Software Development Pipeline (55s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Softdev Pipeline" | "A complete dev pipeline: plan, code, lint, test -- orchestrated across panes." |
| 0:04 | Two panes: orchestrator, worker | "Orchestrator on the left. Worker listening on the right." |
| 0:08 | `##pane listen orchestrator` in worker | |
| 0:10 | Phase 1: Planning | "Phase one: planning." |
| 0:12 | Type `##>event:ai:softdev:golang:planning` | "Send the planning event." |
| 0:15 | Worker's AI creates a structured plan | "The worker's AI creates an implementation plan." |
| 0:20 | Phase 2: Development | "Phase two: development." |
| 0:22 | Type `##>event:ai:softdev:golang:development` | |
| 0:25 | Worker's AI writes code based on plan | "The AI builds on the plan. It has the accumulated context from phase one." |
| 0:30 | Phase 3: Linting | "Phase three: linting." |
| 0:32 | Type `##>event:sh:softdev:golang:linting` | |
| 0:34 | Worker runs `go vet ./...` | "go vet runs automatically." |
| 0:37 | Phase 4: Testing | "Phase four: unit testing." |
| 0:39 | Type `##>event:sh:softdev:golang:unit_testing` | |
| 0:41 | Worker runs `go test -v ./...` | "Tests run. Results stream." |
| 0:45 | Show context accumulation | "Each phase builds on the previous. The listener maintains a 50KB context buffer." |
| 0:49 | End card | "Plan, code, lint, test -- a full pipeline orchestrated with events." |

### Key Moments to Annotate
- [0:12] Phase badge: "Planning"
- [0:22] Phase badge: "Development"
- [0:32] Phase badge: "Linting"
- [0:39] Phase badge: "Unit Testing"
- [0:45] Callout: "50KB context buffer"

---

## Story 40: Pipeline Commands (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pipeline Commands" | "Load, run, and manage multi-step pipelines." |
| 0:04 | Type `##pipe help` | "Pipeline help shows all available commands." |
| 0:07 | Output: command list | |
| 0:10 | Show a pipeline YAML file | "Pipelines are defined in YAML." |
| 0:14 | Type `##pipe load my-pipeline.yaml` | "Load a pipeline." |
| 0:17 | Output: "Pipeline loaded" | |
| 0:19 | Type `##pipe list` | "List all loaded pipelines." |
| 0:22 | Type `##pipe show my-pipeline` | "Inspect a pipeline's steps." |
| 0:25 | Type `##pipe run my-pipeline` | "Run it." |
| 0:28 | Pipeline executes across panes | "Each step fires in sequence." |
| 0:32 | Type `##pipe status` | "Check the status." |
| 0:35 | End card | "Pipelines: define, load, run, and monitor multi-step workflows." |

### Key Moments to Annotate
- [0:14] Highlight: `##pipe load`
- [0:25] Highlight: `##pipe run`
- [0:32] Highlight: `##pipe status`
