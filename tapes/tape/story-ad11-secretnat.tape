# Story AD-11: The secret that never leaves your machine (SecretNAT / ReSet) ~85s
# Hook: "It's NAT, but for secrets."
# Master plan: marketing/assets/videos/secretnat-reversible-secrets.md
#
# Run (from tapes/render-sandbox/demo-snat, proxy already running on :8899):
#   bash video-tutorials/demos/secretnat/render-ad11.sh
# Then: make say && make tts-one F=story-ad11-secretnat.say SPEED=1.05
#       && bash video-tutorials/demos/secretnat/compose-ad11.sh
#
# DESIGN: single pane. ##snat status in SHELL mode; paste in PROMPT mode; then
# Double-Escape ONCE (prompt->rysh) so ##snat list / ##snat get render in the
# rysh buffer (## output only shows in shell/rysh display modes); then DETACH
# (Ctrl+O d) to the host shell to grep the wire. VHS can't send Alt+Arrow and
# Double-Escape cycles shell->prompt->rysh->chat (not a toggle) — this routing
# avoids both. The ONLY non-deterministic beat is the model's one-sentence
# answer. REAL run through the real Anthropic API; the proxy only observes.
#
# Pre-take hygiene (every take), FROM render-sandbox/demo-snat (render-ad11.sh does this):
#   - delete-session story-ad11; verify .rysh/sessions/story-ad11.json gone; kill stray daemons
#   - rm -f wire.log deploy/.env; rm -rf .rysh/secrets   (fresh, real wire log)
#   - NO real secret anywhere: env, rysh.config.yaml, .rysh/secrets/, shell history
#   - keep the sandbox config free of debug logging (a DBG line on camera kills a take)
#   - ANTHROPIC_API_KEY in vhs env; RYSH_API_URL -> the proxy; PATH shim bin/rysh -> rysh_local

# --- Output Settings ---
Output story-ad11-secretnat.mp4

# --- Terminal Settings ---
Set FontSize 18
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 65ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:10  Title / Hook (title card added in post)
# "Every AI coding tool has the same problem. To help you, it
#  reads your code -- and your code is full of secrets. So your
#  keys end up on someone else's servers. Rysh fixes that at the
#  wire."
# ============================================================
Type "rysh"
Enter
Sleep 7s

# ============================================================
# 0:10-0:22  On by default
# "SecretNAT is on by default. It sits between rysh and the model.
#  Every request that leaves this machine passes through it first --
#  and the provider only ever sees synthetic tokens."
# ============================================================
Type "##snat status"
Enter
Sleep 6s

# ============================================================
# 0:22-0:44  The paste (detected tier, zero setup)
# "I'll paste a live Stripe key and ask about it. The model answers
#  correctly -- it knows it's a live key -- but it's reasoning about
#  a token, S-N-A-T zero-zero-zero-zero-zero-one, never your value."
# ============================================================
# Double-Escape: shell -> prompt mode
Escape
Sleep 0.3s
Escape
Sleep 1s
Type "In one sentence: is this Stripe key live or test, and what does the sk_live_ prefix mean? sk_live_DEMOKEY_REDACTED"
Enter
Sleep 15s

# ============================================================
# 0:44-1:02  See the mapping, and unmask it -- locally
# "Rysh kept a reversible map. ##snat list shows every token it
#  swapped in -- tokens only. And when YOU need the real value,
#  ##snat get hands it back -- right here, on your machine. Never
#  to the model."
# ============================================================
# Double-Escape ONCE: prompt -> rysh mode (## output renders here)
Escape
Sleep 0.3s
Escape
Sleep 1s
Type "##snat list"
Enter
Sleep 5s
Type "##snat get sk_live_SNAT000001"
Enter
Sleep 6s

# ============================================================
# 1:02-1:22  The reveal: step out of rysh, look at the wire
# "Now the receipts. Step out of rysh, and grep every byte it sent
#  the model. How many times did the real key leave this machine?
#  Zero. What the model saw was the token -- a look-alike rysh can
#  reverse and the provider can't. That's NAT, for secrets."
# ============================================================
# Detach: Ctrl+O then d -> back to the host shell
Ctrl+O
Sleep 0.5s
Type "d"
Sleep 3s
Type "grep -c sk_live_DEMOKEY_REDACTED wire.log     # real key on the wire"
Enter
Sleep 4s
Type "grep -oE 'sk_live_SNAT[0-9]+' wire.log | sort -u    # what the model saw"
Enter
Sleep 5s

# ============================================================
# 1:22-1:30  Close (end card added in post)
# "You can unmask it. The model can't. On by default, reversible,
#  in memory only. Your keys never become someone else's training
#  data. Rysh -- onboarding design partners now."
# ============================================================
Sleep 4s
