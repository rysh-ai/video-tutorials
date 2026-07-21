# Story AD-08: What the Agent CAN'T Do Without You (~75-80s) — TRUST TOOLKIT CUT
# Hook: "Trust is a mechanism, not a promise."
# Master plan: marketing/assets/videos/trust-toolkit.md  (see RESCOPE note 2026-07-15)
#
# Run (from tapes/render-sandbox, with PATH shim to fresh build):
#   PATH="$PWD/bin:$PATH" RYSH_SESSION=story-ad08 vhs ../tape/story-ad08-trust-toolkit.tape
# Then: make say && make tts-one F=story-ad08-trust-toolkit.say SPEED=1.05
#       && make vover-one F=story-ad08-trust-toolkit.mp4
#
# NOTE: scenes 3-4 run a LIVE model (grounding gate -> diff -> approval) — sleeps
# there are generous estimates. Do a timing pass after take 1; if cutting, cut each
# segment to its OWN file and concat with the concat DEMUXER (VFR).
#
# KEEPER: take 4 (80.04s raw; final vover 84.5s with cards) — 2026-07-15.
# Take-2 QC: fresh-session bootstrap race wedged input (~50% under load) —
# FIXED in rysh-cli (tabReadyMsg, tab.go/workspace_tabs.go/workspace.go);
# rebuild rysh_local before filming. Take-3 QC: substrate contaminated via
# cwd-drift (use ABSOLUTE paths for every pre-take mutation + verify with
# cat right before vhs) and rysh.config.yaml left debug logging on (DBG
# line on camera) — keep the sandbox config-free.
#
# Take-1 QC (2026-07-15): the session registry is PROJECT-LOCAL now
# (render-sandbox/.rysh/sessions/<name>.json — NOT ~/.local/state/rysh). A stale
# record makes the TUI attach to a dead session: "no tabs" badge, pane stuck
# "idle | Shell..", ALL typed input dropped (only mode keys register). Run
# delete-session FROM the render-sandbox cwd and verify the .json is gone.
#
# Pre-take hygiene (every take):
#   - FROM render-sandbox: ./bin/rysh delete-session story-ad08; verify
#     .rysh/sessions/story-ad08.json is gone; kill leftover daemons by PID
#     (pgrep -f "daemon story-ad08") — never pkill rysh blindly
#   - re-seed render-sandbox/hello.go (CLEAN version, no comment above main)
#   - rm -rf render-sandbox/.rysh/secrets  (the gitignore beat must be a fresh create)
#   - ANTHROPIC_API_KEY must be in the env vhs inherits
#   - PATH shim bin/rysh -> rysh-cli/rysh_local (brew rysh is 90 commits behind)

# --- Output Settings ---
Output story-ad08-trust-toolkit.mp4

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
# "Every agent demo shows you what the agent can do. This one
#  shows you what it can't do -- without you."
# ============================================================
Type "rysh"
Enter
Sleep 6s

# ============================================================
# 0:08-0:32  Secrets: masked at the point of entry
# "A secret enters rysh exactly once -- the moment you type it.
#  Even that line is masked before it reaches the buffer, or the
#  history. It's stored scoped to this workspace -- persist it,
#  and it lands in a folder rysh git-ignores for you. The only
#  way to see the value again is to ask for it. Explicitly."
# ============================================================
Type "##secret new STRIPE_KEY sk_test_demo123 --persist"
Enter
Sleep 4s
Type "##history"
Enter
Sleep 4s
Type "cat .rysh/secrets/.gitignore"
Enter
Sleep 4s
Type "##secret list"
Enter
Sleep 5s

# ============================================================
# 0:32-0:57  Grounding: the gate
# "Before an agent may change anything here, it has to read.
#  Enforced grounding -- the default -- starts every run with
#  mutating tools locked. Exploration only, until the agent files
#  a grounding report naming what it read. And if it doesn't
#  understand, it doesn't guess. It stops, and it asks you."
# ============================================================
Type "##grounding"
Enter
Sleep 5s
# Double-Escape: shell mode -> prompt mode
Escape
Sleep 0.3s
Escape
Sleep 1s
Type "Add a one-line comment above main() in hello.go saying what it prints. Keep everything else unchanged."
Enter
# live model: file_read -> grounding_report -> edit + colored diff
Sleep 20s

# ============================================================
# 0:57-1:14  Approvals: the human gate
# "The gate is open -- and the edit still doesn't execute. It
#  queues. Here's the diff; here's the prompt. It's been waiting
#  five seconds now. It would wait all day -- that's the point.
#  Approve it, and only then does it touch the file. Or reject
#  it, with a reason the agent reads."
# ============================================================
# the approval prompt is on screen -- the WAIT is the shot
Sleep 6s
Type "y"
Enter
# apply + final agent answer render; end ON the applied edit.
# (Take-3 lesson: do NOT double-Escape back for a `cat` — Double-Escape
# CYCLES shell→prompt→rysh→chat, so esc×2 from prompt lands in RYSH mode
# and an unknown command dumps the help screen on camera.)
Sleep 10s

# ============================================================
# 1:14-1:21  Close (end card added in post)
# "Masked secrets. A grounding gate. A human approval. One
#  runtime, not three plugins. rysh, at rysh-dot-A-I --
#  onboarding design partners now."
# ============================================================
Sleep 5s
