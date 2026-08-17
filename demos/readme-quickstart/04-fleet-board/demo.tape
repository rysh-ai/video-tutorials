# Demo 4 — a mixed Claude + Codex fleet builds a todo app on a shared board.
#
# roadmap (Claude) sets the goal, fleet-manager (Codex) splits it into work
# orders, worker-1 (Codex) and worker-2 (Claude) build in parallel, and all four
# report to the agents board in lane-3. The board is the point of the film: it is
# the only place a viewer can watch four agents at once.
#
# ── THE SECTIONS ARE GATED ON THE BOARD, NOT ON A CLOCK ───────────────────────
# The fleet is real work by real agents, so its pace is not knowable in advance.
# A measured run went: board opens at ~1:00, work orders out at ~1:40, first
# worker signs off at ~4:20, DEMO COMPLETE at ~5:45 — but that is a measurement,
# not a promise. So every section ends on a `Wait+Screen` for text the board
# itself prints. If the fleet is slow the section waits; if it is quick the
# section moves on. A tape that guessed with `Sleep` would film an empty board on
# a slow day and miss the ending on a fast one.
#
# `Wait+Screen` matches the WHOLE screen, and the board pane is always visible in
# lane-3, so these markers are read straight off it. They are also chosen to be
# unique per phase: the board scrolls, and a marker that already went past would
# match instantly and film the wrong moment.
#
# ── WHAT COSTS TAKES HERE, LEARNED ON DEMOS 1–3 ───────────────────────────────
# Both vendors block on a first-run trust dialog with nobody to answer it, and a
# blocked agent looks exactly like a slow one — setup.sh grants both up front.
# `rysh stop` must be issued from the session's own directory or it silently does
# nothing and leaves daemons behind. And every hidden re-attach sleeps 12s,
# because at 6s a take lost its first typed line to a pane that was not yet
# taking input.
#
# Rendered by ../make-demo.sh. See 01-first-panes/demo.tape for the top margin.

Set Shell "bash"
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 60
Set TypingSpeed 55ms
Set WaitTimeout 600s

# @section 1  — the shape of the session, before anything runs
Hide
Type "cd /tmp/rysh-demo-4 && clear"
Enter
Sleep 1s
Type "rysh attach fleetboard"
Enter
Sleep 12s
Show
Sleep 10s

# @section 2  — start the fleet; the board opens itself
Hide
Type "cd /tmp/rysh-demo-4 && clear"
Enter
Sleep 1s
Show
Sleep 2s
Type "./start-fleet.sh"
Enter
Sleep 4s
Type "rysh attach fleetboard"
Enter
Wait+Screen@480s /DEMO:/
Sleep 12s

# @section 3  — the plan, and the split into work orders
Hide
Type "cd /tmp/rysh-demo-4 && clear"
Enter
Sleep 1s
Type "rysh attach fleetboard"
Enter
Sleep 12s
Show
Wait+Screen@480s /orders are out|work-order/
Sleep 12s

# @section 4  — two builders, two vendors, working at once
Hide
Type "cd /tmp/rysh-demo-4 && clear"
Enter
Sleep 1s
Type "rysh attach fleetboard"
Enter
Sleep 12s
Show
Wait+Screen@480s /my task is finished/
Sleep 14s

# @section 5  — the fleet signs off
Hide
Type "cd /tmp/rysh-demo-4 && clear"
Enter
Sleep 1s
Type "rysh attach fleetboard"
Enter
Sleep 12s
Show
Wait+Screen@600s /DEMO COMPLETE/
Sleep 14s

# @section 6  — what four agents actually produced
Hide
Type "cd /tmp/rysh-demo-4 && clear"
Enter
Sleep 1s
Show
Sleep 1.5s
Type "ls todo-app/"
Enter
Sleep 5s
Type "wc -l todo-app/index.html todo-app/styles.css todo-app/app.js"
Enter
Sleep 7s
