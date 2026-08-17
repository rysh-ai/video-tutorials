# readme-quickstart — the demos linked from the public README

Four narrated, subtitled videos, simple to complex, made to sit at the top of
`scripts/oss-assets/README-code.md` (which `scripts/export-oss.sh` injects into
the public `rysh-ai/rysh-cli-code` repo).

| # | Directory | Shows |
| --- | --- | --- |
| 1 | `01-first-panes/` | Install, a first session, tabs, lanes, stacked panes, `##claude` in each pane of the stack |
| 2 | `02-stop-start/` | `rysh stop`, then attach again — Claude and Codex resume, with the conversation intact |
| 3 | `03-claude-codex-parallel/` | A stack of three, Claude in two panes and Codex in the third, all working at once |
| 4 | `04-fleet-board/` | A mixed fleet — Claude and Codex agents talking to each other on a shared board — builds a browser todo app |
| 5 | *(no source here)* | **Graph Engineering** — the white-paper video, built by a different pipeline and only *staged* here |

All four are verified frame by frame: demo 2's agents answer the codewords they
were told before the stop, demo 3's three agents each write their file, and demo
4's fleet ships a todo app that parses, loads its own CSS and JS, and uses no
network and no dependencies.

Demo 4 is the only one where the agents drive each other rather than being
driven. `roadmap` (Claude) sets the goal, `fleet-manager` (Codex) splits it into
work orders and writes a shared contract, `worker-1` (Codex) builds the page,
`worker-2` (Claude) builds the behaviour, and all four narrate themselves to the
agents board in lane-3 — which is the only place a viewer can watch four agents
at once. The take caught a real review loop: Codex's manager found a duplicated
count label, sent one correction to Claude's worker over `rysh ansa prompt`,
waited for the fix, and only then signed off. Its machinery is adapted from
`../agent-board-fleet/`, which worked most of it out the hard way.

### Demo 5 is a guest, not a build target

`out/05-graph-engineering.*` is **not built by `make-demo.sh`** and has no source
directory here. It is the Graph Engineering white-paper video, built by
`marketing/assets/videos/graph-engineering/` (its own tape, its own narration, its
own `narrate.sh` using Deepgram for the *voice* as well as the timings). It is
copied in so all five ship from one folder; rebuild it with that directory's
`./record.sh`, never with `./make-demo.sh`.

Two consequences worth knowing:

- **Its subtitles are already pixels**, burned by its own pipeline in its own
  style — bold with a shadow rather than this folder's boxed style. `speed-up.sh`
  detects a master with no `.softsubs.mp4` beside it and skips the burn step, so
  the picture is re-timed and the baked text rides along. Burning again would lay
  a second copy of every caption over the first.
- **There is no `05-graph-engineering.softsubs.mp4`**, because no soft-subtitle
  master exists to make one from — its pipeline burns during the same encode that
  fits each clip. Upload the `.mp4` as-is, or ask that pipeline for a clean cut.

Its own handoff (`/tmp/graph-engineering-HANDOFF.md` at time of writing) records
the open gates on it: nobody has watched it end to end, hosting is undecided, and
its narration is under the claim discipline of
`new_roadmap/designs/024-investor-claims.md` — **do not re-cut or re-time its
narration without reading that**. Re-timing the picture, as done here, changes no
claim: its cue 7 says "about a minute of real time, sped up here", which is a
statement about real time and survives any playback factor.

## Build one

```sh
./make-demo.sh 01-first-panes
./make-demo.sh 01-first-panes --skip-record   # reuse the clips, redo the audio
./make-demo.sh 01-first-panes --skip-voice    # reuse the cues, re-record only
```

Output:

| File | What it is |
| --- | --- |
| `out/<demo>.mp4` | **the shipping cut** — 1.5x, subtitles **burned in** (visible in any player) |
| `out/<demo>.softsubs.mp4` | the same, subtitles as a selectable track — upload this to YouTube |
| `out/<demo>.srt` | its subtitle file, to attach as the YouTube caption track |
| `out/1x/…` | the same three at recorded speed, kept as the master |

The plain name carries burned-in subtitles because a soft track is switched off
by default in most players: a file that technically "has subtitles" opens showing
none, which is what it looks like when someone reports a video as unsubtitled.
For YouTube, prefer `.softsubs.mp4` plus the `.srt` — its own caption renderer
stays sharp at every resolution, where baked pixels do not.

The plain names are the sped-up cut on purpose: those are the paths that get
uploaded, so a rebuild must not quietly put a 1x file back at an address that
already went out at 1.5x. `PLAYBACK=1 ./make-demo.sh <demo>` ships the master
unchanged; `./speed-up.sh 1.25` re-times what is already built.

Re-timing moves three clocks together, which is why it is a script and not a
one-line `setpts`: the picture is re-stamped, the audio goes through `atempo`
(tempo without pitch — a plain rate change would raise the narrator a fifth),
and the **subtitle timestamps are divided too**. An ffmpeg filter cannot touch a
subtitle stream, so captions left alone drift a third of the way out by the end
— confidently wrong, which is worse than absent. The burned-in cut is rebuilt
from the re-timed SRT rather than sped up itself, because text already rasterised
into the picture cannot be re-timed.

## How it is put together

**Recorded section by section, not in one run.** VHS does not capture in real
time — `../../tapes/RENDERING.md` measured three unmodified tapes coming out at
0.097, 0.142 and 0.279 of the length their `Sleep` lines ask for, because it
drops frames whenever the terminal renders faster than it can screenshot, and it
drops them unevenly. So there is no arithmetic from `Sleep` values to a
timestamp, and a voice track laid against wall clock drifts further out with
every paragraph. Instead each `# @section N` of the tape becomes its own clip,
one narration cue is synthesised per section, and clip N is fitted to cue N: the
clip is stretched (up to 2.5×) and then its last frame is held for whatever is
left. Sync is structural — the narration cannot describe something that is not on
screen. The approach and the measurement are inherited from
`marketing/assets/videos/graph-engineering/narrate.sh`.

**The top margin is `Set Padding`.** VHS 0.11 has no `Set Margin`; padding is the
only lever it offers and it applies to all four sides. The value in each tape
header is chosen for the TOP edge, so the terminal's first rows — the session and
tab bar — never sit against the frame.

**Every section re-attaches behind `Hide`.** Each section is a separate `vhs`
run and therefore a separate terminal. The session lives in the daemon rather
than in the shell, so a section can pick up exactly where the last one left off;
the `rysh attach` that does it is hidden so it does not appear seven times.

**Voice is OpenAI, subtitle timings are Deepgram.** Cues are synthesised with
OpenAI TTS (`tts-1-hd`, `nova`) and cached by SHA-256 of their text, so editing
one paragraph does not re-bill the script. The finished audio is then normalised
to −16 LUFS in a two-pass `loudnorm` — raw TTS lands near −29 LUFS, which under a
terminal recording is a video people turn up and still cannot hear. Subtitles
come from `../agent-board-fleet/voiceover/srt_from_deepgram.py`: **timings** from
Deepgram, because only the audio knows when a word was really said, and **words**
from the narration script, because a transcript of synthetic speech is still a
transcript and a subtitle that says something the script does not is worse than
no subtitle.

**Keys come from the session's secret store**, never from a file in the repo:
`OPENAI_API_KEY` and `DEEPGRAM_API_KEY` are read with `##secret get` and only
their lengths are ever printed.

**`_bin/rysh` points at the released, publicly installable build** — not at a
local dev build. A demo attached to the README has to show what someone actually
gets from the install line in that README. Demo 1 films the real
`go install github.com/rysh-ai/rysh-cli-code/cmd/rysh@latest`.

## Re-recording

`_run/` and `.build/` are gitignored scratch. Each demo has a `setup.sh` that
clears its session before a take and a `teardown.sh` that stops it after, both
run by `make-demo.sh`. Demo 2's setup creates the session up front on purpose:
its section 1 is about panes, not about creating a session, which demo 1 covers.

### Things that are load-bearing and easy to break

Demo 3 took seven takes. Every one of them failed for a different real reason,
and none of those reasons was visible to a test — only to watching the footage.
They are written up at the top of `03-claude-codex-parallel/demo.tape`; the short
list, because each will bite again:

- **Demo 2's codeword.** Each agent is told a codeword *before* the stop and
  asked for it *after* the restart. A pane that merely reappears proves nothing;
  the answer is the only evidence the conversation came back.
- **Codex needs a real turn before the stop.** It records a session when the
  conversation starts, not when the process does, so `##codex` followed straight
  away by a stop leaves nothing to resume. Section 3 of demo 2 is what makes
  section 5 possible.
- **Codex asks about trust on first run in a directory**, and blocks. The next
  keystrokes then land in that dialog and dismiss it, and bash inherits the pane
  — which reads exactly like a crash and is not. `setup.sh` trusts the workspace
  up front.
- **Stack mode, not navigate mode.** `Ctrl+Space` is the only chord that moves
  focus between pane *groups*, and VHS emits it as NUL, which ttyd drops
  intermittently; the keystrokes then reach the agent instead. `Ctrl+S`+digit is
  ordinary bytes, survives raw mode, and is absolute — a dropped press cannot
  leave focus one pane off.
- **Gate on footer text, never on a banner title.** A stacked pane is short, so
  the banner scrolls off within seconds and a `Wait+Screen /Claude Code/` will
  wait three minutes at an agent that is running perfectly well.
- **`rysh stop` must be issued from the session's own directory.** rysh state is
  project-local, so a stop from anywhere else silently succeeds and leaves the
  daemon running. Six of them accumulated across failed takes before this was
  spotted, and each new take attached to whichever answered first.
- **Teardown is on an `EXIT` trap** in `make-demo.sh`, so a take that dies
  mid-record still cleans up. It used to sit after the record loop, which is how
  those six daemons survived.
