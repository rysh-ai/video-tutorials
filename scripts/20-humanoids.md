# Group 20: Humanoids (Stories 79-84)

Narration scripts for humanoids -- autonomous agents that bridge external communication channels: WhatsApp, Slack, Email, Phone, and Chatbot.

**Total duration:** ~4 min 30s

---

## Story 79: What Are Humanoids? (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Humanoids" | "An agent that talks to the outside world -- WhatsApp, Slack, email, phone, chat." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. A humanoid is an autonomous agent plus bidirectional external communication channels." |
| 0:09 | Double-Escape into rysh mode | "An inbound message becomes a prompt; the AI reply goes back out through the same channel." |
| 0:16 | Type `##humanoid spawn support "..."` | "Spawn it just like an agent: a name and a system prompt. Use ##humanoid spawn instead of ##agent spawn." |
| 0:26 | Type `##humanoid list`, channels column shown | "##humanoid list shows every humanoid, its status, and which channels it has connected." |
| 0:36 | Type `@support how would you greet...` | "You can still talk to it directly with the at-sign prefix, exactly like any agent -- channels just add external reach on top." |
| 0:47 | AI response renders | "Humanoids: your AI, reachable wherever your users already are." |

### Key Moments to Annotate
- [0:03] Callout: agent + channels (WhatsApp/Slack/Email/Phone/Chatbot)
- [0:16] Highlight `##humanoid spawn <name> <system-prompt>`
- [0:36] Show prefix badge: `@name` works for humanoids too

---

## Story 80: Spawning a Humanoid (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Spawning a Humanoid" | "Inline prompt or a skill file with a contacts block -- either way, it's one command." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. The quickest way is an inline system prompt." |
| 0:08 | Write `.rysh/humanoids/support.md` with `contacts.slack` | "For real channels, write a skill file. It looks like an agent skill file but adds a contacts section -- here, a Slack block with tokens and channels." |
| 0:18 | Type `cat .rysh/humanoids/support.md` | "Name, description, model, then the contacts block. The dollar-brace ENV_VAR syntax pulls secrets from the environment at parse time." |
| 0:28 | Double-Escape, `##humanoid spawn .../support.md` | "Spawn from the file with ##humanoid spawn. Rysh wires up every channel in the contacts block." |
| 0:38 | Type `##humanoid list` | "##humanoid list shows it running, with its Slack channel attached." |

### Key Moments to Annotate
- [0:08] Highlight `contacts:` YAML section
- [0:18] Highlight `${ENV_VAR}` secret resolution
- [0:28] Highlight `##humanoid spawn <file.md>`

---

## Story 81: Slack Channel (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Slack Channel" | "Drop your humanoid into Slack and let it answer threads on its own." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. The Slack channel is configured under contacts.slack: a bot token, an app token, and the channels to join." |
| 0:10 | Write/show skill file with `slack` block | "Tokens use the ENV_VAR syntax so they never sit in plaintext. Channels list the rooms the humanoid listens and replies in." |
| 0:20 | Double-Escape, `##humanoid spawn .../support.md` | "Spawn it from the file." |
| 0:28 | Type `##humanoid channel start support slack` | "Start the Slack adapter explicitly with ##humanoid channel start, the humanoid's name, and the channel type slack." |
| 0:36 | Type `##humanoid channels support` | "##humanoid channels support shows the connection details -- which channels it joined and whether the adapter is live." |

### Key Moments to Annotate
- [0:03] Highlight `contacts.slack`: `bot_token`, `app_token`, `channels`
- [0:28] Highlight `##humanoid channel start <name> slack`
- [0:36] Highlight `##humanoid channels <name>`

---

## Story 82: Email Channel (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Email Channel" | "Give your humanoid an inbox -- it reads incoming mail and writes the replies." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. The email channel lives under contacts.email with IMAP for reading and SMTP for sending." |
| 0:10 | Write/show skill file with `email` block | "Set the address, IMAP host and port, SMTP host and port, and the username and password as ENV_VARs." |
| 0:22 | Double-Escape, `##humanoid spawn .../support.md` | "Spawn it. The humanoid gains email_list, email_read, and email_send tools." |
| 0:31 | Type `##humanoid channel start support email` | "Start the email adapter and the humanoid begins polling the inbox, turning each new message into a prompt and mailing back its answer." |
| 0:39 | Type `##humanoid channels support` | "##humanoid channels support confirms the inbox is connected and live." |

### Key Moments to Annotate
- [0:03] Highlight `contacts.email`: `imap_host`/`imap_port`, `smtp_host`/`smtp_port`
- [0:22] Callout tools: `email_list`, `email_read`, `email_send`
- [0:31] Highlight `##humanoid channel start <name> email`

---

## Story 83: WhatsApp & Phone Channels (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "WhatsApp & Phone Channels" | "WhatsApp Cloud API and Twilio phone -- your humanoid reaches everyone's pocket." |
| 0:03 | Type `rysh`, TUI launches | "Launch rysh. WhatsApp uses the Cloud API; phone uses Twilio. Both go in the contacts block." |
| 0:10 | Write/show skill file with `whatsapp` + `phone` | "WhatsApp needs a phone, an api_key, and a business_id. Phone needs a number, the provider twilio, an account_sid, and an auth_token -- every secret pulled in with the ENV_VAR syntax." |
| 0:24 | Double-Escape, spawn, `##humanoid channel start support whatsapp` | "Spawn the humanoid, then start the WhatsApp channel." |
| 0:33 | Type `##humanoid channel start support phone` | "Start the phone channel the same way -- name, then the channel type." |
| 0:40 | Type `##humanoid channels support` | "##humanoid channels support lists both channels, now live." |

### Key Moments to Annotate
- [0:10] Highlight `contacts.whatsapp` (`phone`/`api_key`/`business_id`) and `contacts.phone` (`provider: twilio`)
- [0:10] Highlight `${ENV_VAR}` secrets
- [0:24] Highlight `##humanoid channel start <name> <channel-type>`

---

## Story 84: Humanoids vs Agents (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Humanoids vs Agents" | "Same brain, same skill format -- agents face inward, humanoids face the world." |
| 0:03 | Type `rysh`, double-Escape to rysh mode | "Launch rysh and drop into rysh mode. Let's spawn one of each and compare." |
| 0:09 | Type `##agent spawn worker "..."` | "An agent is an internal worker -- no terminal, no external reach. Perfect for reviewing code or running tasks inside the workspace." |
| 0:17 | Type `##humanoid spawn support "..."` | "A humanoid is the same agent plus external channels. Same skill file format -- it just adds a contacts block." |
| 0:25 | Type `@@worker deactivate`, `@@support deactivate` | "And the at-sign and double-at-sign prefixes work for both -- Rysh resolves the name across both registries automatically." |
| 0:34 | Hold final frame | "Agents are your internal team; humanoids are your public face. One format, two reaches." |

### Key Moments to Annotate
- [0:09] Callout: agent = internal worker
- [0:17] Callout: humanoid = agent + `contacts:` channels
- [0:25] Show `@`/`@@` resolve across both registries
