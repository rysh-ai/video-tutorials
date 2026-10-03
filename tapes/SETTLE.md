# SETTLE — the E5 settling experiment (E5 §2 T3, §6.3 hypothesis)

Run 2026-10-03 on `macminim5` (Apple Silicon, arm64), natively: no Rosetta. The renderer was
vhs 0.12.1 from the Homebrew arm64 bottle (`vhs` sha256 `4814a1a3…a7ca5`), with ttyd 1.7.7,
ffmpeg 9.0.2 and Google Chrome. Recipe: `tapes/render_settle.sh`. Tapes: `tapes/settle/`.
Data: `tapes/settle-results.tsv`.

## 1. The hypothesis

vhs emits a frame when the screen *changes*. If that is true, a render's length tracks how much
the screen moves, not the tape's `Sleep` budget. This would explain three things the archived
evidence reports: `duration == nb_frames/25`, the wandering capture rate, and why the
skill-file-typing stories 081/082/083 came closest to passing QC.

## 2. Design

Both tapes have a budget of **20.000 s** as modelled by `tape_budget.py`. They use identical
terminal settings: the story corpus's 1920×1080, FontSize 16, Catppuccin Mocha, Padding 20 and
`Shell bash`, with `TypingSpeed 100ms` in both. Neither sets `Set Framerate`. Neither runs
`rysh`, so they test only the renderer.

| Tape | Screen | Budget arithmetic |
|---|---|---|
| `settle-sleep.tape` | still | `Type "echo settle"` 11 × 0.1 = 1.1 s, `Enter` 1 tick = 0.1 s, `Sleep 18.8s` → **20.0 s** |
| `settle-type.tape` | moving the whole time | 200 chars × 0.1 s = **20.0 s**. TypingSpeed = 20.0 s / 200 chars = 100 ms |

The tapes were rendered back to back in the order sleep, type, sleep, type, sleep, type
(ABABAB), with n = 3 per arm. `nb_frames` comes from decoding the file
(`ffprobe -count_frames`), not from the header. Duration comes from `ffprobe format=duration`.
Load is `sysctl -n vm.loadavg` (1-minute) read before each render.

## 3. Results (every number is an `ffprobe` or clock reading)

| tape | run | budget_s | nb_frames | duration_s | ratio | r_frame_rate | wall_s | load_before |
|---|---|---|---|---|---|---|---|---|
| settle-sleep | 1 | 20.000 | 474 | 18.960 | 0.948 | 25/1 | 24.4 | 187.20 |
| settle-type  | 1 | 20.000 | 497 | 19.880 | 0.994 | 25/1 | 25.4 | 136.72 |
| settle-sleep | 2 | 20.000 | 467 | 18.680 | 0.934 | 25/1 | 23.5 | 101.83 |
| settle-type  | 2 | 20.000 | 495 | 19.800 | 0.990 | 25/1 | 27.0 | 89.05 |
| settle-sleep | 3 | 20.000 | 471 | 18.840 | 0.942 | 25/1 | 23.8 | 69.21 |
| settle-type  | 3 | 20.000 | 495 | 19.800 | 0.990 | 25/1 | 25.2 | 59.10 |

- **Sleep arm:** ratio 0.934–0.948. It is short by 1.04–1.32 s.
- **Type arm:** ratio 0.990–0.994. It is short by 0.12–0.20 s.
- **The ranges do not overlap.**

The renders are gitignored. Each is cited by its absolute path and sha256 in the
`mp4_path`/`mp4_sha256` columns of `settle-results.tsv`, under
`/Users/halilagin/root/github/rysh-ai/worktrees/video-tutorials-e5-settle/tapes/out/settle/`.

## 4. Verdict

**The hypothesis meets the work order's "supported" test as written, but the effect is about
1 s. It does not explain the E5 deficit, because the deficit did not reproduce at all.**

1. **Against the work order's criteria.** The type renders sit consistently near 1 (0.990–0.994).
   The sleep renders are consistently shorter (0.934–0.948), and the two ranges do not overlap
   at n = 3. So the criteria are met. A still screen does lose roughly 1.0–1.3 s of a 20 s
   budget that a moving screen keeps. That fits a weak form of "frames follow screen change":
   some idle time is not captured. Whether it is a fixed offset or proportional to idle time is
   **not measured**. That would need a second budget, for example 40 s.
2. **Against the deficit the hypothesis was meant to explain, it is not supported.** E5's
   archived renders of real story tapes came out at ratio **0.097–0.279**, with wall time 6–12×
   the budget at load 55–140 (`render-repeat-019.tsv`: story-019 at 0.164 and then 0.097;
   `render-control-results.tsv`: 0.097, 0.142, 0.279). Here, *both* arms render at
   **0.93–0.99**, with wall time about 1.2× the budget, even at load **187**. Screen motion moved
   the ratio by about 0.05. The historical gap is about 0.8.
3. **What changed is confounded, and this run cannot separate the causes.** The archived renders
   differed in two ways at once:
   - **(a) Toolchain.** They used x86_64 vhs under Rosetta on an M1 (E5 §1). This run used
     native arm64 vhs 0.12.1.
   - **(b) Content.** Their tapes drive the `rysh` TUI. These tapes drive bare bash.

   Either one could be what makes capture fall behind real time. **Separating them takes one
   control render of a corpus tape (story-019, budget 20.55 s) on this toolchain.** If it lands
   near 1.0, the deficit was the Rosetta toolchain and post-hoc re-time (T2) is no longer needed
   for new renders. If it lands near 0.1–0.3, the deficit comes from rendering the rysh TUI.

   I did not run that control. `render_control.sh` runs `rysh delete-session default`, and this
   machine is running live rysh sessions. It needs a sandboxed session, a decision for the lead.

## 5. Not done

- No second budget, so the fixed-offset vs proportional question is open.
- No corpus-tape control render, so the toolchain vs content confound is open (see §4.3).
- n = 3. Load fell steadily across the run, from 187 to 59. The type arm stayed flat (0.990 to
  0.994) over that whole range, which is itself evidence that load does not drive the ratio on
  this toolchain.
