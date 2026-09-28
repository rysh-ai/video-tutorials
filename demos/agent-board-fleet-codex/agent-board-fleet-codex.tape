# agent-board-fleet-codex — four Codex agents build a web app, live, on one board.
#
# The claude version of this shot is ../agent-board-fleet/agent-board-fleet.tape.
# Same framing, same beats, same session shape; only the agent differs.
#
# Rendered by ./record.sh, which builds the session first and checks the take
# afterwards. Do not run vhs on this directly: the tape assumes the layout
# already exists and that `rysh` is on PATH under its plain name.
#
# QUOTE EVERY PATH. VHS's parser reads a bare path beginning with `_` (or a
# digit) as a command and fails the whole tape with "Invalid command".

Output "_run/agent-board-fleet-codex.mp4"

Set FontSize 14
Set Width 1920
Set Height 1080
Set Framerate 24
Set Theme "Catppuccin Mocha"
Set TypingSpeed 35ms
Set Shell "bash"

# Padding 90, not the usual 20. The player's chrome eats the top of the frame —
# roughly three text rows — and at 20 that took the tab bar and the first pane
# header with it. 90px is about five rows of clearance, so the top of the TUI
# survives whatever crops it. This is the same fix the remote-reach re-shoot
# needed (marketing/tracker.md, 2026-07-15).
Set Padding 90

Sleep 2s

# A title line first, and it is deliberately expendable: if a player still eats
# the top rows despite the padding, this is what it eats. Everything that
# matters is below it.
Type "# ─────────  rysh · a fleet of codex agents and the board they report to  ─────────"
Enter
Sleep 1500ms

Type "# Four Codex agents build a web app — and every one of them reports to a shared board."
Enter
Sleep 1500ms
Type "# Lane 1: roadmap + fleet-manager.  Lane 2: worker-1 + worker-2.  Lane 3: the agents board."
Enter
Sleep 2s

Type "./start-fleet.sh"
Enter
Sleep 2500ms

Type "rysh attach codexfleet"
Enter

# The run itself. The claude version of this demo came in at 3m30s; this ceiling
# is deliberately looser because codex's pace on this machine had not been
# measured when the tape was written, and a take that runs past its Sleep loses
# its ending outright.
#
# It cannot be trimmed by wall clock either: VHS does not capture in real time
# on a loaded machine — it drops frames unevenly when the terminal renders
# faster than it can screenshot, so a tape that sleeps 8 minutes does not
# produce an 8 minute file and no offset computed from these Sleep lines points
# at the frame you think it does. record.sh trims the static tail by looking at
# the FRAMES.
Sleep 8m
