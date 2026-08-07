# Ad-tape command drift — verified against the current tree

**Written:** 2026-08-07 · **Epic:** `G-15` (rysh demo-video series) · **Scope: PARTIAL —
2 of 10 ad tapes.** Read §4 before treating any other tape as checked.

## Why this exists

Every ad tape carries a verification stamp that is now stale. E.g.
`tape/story-ad04-forge-owner.tape:10`:

> `# All commands verified against build v0.1.25-90-g8b75c48 on 2026-07-15`

The shipping release is **v0.2.3** (`curl -s https://packages.rysh.ai/releases/latest.txt`
→ `0.2.3`; `git -C rysh-cli tag --sort=-v:refname | head -1` → `v0.2.3`). Nothing should be
re-shot from a tape whose commands have not been re-checked against the build being filmed.

## Method

**Static verification against source, not a built binary.** `rysh` is not on PATH on this
machine and the host was under sustained load (average 99–139) throughout, so a Go build was
not attempted. Every verdict below cites the dispatcher line that implements the command —
which is stronger evidence than `--help` output anyway, because it names the code path.

Commands were extracted from each tape's `Type "…"` directives and de-duplicated.

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

## §4 — NOT VERIFIED (8 of 10 tapes)

No claim is made about these. They were not checked and must not be treated as clean:

`story-ad04-forge-owner` · `story-ad04-forge-team` · `story-ad07-slack-humanoid` ·
`ad07-insert-scene4` · `story-ad08-trust-toolkit` · `story-ad10-remote-reach` ·
`story-ad10-teammate` · `story-ad10-remote-mgmt`

One adjacent check *was* done and is worth recording, because it closes a worry rather than
opening one: **ad04 makes no gRPC or GraphQL claim at all.** `grep -inE 'grpc|graphql'` over
both ad04 tapes, `story-ad04-forge.vover.srt` and `forge-private-api.md` returns nothing —
it is OpenAPI/REST end to end. So 024's standing caveat 3 (*"unary and server-streaming
only, never drop it"*) does not attach to that video. That is not a full command
verification of ad04, only a claims check.
