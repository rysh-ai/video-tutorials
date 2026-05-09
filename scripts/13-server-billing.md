# Group 13: Server, Deployment & Billing (Stories 48-50)

Narration scripts for the upstream server, billing, and session management.

**Total duration:** ~2 min 25s

---

## Story 48: The Upstream Server (55s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Upstream Server" | "A Go server that bridges rysh sessions. PostgreSQL, NATS, Docker." |
| 0:04 | Architecture diagram | "The upstream server is a self-hosted collaboration hub." |
| 0:08 | Show stack: Go + Gin, PostgreSQL, NATS, nginx, React | "Go and Gin for the API. PostgreSQL for data. Embedded NATS for real-time messaging. React for the dashboard." |
| 0:15 | Terminal, type `docker compose up -d` | "Start the full stack with Docker Compose." |
| 0:18 | Services starting | "Five services: postgres, migrate, backend, frontend, nginx." |
| 0:23 | Open browser, show web dashboard | "The web dashboard for workspace management." |
| 0:27 | Register a user, create workspace | "Register, create a workspace, get an API key." |
| 0:32 | Show config: `[upstream]` with API key | "Configure your local rysh with the server URL and API key." |
| 0:37 | Type `##share pane view` | "Now you can share panes." |
| 0:40 | Output flows through server | "Output flows through the server to remote subscribers." |
| 0:44 | Show: `make dev-up` vs `make prod-up` | "Dev mode for development. Prod mode for production with resource limits and logging." |
| 0:49 | End card | "A self-hosted collaboration hub. Share panes, manage workspaces, connect sessions." |

### Key Moments to Annotate
- [0:04] Architecture diagram
- [0:15] Highlight: `docker compose up -d`
- [0:18] Service list overlay
- [0:44] Highlight: dev vs prod

---

## Story 49: Subscription Billing with Stripe (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Stripe Billing" | "Four tiers. Free to Enterprise. Stripe Checkout built in." |
| 0:04 | Pricing table overlay | "Four tiers." |
| 0:07 | Free tier | "Free: 1 workspace, 3 sessions, 30 panes. Zero dollars." |
| 0:11 | Solo tier | "Solo: 3 workspaces, 10 sessions, 100 panes. Nineteen dollars a month." |
| 0:15 | Team tier | "Team: 20 workspaces, 200 sessions, 2000 panes. Forty-nine dollars." |
| 0:19 | Enterprise tier | "Enterprise: unlimited. Custom pricing." |
| 0:22 | Web dashboard billing page | "The billing page in the web dashboard." |
| 0:25 | Monthly/yearly toggle | "Monthly or yearly toggle." |
| 0:27 | Click "Upgrade" | "Click upgrade." |
| 0:29 | Stripe Checkout opens | "Stripe Checkout opens for secure payment." |
| 0:32 | Click "Manage Billing" | "Manage billing opens the Stripe portal -- change plan, update payment, cancel." |
| 0:36 | Show resource enforcement | "Limits are enforced at three levels: workspaces on the server, sessions at WebSocket upgrade, panes in the daemon." |
| 0:41 | End card | "Stripe billing, fully integrated. Checkout, portal, webhooks, and resource enforcement." |

### Key Moments to Annotate
- [0:04] Pricing table
- [0:29] Callout: "Stripe Checkout"
- [0:32] Callout: "Stripe Billing Portal"
- [0:36] Overlay: "3-level enforcement"

---

## Story 50: Session Management (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Session Management" | "Control sessions from the command line. Even without a TUI." |
| 0:04 | Type `rysh my-session` | "Start a named session." |
| 0:07 | TUI opens | |
| 0:09 | Press `Ctrl+O d` | "Detach with Ctrl+O d." |
| 0:12 | Back to shell | "The session runs in the background." |
| 0:14 | Type `rysh list-sessions` | "List all sessions." |
| 0:17 | Output: my-session, detached, PID | "Name, state, PID." |
| 0:20 | Type `rysh attach my-session` | "Reattach. Full state restored from JetStream KV." |
| 0:24 | TUI reopens | |
| 0:26 | Detach again | |
| 0:28 | Type `rysh send my-session "go test ./..."` | "Send a command without attaching." |
| 0:32 | Type `rysh send my-session "explain failures" --mode prompt` | "Send an AI prompt." |
| 0:36 | Type `rysh detach my-session` | "Detach from outside -- sends SIGUSR1." |
| 0:39 | Type `rysh delete-session my-session` | "Delete: terminates the process, removes the record, deletes NATS data." |
| 0:43 | End card | "Full CLI lifecycle: start, detach, attach, send, delete." |

### Key Moments to Annotate
- [0:09] Key badge: `Ctrl+O d`
- [0:20] Highlight: `rysh attach`
- [0:28] Highlight: `rysh send`
- [0:39] Highlight: `rysh delete-session`
