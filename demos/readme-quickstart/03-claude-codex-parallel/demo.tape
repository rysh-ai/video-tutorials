# Demo 3 — Claude and Codex in three stacked panes, working at the same time.
#
# ── WHY A STACK, AFTER FOUR TAKES SPENT ON A SPLIT ────────────────────────────
# Earlier cuts put the panes in separate pane GROUPS so all three were on screen
# together, and moved between them with `Ctrl+Space` (navigate mode) + j/k. That
# is the only chord that moves focus between groups, and it is the one chord this
# pipeline cannot send reliably: VHS emits Ctrl+Space as NUL (0x00), which does
# not always survive the trip through ttyd. When it is dropped the pane is still
# relaying the agent, so keystrokes meant for the multiplexer reach the agent
# instead — one take ended with Claude replying "that message came through as
# j##codex — was that a stray keystroke?", which is a fair question.
#
# `alt+up`/`alt+down` do move focus and are ordinary bytes, but `model_update.go`
# is explicit that raw mode never reaches them: an interactive app receives Alt
# sequences through the relay. Prefix mode (`Ctrl+O`) does survive raw mode,
# tmux-style, but it opens modes and does not move focus between groups.
#
# What is left — and what every other section of every other demo here leans on
# without a single failure — is STACK MODE: `Ctrl+S` then a digit selects a pane
# by number. Ordinary bytes, intercepted in raw mode, and ABSOLUTE rather than
# relative, so a dropped keypress cannot leave focus one pane off. That is how
# the very first cut put two prompts into the same pane.
#
# The cost is honest and small: panes in one group stack Zellij-style, so one is
# expanded and the others collapse to `[N/M]` title bars. You watch them one at a
# time. That they run SIMULTANEOUSLY is proved by section 5 rather than by the
# layout — three files, written by three agents, while you flip between them.
#
# ── WHAT BROKE THE FOUR-PANE CUT, since the comment here first guessed wrong ──
# Both Codexes looked like they "exited the moment they launched", leaving bash
# holding the pane and eating the task line (`bash: amed: command not found`). It
# was not a crash, not concurrency, not pane geometry and not the directory — all
# tested and cleared. Codex was ALIVE and blocked on a dialog: on first run in an
# unfamiliar directory it asks "Do you trust the contents of this directory?
# 1. Yes, continue / 2. No, quit" and waits. The tape's next keystrokes landed in
# that dialog and dismissed it. The proof is in codex's own config —
# /private/tmp/rysh-demo-2 is in its trusted list, because demo 2's first take
# pressed Enter on the dialog by accident, and /private/tmp/rysh-demo-3 never
# was. That single entry is the whole difference. `setup.sh` now trusts the
# workspace before the camera rolls.
#
# ── THE WAIT MARKERS ARE FOOTER TEXT, NOT BANNER TITLES ───────────────────────
# A stacked pane is short, so an agent's opening banner scrolls off almost at
# once. This cost a take per agent: a gate on /Claude Code/ timed out at 180s
# against a Claude running perfectly well with its welcome box half off the top,
# and a gate on /OpenAI Codex/ did the identical thing to a Codex sitting there
# showing `permissions: YOLO mode`. What stays on screen is the BOTTOM of an
# agent's UI, so that is what these match. A marker you can read in a full-height
# pane is not evidence it survives in a third of one.
#
# Rendered by ../make-demo.sh. See 01-first-panes/demo.tape for the top margin.

Set Shell "bash"
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 60
Set TypingSpeed 55ms
Set WaitTimeout 240s

# @section 1  — three stacked panes
Hide
Type "cd /tmp/rysh-demo-3 && clear"
Enter
Sleep 1s
Type "rysh attach parallel"
Enter
Sleep 12s
Show
Sleep 3s
Type "##new stack 2"
Enter
Sleep 8s

# @section 2  — an agent in each, one at a time
#
# Every hidden re-attach sleeps 12s. At 6s a take lost its first `##claude`
# outright — the pane sat idle, still showing the previous section's output,
# because the keystrokes arrived before the re-attached pane was taking input.
Hide
Type "cd /tmp/rysh-demo-3 && clear"
Enter
Sleep 1s
Type "rysh attach parallel"
Enter
Sleep 12s
Show
Sleep 3s
Ctrl+S
Sleep 1s
Type "1"
Sleep 2s
Escape
Sleep 3s
Type "##claude"
Enter
Wait+Screen@180s /bypass permissions/
Sleep 4s
Ctrl+S
Sleep 1s
Type "2"
Sleep 2s
Escape
Sleep 4s
Type "##codex"
Enter
Wait+Screen@180s /YOLO mode/
Sleep 4s
Ctrl+S
Sleep 1s
Type "3"
Sleep 2s
Escape
Sleep 4s
Type "##claude"
Enter
Sleep 24s

# @section 3  — one task per pane, top of the stack down
#
# THE SETTLES ARE LOAD-BEARING. Text typed into a pane still relaying an agent's
# redraw loses the head of the line — demo 2's first take had a codeword arrive
# with its first twenty characters missing, and Codex then answered the mangled
# question truthfully, which proves nothing to a viewer. A beat after leaving
# stack mode, and a slower `Type@`, is what prevents it.
Hide
Type "cd /tmp/rysh-demo-3 && clear"
Enter
Sleep 1s
Type "rysh attach parallel"
Enter
Sleep 12s
Show
Sleep 3s
Ctrl+S
Sleep 1s
Type "1"
Sleep 2s
Escape
Sleep 5s
Type@120ms "Write a file named one.txt containing only the word one. Then stop."
Enter
Sleep 6s
Ctrl+S
Sleep 1s
Type "2"
Sleep 2s
Escape
Sleep 5s
Type@120ms "Write a file named two.txt containing only the word two. Then stop."
Enter
Sleep 6s
Ctrl+S
Sleep 1s
Type "3"
Sleep 2s
Escape
Sleep 5s
Type@120ms "Write a file named three.txt containing only the word three. Then stop."
Enter
Sleep 8s

# @section 4  — flip through the stack while all three work
Hide
Type "cd /tmp/rysh-demo-3 && clear"
Enter
Sleep 1s
Type "rysh attach parallel"
Enter
Sleep 12s
Show
Sleep 4s
Ctrl+S
Sleep 1s
Type "1"
Sleep 8s
Type "2"
Sleep 8s
Type "3"
Sleep 8s
Escape
Sleep 4s

# @section 5  — what three agents produced
Hide
Type "cd /tmp/rysh-demo-3 && clear"
Enter
Sleep 1s
Show
Sleep 1.5s
Type "ls one.txt two.txt three.txt"
Enter
Sleep 5s
Type "cat one.txt two.txt three.txt"
Enter
Sleep 6s
