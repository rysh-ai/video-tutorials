# Group 26: Chrome, Server & Billing (Stories 107-111)

Narration scripts for the Chrome extension, the upstream server, subscription billing, and the chatbot widget. These cover the surfaces that turn rysh from a local tool into a collaboration platform.

**Total duration:** ~4 min

---

## Story 107: Chrome Extension Browser Automation (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Chrome Extension" | "A rysh pane that lives in your browser's side panel and drives the page." |
| 0:05 | Echo: side panel is a pane | "The Chrome extension's side panel is a real rysh pane -- same modes, same AI agent -- except its job is to drive the browser you are looking at." |
| 0:15 | Echo: connection | "It connects to your session the same way every other client does: a NATS-over-WebSocket link back to the bus." |
| 0:26 | Echo: persistence | "Because the agent lives in the pane and not the page, your conversation persists across navigations -- click a link, load a new URL, the agent keeps its full context." |
| 0:38 | Echo: wrap | "Ask the agent to fill a form or pull data, and it acts on the live tab -- a browser copilot wired into your terminal." |

### Key Moments to Annotate
- [0:05] Highlight "side panel = a rysh pane"
- [0:15] Callout: NATS-over-WebSocket
- [0:26] Callout: conversation persists across navigations

---

## Story 108: Browser Tools (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Browser Tools" | "Navigate, click, type, screenshot -- the agent's browser toolbelt." |
| 0:05 | Echo: browser_action | "The core tool is browser_action -- it can navigate to a URL, type into a field, or click an element on the page." |
| 0:15 | Echo: get_text / screenshot | "To read the page, the agent uses get_text to pull content, and screenshot to capture the view as a base64 image it can reason over." |
| 0:26 | Echo: execute_js + tabs | "It can run arbitrary page JavaScript with execute_js -- which always requires your approval -- and manage tabs: get_tabs, switch_tab, new_tab, close_tab." |
| 0:36 | Echo: selectors | "And to find elements reliably, it has six selector strategies -- so it can target the right thing even on messy pages." |

### Key Moments to Annotate
- [0:05] Highlight `browser_action`: navigate / type / click
- [0:26] Callout: `execute_js` requires approval
- [0:36] Callout: 6 selector strategies

---

## Story 109: The Upstream Server (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "The Upstream Server" | "rysh-server: the hub that routes shares between machines." |
| 0:05 | Echo: what it is | "rysh-server is the optional upstream hub. Local sessions connect to it to share panes, groups, and tabs with collaborators on other machines." |
| 0:15 | Echo: tech stack | "Under the hood it is Go and Gin for the API, PostgreSQL for persistence, an embedded NATS server for real-time messaging, and nginx out front." |
| 0:26 | Echo: what it manages | "The server handles authentication with JWT or Firebase, and it owns workspaces, members, API keys, and the routing and access control for every share." |
| 0:37 | Echo: deployment | "It ships as a Docker Compose stack -- make dev-up for development, make prod-up for production -- so you can stand up your own hub in minutes." |

### Key Moments to Annotate
- [0:15] Highlight stack: Go/Gin + PostgreSQL + embedded NATS + nginx
- [0:26] Callout: JWT/Firebase auth, workspaces, members, API keys, share routing
- [0:37] Callout: Docker Compose dev/prod

---

## Story 110: Stripe Billing & Plans (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Stripe Billing & Plans" | "Four tiers, Stripe checkout, and limits enforced in three places." |
| 0:05 | Echo: tiers | "The server has four plans. Free, Solo at nineteen dollars a month, Team at forty-nine, and Enterprise with custom pricing -- each raises your limits." |
| 0:16 | Echo: limits | "The limits cap three resources: workspaces, concurrent sessions, and panes -- so Free is one workspace, three sessions, thirty panes; Team jumps to twenty, two hundred, two thousand." |
| 0:27 | Echo: Stripe integration | "Payments run through Stripe. The billing page offers monthly or yearly with Stripe Checkout, a Billing Portal for managing the subscription, and webhooks that keep the server in sync." |
| 0:38 | Echo: three layers | "Limits are enforced at three layers: workspaces server-side at creation, sessions server-side at the WebSocket upgrade, and panes daemon-side in the WorkspaceActor before a pane is spawned." |

### Key Moments to Annotate
- [0:05] Highlight tiers: Free / Solo $19 / Team $49 / Enterprise
- [0:16] Callout: limits on workspaces / sessions / panes
- [0:38] Callout: enforced at 3 layers

---

## Story 111: Chatbot Widget & Connections (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Chatbot Widget & Connections" | "Drop a rysh-powered chatbot on your website with one script tag." |
| 0:05 | Echo: per-workspace config | "Each workspace has its own chatbot config -- a system prompt, a model, and a list of allowed origins that may embed it." |
| 0:15 | Echo: widget script | "You embed it with a single script -- chatbot slash widget dot js -- and the widget appears on your site." |
| 0:25 | Echo: visitor sessions + takeover | "Every visitor gets their own session, and at any point a human can step in and take over the conversation from the bot." |
| 0:35 | Echo: external connections | "Beyond the website, the same workspace can connect external channels -- Slack, WhatsApp, Email -- so every conversation lands in one place." |

### Key Moments to Annotate
- [0:05] Highlight chatbot config: system prompt / model / allowed origins
- [0:15] Highlight `/chatbot/widget.js`
- [0:25] Callout: per-visitor sessions + human takeover
