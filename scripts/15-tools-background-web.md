# Group 15: Tools — Background & Web (Stories 57-60)

Narration scripts for the background-execution and web tools. These show prompt mode (`<`) launching long-running jobs and reaching out to the internet. Starting and killing background jobs are approval-gated; reading output and the web tools are not.

**Total duration:** ~2 min 45s

---

## Story 57: Background Bash (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Background Bash" | "Long-running jobs don't block the agent -- bash_background returns a session id and keeps running." |
| 0:03 | Type `rysh` in a project | "Start rysh in a project with something long-running, like a dev server." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape for prompt mode." |
| 0:13 | Type "start a long-running ping ... in the background" | "Ask it to start a long-running command in the background. The bash_background tool launches it and immediately returns a session id." |
| 0:24 | Approval footer, press `y` | "So the agent stays free to keep working. Starting a background job is approval-gated -- press y to allow it." |
| 0:32 | Highlight ring buffer | "Output is captured in a 256-kilobyte ring buffer, and the session persists until you kill it or close the pane." |
| 0:42 | End card | "Fire it off, get a session id, and move on." |

### Key Moments to Annotate
- [0:13] Highlight the `bash_background` tool
- [0:24] Show approval prompt (approval-gated)
- [0:32] Callout: "256KB ring buffer, persists until killed"

---

## Story 58: Reading Background Output / Killing (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Reading Output & Killing" | "Check on a background job with bash_output, and shut it down with kill_shell." |
| 0:03 | Type `rysh` (job already running) | "Start rysh -- assume a background job is already running here." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape for prompt mode." |
| 0:13 | Type "list my background sessions and show output" | "Ask what the background jobs are doing. The bash_output tool reads from a session's ring buffer, or lists every running session." |
| 0:22 | AI shows sessions and output | "It's read-only, so there's no approval prompt." |
| 0:28 | Type "kill that background session", press `y` | "When you're done, ask it to stop the job. The kill_shell tool terminates the session and returns its final output -- approval-gated, so press y to confirm." |
| 0:37 | End card | "Watch it, then end it -- full control over background work." |

### Key Moments to Annotate
- [0:13] Highlight `bash_output` (no approval; reads or lists)
- [0:28] Highlight `kill_shell` (approval-gated; returns final output)

---

## Story 59: Web Search (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Web Search" | "Ask the agent to search the web -- web_search hits the Brave Search API." |
| 0:03 | Type `rysh` (Brave key set) | "Start rysh. Make sure your Brave API key is set so web_search is enabled." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape for prompt mode." |
| 0:13 | Type "search the web for the latest Go release" | "Ask it to look something up. The web_search tool queries the Brave Search API and feeds the results back to the agent." |
| 0:24 | AI summarizes results | "It summarizes them right in the pane. It's read-only, so it runs without an approval prompt." |
| 0:32 | Highlight config | "Web search is off until you set brave_api_key in config, or the RYSH_BRAVE_API_KEY environment variable." |
| 0:37 | End card | "The agent's reach extends past your machine -- straight to the web." |

### Key Moments to Annotate
- [0:13] Highlight the `web_search` tool (Brave Search API, no approval)
- [0:32] Callout: `brave_api_key` / `RYSH_BRAVE_API_KEY`

---

## Story 60: Web Fetch (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Web Fetch" | "Point the agent at a URL -- web_fetch pulls the page and summarizes it." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape for prompt mode." |
| 0:13 | Type "fetch https://go.dev and summarize it" | "Give it a link and ask for a summary. The web_fetch tool pulls the URL's content and hands it to the agent." |
| 0:24 | AI distills the page | "It reads it and distills the page into a few lines. Fetching is read-only -- no approval prompt." |
| 0:32 | Highlight pairing | "Pair web_fetch with web_search and the agent can find a source, open it, and bring the details back into your terminal." |
| 0:37 | End card | "Any page on the web, summarized in your pane." |

### Key Moments to Annotate
- [0:13] Highlight the `web_fetch` tool (no approval)
- [0:32] Callout: pairs with `web_search`
