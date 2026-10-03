# settle-type.tape — E5 settling experiment, arm B: the screen changes CONTINUOUSLY.
# Budget (tape_budget.py model): Type 200 chars x 100ms = 20.0 s, no Sleep, no keys.
# TypingSpeed 100ms is chosen so typing time == budget: 20.0 s / 200 chars = 0.100 s/char.
# Rendered by tapes/render_settle.sh, which sets the Output path per run.
# --- Terminal Settings (identical in both settle tapes; copied from the story corpus) ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 100ms
Set Shell "bash"
# No Set Framerate: both tapes take the vhs default.

Type "the quick brown fox jumps over the lazy dog the quick brown fox jumps over the lazy dog the quick brown fox jumps over the lazy dog the quick brown fox jumps over the lazy dog the quick brown fox jump"
