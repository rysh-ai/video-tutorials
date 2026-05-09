# Diagrams & Visual Assets

ASCII diagrams for on-screen overlays, architecture explanations, and visual reference during recording.

---

## 1. Rysh Architecture Overview

```
+--------------------------------------------------+
|                   Rysh Session                    |
|                                                   |
|  +-----------+     +----------+     +-----------+ |
|  |    TUI    |     |   NATS   |     |   Web     | |
|  | (Bubble   |<--->|   Bus    |<--->| Terminal  | |
|  |   Tea)    |     |(embedded)|     | (React)   | |
|  +-----------+     +----+-----+     +-----------+ |
|                         |                         |
|              +----------+----------+              |
|              |                     |              |
|  +-----------+---+   +------------+----+          |
|  | WorkspaceActor|   |  JetStream KV  |          |
|  +-------+-------+   +----------------+          |
|          |                                        |
|    +-----+-----+                                  |
|    |           |                                  |
|  +-+---+   +--+---+                              |
|  | Tab |   | Tab  |                              |
|  +-+---+   +------+                              |
|    |                                              |
|  +-+--------+--------+                           |
|  |          |        |                            |
|  +---+  +---+  +----+                            |
|  |Lane| |Lane| |Lane |                           |
|  +-+--+ +-+--+ +--+--+                           |
|    |      |       |                               |
|  +-+--+ +-+--+ +-+---+                           |
|  | PG | | PG | | PG  |  (PG = PaneGroup)         |
|  +-+--+ +----+ +-+---+                           |
|    |              |                               |
|  +-+--+  +----+ +-+--+                           |
|  |Pane|  |Pane| |Pane |                           |
|  +-+--+  +----+ +-+--+                           |
|    |              |                               |
|  +-+------+  +---+----+                           |
|  |Agentic |  |Agentic |                           |
|  | Actor  |  | Actor  |                           |
|  +--------+  +--------+                           |
+--------------------------------------------------+
```

---

## 2. Four Input Modes

```
+----------+    Double     +----------+    Double     +----------+    Double     +----------+
|  SHELL   | -- Escape --> |  PROMPT  | -- Escape --> |   RYSH   | -- Escape --> |   CHAT   |
|    >     |               |    <     |               |    ##    |               |    @     |
| Commands |               | AI Agent |               |  System  |               |  Agents  |
+----------+               +----------+               +----------+               +----------+
     ^                                                                                 |
     |                              Double Escape                                      |
     +---------------------------------------------------------------------------------+
```

---

## 3. Pane Layout: Columns, Rows, and Stacks

```
Tab
+-------------------+-------------------+-------------------+
|                   |                   |                   |
|   Lane 1          |   Lane 2          |   Lane 3          |
|   (Flex: 1)       |   (Flex: 2)       |   (Flex: 1)       |
|                   |                   |                   |
| +--------------+  | +--------------+  | +--------------+  |
| | PaneGroup 1  |  | | PaneGroup 3  |  | | PaneGroup 5  |  |
| |              |  | |              |  | | [1/3] Stack  |  |
| | Pane A       |  | | Pane C       |  | | Pane E (top) |  |
| |              |  | |              |  | | ~~~~~~~~~~~~ |  |
| +--------------+  | +--------------+  | | Pane F       |  |
| | PaneGroup 2  |  |                   | | Pane G       |  |
| | (SplitDown)  |  |                   | +--------------+  |
| |              |  |                   |                   |
| | Pane B       |  |                   |                   |
| |              |  |                   |                   |
| +--------------+  |                   |                   |
+-------------------+-------------------+-------------------+

Legend:
  Lane     = Column (horizontal flex weight)
  PaneGroup = Vertical section within a lane (row flex weight)
  Stack    = Multiple panes in one group ([top visible] / background title bars)
```

---

## 4. Actor Hierarchy

```
WorkspaceActor
 |
 +-- TabActor (1..n)
 |    |
 |    +-- LaneActor (1..n)
 |         |
 |         +-- PaneGroupActor (1..n)
 |              |
 |              +-- PaneActor (1..n, stacked)
 |                   |
 |                   +-- AgenticActor (child, LLM execution)
 |                   +-- SharedOutputActor (child, redaction)
 |                   +-- PaneSharedOutputListenerActor (optional)
 |                   +-- RemoteShareListenerActor (optional)
 |
 +-- AgentRegistryActor
 |    |
 |    +-- AgentActor (1..n, headless)
 |         |
 |         +-- AgenticActor (child)
 |
 +-- HumanoidRegistryActor
 |    |
 |    +-- HumanoidActor (1..n, headless)
 |         |
 |         +-- AgenticActor (child)
 |         +-- ChannelAdapter (1..n, goroutines)
 |
 +-- ShareRegistryActor
      |
      +-- UpstreamShareActor (1..n)
```

---

## 5. Humanoid Architecture

```
External Platform           Rysh Humanoid                    LLM
+--------------+           +------------------+           +---------+
| Slack msg    | --------> | ChannelAdapter   | --------> |         |
| WhatsApp msg |  inbound  | (per channel)    |  prompt   | Agentic |
| Email        | --------> |                  | --------> | Actor   |
| SMS          |           | HumanoidActor    |           |         |
| Chat widget  |           |  - contexts      |           |         |
+--------------+           |  - routing       |           +---------+
       ^                   |                  |               |
       |                   |                  |               |
       +-------------------| ChannelAdapter   | <-------------+
            outbound       |  Send()          |   response
                           +------------------+
```

---

## 6. NATS Message Flow

```
Control Plane (ordered, sequential):
  TUI --> rysh.ws.{session}.inbox --> WorkspaceActor
       --> rysh.tab.{tabID}.inbox --> TabActor
       --> rysh.lane.{laneID}.inbox --> LaneActor
       --> rysh.pane-group.{groupID}.inbox --> PaneGroupActor
       --> rysh.pane.{paneID}.inbox --> PaneActor

Data Plane (low latency, direct):
  PTY output --> rysh.pane.{paneID}.output --> TUI subscriber
  AI output  --> rysh.pane.{paneID}.output --> TUI subscriber
  Raw keys   --> rysh.pane.{paneID}.rawinput --> PaneActor (1-hop)

Pass-through (WorkspaceActor -> PaneActor directly):
  Input, rename, listener, share commands
  Skip Tab/Lane/PaneGroup (2-hop instead of 5)
```

---

## 7. Sharing Flow

```
Local Session                  Upstream Server              Remote Session
+------------+                +----------------+            +------------+
|            |                |                |            |            |
| PaneActor  |  output        |                |  output    |            |
|     |      | ------------> | NATS Broker    | --------> | Listener   |
|     v      |                |                |            |   Pane     |
| SharedOutput|  redacted     |                |            |            |
|   Actor    | ------------> |   share topic  |            |            |
|            |                |                |            |            |
|            |  command       |                |  command   |            |
|            | <------------ | (control mode) | <-------- | Remote     |
|            |                |                |            |   User     |
+------------+                +----------------+            +------------+

Security: SharedOutputActor redacts secrets BEFORE output leaves the session.
```

---

## 8. Pipeline Event Flow

```
Orchestrator Pane                              Worker Pane
+------------------+                          +------------------+
|                  |                          |                  |
| ##>event:print:  | -----> NATS output ----> | PaneSharedOutput |
|   Hello World    |                          | ListenerActor    |
|                  |                          |   |              |
| ##>event:ai:     | -----> NATS output ----> |   +-> AI prompt  |
|   softdev:       |                          |       (Agentic)  |
|   golang:dev     |                          |                  |
|                  |                          |   +-> Shell cmd  |
| ##>event:sh:     | -----> NATS output ----> |   |   go test    |
|   softdev:       |                          |                  |
|   golang:test    |                          |                  |
+------------------+                          +------------------+

Context: Listener maintains 50KB buffer of non-event output.
```

---

## 9. Tool Approval Strategies

```
Preview-First (file_edit, file_write, apply_patch, multi_edit):
  1. AI proposes change
  2. Tool executes (preview only)
  3. Diff displayed to user
  4. User approves/rejects
  5. Change committed (if approved)

Pre-Approval (bash, bash_background, kill_shell, git_commit):
  1. AI describes what it wants to run
  2. User sees command/description
  3. User approves/rejects
  4. Tool executes (if approved)
  5. Output returned

Auto-Approved (file_read, glob, grep, tree, symbol_search, ...):
  1. AI calls tool
  2. Tool executes immediately
  3. Output returned

Approval Options:
  y = Approve this call
  Y = Approve all future calls of this tool type
  n = Reject
  N = Reject with reason (guides AI to try differently)
```

---

## 10. Web Terminal Architecture

```
+------------------+         +------------------+        +------------------+
|                  |         |                  |        |                  |
|   Browser        |  WS     |   web.Server     | NATS   |   Actor System   |
|   (React SPA)    | <-----> |   (embedded)     | <----> |   (proto.actor)  |
|                  |         |                  |        |                  |
|  - Renders       |  JSON   |  - Snapshots     | Pub/   |  - Workspace     |
|    snapshots     |  frames |    every 200ms   | Sub    |  - Tabs          |
|  - Sends         |         |  - Routes        |        |  - Panes         |
|    commands      |         |    commands       |        |  - Agents        |
|                  |         |                  |        |                  |
+------------------+         +------------------+        +------------------+

Embedded via //go:embed -- no external frontend server needed.
Single binary contains CLI + web server + React frontend.
```

---

## 11. Session Lifecycle

```
              rysh <name>
                  |
                  v
          +-------+-------+
          |   RUNNING     |
          | (TUI attached)|
          +---+-------+---+
              |       |
    Ctrl+O d  |       | exit / Ctrl+D
              v       v
      +-------+--+ +--+--------+
      | DETACHED | | STOPPED   |
      | (bg proc)| | (no proc) |
      +----+-----+ +-----------+
           |             ^
  rysh     |             |
  attach   |    rysh     |
  <name>   |    delete   |
           v    <name>   |
      +----+-----+      |
      |  RUNNING  |------+
      +----------+
```

---

## 12. Subscription Tiers

```
+----------+----------+----------+----------+
|   FREE   |   SOLO   |   TEAM   |  ENTER-  |
|          |          |          |  PRISE   |
+----------+----------+----------+----------+
| 1 ws     | 3 ws     | 20 ws    | Unlimited|
| 3 sess   | 10 sess  | 200 sess | Unlimited|
| 30 panes | 100 panes| 2000     | Unlimited|
|          |          | panes    |          |
+----------+----------+----------+----------+
| $0/mo    | $19/mo   | $49/mo   | Custom   |
+----------+----------+----------+----------+

Enforcement:
  Workspaces -> Server (API)
  Sessions   -> WebSocket upgrade
  Panes      -> Daemon (WorkspaceActor)
```

---

## Usage Notes

- Copy these diagrams directly into video editing software as text overlays.
- Use a monospace font (JetBrains Mono, Fira Code) for rendering.
- Scale to fill the relevant portion of the screen.
- Add a semi-transparent dark background behind the diagram for readability.
- Fade in/out with 0.3s transition.
- Keep on screen for at least 5 seconds -- these take time to parse visually.
