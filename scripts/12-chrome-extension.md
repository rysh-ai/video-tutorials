# Group 12: Chrome Extension & Browser Automation (Stories 46-47)

Narration scripts for the Chrome extension. Your browser becomes a pane.

**Total duration:** ~1 min 50s

---

## Story 46: Chrome Extension -- Browser as a Pane (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Chrome Extension" | "The Chrome extension IS a pane. Same protocol. Same tools." |
| 0:04 | Chrome with extension installed | "Install the Rysh Chrome extension." |
| 0:07 | Open side panel | "Open the side panel." |
| 0:10 | Extension connects via NATS WebSocket | "It connects to rysh-server via NATS WebSocket -- the same protocol as every other actor." |
| 0:15 | Type: "What am I looking at?" | "Ask the AI about the current page." |
| 0:18 | AI reads page context, responds | "The AI reads the active tab's content and responds." |
| 0:23 | Navigate to a different page | "Navigate to a different page." |
| 0:26 | Type another prompt | "Ask another question." |
| 0:29 | AI responds with page-specific context | "It adapts to whatever page you're on." |
| 0:33 | Show approval dialog in extension | "Tool approvals work here too. File edits, bash commands -- all gated." |
| 0:38 | Show conversation history | "Conversation history persists across page navigations." |
| 0:42 | Explain: NATSEnvelope protocol | "The extension speaks the exact same NATSEnvelope protocol as the CLI." |
| 0:46 | End card | "Your browser is a rysh pane." |

### Key Moments to Annotate
- [0:10] Callout: "NATS WebSocket connection"
- [0:18] Callout: "AI reads page context"
- [0:33] Callout: "Approval dialog"
- [0:42] Overlay: "NATSEnvelope protocol"

---

## Story 47: Browser Automation (60s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Browser Automation" | "Navigate, click, type, screenshot -- the AI drives your browser." |
| 0:04 | Extension side panel open | "From the extension, ask the AI to do something." |
| 0:07 | Type: "Go to GitHub and search for rysh" | "Navigate and search." |
| 0:10 | AI uses browser_action: navigate | "The AI navigates to GitHub." |
| 0:13 | AI uses browser_action: type | "Types in the search box." |
| 0:16 | AI uses browser_action: click | "Clicks search." |
| 0:19 | Results appear | "GitHub search results." |
| 0:21 | Type: "What are the first 3 results?" | "Ask about the results." |
| 0:24 | AI uses get_text | "The AI uses get_text to extract page content." |
| 0:27 | Results listed | |
| 0:29 | Type: "Take a screenshot" | "Take a screenshot." |
| 0:31 | AI captures visible tab | "The visible tab is captured." |
| 0:34 | Show element selection strategies | "Elements can be selected by CSS, XPath, text content, ARIA label, role, or test ID." |
| 0:40 | Show: `execute_js` with approval | "execute_js runs arbitrary JavaScript -- but it requires approval." |
| 0:44 | Show approval dialog | "You approve before any code runs." |
| 0:47 | Tab management: `get_tabs`, `switch_tab` | "Tab management: get all tabs, switch between them, open new ones, close them." |
| 0:52 | Type: "Close the current tab" | |
| 0:54 | AI uses close_tab | |
| 0:56 | End card | "Full browser control. Navigate, click, type, extract, screenshot, manage tabs." |

### Key Moments to Annotate
- [0:10] Tool badge: "navigate"
- [0:13] Tool badge: "type"
- [0:16] Tool badge: "click"
- [0:24] Tool badge: "get_text"
- [0:34] Overlay: "6 selector strategies"
- [0:40] Callout: "Approval required"
