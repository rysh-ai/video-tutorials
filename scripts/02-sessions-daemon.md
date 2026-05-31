# Group 2: Sessions & Daemon (Stories 5-9)

Narration scripts for the session lifecycle: starting, naming, detaching, driving from outside, and how state persists.

**Total duration:** ~3 min 50s

---

## Story 5: Your First Session (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Your First Session" | "Name a session, work in it, then detach -- and it keeps running without you." |
| 0:05 | Type `rysh my-project`, TUI opens | "Pass a name to rysh and you get a named session. Here we open one called my-project." |
| 0:13 | Run `git status` | "Work as usual -- run commands, build, test. This pane is a normal shell." |
| 0:21 | `Ctrl+O`, then `d` to detach | "Press Ctrl+O for prefix mode, then d to detach. You drop back to your shell, but the session lives on." |
| 0:30 | `rysh list-sessions` shows it detached | "rysh list-sessions shows it -- still alive, marked detached, with its process ID." |
| 0:39 | `rysh attach my-project`, TUI reopens | "Reattach any time with rysh attach my-project. Your output, history, and pane layout are all restored." |

### Key Moments to Annotate
- [0:21] Show key badge: `Ctrl+O` then `d`
- [0:30] Highlight the "detached" state and PID
- [0:39] Callout: "State restored from JetStream KV"

---

## Story 6: Named & Detached Sessions (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Named & Detached Sessions" | "Create a session attached, or spin one up headless as a background daemon." |
| 0:05 | `rysh create my-session`, TUI attaches | "rysh create my-session builds a fresh session and attaches its TUI right away." |
| 0:15 | `rysh create build-bot --detached`, prompt returns | "Add --detached, or just -d, and the daemon spawns headlessly -- no TUI, control returns to your prompt." |
| 0:27 | `rysh list-sessions` shows the headless one | "List your sessions and the headless one is right there, running in the background." |
| 0:36 | `rysh attach build-bot` | "Attach to it whenever you like with rysh attach. Detached now, fully interactive when you need it." |

### Key Moments to Annotate
- [0:15] Highlight `--detached` / `-d` flag
- [0:27] Highlight the background session in the list

---

## Story 7: Attach, Detach, List, Delete (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Attach, Detach, List, Delete" | "Four commands manage a session's whole lifecycle from outside the TUI." |
| 0:05 | `rysh list-sessions` | "rysh list-sessions shows every session, its state, and its process ID." |
| 0:14 | `rysh attach my-project`, then detach again | "rysh attach reopens a session's TUI exactly where you left it." |
| 0:22 | `rysh detach my-project` from the shell | "And rysh detach gracefully detaches a running session from outside -- no need to be inside it." |
| 0:31 | `rysh delete-session my-project`, then list again | "rysh delete-session tears it all down: it kills the process and purges the session's NATS data directory." |

### Key Moments to Annotate
- [0:22] Contrast: detach from inside (`Ctrl+O d`) vs. from outside (`rysh detach`)
- [0:31] Callout: "Kills process + purges NATS data"

---

## Story 8: Sending Input Remotely (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Sending Input Remotely" | "Drive a running session from the outside -- no attach required." |
| 0:05 | `rysh send my-session "ls -la"` | "rysh send delivers input to a session's active pane. Here we run ls -la in my-session without attaching." |
| 0:15 | `rysh send ... --pane abc123` | "Add --pane with a pane ID to target one exact pane." |
| 0:24 | `rysh send ... "summarize the codebase" --mode prompt` | "Use --mode prompt to send an AI prompt instead of a command -- the agent in that pane handles it." |
| 0:34 | `rysh send ... "make build" --mode shell` | "Or --mode shell to run a command explicitly. Omit --mode and Rysh uses the pane's current mode." |

### Key Moments to Annotate
- [0:15] Highlight `--pane <id>` selector
- [0:24] Highlight `--mode prompt` vs `--mode shell`

---

## Story 9: Session Persistence (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Session Persistence" | "Detach, reattach -- your panes come back exactly as you left them." |
| 0:05 | `ls ~/.local/state/rysh/nats/` | "Every session's state lives on disk under ~/.local/state/rysh/nats, one directory per session." |
| 0:15 | `ls ~/.local/state/rysh/nats/my-project/` | "Inside, two JetStream key-value buckets hold everything: rysh-workspace stores your tab and pane layout..." |
| 0:26 | Echo the bucket roles | "...and rysh-panes stores each pane's output buffer, mode, and last command, keyed by pane ID." |
| 0:36 | `rysh attach my-project`, state restored | "On attach, the workspace restores straight from KV. Detach freely -- nothing is lost." |

### Key Moments to Annotate
- [0:15] Highlight the `rysh-workspace` KV bucket
- [0:26] Highlight the `rysh-panes` KV bucket
- [0:36] Callout: "Restore-on-attach from JetStream KV"
