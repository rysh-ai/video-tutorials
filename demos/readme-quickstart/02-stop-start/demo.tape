# Demo 2 — Stop the session, start it again, and the agents are still there.
#
# The claim this demo makes is the strong one, so it is filmed the only way that
# proves it: each agent is told a codeword BEFORE the session is stopped, and is
# asked for it AFTER the restart. A pane that merely reappears proves nothing —
# the conversation has to come back with it.
#
# CODEX NEEDS A REAL TURN BEFORE THE STOP. Codex records a session when the
# conversation starts, not when the process does, so `##codex` followed straight
# away by a stop leaves nothing to resume. Section 3 is not decoration; it is
# what makes section 5 possible.
#
# Rendered by ../make-demo.sh. See 01-first-panes/demo.tape for why `Set Padding`
# is the top margin and why every section re-attaches behind `Hide`.

Set Shell "bash"
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 60
Set TypingSpeed 55ms
Set WaitTimeout 180s

# @section 1  — two stacked panes, Claude in the first
Hide
Type "cd /tmp/rysh-demo-2 && clear"
Enter
Sleep 1s
Type "rysh attach stopstart"
Enter
Sleep 6s
Show
Sleep 2s
Type "##new stack 1"
Enter
Sleep 5s
Ctrl+S
Sleep 1s
Type "1"
Sleep 1s
Escape
Sleep 1s
Type "##claude"
Enter
Wait+Screen@120s /Claude Code/
Sleep 3s

# @section 2  — Codex in the second
Hide
Type "cd /tmp/rysh-demo-2 && clear"
Enter
Sleep 1s
Type "rysh attach stopstart"
Enter
Sleep 6s
Show
Sleep 1s
Ctrl+S
Sleep 1s
Type "2"
Sleep 2s
Escape
Sleep 1s
Type "##codex"
Enter
Wait+Screen@120s /OpenAI Codex/
Sleep 3s

# @section 3  — give each agent a codeword
#
# THE SETTLES HERE ARE LOAD-BEARING. On the first take the codeword typed into
# Codex arrived as "111. Reply with just OK." — the first twenty-odd characters
# were swallowed because the pane was still relaying Codex's redraw when the
# keystrokes started. Codex then answered "111" after the restart, which is a
# true answer to a mangled question and proves nothing to a viewer. Hence: a
# longer attach, an explicit stack selection so focus is never inherited, and a
# beat after leaving stack mode before anything is typed.
Hide
Type "cd /tmp/rysh-demo-2 && clear"
Enter
Sleep 1s
Type "rysh attach stopstart"
Enter
Sleep 10s
Show
Sleep 2s
Ctrl+S
Sleep 1s
Type "1"
Sleep 2s
Escape
Sleep 4s
Type@120ms "Remember this codeword: WALRUS-1111. Reply with just OK."
Enter
Sleep 20s
Ctrl+S
Sleep 1s
Type "2"
Sleep 2s
Escape
Sleep 5s
Type@120ms "Remember this codeword: MARMOT-2222. Reply with just OK."
Enter
Sleep 24s

# @section 4  — stop the whole session
Hide
Type "cd /tmp/rysh-demo-2 && clear"
Enter
Sleep 1s
Show
Sleep 1.5s
Type "rysh stop stopstart"
Enter
Sleep 6s
Type "rysh list-sessions"
Enter
Sleep 6s

# @section 5  — start it again; the agents come back on their own
Hide
Type "cd /tmp/rysh-demo-2 && clear"
Enter
Sleep 1s
Show
Sleep 1.5s
Type "rysh attach stopstart"
Enter
Sleep 45s

# @section 6  — ask for the codeword
Hide
Type "cd /tmp/rysh-demo-2 && clear"
Enter
Sleep 1s
Type "rysh attach stopstart"
Enter
Sleep 12s
Show
Sleep 2s
Ctrl+S
Sleep 1s
Type "1"
Sleep 2s
Escape
Sleep 4s
Type@120ms "What codeword did I ask you to remember? Answer with just the codeword."
Enter
Sleep 22s
Ctrl+S
Sleep 1s
Type "2"
Sleep 2s
Escape
Sleep 5s
Type@120ms "What codeword did I ask you to remember? Answer with just the codeword."
Enter
Sleep 28s
