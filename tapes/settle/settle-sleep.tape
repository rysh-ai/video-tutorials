# settle-sleep.tape — E5 settling experiment, arm A: the screen is STILL.
# Budget (tape_budget.py model): Type 11 chars x 100ms = 1.1 s + Enter 1 tick = 0.1 s
#                                + Sleep 18.8 s                        = 20.0 s
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

Type "echo settle"
Enter
Sleep 18.8s
