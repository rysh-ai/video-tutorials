# Group 10: Web Terminal (Stories 41-43)

Narration scripts for the embedded web terminal. Browser-based full TUI parity.

**Total duration:** ~2 min 5s

---

## Story 41: The Embedded Web Terminal (55s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Web Terminal" | "Your full terminal. In a browser. Same shortcuts, same modes, same everything." |
| 0:04 | Terminal, type `##rysh web start` | "Start the web server." |
| 0:07 | Output: "Web server started on port 23232" | "Running on port 23232." |
| 0:10 | Open browser, go to localhost:23232 | "Open it in your browser." |
| 0:13 | Web TUI loads -- tabs, panes, footer | "The full TUI. Tabs, panes, mode indicators -- everything." |
| 0:18 | Type a command in the browser | "Type a shell command." |
| 0:21 | Output appears | "It runs on the same backend." |
| 0:24 | Switch modes (Double-Escape) | "Double-Escape switches modes, just like the CLI." |
| 0:27 | Enter tab mode (Ctrl+T) | "All 13 interaction modes work." |
| 0:30 | Create a pane (Ctrl+P n) | "Split panes." |
| 0:33 | Show approval workflow | "Even the approval workflow works -- diff display, clickable approve/reject." |
| 0:38 | Run vim in a pane | "Run vim. The VT screen renders in the browser." |
| 0:42 | Show raw mode working in browser | "Raw mode, keyboard forwarding -- all of it." |
| 0:47 | Side by side: CLI and browser showing same state | "Both views show the same workspace. Same NATS bus. Same actors." |
| 0:51 | End card | "Full-fidelity browser terminal. Same engine, different frontend." |

### Key Moments to Annotate
- [0:04] Highlight: `##rysh web start`
- [0:13] Callout: "Full TUI in the browser"
- [0:33] Callout: "Approval workflow"
- [0:47] Split screen overlay

---

## Story 42: Web Terminal Architecture (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Architecture" | "It's not a separate service. It's the same NATS bus." |
| 0:04 | Architecture diagram on screen | "The web terminal shares the exact same backend as the CLI." |
| 0:08 | Highlight: Browser -> WebSocket -> web.Server | "The browser connects via WebSocket." |
| 0:12 | Highlight: web.Server -> NATS Bus | "The web server publishes commands to the NATS bus -- the same bus the TUI uses." |
| 0:16 | Highlight: NATS Bus -> Actor System | "Actors process them identically." |
| 0:19 | Show: "Snapshots every 200ms" | "The server pushes workspace snapshots every 200 milliseconds via WebSocket." |
| 0:24 | Highlight: React + TypeScript frontend | "The frontend is React plus TypeScript." |
| 0:28 | Show: `//go:embed` | "It's embedded in the binary via go:embed. No external dependencies." |
| 0:32 | Show: single binary | "One binary. CLI and web server. Zero external deps at runtime." |
| 0:36 | End card | "Same NATS bus, same actors, same state. A second frontend, not a separate service." |

### Key Moments to Annotate
- [0:04] Architecture diagram
- [0:19] Overlay: "200ms snapshots"
- [0:28] Callout: "go:embed"

---

## Story 43: Web Terminal Commands (30s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Web Commands" | "Start, stop, and check status. Three commands." |
| 0:03 | Type `##rysh web start` | "Start on the default port." |
| 0:06 | Output: port 23232 | |
| 0:08 | Type `##rysh web start 9090` | "Or specify a custom port." |
| 0:11 | Output: port 9090 | |
| 0:13 | Type `##rysh web status` | "Check if it's running." |
| 0:16 | Output: "Running on port 9090" | |
| 0:18 | Type `##rysh web stop` | "Stop it gracefully." |
| 0:21 | Output: "Web server stopped" | |
| 0:23 | Explain: auto-shutdown | "When your rysh session exits, the web server shuts down automatically." |
| 0:27 | End card | "Three commands. Auto-cleanup on exit." |

### Key Moments to Annotate
- [0:03] Highlight: `##rysh web start`
- [0:13] Highlight: `##rysh web status`
- [0:18] Highlight: `##rysh web stop`
