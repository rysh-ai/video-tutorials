# Group 11: Interactive Terminal (Stories 42-45)

Narration scripts for Rysh's interactive terminal support -- running full-screen
programs like vim and htop, the raw-mode forwarding that makes them feel native,
the `##raw` manual toggle, and live PTY resize.

**Total duration:** ~2 min 50s

---

## Story 42: Running Vim & Htop (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Running Vim & Htop" | "vim, htop, less, nano -- full-screen programs just work, right inside a Rysh pane." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh -- a pane is a full PTY-backed shell." |
| 0:07 | Type `vim hello.go` | "Open a file in vim. The moment vim switches to its alternate screen, Rysh detects it and enters raw mode automatically." |
| 0:14 | Insert text in vim | "Now every keystroke flows straight to the terminal emulator. Insert mode, normal mode -- vim behaves exactly as it should." |
| 0:24 | `:wq` to save and quit | "Write and quit with colon-w-q. Back to the shell, no surprises." |
| 0:30 | Type `htop`, live view renders | "Run htop -- another alternate-screen program. Rysh's vt10x emulator renders the live process view inside the pane." |
| 0:40 | Press `q` to quit | "Press q to quit htop and return to your shell prompt." |
| 0:47 | Hold final frame | "Interactive terminal apps, no configuration, no caveats." |

### Key Moments to Annotate
- [0:07] Callout: "Alternate screen detected -> raw mode auto-engages"
- [0:30] Callout: "vt10x virtual terminal emulator"

---

## Story 43: Raw Mode & Escape Hatch (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Raw Mode & Escape Hatch" | "In raw mode every key goes to the program. Ctrl+O is your escape hatch back to Rysh." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh, then open an interactive program." |
| 0:07 | Type `vim notes.txt`, type into it | "Open vim. On the alternate screen, the pane enters raw mode -- Tab, brackets, Escape, every key is forwarded straight to vim." |
| 0:15 | Press `Ctrl+O` -> prefix mode | "So how do you reach Rysh's own shortcuts? Ctrl+O. It's the one key raw mode reserves -- the escape hatch out to prefix mode, even while a program owns the screen." |
| 0:27 | Press any key to cancel back | "From prefix mode you can detach with d, or press any other key to cancel and drop right back into the program." |
| 0:34 | `:q!` to quit vim | "Back in vim, quit the usual way -- colon-q-bang to discard." |
| 0:42 | Hold final frame | "Raw mode keeps programs happy; Ctrl+O keeps you in control." |

### Key Moments to Annotate
- [0:07] Badge: "RAW MODE -- all keys forwarded to PTY"
- [0:15] Key badge: `Ctrl+O` -> prefix mode
- [0:27] Note: "any other key cancels prefix mode"

---

## Story 44: Toggling Raw Mode (##raw) (35s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Toggling Raw Mode" | "Need raw mode without an interactive program? ##raw flips it on and off by hand." |
| 0:03 | Type `rysh`, TUI launches | "Raw mode usually engages automatically -- but you can control it directly." |
| 0:07 | Double-Escape to rysh mode | "Double-Escape to rysh mode, where ## system commands live." |
| 0:13 | Type `##raw` (raw mode on) | "Type ##raw to turn raw mode on manually. Now keystrokes are forwarded as raw bytes to the PTY -- handy for stubborn programs Rysh didn't auto-detect." |
| 0:22 | `Ctrl+O`, then `##raw` again (off) | "##raw is a toggle. Press Ctrl+O to step out to prefix mode, then run ##raw again to turn it back off." |
| 0:30 | Hold final frame | "One command, full manual control over the interactive terminal." |

### Key Moments to Annotate
- [0:13] Highlight `##raw` toggle ON
- [0:22] Key badge: `Ctrl+O` to escape raw mode, then `##raw` OFF

---

## Story 45: PTY Resize (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "PTY Resize" | "Resize the window and your programs follow -- SIGWINCH propagates and the emulator reflows." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh and check the terminal dimensions." |
| 0:08 | `echo cols=$(tput cols) rows=$(tput lines)` | "Run tput to read the current columns and rows -- the values the PTY is reporting to your shell." |
| 0:15 | `Ctrl+P n` splits right | "Split a pane with Ctrl+P n. Splitting changes each pane's geometry, and Rysh sends a SIGWINCH so the shell learns its new size." |
| 0:23 | Re-run the `tput` echo | "Check again in the narrower pane -- the column count has dropped. The PTY was resized live, no restart needed." |
| 0:30 | Type `htop`, then `q` | "Interactive programs adapt too. Launch htop -- the vt10x emulator reflows its layout to whatever space the pane currently has." |
| 0:37 | Hold final frame | "Resize freely. Your shells and full-screen apps reflow to fit." |

### Key Moments to Annotate
- [0:15] Callout: "SIGWINCH propagated on geometry change"
- [0:23] Highlight the changed column count
- [0:30] Callout: "vt10x reflows the alternate screen"
