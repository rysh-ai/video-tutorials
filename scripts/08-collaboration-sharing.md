# Group 8: Collaboration & Sharing (Stories 33-37)

Narration scripts for collaboration features. Local pane listening, remote sharing, and context hopping.

**Total duration:** ~3 min 50s

---

## Story 33: Cross-Pane Listening (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Cross-Pane Listening" | "Pane B watches everything Pane A does. Live." |
| 0:04 | Two panes side by side | "Two panes. Let's name the left one builder." |
| 0:07 | Type `##pane name builder` in left pane | |
| 0:10 | Switch to right pane | "In the right pane..." |
| 0:12 | Type `##pane listen builder` | "Tell it to listen to builder." |
| 0:15 | Output: "Listening to builder" | |
| 0:17 | Switch to left pane (builder) | "Now run commands in the builder." |
| 0:19 | Type `ls -la` in builder | |
| 0:22 | Right pane shows output prefixed with `[builder]` | "The right pane sees everything -- prefixed with the source name." |
| 0:26 | Run more commands in builder | "Every command, every output, forwarded live." |
| 0:30 | Callout: "Secret redaction" | "The SharedOutputActor strips secrets before forwarding." |
| 0:34 | Switch to right pane, type `##pane unlisten` | "unlisten to stop." |
| 0:38 | End card | "Cross-pane listening with automatic secret redaction." |

### Key Moments to Annotate
- [0:12] Highlight: `##pane listen`
- [0:22] Callout: `[builder]` prefix
- [0:30] Overlay: "SharedOutputActor redacts secrets"
- [0:34] Highlight: `##pane unlisten`

---

## Story 34: Sharing Panes to the Cloud (55s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Cloud Sharing" | "Share your pane with anyone. View-only or full control." |
| 0:04 | Show config file, `[upstream]` section | "First, configure the upstream server in your config." |
| 0:08 | Show: `enabled = true`, `url = "wss://rysh.ai"` | "Enable it, set the URL." |
| 0:12 | Back to terminal | |
| 0:14 | Type `##share pane view` | "Share the active pane in view-only mode." |
| 0:17 | Output: "Shared: share-abc123 (view)" | "It's live. Anyone with the share ID can subscribe." |
| 0:21 | Type `##share pane control` | "Or share in control mode." |
| 0:24 | Output: "Shared: share-def456 (control)" | "Control mode lets remote users send commands." |
| 0:28 | Switch to remote user's perspective | "On the other end..." |
| 0:31 | Type `##upstream subscribe share-abc123` | "Subscribe to the shared output." |
| 0:34 | Output streams in from the source | "Live output from the source pane." |
| 0:38 | Type `##share list` | "Back on the source -- list active shares." |
| 0:41 | Output shows shares | |
| 0:44 | Type `##unshare pane` | "Unshare when done." |
| 0:47 | Output: "Unshared" | |
| 0:50 | End card | "View-only for observation. Control for pair programming. Share to the cloud." |

### Key Moments to Annotate
- [0:14] Highlight: `##share pane view`
- [0:21] Highlight: `##share pane control`
- [0:31] Highlight: `##upstream subscribe`
- [0:44] Highlight: `##unshare pane`

---

## Story 35: Sharing at Every Level (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Sharing Granularity" | "Share one pane. Or a whole tab. Your choice." |
| 0:04 | Diagram: Tab -> Lane -> PaneGroup -> Pane | "Rysh has a hierarchy: tab, lane, pane group, pane." |
| 0:08 | Highlight: single pane | "Share a single pane." |
| 0:10 | Type `##share pane view` | |
| 0:13 | Highlight: pane group | "Share a pane group -- all stacked panes." |
| 0:15 | Type `##share panegroup control` | |
| 0:18 | Highlight: lane | "Share a lane -- an entire column." |
| 0:20 | Type `##share lane view` | |
| 0:23 | Highlight: tab | "Share a tab -- everything in it." |
| 0:25 | Type `##share tab control` | |
| 0:28 | Explain: child panes included | "Each level includes all child panes." |
| 0:32 | End card | "Share exactly what you want -- from a single pane up to an entire tab." |

### Key Moments to Annotate
- [0:04] Hierarchy diagram
- [0:10] Highlight level: Pane
- [0:15] Highlight level: PaneGroup
- [0:20] Highlight level: Lane
- [0:25] Highlight level: Tab

---

## Story 36: Remote Command Execution (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Remote Control Mode" | "A remote user sends a command to your pane. You control what's allowed." |
| 0:04 | Type `##share pane control` | "Share in control mode." |
| 0:07 | Switch to remote perspective | "On the remote side..." |
| 0:10 | Type `##upstream subscribe share-xyz` | "Subscribe." |
| 0:13 | Type `##upstream send make build` | "Send a command." |
| 0:16 | Command runs in local pane | "The command executes locally." |
| 0:19 | Back to local config | "But you control the rules." |
| 0:22 | Show config: `allowed_commands` | "Whitelist: only specific commands are allowed." |
| 0:26 | Show config: `command_blocklist` | "Blocklist: dangerous commands are always rejected." |
| 0:30 | Show config: `command_approval = true` | "Approval mode: every remote command requires your confirmation." |
| 0:35 | Show approval dialog | "You see the command and approve or reject." |
| 0:39 | End card | "Whitelist, blocklist, and optional approval. You're always in control." |

### Key Moments to Annotate
- [0:13] Highlight: `##upstream send`
- [0:22] Config highlight: `allowed_commands`
- [0:26] Config highlight: `command_blocklist`
- [0:30] Config highlight: `command_approval`

---

## Story 37: The Hop Command (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "The Hop Command" | "Copy one pane's context into another. Then resume the AI conversation." |
| 0:04 | Two panes: source with history, empty target | "Pane A has been working. Pane B is fresh." |
| 0:08 | In pane A, type `##hop pane-B-name` | "Hop sends pane A's entire output to pane B." |
| 0:12 | Output: "Hopped to pane-B" | |
| 0:15 | Switch to pane B | "Switch to pane B." |
| 0:17 | Output: "Received 142 lines from pane-A" | "It received 142 lines of context." |
| 0:21 | Type `##hop resume` | "Now type hop resume." |
| 0:24 | AI gets context wrapped in `<copied-text>` tags | "The AI in pane B gets the full context from pane A wrapped in special tags." |
| 0:28 | AI acknowledges and summarizes | "It acknowledges and summarizes what it sees." |
| 0:32 | Continue the conversation | "Now you can continue the conversation in pane B with full awareness of pane A's work." |
| 0:37 | End card | "Hop transfers context. Resume picks it up. Seamless hand-off between panes." |

### Key Moments to Annotate
- [0:08] Highlight: `##hop <target>`
- [0:21] Highlight: `##hop resume`
- [0:24] Callout: `<copied-text>` wrapper
