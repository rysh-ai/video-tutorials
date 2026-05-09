# Group 4: Interactive Terminal (Stories 15-17)

Narration scripts for interactive terminal support. These stories demonstrate that Rysh is a real terminal, not just a text runner.

**Total duration:** ~2 min

---

## Story 15: Running Vim Inside Rysh (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Running Vim Inside Rysh" | "Type vim. It just works. No configuration needed." |
| 0:03 | Shell mode, `>` prompt | "You're in shell mode. Let's open a file." |
| 0:05 | Type `vim main.go` | "Type vim main.go." |
| 0:08 | Vim opens, pane enters raw mode | "Vim opens. The pane automatically detects alternate screen buffer and enters raw mode." |
| 0:12 | Show `RAW` indicator in border | "See the RAW indicator in the pane border." |
| 0:15 | Navigate in vim: `j`, `k`, `gg`, `G` | "All vim navigation works. j, k, gg, G." |
| 0:20 | Enter insert mode: `i` | "Enter insert mode. Type some code." |
| 0:23 | Type a line of code | |
| 0:26 | Press Escape, type `:w` | "Save with :w." |
| 0:29 | Type `:q` | "Quit with :q." |
| 0:31 | Pane exits raw mode, back to `>` prompt | "The pane automatically exits raw mode. Back to your shell." |
| 0:35 | Explain the tech | "Under the hood, a vt10x virtual terminal emulator handles all ANSI sequences." |
| 0:40 | Run `htop` briefly | "It's not just vim. htop, less, nano, top -- all work." |
| 0:45 | End card | "Interactive programs work seamlessly via auto-detected raw mode." |

### Key Moments to Annotate
- [0:08] Callout: "Auto-detected raw mode"
- [0:12] Arrow to `RAW` indicator
- [0:31] Callout: "Auto-exits raw mode"
- [0:35] Overlay: "Powered by vt10x"

---

## Story 16: Raw Mode and the Escape Hatch (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Raw Mode & Escape Hatch" | "Every keystroke goes to the PTY. Except one: Ctrl+O." |
| 0:03 | Type `htop`, pane enters raw mode | "htop is running. The pane is in raw mode." |
| 0:06 | Press various keys | "Every key goes straight to htop. k sorts by CPU, q would quit." |
| 0:10 | Callout: "All keys forwarded" | "But what if you need to switch panes? Or detach?" |
| 0:14 | Show key badge `Ctrl+O` | "Ctrl+O is the escape hatch. It enters prefix mode." |
| 0:17 | Press `Ctrl+O` | "The mode changes to PREFIX." |
| 0:20 | Press `d` to detach (or explain) | "From here, press d to detach. Or switch to another pane." |
| 0:24 | Press any other key to cancel | "Any other key cancels and returns to raw mode." |
| 0:28 | Show `##raw` command | "You can also toggle raw mode manually with the ##raw command." |
| 0:32 | Type `##raw` | "Useful when auto-detection doesn't kick in." |
| 0:36 | End card | "Ctrl+O is the universal escape from raw mode." |

### Key Moments to Annotate
- [0:14] Key badge: `Ctrl+O` -- "Escape Hatch"
- [0:17] Mode indicator: "PREFIX"
- [0:28] Highlight: `##raw`

---

## Story 17: PTY Resize (30s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "PTY Resize" | "Resize a pane. The PTY resizes too. Automatically." |
| 0:03 | Run `htop` in a pane | "htop is running." |
| 0:05 | Enter layout mode `Ctrl+L` | "Enter layout mode." |
| 0:07 | Press arrow keys to resize | "Resize the pane with arrow keys." |
| 0:10 | htop redraws to new dimensions | "Watch htop redraw. It adapts to the new dimensions." |
| 0:14 | Resize the terminal window (drag) | "Resize the whole terminal window." |
| 0:17 | All panes and PTYs adapt | "Every pane and every PTY adapts instantly." |
| 0:20 | Show `TERM=xterm-256color` | "TERM is set to xterm-256color for full capability reporting." |
| 0:25 | End card | "PTY resize is fully propagated. Panes and programs adapt instantly." |

### Key Moments to Annotate
- [0:07] Key badge: `Ctrl+L` then arrow keys
- [0:10] Callout: "PTY resize propagated"
- [0:20] Callout: "TERM=xterm-256color"
