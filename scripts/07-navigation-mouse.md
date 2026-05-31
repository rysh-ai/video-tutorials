# Group 7: Navigation & Mouse (Stories 27-29)

Narration scripts for moving around a Rysh workspace. This group recaps the navigation keys, scrollback, and full mouse support.

**Total duration:** ~2 min 5s

---

## Story 27: Pane & Tab Navigation (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Pane & Tab Navigation" | "Move through your workspace without lifting your hands from the keyboard." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh. We'll build out a few panes and tabs so there is something to navigate." |
| 0:08 | `Ctrl+P n` split, `Ctrl+T n` new tab | "Ctrl+P then n splits a pane to the right. Ctrl+T then n opens a fresh tab." |
| 0:15 | Press `Tab`, then `Alt+Up`/`Alt+Down` | "Press Tab to cycle to the next pane. Alt+Up and Alt+Down step between panes too." |
| 0:24 | Type `[`, `]`, then `Alt+Left`/`Alt+Right` | "Brackets move between tabs -- left bracket back, right bracket forward. Alt+Left and Alt+Right do the same." |
| 0:34 | Press `Alt+B`, `Alt+F` | "On macOS, Option plus arrow can be tricky, so Alt+B and Alt+F also walk between your tabs." |
| 0:42 | Hold layout | "One muscle memory for panes, one for tabs. That is your whole workspace." |

### Key Moments to Annotate
- [0:15] Key badges: `Tab`, `Alt+Up`, `Alt+Down`
- [0:24] Key badges: `[` `]`, `Alt+Left`, `Alt+Right`
- [0:34] Key badges: `Alt+B`, `Alt+F` (macOS)

---

## Story 28: Scrollback & Scrolling (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Scrollback & Scrolling" | "Long output scrolls off the top? Walk back through every line." |
| 0:03 | Type `rysh`, TUI launches | "Start rysh and generate a wall of output so we have a real scrollback buffer to explore." |
| 0:08 | Type `seq 1 200`, output floods | "Each pane keeps its own scrollback. Let's fill it up." |
| 0:14 | Press `PageUp`, `PageUp`, `PageDown` | "PageUp scrolls the active pane up one full page, PageDown brings you back down a page at a time." |
| 0:22 | Press `Shift+Up`, `Shift+Down` | "For fine control, Shift+Up and Shift+Down move a single line per press." |
| 0:30 | Press `Home`, then `End` | "Home snaps to the very top of the buffer, and End drops you straight back to the live prompt." |
| 0:37 | Hold at live prompt | "Page, line, top, bottom -- you never lose a line of history." |

### Key Moments to Annotate
- [0:14] Key badges: `PageUp`, `PageDown`
- [0:22] Key badges: `Shift+Up`, `Shift+Down`
- [0:30] Key badges: `Home`, `End`

---

## Story 29: Mouse Support (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Mouse Support" | "Keyboard-first, but the mouse is right there when you want it." |
| 0:03 | Type `rysh`, TUI launches | "Rysh has full mouse support built in. Let's walk through what it can do." |
| 0:08 | `Ctrl+P n` split into two panes | "Split into two panes. With the mouse, a single click on any pane focuses it instantly." |
| 0:14 | Echo line about click-drag | "Click and drag across text to select it. When you release the button, the selection is copied straight to your system clipboard." |
| 0:24 | Type `seq 1 120`, then scroll | "The mouse wheel scrolls the pane under your cursor, three lines per step, through the same scrollback buffer." |
| 0:33 | Echo recap line | "Click to focus, drag to select, release to copy, wheel to scroll. The mouse and keyboard work together." |

### Key Moments to Annotate
- [0:08] Callout: click any pane to focus
- [0:14] Callout: drag-select copies on release
- [0:24] Callout: wheel = 3 lines per step
