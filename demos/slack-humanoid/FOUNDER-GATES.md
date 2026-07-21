# ad07 Slack humanoid video — FOUNDER GATES

> Status as of **2026-07-15 (night)**: **BOTH GATES CLOSED — CLEARED TO FILM.**
> Gate 1: Slack governance implemented + step-flow leak fixed on branch
> `feat-slack-governance` (worktree `worktrees/rysh-cli-feat-slack-governance`,
> not yet merged/committed). Gate 2: tokens live in
> `.rysh/secrets/halil-macbook-rysh/SLACK_{BOT,APP}_TOKEN` (workspace **Peralabs**,
> bot user **rysh**, `#support` exists, bot is a member, all scopes present,
> Socket Mode verified). **Full E2E verified on real Slack 2026-07-15 ~01:16**:
> mention in human mode → total channel silence → draft → typed `send` → exactly
> one approved reply posted in-thread. Film against the worktree's `./rysh_local`.
>
> ⚠️ **SHOOT-CRITICAL gotcha discovered during E2E:** the desktop app session
> `rysh` runs its own `slack-bot` humanoid on the SAME Slack app in ai mode — it
> auto-replies to every @Rysh mention and will wreck any take. Before filming:
> `rysh --humanoid --session rysh channel stop slack-bot slack`
> (restore after: `… channel start slack-bot slack`). Check for OTHER daemons
> holding the app too: `ps aux | grep 'rysh.*daemon'`.

---

## Gate 1 — CLOSED: Slack governance implemented (2026-07-15)

Implemented in `worktrees/rysh-cli-feat-slack-governance` (mirrors the shipped
human-governed WhatsApp pattern):

- `slackGovernance` flag: read from `contacts.slack.governance` at spawn (default
  `ai`), flipped live by `##humanoid governance <name> ai|human` — **fully live in
  BOTH directions** (slack_* tools register for every Slack humanoid at spawn, so
  the flip needs no respawn; the governance system prompt is mode-neutral).
- Human mode inbound: no auto-reply. The pane shows the message and the AI
  **auto-prepares a reply draft** via `slack_draft` (channel + thread_ts retained);
  the outbound flush is suppressed. The human types **`send`** → `slack_send` posts
  into the right channel/thread. Exact on-screen strings for QC are in the master
  plan's verification note.
- New tools: `slack_list`, `slack_read`, `slack_draft`, `slack_send` (send requires
  approval), backed by an in-memory message store on the Slack adapter.
- UX fix: governance changes now report WHICH channels switched
  (`[governance] mode changed to: human (slack)`); a humanoid with no governable
  channels says so instead of printing a false success. The workspace ack reads
  `requested governance "human" for <name>`.
- Tests: `internal/tools/slack_tools_test.go`, `internal/channels/slack_store_test.go`,
  `internal/actors/humanoid_slack_governance_test.go` (incl. the money-shot flow:
  inbound in human mode fires the draft-only prompt, outbound suppressed). Full
  `go test ./internal/...` green; `go vet` clean; headless smoke via
  `rysh_local create --detached` + `rysh --humanoid --session <s> …` verified
  spawn/list/governance.

**Product findings from the dry-run shoots (2026-07-15 night, for the founder):**
1. **TUI dynamic per-humanoid input mode is broken** (desktop app unaffected):
   cycling into the `<humanoid-name>` mode renders the merged buffer instead of
   the mode buffer (no live stream subscription/backfill) and typed input is
   silently dropped. Workaround shipped in the worktree: `streamToPane` mirrors
   the humanoid stream to the legacy **external** buffer, and the tape uses
   external mode (fixed mode: full TUI render + input → registered humanoid via
   the enriched governed path). Proper TUI dynamic-mode support is a follow-up.
2. **Footer `esc×2→<mode>` labels are static**, not derived from the pane's
   actual enabled-mode cycle — after `##mode delete` they advertise modes that
   aren't next (or enabled). Cosmetic, but confusing on camera; follow-up.
3. Worktree also carries the ported (uncommitted) `tabReady` bootstrap-race fix
   from rysh-cli — without it, fresh-session takes drop ALL typed input.

<details><summary>Original blocker analysis (for the record)</summary>

The entire ad07 story is: *`##humanoid governance support-bot human` → the next Slack
question produces a **draft in the terminal awaiting confirm** → approve → posts.*

**That flow does not exist for Slack in the current build.** Code-verified 2026-07-15
on `rysh-cli` branch `halil`:

| Evidence | Location |
|---|---|
| `MsgHumanoidSetGovernance` flips **only** `emailGovernance` / `whatsappGovernance`; a Slack-only humanoid is a **silent no-op** | `rysh-cli/internal/actors/humanoid.go:410–426` |
| Human-governed inbound branches exist for `email` and `whatsapp` **only**; Slack inbound always auto-replies (in `ai` semantics) regardless of the flag | `rysh-cli/internal/actors/humanoid.go:850, 896` |
| No `slack_*` draft/approve tools exist (WhatsApp has list/read/draft/approve/send per commit `3c1b777`) | `rysh-cli/internal/agentic/`, `internal/channels/slackflow.go` (zero governance/draft hits) |
| UX trap: the CLI still prints `governance set to "human"` even when nothing was gated | `rysh-cli/internal/actors/workspace_humanoids.go:297–311` |

**Honesty guardrail (from the demo prompt + master plan):** the draft-and-confirm must
be *real* — "do not stage/fake the confirm step; if the flow differs from the script,
fix the SCRIPT." There is no honest Slack variant of this script today.

### What shipping it would take (pattern already exists)

Mirror the human-governed WhatsApp mode (commit `3c1b777`) for Slack:

1. `slackGovernance` field on `HumanoidActor`; read from `contacts.slack.governance`
   at spawn (the YAML field already exists on `ChannelConfig.Governance`); flip it in
   the `MsgHumanoidSetGovernance` handler when a `slack` contact exists.
2. Human-governed inbound branch for `m.ChannelType == "slack"`: update conversation
   context, echo the question to the pane, **do not auto-reply**; generate the reply as
   a pending draft (reuse `channels.DraftStore`) and render
   `DRAFT — awaiting confirmation` + approve/discard affordance in the pane.
3. Approve path posts via the existing `SlackAdapter.Send` (`PostMessage`,
   `slack.go:346`), threading preserved.
4. Fix the silent-success UX: `governance` command should report *which* channels were
   actually switched (and error when none support it).

</details>

## Gate 2 — CLOSED: workspace + tokens found and verified (2026-07-15)

Tokens live in `.rysh/secrets/halil-macbook-rysh/SLACK_BOT_TOKEN` / `SLACK_APP_TOKEN`
(rysh persisted-secret files; never echo them). Verified via Slack API without
printing values: workspace **Peralabs** (`peralabs-workspace.slack.com`), bot user
**rysh**, scopes `chat:write channels:history channels:read groups:history groups:read
im:history im:read users:read app_mentions:read channels:join`, Socket Mode OK
(`apps.connections.open` → ok), `#support` (C0BH6K6S90T) exists with the bot as member.

> ⚠ **Channel update (2026-07-15 ~02:00, ad10 shoot):** `#support` (C0BH6K6S90T) accumulated
> smoke-test threads and was **archived** (recoverable — unarchive in channel settings); the
> live demo channel is now **`#support-desk` (C0BH9RRP2HK)**, bot already a member. The ad10
> skill file (`video-tutorials/demos/remote-reach/humanoids/support-bot/SKILL.md`) points at
> `#support-desk`; if the ad07 shoot wants `#support`, unarchive it or retarget the ad07 skill.

For the shoot, load them into the launch shell without printing:

```sh
export SLACK_BOT_TOKEN="$(cat <repo>/.rysh/secrets/halil-macbook-rysh/SLACK_BOT_TOKEN)"
export SLACK_APP_TOKEN="$(cat <repo>/.rysh/secrets/halil-macbook-rysh/SLACK_APP_TOKEN)"
```

The daemon inherits env at session-create time — recreate the session from the
exported shell after any `delete-session` (which also wipes the workdir's `.rysh/`
— re-seed the skill file after).

<details><summary>Original setup checklist (kept for rebuilding the app from scratch)</summary>

### 2.1 Workspace
- [ ] Create a **throwaway Slack workspace** (free tier fine), e.g. `northwind-devtools.slack.com`.
- [ ] Create channel **`#support`**, add a second (human) member account or a second
      browser profile to play the "teammate" asking questions on camera.

### 2.2 App — create from this manifest (api.slack.com/apps → *Create New App* → *From a manifest*)

```json
{
  "display_information": { "name": "support-bot" },
  "features": {
    "bot_user": { "display_name": "support-bot", "always_online": true }
  },
  "oauth_config": {
    "scopes": {
      "bot": [
        "app_mentions:read",
        "channels:history",
        "channels:read",
        "chat:write",
        "users:read"
      ]
    }
  },
  "settings": {
    "event_subscriptions": {
      "bot_events": ["app_mention", "message.channels"]
    },
    "interactivity": { "is_enabled": false },
    "org_deploy_enabled": false,
    "socket_mode_enabled": true,
    "token_rotation_enabled": false
  }
}
```

Scopes/events map 1:1 to what the adapter actually calls (`slack.go`): `PostMessage`
→ `chat:write`; `AppMentionEvent` → `app_mention` + `app_mentions:read`;
`MessageEvent` → `message.channels` + `channels:history`; `GetConversationInfo` →
`channels:read`; `GetUserInfo` → `users:read`. Socket Mode is **required**
(`socketmode.New`, `slack.go:114`) — no public webhook needed.

### 2.3 Tokens (⚠️ never on camera, never in the repo)
- [ ] **Bot token** `xoxb-…`: *OAuth & Permissions* → *Install to Workspace* → copy.
- [ ] **App-level token** `xapp-…`: *Basic Information* → *App-Level Tokens* →
      *Generate* with scope **`connections:write`**.
- [ ] Invite the bot to the channel: `/invite @support-bot` in `#support`.
- [ ] Export in the shell that will run rysh for the shoot (NOT in any file in the tree):

```sh
export SLACK_BOT_TOKEN='xoxb-…'
export SLACK_APP_TOKEN='xapp-…'
```

The skill file references them only as `${SLACK_BOT_TOKEN}` / `${SLACK_APP_TOKEN}`
(expansion precedence: session secrets → config → environment,
`humanoid_skillfile.go`). Nothing sensitive ever renders on screen.

### 2.4 Smoke test before scheduling the shoot

```sh
# Build from the FEATURE WORKTREE (Slack governance lives there until merged):
cd worktrees/rysh-cli-feat-slack-governance && GOWORK=off make build
mkdir -p /tmp/rysh-slack-demo/.rysh/humanoids/support-bot
cp video-tutorials/demos/slack-humanoid/humanoids/support-bot/SKILL.md \
   /tmp/rysh-slack-demo/.rysh/humanoids/support-bot/
cd /tmp/rysh-slack-demo && <worktree>/rysh_local slack-demo
# in the pane (rysh mode):
#   ##humanoid spawn support-bot
#   ##humanoid channel start support-bot slack
#   ##humanoid channels support-bot       ← expect slack: connected
# then @mention support-bot from the teammate account in #support → auto-reply lands
#   ##humanoid governance support-bot human
# next @mention → pane shows "--- New Slack message ---" + a reply DRAFT → type "send"
# → the reply posts to the Slack thread
# (gotcha: rysh delete-session WIPES the working dir's .rysh/ — re-seed AFTER deletes)
```

</details>

## E2E verification record (2026-07-15 ~01:16, real Peralabs Slack)

1. `slack-e2e` session (feature-build `rysh_local`, cwd `/tmp/rysh-slack-e2e`),
   `##humanoid spawn support-bot` → `channel start … slack` → `[connected]`.
2. ai mode: mentions auto-replied in-thread with step-title progress flow. ✅
3. `##humanoid governance support-bot human` → next mention
   ("is staging frozen on Fridays?") produced **total channel silence** (no steps,
   no text — daemon log: draft-only prompt + `slack_draft` + "suppressing auto-send").
4. Approval `@support-bot send` → `slack_send` posted exactly ONE in-thread reply:
   "Yes — staging deploys are frozen every Friday after 16:00 UTC (release freeze)…" ✅
5. Fix shipped during E2E: human mode now gates the step-title flow too
   (`forwardStepToChannel`), so pre-approval the channel sees NOTHING.

---

## Prepared and waiting in this folder

- `humanoids/support-bot/SKILL.md` — demo persona (dummy company, `${ENV_VAR}` tokens,
  `reply_mode: mentions`). Copy into the shoot dir's `.rysh/humanoids/` as above.
- Master plan updated with this verification finding:
  `marketing/assets/videos/humanoids-governance.md`.

## Sequencing once both gates close

1. Re-verify the Slack draft-and-confirm UX as shipped; fix the SCRIPT to match it.
2. Film per `humanoids-governance.md` + `intro-loop-leash.md` §5 checklist
   (region-capture app windows ONLY — never full desktop; no `##help` on camera).
3. Then: TTS narration → merge → cards → QC frames → caption pack (competitor claims
   sourced in `marketing/competitors.md` first) → tracker updates.
4. CTA gate: **rysh.ai/design-partner must return 200** before publish (404 as of 2026-07-15).
