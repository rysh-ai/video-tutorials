# RENDERING.md — what it actually takes to render a tape, and what comes out

E5 T2. Everything below was run on this machine on **2026-08-12**. Every version
string is pasted from the tool that printed it, every duration is an `ffprobe`
reading of a file on disk, and every prerequisite was confirmed by watching the
check fail before it passed. Nothing here is assumed.

The short version: **the render loop works, and its output length is not under
the tape's control.** Three unmodified tapes rendered clean and came out at
0.097, 0.142 and 0.279 of their nominal length. §5 explains why, and §6 says
what that does to T1.

---

## 1. Reproduce it in three commands

From `video-tutorials/tapes` in a worktree of this repo:

```sh
(cd ../../rysh-cli && GOWORK=off go build \
    -ldflags "-s -w -X main.version=$(git describe --tags --always --dirty)" \
    -o ../worktrees/video-tutorials-e5-t2-render/tapes/render-sandbox/bin/rysh ./cmd/rysh)

./check_render_prereqs.sh          # red until the line above has run
./render_control.sh story-019-stacked-panes
```

`render_control.sh` writes `render-control-results.tsv` (budget, wall time,
`ffprobe` duration, drift, load) and moves the mp4 and gif into `out/`.

## 2. Prerequisites — tested, not assumed

`check_render_prereqs.sh` is the executable copy of this table. It was written
**before** anything was installed or built and it failed on this machine on
required check 5, `rysh` not on `PATH`, exit 1. That red is the evidence the
list is real; a prerequisite nobody watched fail proves nothing.

| # | Prerequisite | Found on this box | Why a tape needs it |
|---|---|---|---|
| 1 | `vhs` | `0.11.0` at `/usr/local/bin/vhs` | reads the tape; nothing else does |
| 2 | `ttyd` | `1.7.7-unknown` at `/usr/local/bin/ttyd` | vhs drives a real terminal through it; without it vhs exits before the first directive |
| 3 | `ffmpeg` | `8.1.1` at `/usr/local/bin/ffmpeg` | vhs shells out to it to encode |
| 4 | `ffprobe` | `8.1.1` | not needed to render — needed to *measure*, and an unmeasured render calibrates nothing |
| 5 | `rysh` | **built from source, see §3** | all 121 tapes type `rysh` at the shell; without it every tape films "command not found" |
| 6 | `bash` | `/bin/bash`, GNU bash 3.2 | every tape carries `Set Shell "bash"` |
| 7 | Chrome or Chromium | `/Applications/Google Chrome.app` | vhs screenshots the ttyd page through a headless browser |
| 8 | JetBrains Mono | **absent — WARN, not FAIL** | tapes set no `FontFamily`, so vhs applies its default `JetBrains Mono`; absent, the browser falls back to a generic monospace. Renders still succeed and durations are unaffected — it changes glyphs, not timing |

Two things the tapes' own header comments claim as prerequisites and that are
**not** separately required: "no existing default session" is handled per-render
(`rysh delete-session` before and after, one `RYSH_SESSION` per tape), and the
Catppuccin Mocha theme ships inside vhs.

## 3. The build

```sh
cd rysh-cli
GOWORK=off go build -ldflags "-s -w -X main.version=$(git describe --tags --always --dirty)" \
  -o <sandbox>/bin/rysh ./cmd/rysh
```

| | |
|---|---|
| Binary | `tapes/render-sandbox/bin/rysh` (49 MB, gitignored via root `.gitignore:32`) |
| Version | `rysh v0.2.5-81-ge6257f8` |
| Source | `rysh-cli` on `macmini` |
| Wall time | **8.6 s** warm |

`GOWORK=off` is not optional: `rysh-cli` is deliberately outside `go.work` and
its pinned `charmbracelet/x/ansi` conflicts with the server's. It is set for
you inside `rysh-cli/Makefile:12`, so `make build` also works — that target
writes `rysh_local` rather than `rysh`, and the tapes type `rysh`.

**This box is an Apple M1, but the render stack is x86_64 under Rosetta.** `go`,
`vhs`, `ttyd` and `ffmpeg` all live in `/usr/local` (Intel Homebrew); `uname -m`
in this shell reports `x86_64`. So the binary above is a Mach-O x86_64, matching
the stack that runs it. A native build is available —
`GOWORK=off GOARCH=arm64 go build` cross-compiles clean, verified, 70 s cold —
but it would be the only arm64 process in an otherwise emulated pipeline, so the
Intel build is what was used and measured. Anyone reading a timing number from
this document should know the whole pipeline is emulated.

## 4. The render sandbox

A tape is rendered from inside a working directory, never from `tapes/`, because
`Output story-NNN.mp4` is relative and vhs writes it to the CWD.

| Property | Value |
|---|---|
| Working directory | `tapes/render-sandbox` |
| `PATH` | `render-sandbox/bin` **first**, then the ambient PATH — so the typed `rysh` is the build under test and never a stale copy from the operator's shell |
| Session | `RYSH_SESSION=story-NNN`, one per tape, deleted before and after |
| Fixtures | `hello.go`, `hello.txt` — seeded copy-if-missing |
| Run artifacts | `.rysh/{history,reports,sessions}` per render — gitignored (`tapes/.gitignore`) |
| Outputs | `<tape>.mp4` and `<tape>.gif`, moved to `tapes/out/` |

`render_all.sh:26` seeds those fixtures with an unconditional `cp -f`, which
overwrites the sandbox's own tracked `hello.go` and leaves the repo dirty after
every render. `render_control.sh` copies only when the file is absent.

## 5. The three control renders — and what they mean

Three tapes, **rendered byte-for-byte as committed**. They are the control, so
nothing edited them: each blob was confirmed hash-identical to `HEAD`
(`ce07e02`), and this worktree was cut before T1's re-timing merge (`1acd57f`)
landed on `macmini`, so no re-timed tape reached this measurement.

**Static budget** is the sum of the tape's `Sleep` directives plus its typing
cost (`Type` text × `TypingSpeed`, plus one tick per key press), computed by
`tape_budget.py`. **Real** is `ffprobe`. **Drift** is real ÷ budget.

| Tape | Sleep | +typing | = budget | wall | frames | **real** | **drift** | load before → after |
|---|---:|---:|---:|---:|---:|---:|---:|---|
| `story-019-stacked-panes` | 18.000 | 2.550 | **20.550** | 239 s | 50 | **2.000 s** | **0.097** | 63.3 → 131.1 |
| `story-050-editing-files` | 24.300 | 6.675 | **30.975** | 278 s | 110 | **4.400 s** | **0.142** | 140.2 → 140.8 |
| `story-001-what-is-rysh` | 33.400 | 4.200 | **37.600** | 175 s | 262 | **10.480 s** | **0.279** | 128.2 → 53.4 |
| `story-019` *(repeat, same tape)* | 18.000 | 2.550 | **20.550** | 121 s | 84 | **3.360 s** | **0.164** | 55.5 → 107.3 |

All four exited `rc=0` with every directive executed — this is not a crash. The
renders are simply far shorter than the tapes ask for.

**The mechanism.** Duration is `nb_frames / 25`, exactly, on all seven mp4s
measured (the four above and the three May-29 masters). VHS captures a
screenshot per frame and encodes the result at a fixed 25 fps. It never gets
near 25 captures per second at 1920×1080 on this box — the four runs achieved
**0.21, 0.40, 1.50 and 0.69 captures/second**. So:

```
real_duration = frames_captured / 25 = (capture_rate × wall_time) / 25
```

The tape's `Sleep` directives set how long the render *takes* — wall time was
6–12× the budget in every run, so the Sleeps are being honoured in real time —
but they have almost no bearing on how long the resulting video *is*. The output
is an unintentional time-lapse whose compression ratio is whatever the capture
loop managed.

**Drift is not a constant, and not a property of the tape.** The same tape,
unmodified, rendered twice about half an hour apart, came out **2.000 s** and
**3.360 s** — a 1.7× spread with zero change to the input.

**Load average does not predict it.** Render 1 drifted 0.097 starting at load 63;
render 2 drifted 0.142 starting at load 140. Higher load, less drift. The
1-minute average is a lagging number and these renders run 2–5 minutes, so it
describes a different window than the one that mattered. **No load-to-drift rule
belongs in this document,** and none is given.

**Normalising against the May-29 masters does not rescue it.** Those three were
rendered on a quiet machine and are the only earlier data points available:

| Tape | May-29 real | May-29 drift | drift now | ratio |
|---|---:|---:|---:|---:|
| `story-019-stacked-panes` | 7.28 s | 0.354 | 0.097 | 3.65 |
| `story-050-editing-files` | 13.68 s | 0.442 | 0.142 | 3.11 |
| `story-001-what-is-rysh` | 14.24 s | 0.379 | 0.279 | 1.36 |

If drift at a given moment were a property of machine state alone, that ratio
would be roughly constant and one throwaway calibration tape could predict a
whole batch. It ranges 1.36–3.65 — nearly as wide as the raw drift it was
supposed to normalise. **Treat this as a refuted three-point hypothesis, not a
finding.** What survives is weaker and firmer: drift varies a lot, it varies
between two runs of the same tape, and nothing measured here predicts it in
advance.

And note the quiet-machine baseline is itself only 0.354–0.442. **Even on an
idle box this pipeline produced videos at roughly 40 % of nominal length.** The
111 masters' 3.7× narration overrun in the E5 work order §1 is this same number
seen from the other end.

## 6. What this does to T1

T1 re-times the 111 tapes so that a tape's predicted duration matches its
`say/*.mp3`. The prediction is the static budget in §5 — and the measured
relationship between that budget and the rendered mp4 ranged **0.097 to 0.279**
across three tapes today, and **0.097 to 0.164 on one tape rendered twice**.

So a re-timed tape does not yield a correctly-timed video. Lengthening the
`Sleep`s makes the render take proportionally longer in wall time while the
capture loop continues to emit whatever it manages, so a tape re-timed to 60 s
still renders to whatever `frames/25` comes out to. **T1 remains necessary — the
tapes are wrong and it fixes their shape — but it is not sufficient, and its
predicted durations must not be reported as expected video lengths.** T1's own
commit already says "static model, not render-validated"; this is the
measurement behind that caveat.

What would actually close the gap, in rough order of cost, none of it done here:

1. **Ask vhs for fewer frames.** `Set Framerate` is untested on this box. If the
   encode framerate can be brought down to something the capture loop can hit,
   duration and wall time converge. Cheapest thing to try, and it is a one-line
   tape change.
2. **Render smaller.** 1920×1080 is what starves the capture loop. Rendering at
   1280×720 and upscaling costs sharpness, not correctness.
3. **Render on an idle machine.** Worth 0.4 against 0.1, per the table above —
   an improvement, not a fix.
4. **Stop relying on the render's length.** Retime the *video* after the fact
   with ffmpeg against the known mp3 duration, instead of trying to make vhs
   produce a given length. This is the only option above that does not depend on
   a number nobody can predict.

Recommendation: try (1) before anything else, and measure it the way §5 was
measured. It is the only cheap option that attacks the mechanism.

## 7. What was not tested

- `Set Framerate` — named as the first thing to try in §6, not measured.
- Rendering at a resolution other than 1920×1080.
- Any render on an idle machine; load was 55–140 throughout.
- The other 118 tapes. Three were rendered, one of them twice.
- Whether the missing JetBrains Mono changes anything visible. The fallback
  renders and the timing is unaffected; nobody compared frames.
- Tapes needing Slack tokens, an upstream, or a live API key. All three controls
  are self-contained; `render-ad07.sh` documents what the Slack ones additionally
  need and none of it was exercised.
