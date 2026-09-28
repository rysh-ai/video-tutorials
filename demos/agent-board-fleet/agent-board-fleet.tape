# agent-board-fleet — four Claude agents build a web app, live, on one board.
#
# Rendered by ./record.sh, which builds the session first and checks the take
# afterwards. Do not run vhs on this directly: the tape assumes the layout
# already exists and that `rysh` is on PATH under its plain name.
#
# QUOTE EVERY PATH. VHS's parser reads a bare path beginning with `_` (or a
# digit) as a command and fails the whole tape with "Invalid command".

Output "_run/agent-board-fleet.mp4"

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
# matters is below it. (The first take typed `printf '\n\n\n'` here, which did
# the same job and looked like a mistake on camera.)
Type "# ─────────  rysh · a fleet of agents and the board they report to  ─────────"
Enter
Sleep 1500ms

Type "# A fleet of Claude agents builds a web app — and every one of them reports to a shared board."
Enter
Sleep 1500ms
Type "# Lane 1: roadmap + fleet-manager.  Lane 2: worker-1 + worker-2.  Lane 3: the agents board."
Enter
Sleep 2s

Type "./start-fleet.sh"
Enter
Sleep 2500ms

Type "rysh attach agentfleet"
Enter

# The run itself. Measured end to end at ~3m30s on the build machine: the
# roadmap opens the board at ~0:50, the work orders go out at ~2:10, both
# workers sign off at ~2:40, the closing milestone lands at ~3:20.
#
# 6 minutes is a ceiling with slack, not the expectation. It cannot be a
# tight fit and it cannot be trimmed by wall clock either: VHS does not capture
# in real time on a loaded machine — it drops frames unevenly when the terminal
# renders faster than it can screenshot, so a tape that sleeps 6 minutes does
# not produce a 6 minute file and no offset computed from these Sleep lines
# points at the frame you think it does (showcase.tape learned this the hard
# way). record.sh therefore trims the static tail by looking at the FRAMES.
Sleep 6m
