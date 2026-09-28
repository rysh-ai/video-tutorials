# agent-board-fleet — a demo video of a fleet and its board

Four Claude agents in one rysh session build a browser-only todo manager while
every one of them reports to a shared **agents board**. The board is the point of
the film: it is the only place a viewer can watch four agents at once.

> A **Codex** run of this same scenario lives next door in
> [`../agent-board-fleet-codex/`](../agent-board-fleet-codex/) — same layout,
> same beats, same framing. Its README records what had to change for Codex and
> how the two runs compare.

```
lane-1             lane-2             lane-3
+---------------+  +---------------+  +---------------+
| roadmap       |  | worker-1      |  |               |
+---------------+  +---------------+  | agents-board  |
| fleet-manager |  | worker-2      |  |               |
+---------------+  +---------------+  +---------------+
```

## Record it

```sh
./record.sh
```

That is the whole thing: it resets the session, builds the layout, films with
VHS, checks the board actually reached `DEMO COMPLETE`, and trims the static
tail. Output lands in `out/agent-board-fleet.mp4`; the untrimmed take stays at
`_run/agent-board-fleet.mp4`.

`./record.sh --no-reset` films whatever session is already up — useful for
re-shooting the framing without paying for another fleet run.

Run the pieces by hand if you are debugging one of them:

```sh
./setup-session.sh     # clean session + 3-lane layout + board, ids -> _run/panes.env
./launch-agents.sh     # render briefs, start the four agents (staged)
vhs agent-board-fleet.tape
```

## What each file is

| File | Role |
|---|---|
| `record.sh` | the whole take: reset → film → verify → trim |
| `setup-session.sh` | session, three lanes, five panes, the board, the names |
| `launch-agents.sh` | renders the briefs and starts the agents in order |
| `start-fleet.sh` | one short line for the tape to type; nohups the launcher |
| `agent.sh` | starts one agent in the pane it is typed in |
| `agent-board-fleet.tape` | the VHS tape |
| `briefs/` | the source briefs; `_protocol.md` is spliced into all four |
| `trust-dir.sh` | pre-accepts Claude Code's workspace-trust dialog |
| `rysh.config.yaml` | the demo's own session, its own NATS port, its own state |
| `CLAUDE.md` | scopes the agents to this directory |
| `voiceover/agent-board-fleet.say` | the narration script |
| `voiceover/make-voiceover.sh` | narration + subtitles onto a copy of the take |
| `voiceover/srt_from_deepgram.py` | Deepgram timings + `.say` words → SRT |

Everything generated is disposable: `_run/` (rendered briefs, logs, raw take),
`.rysh/` (session state and the board's KV), `todo-app/` and `ROADMAP.md` (what
the fleet builds). `setup-session.sh` deletes all of it at the start of a take.

## How the fleet is wired

- **The board is one thread.** `launch-agents.sh` mints it as
  `<roadmap-pane-id>/1` and bakes it into every brief. The id must be prefixed
  with the poster's own pane id or the board will not accept that post as the
  thread's **root** (`board.ownsThread`) — any other string files every post as a
  reply to a thread that never arrives, and the pane renders `awaiting root` for
  the whole demo.
- **Down the chain is a message; up the chain is the board.** The roadmap
  `ansa prompt`s the manager, the manager `ansa prompt`s each worker — but nobody
  reports back by message. Workers post `worker-N: my task is finished` and the
  manager *polls the board* for both; the manager posts its own sign-off and the
  roadmap polls for that. A push interrupts a working agent and can be missed; a
  post cannot. The first cut had the manager notify the roadmap directly and the
  manager simply forgot the last command, which stranded the take with three
  sign-offs out of four.
- **Names are wiring, not decoration.** `##pane name roadmap` is what makes
  `rysh ansa prompt @roadmap` resolve, and it is also the persona the board
  prints. `##pane name` renames the *caller's* pane — there is no positional id —
  so each rename is sent as the pane being renamed.

## Things that cost a take

- **The board survives `delete-session`.** It is a JetStream KV bucket keyed by
  session name, so the next take opens on the last take's posts. Wiping `.rysh`
  is what actually resets it.
- **The daemon's environment is every agent's environment.** Built from inside a
  claude session, the daemon inherits `CLAUDE_EFFORT` (agents think at the
  operator's effort — an inherited `xhigh` makes the demo crawl),
  `CLAUDE_CODE_CHILD_SESSION` (a "transcript saving is off" banner in all four
  panes) and `CLAUDE_CODE_MESSAGING_*` (a socket addressing the operator's own
  claude). `setup-session.sh` scrubs them at `rysh create`.
- **The trust dialog stops everything.** Four interactive agents, four "Is this a
  project you trust?" prompts, nobody at the keyboard. `trust-dir.sh` stores the
  same answer clicking *Yes* would.
- **The default NATS port is the founder's live session.** At `24242` this
  daemon joins that bus as a client instead of starting its own server, and the
  demo dies when the live session stops. The config pins `24343`;
  `setup-session.sh` asserts the daemon is the listener.
- **Quote every path in the tape.** VHS reads a bare `_run/x.png` as a command
  and fails the whole tape with `Invalid command`.
- **Never trim by wall clock.** VHS drops frames unevenly under load, so the
  tape's `Sleep` values do not map onto timestamps in the output. `record.sh`
  finds the end of the action with `freezedetect`, from the frames themselves.

## Framing

1920×1080, FontSize 14, Catppuccin Mocha, **Padding 90**. The padding is the
important one: player chrome eats roughly the top three text rows, and at the
usual `Set Padding 20` that took the tab bar and the first pane header with it.
The first typed line is a decorative title and is deliberately expendable — if a
player still crops the top, that is the line it takes.

## Voiceover and subtitles

```sh
cd voiceover && ./make-voiceover.sh
```

Narrates the take, subtitles it, and writes two NEW files — the silent master is
opened read-only and stays byte-identical (checked by md5 across every run).

```
voiceover/agent-board-fleet.say   the narration script, with timing cues
        → agent-board-fleet.raw.mp3   OpenAI TTS (nova, tts-1-hd)
        → agent-board-fleet.mp3       the same, loudness-normalised
        → agent-board-fleet.srt       Deepgram timings + the script's words
out/agent-board-fleet.vover.mp4       narration + a soft subtitle track
out/agent-board-fleet.vover.subs.mp4  narration + subtitles burned in
```

Both keys come from the session's own store — `##secret get OPENAI_API_KEY` and
`##secret get DEEPGRAM_API_KEY` — captured straight into shell variables and
never echoed, never written to a file, never passed on a command line where
`ps` would show them. The script prints their *lengths* and nothing else; a
prefix of a live key is still a leak into a log that outlives the run.

`./make-voiceover.sh --skip-tts` reuses the raw mp3 and `DG_REUSE=1` reuses the
cached transcript, so re-cutting subtitles or restyling costs nothing.

### Four things that had to be right

- **Cues come from the frames, not from the tape.** VHS drops frames unevenly,
  so `Sleep` values are not video timestamps. The cues were derived by cropping
  the board pane at six times (`_run/contact.png`), reading the newest post in
  each, and solving for `video_t = wall_clock − 15:13:47`. Two of those brackets
  are one post wide, which is what pins it. **Re-record and these cues are wrong
  until they are re-derived the same way.**
- **Deepgram supplies the timings; the `.say` file supplies the words.** The
  `.say` cues are requests, not facts — `tts_openai.py` advances its cursor by
  the *actual* synthesised length, so speech drifts from the script. But a
  transcript of synthetic speech is still a transcript: Deepgram returned "One
  Rish session", "the road map agent", "a to do manager", and — changing the
  meaning outright — "the page **in** the style sheet" where the script says
  "the page **and** the stylesheet". So the two streams are aligned with
  `difflib` and each script word inherits the clock of the word it matched.
- **Burned-in subtitles need an explicit script resolution.** ffmpeg converts
  SRT to ASS at 384×288 and libass then scales everything by 1080/288 = 3.75, so
  the first attempt at `Fontsize=21` rendered at ~79px and covered three panes.
  With `PlayResX/Y` set to the real frame, sizes are plain pixels: 30px text,
  14px off the bottom — inside the empty band the TUI leaves under its status
  line, so two lines still touch nothing.
- **The raw TTS is unpublishably quiet**: −29.1 LUFS integrated against a −8 dBFS
  peak. A flat gain cannot fix that (+13 dB clips hard), so the pipeline runs
  two-pass `loudnorm` to −16 LUFS / −1.5 dBTP; the masters land at −17.0 LUFS,
  −1.7 dBFS peak. Two passes, not one: single-pass loudnorm works from a running
  estimate and pumps on narration full of long silences, which this is.

## Takes on disk

| File | What it is |
|---|---|
| `out/agent-board-fleet.mp4` | the silent take — the master, never modified |
| `out/agent-board-fleet.vover.mp4` | + narration, + soft subtitles |
| `out/agent-board-fleet.vover.subs.mp4` | + narration, + burned-in subtitles |
| `out/agent-board-fleet-take1.mp4` | copy of take 1, 2026-08-15, 3m29s, 4/4 sign-offs |
| `_run/agent-board-fleet.mp4` | the same take untrimmed (371s) |

**Take 1 opened with `printf '\n\n\n'`** where the tape now types a title line —
same job, but it read as a mistake on camera. Re-shoot with `./record.sh` to get
the title version; everything else about the take is unchanged.

**Nothing here is tracked.** `.gitignore:51` ignores the whole `video-tutorials/`
tree, so the recipe — these scripts and briefs — is gitignored alongside the
render. That is the pre-existing convention for this folder (`forge-billing`,
`remote-reach` and the rest sit under the same rule), not a decision made here.
If the recipe should survive a clean checkout, `git add -f` is the deliberate
act that does it.

## Levers

- **Run length** is dominated by how hard the agents think. `~/.claude/settings.json`
  sets `"effortLevel": "xhigh"` globally, and the agents inherit it — that is what
  the panes mean by *"thinking with xhigh effort"*. Take 1 still came in at 3m29s,
  but `claude --effort medium` in `agent.sh` is the knob if you want a shorter
  film. It is left alone by default rather than quietly overriding a global
  preference.
- **Model** is `--model sonnet` in `agent.sh`, chosen for pace.
- **What gets built** is `briefs/roadmap.md` step 3 and nothing else. Change the
  scope there and the rest of the fleet follows it.
