# Group 7: Humanoids -- AI with External Channels (Stories 29-32)

Narration scripts for humanoids. These extend agents with real-world communication.

**Total duration:** ~3 min

---

## Story 29: What Are Humanoids? (55s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Humanoids" | "An AI agent that answers your Slack, email, WhatsApp, and phone." |
| 0:04 | Architecture diagram on screen | "A humanoid is an autonomous agent -- same as what we saw before -- but with external communication channels." |
| 0:10 | Show diagram flow: External -> ChannelAdapter -> HumanoidActor -> AgenticActor -> LLM | "A message arrives from Slack. It flows through a channel adapter to the humanoid actor, which sends it to the LLM." |
| 0:18 | Show return path: LLM -> HumanoidActor -> ChannelAdapter -> External | "The LLM response flows back through the same channel adapter to Slack." |
| 0:24 | Show five channel icons | "Five channels: WhatsApp, Slack, Email, Phone via Twilio, and a website Chatbot." |
| 0:30 | Show conversation context | "Each thread gets its own conversation context." |
| 0:34 | Show: "20-turn history, 24-hour TTL" | "The last 20 turns, with a 24-hour expiry." |
| 0:38 | Show contextual prompt format | "When a message comes in, the humanoid builds a rich prompt with sender info, channel context, and conversation history." |
| 0:45 | Show prompt snippet | |
| 0:49 | End card | "Humanoids bridge AI agents and the outside world." |

### Key Moments to Annotate
- [0:10] Architecture diagram with arrows
- [0:24] Five channel icons: WhatsApp, Slack, Email, Phone, Chatbot
- [0:34] Overlay: "20 turns, 24h TTL"

---

## Story 30: Spawning a Humanoid from a Skill File (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Humanoid Skill Files" | "A Markdown file that connects your AI to Slack and email." |
| 0:04 | Show skill file in editor | "A humanoid skill file looks like an agent file, but with a contacts section." |
| 0:08 | Highlight YAML frontmatter | "Name, description, model -- same as agents." |
| 0:12 | Highlight `contacts:` section | "The contacts section defines your channels." |
| 0:15 | Show slack config | "Slack needs a bot token, app token, and channels." |
| 0:19 | Show email config | "Email needs IMAP and SMTP credentials." |
| 0:22 | Highlight `${SLACK_BOT_TOKEN}` | "Notice the dollar-curly-brace syntax. Secrets come from environment variables." |
| 0:26 | Show: "Resolved at parse time" | "Variables are resolved when the file is loaded. No plaintext secrets in your repo." |
| 0:30 | Back to terminal | |
| 0:32 | Type `##humanoid spawn support-agent.md` | "Spawn from the file." |
| 0:35 | Output: humanoid created, channels listed | "The humanoid is created. Channels are configured." |
| 0:38 | Type `##humanoid list` | "List shows the humanoid with channel status." |
| 0:41 | Type `##humanoid channels support-agent` | "Detailed channel info." |
| 0:44 | End card | "Skill files define both the AI persona and its communication channels." |

### Key Moments to Annotate
- [0:12] Highlight `contacts:` section
- [0:22] Callout: `${ENV_VAR}` syntax
- [0:26] Overlay: "No plaintext secrets"
- [0:32] Highlight: `##humanoid spawn`

---

## Story 31: Managing Humanoid Channels (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Managing Channels" | "Start and stop channels individually. Full control." |
| 0:03 | Type `##humanoid channel start support-agent slack` | "Start the Slack channel adapter." |
| 0:07 | Output: "Slack channel started" | "The Slack adapter connects via Socket Mode." |
| 0:10 | Type `##humanoid channel stop support-agent email` | "Stop the email adapter." |
| 0:14 | Output: "Email channel stopped" | |
| 0:16 | Type `##humanoid channels support-agent` | "Check channel status." |
| 0:19 | Output: Slack connected, Email disconnected | "Slack: connected. Email: stopped." |
| 0:23 | Explain: inbound messages trigger AI | "When a message arrives on Slack, the AI processes it and responds in-thread." |
| 0:28 | Type `@support-agent what's the current status?` | "You can also prompt the humanoid directly." |
| 0:32 | Agent responds | "Same @name prefix as regular agents." |
| 0:36 | End card | "Each channel starts and stops independently." |

### Key Moments to Annotate
- [0:03] Highlight: `##humanoid channel start`
- [0:10] Highlight: `##humanoid channel stop`
- [0:23] Diagram: Slack -> HumanoidActor -> LLM -> Slack

---

## Story 32: Humanoid vs Agent (35s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Humanoid vs Agent" | "Agent for internal work. Humanoid for external communication." |
| 0:04 | Split screen comparison table | "Let's compare." |
| 0:07 | Row 1: External channels | "Agents: none. Humanoids: WhatsApp, Slack, Email, Phone, Chatbot." |
| 0:12 | Row 2: LLM execution | "Both use the same AgenticActor. Same 35+ tools." |
| 0:16 | Row 3: Output | "Agents output to pane chat. Humanoids output to pane chat AND external channels." |
| 0:21 | Row 4: Use cases | "Agents: code review, testing, monitoring. Humanoids: customer support, Slack bots, auto-responders." |
| 0:27 | Row 5: Prompt/control | "Both use @name for prompts and @@name for control." |
| 0:31 | End card | "Agents work inside. Humanoids work with the outside world. Same AI engine." |

### Key Moments to Annotate
- [0:04] Comparison table overlay
- [0:07] Highlight difference: external channels
- [0:21] Highlight difference: use cases
