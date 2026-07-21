# Story AD-01: Agent Loops, On a Leash (90s) — MARKETING INTRO CUT
# Hook: "Everyone runs agents in loops. Rysh puts the loop on a leash."
# Master plan: marketing/assets/videos/intro-loop-leash.md
#
# Run: vhs story-ad01-loop-leash.tape
# Then: make say && make tts-one F=story-ad01-loop-leash.say
#       && make vover-one F=story-ad01-loop-leash.mp4
#
# NOTE: sleeps around the automation run are estimates — the live loop's pace
# depends on the model. Do a timing pass after the first render and adjust.
#
# Take-1..-5 QC (2026-07-13): a plain `run` is single-pass — a loop only
# arms when the recipe carries loop.while.prompts.until (see scene-2 note;
# `--passes` alone can NOT arm it). Kill the `rysh daemon <session>` zombie
# between takes (it re-persists old KV → restore race), and re-seed the
# recipe AFTER `rysh delete-session` (which wipes .rysh/automations/).
# KEEPER: take 5b (79.4s) — scene timestamps below match that recording.
# The 80% takeover moment is narrated, not captured — a real takeover
# capture can be a later insert shot (see recording checklist).

# --- Output Settings ---
Output story-ad01-loop-leash.mp4
Output story-ad01-loop-leash.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:08  Title / Hook (title card added in post)
# "Everyone is running agents in loops now. And everyone has
#  the same fear: you walk away, and the loop runs away --
#  with your API bill. Rysh puts the loop on a leash."
# ============================================================
Type "rysh"
Enter
Sleep 4s

# Switch input mode to rysh (##) mode: assumes default keying;
# type commands with ## prefix from shell-mode input.
Sleep 2s

# ============================================================
# 0:08-0:24  The recipe is a file
# "Any prompt becomes a reusable automation. Bind a page, save
#  a recipe. It's a file on disk -- your automations live in
#  git, not in a vendor's dashboard."
# ============================================================
# Take-2 QC: typing a long line while the headless browser was still
# starting raced the TUI input — half the line leaked to bash. Wait out the
# startup (6s+) before typing; keep .rysh between takes for a warm profile.
# Take-3 QC: `##auto web save` writes a MINIMAL recipe (no loop block) and a
# loop only arms when the recipe carries loop.while.prompts.until (the LLM
# judge's goal) — so status/stop printed "no active loops". Fix: PRE-SEED
# render-sandbox/.rysh/automations/webs/scout.md with the full loop:{do,while}
# recipe (budget 20p, takeover_when 80, until prompt) and show the FILE on
# camera instead of saving — stronger "your automations live in git" beat.
Type "##web headless on --profile scout https://news.ycombinator.com"
Enter
Sleep 6s
Type "cat .rysh/automations/webs/scout.md"
Enter
Sleep 4s

# ============================================================
# 0:24-0:44  Run with a leash
# "Now the leash. Twenty pages -- rysh counts spend like
#  reading: a page is a thousand tokens, two hundred pages
#  make a book, twenty books a shelf. Twenty pages, ten
#  minutes, hard ceilings. Not suggestions -- the run cannot
#  outspend them."
# ============================================================
# Loop arms from the recipe's loop block (until prompt) — no --passes flag
# needed; this line stays identical to the published copy (blog + promo pack).
Type "##auto web run --headless --budget-size 20p --max-duration 10m --takeover-when 80 scout"
Enter
Sleep 15s

# ============================================================
# 0:44-0:56  The takeover math + live status
# "At eighty percent spent, the takeover prompt takes the
#  wheel -- with the reserved twenty percent as its own budget
#  -- to wrap up cleanly and save results. No clipped runs.
#  No silent overspend. And status shows you the leash, live."
# ============================================================
Type "##auto web status"
Enter
Sleep 6s

# ============================================================
# 0:56-1:06  The judge, and the checkpoint
# "When a pass ends, an LLM judge decides: goal fulfilled,
#  the loop ends -- not yet, and it goes again. Stop it any
#  time; continue resumes from the last checkpoint, budget
#  re-armed. Interruptible by design."
# ============================================================
Type "##auto web stop scout"
Enter
Sleep 4s
Type "##auto web continue scout"
Enter
Sleep 8s

# ============================================================
# 1:06-1:12  Schedule it, headless
# "Schedule it. Cron takes any rysh input -- even whole
#  automations. Headless, on a server, while you sleep."
# ============================================================
Type '##cron add nightly-scout "0 7 * * *" ##auto web run --headless scout'
Enter
Sleep 3s
Type "##cron next"
Enter
Sleep 4s

# ============================================================
# 1:12-1:19  Close (end card added in post)
# "Agents that work while you sleep -- on a leash you define.
#  rysh dot A I -- now onboarding design partners."
# ============================================================
Sleep 4s
