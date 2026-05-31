# Group 23: Upstream & Remote (Stories 95-98)

Narration scripts for connecting to upstream, subscribing to remote shares, remote control, and workspaces.

**Total duration:** ~3 min

---

## Story 95: Connecting to Upstream (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Connecting to Upstream" | "Point Rysh at a workspace URL and an API key -- now your session can join the hub." |
| 0:03 | Type `cat rysh.config`, show `[upstream]` block | "Upstream lives in your rysh.config under the [upstream] section: enabled, the server url, and your api_key." |
| 0:11 | Type `rysh --shared` | "Start rysh with --shared and it auto-shares the first pane to the workspace as soon as it boots." |
| 0:19 | Double-Escape, type `##upstream status` | "Double-Escape into rysh mode. ##upstream status shows your configuration and whether the connection is live." |
| 0:28 | Type `##upstream my-shares` | "The client connects over NATS-over-WebSocket to rysh-server. ##upstream my-shares lists what this session has published." |
| 0:38 | Type `##share status` | "Prefer env vars? RYSH_UPSTREAM_ENABLED, RYSH_UPSTREAM_URL, and RYSH_UPSTREAM_API_KEY override the config at launch." |
| 0:46 | Hold frame | "Config or flags, you're connected to the workspace -- ready to share and subscribe." |

### Key Moments to Annotate
- [0:03] Highlight `enabled`, `url`, `api_key` in `[upstream]`
- [0:11] Highlight `--shared` flag auto-sharing first pane
- [0:28] Callout: NATS-over-WebSocket to rysh-server

---

## Story 96: Subscribing to a Remote Share (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Subscribing to a Remote Share" | "Discover what your teammates are sharing, then subscribe to watch it live." |
| 0:03 | Type `rysh`, double-Escape to rysh mode | "Start rysh connected to your workspace and double-Escape into rysh mode." |
| 0:09 | Type `##upstream list-remote` | "##upstream list-remote asks the server for every share in the workspace -- not just yours, but your teammates' too." |
| 0:18 | Type `##upstream subscribe abc123 view` | "Pick a share ID and ##upstream subscribe with view or control. A RemoteShareListenerActor pipes its output into your pane." |
| 0:28 | Type `##upstream my-shares` | "##upstream my-shares now reflects what you're connected to, alongside anything you're publishing." |
| 0:36 | Type `##upstream unsubscribe` | "Done watching? ##upstream unsubscribe stops the stream and tears down the listener." |
| 0:42 | Hold frame | "List, subscribe, unsubscribe -- the full remote-viewing loop." |

### Key Moments to Annotate
- [0:09] Callout: list-remote queries the server for all workspace shares
- [0:18] Callout: RemoteShareListenerActor forwards output to local pane
- [0:36] Highlight `##upstream unsubscribe`

---

## Story 97: Remote Control (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Remote Control" | "In control mode you don't just watch -- you can drive the remote pane yourself." |
| 0:03 | Type `rysh`, double-Escape to rysh mode | "Start rysh and double-Escape into rysh mode. First we subscribe to a share in control mode." |
| 0:09 | Type `##upstream subscribe abc123 control` | "##upstream subscribe with control requests two-way access. The owner shared it as control, so commands are allowed." |
| 0:17 | Type `##upstream send ls -la` | "##upstream send pushes text to the remote pane. The server validates you're a subscriber and checks the blocklist first." |
| 0:27 | Type `####pane info` | "Want to run a rysh command on the source pane? Prefix it with four hashes -- ####pane info runs ##pane info remotely." |
| 0:37 | Type `##upstream send git status` | "If the owner set command_approval, each command waits for their yes before it executes. Safety stays with the pane's owner." |
| 0:42 | Hold frame | "Control mode turns a remote share into true pair programming -- gated by the owner's rules." |

### Key Moments to Annotate
- [0:17] Callout: server validates subscriber + mode + blocklist
- [0:27] Callout: `####<command>` runs `##<command>` on the source pane
- [0:37] Note: `command_approval` requires owner's yes

---

## Story 98: Workspaces (##ws) (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Workspaces (##ws)" | "A workspace is your shared space -- API-key-scoped, and managed right from rysh mode." |
| 0:03 | Type `rysh`, double-Escape to rysh mode | "Start rysh and double-Escape into rysh mode. Workspaces are managed with the ##ws command." |
| 0:09 | Type `##ws list` | "##ws list shows the workspaces you can reach. Each API key is scoped to exactly one workspace, so access stays isolated." |
| 0:18 | Type `##ws create team-rocket sk-ws-abc123` | "##ws create takes a name and an API key, registering a new workspace you can share into." |
| 0:28 | Type `##ws list` | "List once more to see it. The new workspace is keyed and ready for shares and subscribers." |
| 0:36 | Hold frame | "One API key, one workspace -- clean boundaries for every team you collaborate with." |

### Key Moments to Annotate
- [0:09] Callout: API key scoped to a single workspace
- [0:18] Highlight `##ws create <name> <api_key>`
- [0:28] Note: workspace ready for shares/subscribers
