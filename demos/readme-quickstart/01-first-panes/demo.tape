# Demo 1 — Install rysh, then tabs, lanes, stacked panes, and a Claude in each.
#
# Rendered by ../make-demo.sh, which splits this file on the `# @section N`
# markers and records one clip per section. Everything above the first marker is
# the shared header and is prepended to every section.
#
# `Set Padding 60` IS THE TOP MARGIN. VHS 0.11 has no `Set Margin`; padding is
# the only lever, it applies to all four sides, and 60 is chosen for the top edge
# so the terminal's first rows are never against the frame.
#
# Each section is its own vhs run and therefore its own terminal, so every
# section after the first re-attaches to the session behind `Hide`. The session
# lives in the daemon, not in the shell, which is exactly why that works.

Set Shell "bash"
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 60
Set TypingSpeed 55ms
Set WaitTimeout 180s

# @section 1  — install
Hide
Type "cd /tmp/rysh-demo-1 && clear"
Enter
Sleep 1s
Show
Sleep 1.5s
Type "go install github.com/rysh-ai/rysh-cli-code/cmd/rysh@latest"
Enter
Sleep 8s
Type "rysh version"
Enter
Sleep 4s

# @section 2  — the first session
Hide
Type "cd /tmp/rysh-demo-1 && clear"
Enter
Sleep 1s
Show
Sleep 1.5s
Type "rysh create first-panes"
Enter
Sleep 10s

# @section 3  — tabs
Hide
Type "cd /tmp/rysh-demo-1 && clear"
Enter
Sleep 1s
Type "rysh attach first-panes"
Enter
Sleep 6s
Show
Sleep 2s
Type "##new tab"
Enter
Sleep 4s
Type "##tab name agents"
Enter
Sleep 4s

# @section 4  — lanes
Hide
Type "cd /tmp/rysh-demo-1 && clear"
Enter
Sleep 1s
Type "rysh attach first-panes"
Enter
Sleep 6s
Show
Sleep 2s
Type "##new lane"
Enter
Sleep 5s

# @section 5  — stacked panes
Hide
Type "cd /tmp/rysh-demo-1 && clear"
Enter
Sleep 1s
Type "rysh attach first-panes"
Enter
Sleep 6s
Show
Sleep 2s
Type "##new stack 2"
Enter
Sleep 6s

# @section 6  — a Claude in every stacked pane
Hide
Type "cd /tmp/rysh-demo-1 && clear"
Enter
Sleep 1s
Type "rysh attach first-panes"
Enter
Sleep 6s
Show
Sleep 2s
Type "##claude"
Enter
Sleep 12s
Ctrl+S
Sleep 1s
Type "2"
Sleep 2s
Escape
Sleep 3s
Type "##claude"
Enter
Sleep 14s

# @section 7  — the third one, and back to the top of the stack
Hide
Type "cd /tmp/rysh-demo-1 && clear"
Enter
Sleep 1s
Type "rysh attach first-panes"
Enter
Sleep 6s
Show
Sleep 1s
Ctrl+S
Sleep 1s
Type "3"
Sleep 2s
Escape
Sleep 3s
Type "##claude"
Enter
Sleep 14s
Ctrl+S
Sleep 1s
Type "1"
Sleep 4s
Escape
Sleep 5s
