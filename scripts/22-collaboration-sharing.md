# Group 22: Collaboration & Sharing (Stories 90-94)

Narration scripts for sharing panes, view vs control modes, sharing larger scopes, listing and unsharing, and secret redaction.

**Total duration:** ~3 min 45s

---

## Story 90: Sharing a Pane (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Sharing a Pane" | "One command publishes a live pane to your workspace -- teammates watch it in real time." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh with an upstream workspace configured. Sharing registers your pane on the server for remote collaborators." |
| 0:09 | Double-Escape, type `##share status` | "Double-Escape into rysh mode. ##share status shows whether you're connected to the upstream server." |
| 0:16 | Type `##share pane view` | "##share pane view publishes this pane. The ShareRegistry spawns an UpstreamShareActor that registers it on the server." |
| 0:26 | Back to shell mode, type `ls -la` | "Now anything you do here streams to subscribers. Redacted output forwards to the share's output topic continuously." |
| 0:34 | Rysh mode, type `##share list` | "Back in rysh mode, ##share list shows every active share in this session, each with its own share ID." |
| 0:44 | Hold frame | "From local pane to shared workspace in a single command. Your collaborators are now watching live." |

### Key Moments to Annotate
- [0:09] Highlight `##share status` connection state
- [0:16] Callout: ShareRegistryActor -> UpstreamShareActor registers on server
- [0:34] Highlight the share ID in `##share list`

---

## Story 91: View vs Control Mode (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "View vs Control Mode" | "View lets them watch. Control lets them type. You decide at share time." |
| 0:03 | Type `rysh`, double-Escape to rysh mode | "Start rysh and double-Escape into rysh mode. Every share command takes an optional mode: view or control." |
| 0:09 | Type `##share pane view` | "##share pane view is the default. Remote users observe live output but cannot send any input -- read-only." |
| 0:18 | Type `##unshare pane`, then `##share pane control` | "##unshare pane stops it. Now ##share pane control grants full control: subscribers can send shell commands and prompts." |
| 0:26 | Type `##share status` | "##share status reflects the current mode. Control-mode commands are validated server-side against a blocklist." |
| 0:36 | Type `##share list` | "The default share mode also comes from your [upstream] config, so --shared sessions start in view unless you change it." |
| 0:42 | Hold frame | "View to demo, control to pair. The choice is yours, pane by pane." |

### Key Moments to Annotate
- [0:09] Callout: view = observe only
- [0:18] Callout: control = remote can send shell/prompt input
- [0:26] Note: commands validated against `command_blocklist`

---

## Story 92: Sharing Groups, Lanes & Tabs (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Sharing Groups, Lanes & Tabs" | "Share one pane, or a whole tab. Each level brings its children along." |
| 0:03 | Type `rysh`, `Ctrl+P n`, `Ctrl+P v` to build layout | "Start rysh and split a couple of panes so we have a group, a lane, and a tab worth sharing." |
| 0:10 | Double-Escape to rysh mode | "Double-Escape into rysh mode. The share command works at four scopes: pane, panegroup, lane, and tab." |
| 0:16 | Type `##share panegroup control` | "##share panegroup control shares the active group -- every stacked pane inside it comes along." |
| 0:24 | Type `##share lane view` | "##share lane shares the whole column: all groups, all panes in that lane, as one unit." |
| 0:31 | Type `##share tab view` | "And ##share tab publishes the entire tab -- every lane and pane your collaborators need, in one command." |
| 0:39 | Type `##share list` | "##share list shows all of them together. Share at the level that fits the work." |

### Key Moments to Annotate
- [0:16] Callout: panegroup share includes stacked children
- [0:24] Callout: lane share includes all groups in the column
- [0:31] Callout: tab share includes all lanes

---

## Story 93: Listing & Unsharing (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Listing & Unsharing" | "See everything you're sharing, and pull any of it back with one command." |
| 0:03 | Type `rysh`, rysh mode, `##share pane control` | "Start rysh, double-Escape into rysh mode, and share a pane so we have something to manage." |
| 0:09 | Type `##share list` | "##share list is your single source of truth -- every active share in the session, with its scope, mode, and share ID." |
| 0:18 | Type `##unshare pane` | "##unshare pane stops sharing the active pane. The matching commands exist for panegroup, lane, and tab." |
| 0:28 | Type `##share list` | "List again -- the share is gone. Unregistering tears down the UpstreamShareActor and notifies the server." |
| 0:37 | Hold frame | "List to audit, unshare to revoke. You stay in control of what leaves your session." |

### Key Moments to Annotate
- [0:09] Highlight scope, mode, and share ID columns
- [0:18] Note: `##unshare panegroup|lane|tab` available too
- [0:28] Callout: UpstreamShareActor torn down on unshare

---

## Story 94: Secret Redaction (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Secret Redaction" | "Your secrets never leave your machine -- redaction happens before output is shared." |
| 0:03 | Type `rysh`, then `echo API_KEY=sk-ant-secret-123456` | "Start rysh. Suppose your terminal output contains an API key or token -- exactly the thing you don't want to broadcast." |
| 0:09 | Double-Escape, type `##private pane print` | "Double-Escape into rysh mode. ##private pane print shows the raw buffer -- everything, secrets included, on your screen." |
| 0:18 | Type `##public pane print` | "##public pane print shows the redacted version -- the same view the SharedOutputActor forwards upstream. Secrets are masked." |
| 0:28 | Type `##share pane view` | "When you share a pane, the SharedOutputActor redacts before output leaves the session, so the server never sees raw secrets." |
| 0:38 | Hold frame | "Redaction plus a command blocklist means collaboration without leaking credentials. Share with confidence." |

### Key Moments to Annotate
- [0:09] Callout: `##private` = raw buffer (local only)
- [0:18] Callout: `##public` = redacted buffer (what gets shared)
- [0:28] Callout: SharedOutputActor redacts before output leaves the local session
