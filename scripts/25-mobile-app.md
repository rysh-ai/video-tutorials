# Group 25: Mobile App (Stories 103-106)

Narration scripts for rysh-mobile, the iOS/Android client. These show how the full four-mode model and shared layouts come to a small screen.

**Total duration:** ~3 min

---

## Story 103: The Mobile App (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "The Mobile App" | "rysh in your pocket. Reach your panes from iOS or Android." |
| 0:05 | Echo: rysh-mobile | "rysh-mobile is the native app for iOS and Android. You log in once, and your workspaces are right there on your phone." |
| 0:14 | Echo: drill-down flow | "The flow is a simple drill-down: pick a workspace, see its list of panes, tap a pane to open the live pane view." |
| 0:25 | Echo: XTerm.js | "Each pane renders with XTerm.js, so colors and ANSI look exactly like your desktop terminal." |
| 0:36 | Echo: interactive shared panes | "On shared panes you even get a fully interactive terminal -- run vim or htop from your phone and the keystrokes flow straight through." |
| 0:45 | Echo: wrap | "Your agentic terminal, anywhere you are." |

### Key Moments to Annotate
- [0:14] Show drill-down: workspace -> pane list -> pane view
- [0:25] Highlight "XTerm.js"
- [0:36] Callout: interactive vim/htop on shared panes

---

## Story 104: Per-Mode Streams & Scrollback (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Per-Mode Streams & Scrollback" | "Shell, AI, Chat, Rysh -- four streams, one pane, all on your phone." |
| 0:05 | Echo: bottom mode tabs | "At the bottom of a pane, mobile shows tabs for each mode: Shell, AI, Chat, and Rysh. Each one is its own independent output stream." |
| 0:15 | Echo: unread badges | "When a mode you are not looking at produces output -- say the AI finishes a reply -- that tab gets an unread badge so nothing slips past you." |
| 0:25 | Echo: per-pane per-mode scrollback | "Scrollback is kept per pane and per mode, so scrolling up in the AI stream never disturbs your shell history -- each thread stays separate." |
| 0:36 | Echo: wrap | "Switch modes with a tap, scroll each one on its own -- the full four-mode model, sized for a small screen." |

### Key Moments to Annotate
- [0:05] Highlight bottom mode tabs: Shell / AI / Chat / Rysh
- [0:15] Callout: unread badges
- [0:25] Callout: per-pane, per-mode scrollback

---

## Story 105: Overflow Menu & Pane Actions (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Overflow Menu & Pane Actions" | "Long-press a pane on mobile and the full action menu opens up." |
| 0:05 | Echo: menu actions | "A long-press, or the overflow menu, gives you the common pane actions: copy the output, rename the pane, or share it." |
| 0:15 | Echo: focus control | "There is a terminal focus control too -- you decide when keystrokes go into the pane versus when you are just scrolling and reading." |
| 0:25 | Echo: keyboard avoidance | "And rotating to landscape works cleanly -- the on-screen keyboard is handled with keyboard avoidance so it never covers the pane you are typing in." |
| 0:34 | Echo: wrap | "Everything you need to manage a pane -- one press away." |

### Key Moments to Annotate
- [0:05] Highlight menu: Copy output / Rename / Share
- [0:15] Callout: terminal focus control
- [0:25] Callout: landscape keyboard avoidance

---

## Story 106: Viewing Shared Tabs on Mobile (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Viewing Shared Tabs on Mobile" | "A teammate shares a tab -- you open the whole multi-pane layout on your phone." |
| 0:05 | Echo: owner shares tab | "It starts on the desktop: a teammate runs share tab, which publishes the tab and every pane inside it to the workspace." |
| 0:14 | Echo: receive as layout | "On mobile you subscribe to that share and the tab arrives as a full multi-pane layout -- not a flat list, the real arrangement of panes." |
| 0:25 | Echo: interacting | "Then you interact: read each shared pane, and if the share is in control mode, send input straight back into it from your phone." |
| 0:36 | Echo: wrap | "Shared tabs turn your phone into a live window onto a teammate's whole workspace." |

### Key Moments to Annotate
- [0:05] Highlight `##share tab`
- [0:14] Callout: arrives as a multi-pane layout
- [0:25] Callout: control mode lets you send input
