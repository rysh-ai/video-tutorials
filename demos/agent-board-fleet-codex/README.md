# agent-board-fleet-codex — the same demo, run by Codex

Four **Codex** agents in one rysh session build a browser-only todo manager while
every one of them reports to a shared **agents board**.

This is a deliberate sibling of **`../agent-board-fleet/`**, which runs the same
scenario with Claude. Same layout, same beats, same framing, same board protocol
— read that README first for the reasoning behind all of it. **This file records
only what had to change for Codex, and what the two runs actually measured.**

```
lane-1             lane-2             lane-3
+---------------+  +---------------+  +---------------+
| roadmap       |  | worker-1      |  |               |
+---------------+  +---------------+  | agents-board  |
| fleet-manager |  | worker-2      |  |               |
+---------------+  +---------------+  +---------------+
```

```sh
./record.sh                    # reset → film → verify → trim
cd voiceover && ./make-voiceover.sh
```

## What differs from the Claude version

| | `../agent-board-fleet` | this |
|---|---|---|
| agent | `claude --dangerously-skip-permissions --model sonnet` | `codex --dangerously-bypass-approvals-and-sandbox` |
| model | sonnet | `gpt-5.6-sol` at `high` effort, from `~/.codex/config.toml` |
| session | `agentfleet` | `codexfleet` |
| NATS port | 24343 | **24344** |
| trust gate | `~/.claude.json` `hasTrustDialogAccepted` | `~/.codex/config.toml` `[projects."<dir>"] trust_level` |
| agent instructions | `CLAUDE.md` | `AGENTS.md` |
| tape `Sleep` | 6m | **8m** |

Four of those are not cosmetic:

- **The full-auto flag is not the same flag.** Codex takes
  `--dangerously-bypass-approvals-and-sandbox`. Hand it claude's
  `--dangerously-skip-permissions` and it is an immediate hard error at the pane;
  hand it nothing and it stops at an approval prompt that nobody is there to
  answer. It also switches the sandbox off, which this demo needs — the agents
  write files and shell out to `rysh board post` on every step.
- **The trust gate is a different file with a different shape.** Codex asks *"Do
  you trust the contents of this directory?"* and blocks. The grant is a
  `[projects."<abs path>"]` table with `trust_level = "trusted"`.
  `./trust-dir.sh` writes it marked with a comment naming this demo, and
  `./trust-dir.sh --revoke` removes **only** blocks carrying that mark — a
  directory that was already trusted was somebody else's grant and must survive.
- **The NATS port had to move again.** 24242 is the founder's live session and
  24343 is the Claude version of this demo. At a port something else already
  holds, this daemon joins that server as a *client* rather than starting its
  own — one bus, two sessions. `setup-session.sh` asserts the daemon is the
  listener on 24344.
- **Codex is slower, so the tape sleeps longer.** Measured below. A tape that
  runs past its `Sleep` loses its ending outright, and there is no way to add it
  back afterwards.

The briefs are the Claude briefs with two edits: the demo's opening board post
says *Codex* instead of *Claude*, and the three polling loops no longer say
"give the tool a 600000 ms timeout" — that is Claude Code's phrasing. They now
say "run this in one shell call and let it finish", which both agents read the
same way. Codex ran them as background terminals and waited correctly.

## Measured, same machine, same day

| | Claude | Codex |
|---|---|---|
| board opens | 0:50 | 0:34 |
| work orders out | 2:10 | 2:38 |
| both workers signed off | 2:40 | 4:03 (then re-signed at 5:05 after rework) |
| `DEMO COMPLETE` | 3:20 | 6:03 |
| take length after trim | 3:29 | **6:17** |

Codex ran the same scenario about **1.7× slower** end to end, at `high`
reasoning effort against `gpt-5.6-sol`. It was not less accurate: it produced a
five-id contract and an app whose markup and script matched it exactly, with a
clean `node --check` and no `import`/`export`/`require`/`fetch` — the same gates
the Claude run passed.

Three behavioural notes worth keeping:

- **The manager caught a real defect, on camera.** Verifying the finished app it
  found `updateRemainingCount` writing a whole phrase into `#remaining-count`
  while `index.html` already supplied the surrounding words — duplicated text on
  the page. It did not fix it: it named the file and the mismatch, sent it back
  to worker-2 with `rysh ansa prompt`, posted `[blocked]`, and re-verified after
  the correction. That is exactly the escalation path the brief specifies, and it
  is the best beat in either take. The Claude run never triggered it.

- **Codex loads the `rysh` skill on its own.** The first thing every agent did
  was read `SKILL.md` because the brief's commands are `rysh` commands. Costs a
  few seconds per agent; changes nothing about the result.
- **The board-polling protocol survives the swap intact.** The fleet manager
  parked on `rysh board tail` in a background terminal and reasoned, on camera,
  *"No completion flare yet; the watcher is still healthy. I'm leaving the
  workers uninterrupted, as the demo protocol requires."* That the protocol is
  legible to a different agent is the point of writing it into the board rather
  than into messages.

## Voiceover and subtitles

```sh
cd voiceover && ./make-voiceover.sh
```

Identical machinery to the Claude version — OpenAI TTS for the narration,
Deepgram for the word timings, the `.say` file for the words, two-pass
`loudnorm` to −16 LUFS, subtitles both soft and burned in. Both API keys come
from `##secret get`, captured into shell variables and never printed. See
`../agent-board-fleet/README.md` for why each of those is the way it is.

**One thing genuinely differed, and it matters.** The Claude take came out 1:1
with wall clock, so its cues needed only an offset. This take did not: over a
longer capture VHS dropped frames unevenly and the video runs about **5% slow**
against the clock. No single offset satisfies all six timing brackets — the
early frames imply `17:38:11` and the late ones `17:38:21` — so the cues are
fitted with a scale factor as well:

```
video_t = 0.9502 * (wall_seconds_after_17:38:00) - 5.02
```

Assuming the Claude version's 1:1 mapping here would have pushed every cue
progressively earlier, by ten seconds at the end. The scale factor is a property
of *that capture*, not a constant: re-record and it must be re-derived.

## Two things to know about the outputs

- **`record.sh` reports `5/4 sign-offs`.** That is a naive `grep -c` on
  `my task is finished`, and worker-2 legitimately signed off twice — once
  before the manager's correction and once after. The gate that matters is
  `DEMO COMPLETE` on the board, which it checks separately.
- **The silent take is never modified.** `voiceover/` writes only new files;
  `out/agent-board-fleet-codex.mp4` is opened read-only.

| File | What it is |
|---|---|
| `out/agent-board-fleet-codex.mp4` | the silent take — the master, never modified |
| `out/agent-board-fleet-codex.vover.mp4` | + narration, + soft subtitles |
| `out/agent-board-fleet-codex.vover.subs.mp4` | + narration, + burned-in subtitles |
| `_run/agent-board-fleet-codex.mp4` | the same take untrimmed (492s) |

## Levers

- **Run length** is dominated by `model_reasoning_effort = "high"` in
  `~/.codex/config.toml`. `codex -c model_reasoning_effort="medium"` in
  `agent.sh` is the knob for a shorter film. Left alone by default rather than
  quietly overriding a global preference.
- **Model** likewise comes from `~/.codex/config.toml`; `-m` overrides it.
