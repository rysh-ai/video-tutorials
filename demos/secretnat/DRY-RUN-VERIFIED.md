# SecretNAT demo — off-camera verification (2026-07-15)

Real rysh daemon (v0.1.25-90-g8b75c48, SNAT build) with all LLM traffic routed
through `wireproxy.go` (tees every request body to wire.log before forwarding to
api.anthropic.com). Fake demo keys only.

## Verified facts (all real, from the daemon + the wire)

1. **On by default** — daemon startup log: `secretnat: known-secret set updated count=0`.
2. **Detected tier** — pasted `sk_live_DEMOKEY_REDACTED` in a prompt:
   - wire.log real-key occurrences: **0**
   - wire.log `sk_live_SNAT000001` occurrences: **5** (system-prompt cache + turns)
   - the model still answered correctly ("live key") — semantic type preserved.
   - daemon log: `secretnat: sanitized replacements=1`.
3. **Known tier** — `##secret new STRIPE_KEY sk_live_...`:
   - daemon log: `secretnat: known-secret set updated count=1`
   - subsequent prompt referencing it → wire shows `${STRIPE_KEY}` (2×), real value 0×.
4. **The sanitized user turn as actually sent to Anthropic:**
   `In one sentence: is sk_live_SNAT000001 a live or test key?`

## The one-line wire proof (for on-camera)
    grep -c  'sk_live_DEMOKEY_REDACTED'       wire.log   # -> 0   (real key never left)
    grep -oE 'sk_live_SNAT[0-9]+' wire.log   # -> sk_live_SNAT000001

5. **`##snat list` / `##snat get`** (on camera, rysh-input mode):
   - `##snat list` -> `sk_live_SNAT000001   stripe   hits:1` (token, detector, hits — no value)
   - `##snat get sk_live_SNAT000001` -> `= sk_live_DEMOKEY_REDACTED
      [detected-tier · revealed locally — the model only ever saw the token]`
   `##snat get` was added the same day (`secretnat.Session.Reveal` + `MappingTable.RevealToken` /
   `KnownSet.ValueFor`; unit test `TestSnatCommandGetRevealsLocally`). LOCAL-only reveal: the
   value prints to the owner's own pane and is never placed on the outbound path.

Tool-input restoration (the local file receives the REAL value while the wire keeps the token)
is covered by rysh-shared integration tests (TestOrchestratorRestoresInputSanitizesOutput).
