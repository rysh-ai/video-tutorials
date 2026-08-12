# Ad-tape command drift — verified against the current tree

**Written:** 2026-08-07 · **Extended:** 2026-08-12 · **Epic:** `G-15` (rysh demo-video
series) · **Scope: 10 of 10 ad tapes.**

## Why this exists

Every ad tape carries a verification stamp that is now stale. E.g.
`tape/story-ad04-forge-owner.tape:10`:

> `# All commands verified against build v0.1.25-90-g8b75c48 on 2026-07-15`

Nothing should be re-shot from a tape whose commands have not been re-checked against the
build being filmed.

## Which build each pass verified against

| Pass | Date | Verified against |
|---|---|---|
| §1–§3 (ad01, ad11) | 2026-08-07 | **v0.2.3** — then the latest tag and the published release |
| §5–§12 (the other 8) | 2026-08-12 | **`v0.2.5-81-ge6257f8`** — `rysh-cli` branch `macmini` at commit `e6257f8`, i.e. 81 commits past the `v0.2.5` tag. Published release at the time was **0.2.5** (`curl -s https://packages.rysh.ai/releases/latest.txt` → `0.2.5`) |

The second pass verified against a tree **ahead of the published release**. That is stated
rather than smoothed over: a command whose only implementing symbol landed in those 81
commits would verify here and still be missing from a `0.2.5` binary. None of the commands
below is in that position — every symbol cited in §5–§12 predates the tag, and the ad01/ad11
citations from the first pass were individually re-resolved at `e6257f8` (see §13).

## Method

**Static verification against source, not a built binary.** Every verdict cites the
dispatcher line that implements the command — which is stronger evidence than `--help`
output anyway, because it names the code path.

Commands were extracted from each tape's `Type "…"` directives and de-duplicated. Natural
language typed into an AI pane (`"void invoice INV-2026-0002"`, `"yes, proceed"`), plain
shell (`curl`, `tail`, `ls`, `lsof`, `cat`) and single keystrokes (`"d"`, `"y"`, `"send"`)
are not rysh commands and carry no verdict.

**The hard rule, applied:** no tape edit without a cited code symbol. **No tape was edited by
this pass.** Every `##` and `rysh` command in all ten tapes resolves to a live symbol; the
only defect found is a package name (§3a) and a naming question that belongs to a founder
gate (§4).

## §1 — ad01 loop-leash (`story-ad01-loop-leash.tape`) — ✅ ALL CLEAN

This is the recommended first shoot: single machine, plan + tape + `.srt` all present.

| Command as typed | Verdict | Evidence |
|---|---|---|
| `##web headless on --profile scout <url>` | **lives** | `workspace_webauto.go:101` (`case "headless"`); usage verbatim `:115` — `##web headless on [--profile P] [url]` |
| `##auto web run --headless --budget-size 20p --max-duration 10m --takeover-when 80 scout` | **lives** | usage verbatim `workspace_webauto.go:129` — `##auto web run [--headless] [--step-interval N] [--max-iterations N] [--max-duration D] [--budget-size Np\|Nb\|Ns] [--takeover-when P] <name>`; flag parser `parseWebAutoRunFlags` `:323` |
| `##auto web status` | **lives** | `workspace_auto.go:328` |
| `##auto web stop scout` | **lives** | `workspace_auto.go:332` |
| `##auto web continue scout` | **lives** | `workspace_auto.go:313` |
| `##cron next` | **lives** | `workspace_cron.go:256` (`case "next"`) |

**Verdict: shootable as-is, command-wise.** No tape edit made — there is no drift to fix.
**Amended 2026-08-12:** this section verified `##` commands only. Its `rysh` invocation at
`story-ad01-loop-leash.tape:42` is covered by §4, which is a founder gate, not drift.

Two things that are *not* command drift but still gate the shoot: the `.say`/`.mp3`
narration must be regenerated (0 ad `.mp3` survive — see `../ASSET-INVENTORY.md`), and the
`Sleep` timings were tuned to take 5b, so they need a re-time pass after the first render.

**Watch the flag semantics, they are easy to get wrong:** `--budget-size` takes `Np|Nb|Ns`
(pages/books/shelves) and `--takeover-when` takes a **percentage (10–99), not a text
predicate** — `intro-loop-leash.md` records that correction. `20p` and `80` as typed are both
correct.

## §2 — ad11 SecretNAT (`story-ad11-secretnat.tape`) — ✅ ALL CLEAN

| Command as typed | Verdict | Evidence |
|---|---|---|
| `##snat status` | **lives** | `secretnat_cmd.go:213` (`case "status", ""` — bare `##snat` does the same) |
| `##snat list` | **lives** | `secretnat_cmd.go:181` (`case "list", "ls"`) |
| `##snat get sk_live_SNAT000001` | **lives** | `secretnat_cmd.go:196` (`case "get", "show", "reveal"`); usage `:198` — `##snat get <token>` |

The two on-camera `grep`s over `wire.log` are plain shell, not rysh commands, and need no
verification.

**Verdict: no command drift.** But ad11 is **not** clear to re-render — see §3.
**Amended 2026-08-12:** as with §1, this verified `##` commands only; the `rysh` invocation at
`story-ad11-secretnat.tape:46` is covered by §4. All three citations above were re-resolved at
`e6257f8` and still hold (§13).

## §3 — ad11 has a claims problem that is not a command problem

`new_roadmap/designs/024-investor-claims.md` became binding 2026-08-07 and carries a
`NARROW` verdict for SecretNAT. It permits only:

> *"Secrets are substituted with tokens in the request body before it leaves the machine, and
> a response carrying a live credential in plaintext is reported into the pane. **Responses
> are not rewritten — by design.**"*

That final caveat appears **nowhere** in the tape, the `.srt`, or
`marketing/assets/videos/secretnat-reversible-secrets.md`. The cut says *"the provider only
ever sees synthetic tokens"* and stops. The script does bound the claim correctly at its
line 64 (*"the LLM provider never receives the value"*), so this is a **gap in the narration,
not a false claim** — but it must be in the re-recorded voiceover. Since ad11 needs
re-voicing anyway (no `.mp3` survives), this costs one extra sentence, not a re-shoot.

## §3a — The one unconditional drift: a Homebrew formula that no longer exists

| Command as typed | Tape line | Verdict | Evidence |
|---|---|---|---|
| `brew install rysh-ai/rysh/rysh` | `story-ad10-remote-reach.tape:24` | **DEAD** | The tap ships one formula and it is named `ry`: `rysh-cli/.goreleaser.yml:192` (`brews: - name: ry`), install stanza `:211` (`bin.install "ry"`). The release footer (`footer:` at `:229`) records the rename explicitly at `:230`–`:233`: *"the formula was renamed `rysh` → `ry`… that formula stopped updating at 0.1.28 and has been retired"*, and gives the fresh-install form as `brew install rysh-ai/rysh/ry` (`:242`) |

A viewer who follows this tape literally installs a formula frozen at **0.1.28**. This is
the only row in this document that is wrong **under both branches of `D-8`** (§4) — the
formula is named `ry` whether the video depicts the open build or the closed one — so it is
the only naming defect that can be fixed without waiting on a founder.

`tapes/check-ad-tape-drift.sh` is the failing check for exactly this line. It reads the
formula name out of `.goreleaser.yml` at run time (so it cannot drift from the build the way
a hardcoded string would), fails today on this one line, and deliberately says nothing about
anything `D-8` owns. `bash -n` passes.

**No edit was made.** The rule is no tape edit without a cited symbol; the symbol is cited,
but the line is spoken in the narration and appears in the `.srt`, so re-cutting it is a
shoot decision, not a `sed`.

## §4 — The binary name is a founder gate, not a drift finding

Every ad tape invokes the CLI as `rysh`. **That is not drift in itself.**
`new_roadmap/05-decisions.md:47` records the decision of 2026-07-27:

> **Binary split** — the closed build ships as `ry`, the open build as `rysh`

So `rysh` is *correct* for the OSS build and *wrong* for the released closed build. Which
build a given tutorial depicts is precisely founder gate **`D-8`**
(`new_roadmap/05-decisions.md:25`, *"Is the `ry` (closed) / `rysh` (open) split permanent?"*,
owner: founder, **STILL OPEN**, affects `G-1` and `G-3`). This fleet does not rule founder
gates, so **nothing was renamed.**

What the shipping closed build installs, for the record: `.goreleaser.yml:7`
(`project_name: ry`), `:15`/`:29`/`:43`/`:57` (`binary: ry` on every platform), `:192` (`brews: - name: ry`),
`scripts/install.sh:22` (`BINARY_NAME="${RYSH_BINARY_NAME:-ry}"`, with `:16` noting *"default:
ry; the open-source build is rysh"*). `internal/progname` exists to rewrite `rysh` → `ry` in
help output when `argv[0]` is `ry`, which is the code acknowledging the same split.

**The edit list, written once, both branches.** Whichever way `D-8` lands, nobody needs to
re-derive this:

**If `D-8` says these videos depict the CLOSED build** — every line below must become `ry`:

| Tape | Line | As typed |
|---|---|---|
| `story-ad01-loop-leash.tape` | 42 | `rysh` |
| `story-ad04-forge-owner.tape` | 37 | `rysh attach story-ad04-owner` |
| `story-ad04-forge-team.tape` | 34 | `rysh attach story-ad04-team` |
| `story-ad07-slack-humanoid.tape` | 53 | `rysh attach story-ad07` |
| `ad07-insert-scene4.tape` | 10 | `rysh attach story-ad07` |
| `story-ad08-trust-toolkit.tape` | 56 | `rysh` |
| `story-ad10-remote-reach.tape` | 27 | `rysh` |
| `story-ad10-remote-mgmt.tape` | 13, 16, 19 | `rysh list-sessions` · `rysh send northwind '##humanoid channels support-bot' --mode shell` · `rysh attach northwind` |
| `story-ad10-teammate.tape` | 14 | `rysh` |
| `story-ad11-secretnat.tape` | 46 | `rysh` |

**If `D-8` says they depict the OPEN build** — all thirteen lines are already correct and no
tape edit is required. §3a still applies either way.

Note that this reaches back into §1 and §2: those two sections were marked ✅ ALL CLEAN, and
on `##` commands they still are (§13), but they verified the command surface only and never
looked at the program name. `story-ad01-loop-leash.tape:42` and
`story-ad11-secretnat.tape:46` are in the table above like the rest.

## §5 — ad04 forge owner (`story-ad04-forge-owner.tape`) — ✅ ALL COMMANDS LIVE

| Command as typed | Tape line | Verdict | Evidence |
|---|---|---|---|
| `##forge add billing ./billing-openapi.yaml --targets rysh-toolpack,docs,mcp-server,go-sdk,ts-sdk,py-sdk` | 54 | **lives** | Registered `workspace_rysh_dispatch.go:657` (`name: "forge"`) → `handleForgeSubcommand`. `add` is not a sharing subcommand, so it falls through `workspace_forge.go:76` to `forgecmd.Run`; the case is `internal/forge/forgecmd/forgecmd.go:55`. `--targets` is a real flag: `forgecmd.go:163` (`fs.StringVar(&f.targets, "targets", "rysh-toolpack,docs", …)`) |
| `##integration enable billing` | 66 | **lives** | `workspace_rysh_dispatch.go:668` (`name: "integration"`) → `workspace_integration.go:41` (`case "enable"`); usage verbatim `:44` — `##integration enable <name> [--scope pane\|panegroup\|lane\|tab]`. `workspace_forge.go:24` confirms the ordering the tape shows: *"After `##forge add`, make the tools live with `##integration enable <name>`"* |
| `##forge share api billing` | 69 | **lives** | `workspace_forge.go:46` (`case "share"`) → `handleForgeShare` `:114`; the `api` sub-token is required at `:121` and the usage at `:122` is verbatim `##forge share api <name>` |
| `##forge shares` | 72 | **lives** | `workspace_forge.go:55` (`case "shares", "shared"`) |

Non-commands on screen: `curl -s localhost:8099/health` (34), `tail -f billing.log` (84),
`lsof -nP -i :8099 | grep LISTEN` (95) are plain shell; `d` (104) is a keystroke.
`rysh attach story-ad04-owner` (37) — subcommand lives, `cmd/rysh/main.go:186` (`case
"attach"`); program name per §4.

## §6 — ad04 forge team (`story-ad04-forge-team.tape`) — ✅ ALL COMMANDS LIVE

| Command as typed | Tape line | Verdict | Evidence |
|---|---|---|---|
| `##forge list-remote` | 51 | **lives** | `workspace_forge.go:52` (`case "list-remote", "remote", "ls-remote"`) |
| `##forge subscribe billing` | 54 | **lives** | `workspace_forge.go:61` (`case "subscribe"`) → `handleForgeSubscribe`; documented `workspace_forge.go:31` — `##forge subscribe <name> [--scope …]` |

Non-commands: `ls` (31); the three AI-pane prompts at 69, 80, 83 (*"list this month's unpaid
invoices and total them"*, *"void invoice INV-2026-0002"*, *"yes, proceed"*) are natural
language, not commands; `d` (94) is a keystroke. `rysh attach story-ad04-team` (34) — see §5.

## §7 — ad07 Slack humanoid (`story-ad07-slack-humanoid.tape`) — ✅ ALL COMMANDS LIVE

| Command as typed | Tape line | Verdict | Evidence |
|---|---|---|---|
| `##pane name main` | 56 | **lives** | `workspace_rysh_dispatch.go:231` (`name: "pane"`) → `workspace_pane_commands.go:174` (`case "name"`); usage `:179` — `##pane name <given-name>` |
| `##mode delete prompt` · `##mode delete chat` · `##mode delete rysh` | 59, 62, 65 | **lives** | `workspace_mode.go:62` (`case "delete", "remove", "disable", "del", "rm"`); usage `:80` — *"disable a mode (shell cannot be disabled)"*. All three names are canonical: `prompt` `:25`, `rysh` `:27`, `chat` `:29`. None is `shell`, so none hits the guard |
| `##mode new external` | 68 | **lives** | `workspace_mode.go:60` (`case "new", "add", "enable"`); `external` canonicalised at `:31` (`case "external", "ext"`) and listed in the usage `:75` |
| `##humanoid spawn support-bot` | 78 | **lives** | `workspace_rysh_dispatch.go:461` (`name: "humanoid"`) → `workspace_humanoids.go:133` (`case "spawn"`); usage `:136` — `##humanoid spawn <name>` loads `.rysh/humanoids/<name>/SKILL.md` |
| `##humanoid register-output support-bot main` | 81 | **lives** | `workspace_humanoids.go:164`; usage `:166` — `##humanoid register-output <humanoid-name> <pane-name>`. Arg order as typed is correct (`:170`–`:171`), and `main` resolves through `w.resolvePaneID`, which is why line 56 names the pane first |
| `##humanoid channel start support-bot slack` | 84 | **lives** | `workspace_humanoids.go:289` (`case "channel"`) → `:306` (`case "start"`); usage `:292` — `##humanoid channel start <name> <channel-type>` |
| `##humanoid reply-to support-bot mentions` | 87 | **lives** | `workspace_humanoids.go:321`; `mentions` is one of the two accepted values, validated `:331` |
| `##humanoid governance support-bot human` | 100 | **lives** | `workspace_humanoids.go:343`; `human` validated `:352` |
| `##humanoid governance support-bot ai` | 133 | **lives** | same symbol; `ai` validated `:352` |

`send` (115) is a word typed into a chat pane, not a command. `rysh attach story-ad07` (53) —
see §5.

## §8 — ad07 insert scene 4 (`ad07-insert-scene4.tape`) — ✅ NO COMMANDS TO VERIFY

The only `Type` directive is `rysh attach story-ad07` (10) — subcommand lives
(`cmd/rysh/main.go:186`), program name per §4. This is an insert reel, not a standalone ad.

## §9 — ad08 trust toolkit (`story-ad08-trust-toolkit.tape`) — ✅ ALL COMMANDS LIVE

| Command as typed | Tape line | Verdict | Evidence |
|---|---|---|---|
| `##secret new STRIPE_KEY sk_test_demo123 --persist` | 68 | **lives, but the flag is now a no-op** | `workspace_rysh_dispatch.go:490` (`name: "secret"`) → `handleSecretSubcommand` (`secret.go:32`) → `store.go:605` (`case "new", "set", "add"`). `--persist` is still accepted at `store.go:613`, and `:610` says so in as many words: *"Persistence is ON by default… `--persist`/`-p` is still accepted as an explicit no-op for compatibility."* **No behaviour drift** — it still persists — but the flag no longer appears in the help (`workspace_rysh_dispatch.go:493` documents `[--no-persist]`), so a viewer reading `##secret help` will not find the flag they just watched being typed |
| `##history` | 71 | **lives** | `workspace_rysh_dispatch.go:119` (`name: "h"`, `aliases: []string{"history"}` `:120`) → `handleHistoryCommand` `:125`, implemented `workspace_history_commands.go:8`. Also documented `README.md:380` |
| `##secret list` | 77 | **lives** | Same dispatch entry; help `workspace_rysh_dispatch.go:494` — `##secret list [--tab <tab>]` |
| `##grounding` | 89 | **lives** | `workspace_rysh_dispatch.go:424` (`name: "grounding"`); the bare form is the documented first usage, `:426` — *"show grounding state for active pane"* |

The on-screen `cat .rysh/secrets/.gitignore` (74) is plain shell, but it asserts an artifact
exists, so it was checked: rysh really does write that file — `store.go:149` (`ensureGitignore`,
*"writes a .gitignore into the store root"*) and `internal/config/envref.go:124`–`:126`, whose
content is `# rysh secrets — never commit these` / `*` / `!.gitignore`. **The shot is
truthful.**

`y` (112) is a keystroke; the prompt at 97 is natural language. `rysh` (56) — see §4.

## §10 — ad10 remote reach (`story-ad10-remote-reach.tape`) — ⚠️ ONE DEAD LINE

| Command as typed | Tape line | Verdict | Evidence |
|---|---|---|---|
| `brew install rysh-ai/rysh/rysh` | 24 | **DEAD** | See §3a |
| `##pane name support` | 38 | **lives** | `workspace_pane_commands.go:174` |
| `##humanoid spawn support-bot` | 41 | **lives** | `workspace_humanoids.go:133` |
| `##humanoid channel start support-bot slack` | 44 | **lives** | `workspace_humanoids.go:289` → `:306` |
| `##humanoid channels support-bot` | 47 | **lives** | `workspace_humanoids.go:281`; usage `:283` — `##humanoid channels <name>` |
| `##share pane view` | 53 | **lives** | `workspace_rysh_dispatch.go:258` (`name: "share"`) → `handleShareCommand`; help `:260` is verbatim `##share pane [view\|control]`, so `view` is a documented mode |

`rysh` (27) — see §4.

## §11 — ad10 teammate (`story-ad10-teammate.tape`) — ✅ ALL COMMANDS LIVE

| Command as typed | Tape line | Verdict | Evidence |
|---|---|---|---|
| `##upstream subscribe e9780ee4-…-438113b6239a view` | 23 | **lives** | `workspace_rysh_dispatch.go:282` (`name: "upstream"`) → `handleUpstreamCommand`; usage `workspace_share.go:762` — `##upstream subscribe <shareID> [view\|control]`, and `workspace_upstream_commands.go:86` documents the same form. The typed UUID is a share id and `view` is a documented mode |

`rysh` (14) — see §4.

## §12 — ad10 remote management (`story-ad10-remote-mgmt.tape`) — ✅ ALL COMMANDS LIVE

| Command as typed | Tape line | Verdict | Evidence |
|---|---|---|---|
| `rysh list-sessions` | 13 | **subcommand lives** | `cmd/rysh/main.go:251` (`case "list-sessions"`). Program name per §4 |
| `rysh send northwind '##humanoid channels support-bot' --mode shell` | 16 | **subcommand lives** | `cmd/rysh/main.go:314` (`case "send"`); `--mode` read at `:326` (`flagVal(args[3:], "--mode")`). The payload it carries, `##humanoid channels`, is verified in §10 |
| `rysh attach northwind` | 19 | **subcommand lives** | `cmd/rysh/main.go:186` |
| `##humanoid channel stop support-bot slack` | 28 | **lives** | `workspace_humanoids.go:289` (`case "channel"`) → `:311` (`case "stop"`) |
| `##unshare pane` | 31 | **lives** | `workspace_rysh_dispatch.go:271` (`name: "unshare"`) → `handleUnshareCommand` `:279`; help `:273` is verbatim `##unshare pane   stop sharing the active pane` |

## §13 — §1 and §2 re-resolved at `e6257f8`

The first pass cited twelve source lines against v0.2.3. Every one was re-read at
`v0.2.5-81-ge6257f8` and still resolves to the same symbol:

`workspace_webauto.go:101` (`case "headless"`) · `:115` (usage) · `:129` (usage) · `:323`
(`parseWebAutoRunFlags`) · `workspace_auto.go:313` (`case "continue"`) · `:328` (`case
"status"`) · `:332` (`case "stop"`) · `workspace_cron.go:256` (`case "next"`) ·
`secretnat_cmd.go:181` (`case "list", "ls"`) · `:196` (`case "get", "show", "reveal"`) ·
`:198` (usage) · `:213` (`case "status", ""`).

**No §1 or §2 command verdict is stale.** The one thing that has changed for those two
sections is the program name, which §4 now covers for all ten tapes.

## §14 — What is still not verified

Command surface is now complete for all ten tapes. These remain open and are **not** claimed:

- **Nothing was rendered or executed.** Verdicts are static reads of the dispatcher. `rysh`
  is not on PATH here and the host was under sustained load throughout.
- **Narration and `.srt` were not re-checked against 024** in this pass, except where §3
  already did it for ad11. `E5-video.md` §5 holds a `NARROW` verdict for both #57 SecretNAT
  and #56 Forge; re-rendering either without re-checking its narration ships a claim the
  table restricts.
- **Only two of the eight tapes carry a verification stamp at all** —
  `story-ad04-forge-owner.tape:10` and `story-ad04-forge-team.tape:9`, both reading
  `v0.1.25-90-g8b75c48` / 2026-07-15. The other six have none. The stamps were left alone:
  they are stale, not false, and rewriting them is a tape edit this pass had no need to make.
- One adjacent claims check from the first pass still stands and is worth keeping, because it
  closes a worry rather than opening one: **ad04 makes no gRPC or GraphQL claim at all.**
  `grep -inE 'grpc|graphql'` over both ad04 tapes, `story-ad04-forge.vover.srt` and
  `forge-private-api.md` returns nothing — it is OpenAPI/REST end to end. So 024's standing
  caveat 3 (*"unary and server-streaming only, never drop it"*) does not attach to that
  video. That is a claims check, not a command check; §5 and §6 are the command check.
