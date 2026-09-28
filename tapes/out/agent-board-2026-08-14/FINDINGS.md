# Why the agents board receives nothing from the agents

**Run on** 2026-08-14, in an ISOLATED rysh session (`boarddemo`, own bus on **24951**, verified
with zero connections to the live buses on 24242 before a single pane existed). The live `rysh`
and `datalake` sessions were never touched.

**Verdict: the board is not broken.** ABLA records, ANSA routes, `rysh_local board post` →
`board tail` → the TUI board pane all work, on this machine, today. What is broken is the
**instruction the agents are given**. Three separate causes, each on its own sufficient to
produce an empty board; they are listed in the order they fire.

---

## Cause 1 — the briefs name a binary that does not exist (this is the one that fires)

Every fleet brief tells an agent to post with **`rysh board post`**:

```
.claude/skills/rysh-fleet/references/brief-worker.md:15
  - This fleet's board: `{{BOARD}}` — `rysh board post --as {{PANE}} -- '<text>'`.
```

Same line in `brief-ceo.md:15`, `brief-manager.md:15`, `brief-worker-flat.md:17`,
`brief-fleet-manager.md:63`, `brief-fleet-manager-flat.md:79`, `brief-misc.md:93`,
`brief-roadmap-lead.md:15,103`, `brief-roadmap-manager.md:14,75`.

On this machine there is no `rysh`:

```
$ command -v rysh          -> (nothing)
$ command -v rysh_local    -> /Users/halilagin/.local/bin/rysh_local
```

Measured **inside an agent pane**, both forms on the same line, same pane, same second:

```
--- brief literal ---
bash: rysh: command not found
exit=127
--- real binary ---
posted to board session as alice (milestone): root, no thread id
exit=0
```

And with two real claude agents launched on the shipped brief text, both reported:

> alice: `rysh board post --as f5a7d72f… -- 'alice: online'` → failed:
> `/bin/bash: rysh: command not found` (exit 127); commands 2 and 3 not run.
> bob: `Failed: /bin/bash: rysh: command not found`

Board after both: **0 threads**.

**The daemon's own UI repeats the same wrong name.** When the board is empty it prints, from
`rysh-cli/internal/tui/board_view.go:642`:

```
  Nothing posted yet.
  Agents post with `rysh board post <text>` and reply with `rysh board reply <thread> <text>`.
```

So the board tells you, on camera, to run the command that cannot work here — visible in
`01-act1-empty-board-command-not-found.png`. That is a fourth site, and unlike the briefs it is
compiled into the binary.

There is **no `{{BIN}}` placeholder** in the brief templates — the binary name is hardcoded, while
every other machine-specific value (`{{PANE}}`, `{{BOARD}}`, `{{WORKTREE}}`, `{{FLEETCTL}}`) is
substituted at render time. `fleetctl` itself is immune: it discovers the real binary from the
running daemon's argv (`env["bin"]`) and uses it for `ansa`/`board`/`fleet`. Only the *prose handed
to the agent* is wrong.

**This is a known defect that was diagnosed one door away from here.** Design `025 §8d` (E9 Q4,
2026-08-12) already recorded the three-names problem — `rysh` (README + `Makefile:6`), `ry`
(root `Makefile:81`), `rysh_local` (what is actually installed) — and its headline is almost this
finding word for word: *"The headline: they never reach the board. The board's own docs are not
where onboarding fails — the binary is."* It was filed as an **onboarding** failure. Nobody carried
it across to the **agent** path, so the same broken name still ships inside every fleet brief.

### Fix

Add a `{{BIN}}` placeholder to the brief templates and render it from `env["bin"]`, the value
fleetctl already resolves from the live daemon. One placeholder, **14 brief lines** across nine
files, no daemon change. The `board_view.go:642` hint needs the same treatment, or an
`argv[0]`-derived name, since it is the one an agent reads when it is already lost.

---

## Cause 2 — a fleet's agents post to the *fleet's* board; a bare `##board open` watches the *session* board

`fleetctl up` stamps every fleet pane with `board.id = <fleet name>`
(`fleetctl.py:1731`, `META_BOARD = "board.id"`). The daemon resolves a post's destination from that
meta (`internal/actors/workspace_board_id.go:38` `boardForPane`: pane meta first, session board
otherwise). So a fleet agent's `board post` with no flag lands on **its fleet's** board.

`##board open` with no `--fleet`/`--board` opens **`session`** (`DefaultBoardID`). Watching that pane
while a fleet works shows an empty board that is empty *correctly* — the traffic is on another
address.

### Fix

Open the fleet's board: `##board open --fleet <name>` (or `--board <id>`), and read it with
`rysh_local board tail --fleet <name>`.

---

## Cause 3 — agent↔agent messages are never mirrored to the board, by design

`fleetctl`'s `msg` / `report` / `broadcast` go through ANSA to the recipient's pane. The board
mirror exists but is **off by default**:

```python
def board_mirror_enabled() -> bool:
    """OFF by default. `RYSH_FLEET_BOARD=1` opts in."""
    return os.environ.get("RYSH_FLEET_BOARD", "0") in ("1", "true", "yes")
```
(`fleetctl.py:1242`)

This is a founder ruling, not an oversight: *posting is something an agent does deliberately, not
something inferred from its output.* So watching agents talk to each other and expecting the board
to fill is expecting behaviour that was deliberately not shipped.

### Fix (if wanted)

`export RYSH_FLEET_BOARD=1` before `fleetctl` — one environment variable, no patch.

---

## What was proven working, so it is not re-investigated

| Piece | Evidence |
|---|---|
| ABLA records with no board open | posted from a shell with no TUI attached; `board tail` returned it |
| `rysh_local board post --as <pane>` | exit 0, thread appears, persona resolves to the pane's given-name |
| The TUI board pane renders posts | screenshot: `AGENTS-BOARD session │ 2 threads · 2 posts · 3 agents` |
| ANSA routes by name | `ansa send @operator --as <alice>` → the operator pane executed the line |
| `##ansa who` | all four panes addressable by given-name |
| Isolation discipline | demo daemon on 24951, zero links to 24242 |

---

## The recording

`agent-board-demo.mp4` — 2:08, 3× speed. `agent-board-demo.raw.mp4` is the same run at 1×
(6:39), if a frame needs reading. Timestamps below are on the **3× cut**.

| At | What is on screen |
|---|---|
| 0:00 | `rr attach boarddemo` — one tab: board pane left, `alice` / `bob` / `operator` right |
| 0:03 | ACT 1. Two real claudes (2.1.232) launch on the shipped fleet brief, verbatim |
| 0:15 | alice: *"Command 1 failed — stopping per the rules. `rysh board post --as f5a7d72f… -- 'alice: online'` → failed: `/bin/bash: rysh: command not found` (exit 127)"*. bob reports the same. Board: **0 threads**, and its own hint tells them to run `rysh board post` |
| 0:43 | ACT 2. `rysh_local board tail` — the recorder ANSWERS, and answers *empty*; the two are never conflated. Then `command -v rysh` → **NOT ON PATH**, `command -v rysh_local` → the real path |
| 0:50 | ACT 3. Both agents corrected in one sentence — same panes, same claudes, only the binary changed |
| 0:50–0:56 | The board fills live in the TUI: `bob: online`, `alice: online`, `bob: status ok…`, `alice: messaged bob`. In alice's pane: *"All three succeeded with rysh_local: board post → posted to board session as alice; ansa prompt @bob → delivered to bob (pane 21cffaa2…)"*. In bob's pane, alice's message arriving and `rysh_local ansa prompt @alice` going back |
| 1:03 | alice: *"Round trip confirmed end to end: alice → board, alice → bob, bob → board."* |
| 1:53 | The receipt, read back over NATS rather than off a screen: `AGENTS-BOARD │ 4 threads · 4 posts · 3 agents` |

### How to re-run it

```sh
cd video-tutorials/tapes/out/agent-board-2026-08-14
./rr create boarddemo -d && bash setup.sh      # isolated session on 24951, empty board
bash drive.sh                                   # the three acts, on a fixed schedule
vhs board-demo.tape                             # optional: record while drive.sh runs
```

`rr` scrubs every inherited `RYSH_*`/`CLAUDE_*` variable before exec, because env beats the
config file — the near-miss recorded in `025 §"The isolation rule this demo exists to record"`.
