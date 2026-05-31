# Group 24: Web & Desktop (Stories 99-102)

Narration scripts for the browser and native-desktop client surfaces. These show that the same rysh multiplexer reaches far beyond the terminal.

**Total duration:** ~3 min

---

## Story 99: Web Terminal (##rysh web) (50s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Web Terminal" | "Your whole rysh workspace, in a browser tab. One command starts it." |
| 0:04 | Type `rysh`, TUI launches | "Start rysh as usual -- you land in shell mode." |
| 0:09 | Type `##rysh web start` | "Type the rysh-mode command to start the web UI server. With no port, it listens on the default: 23232." |
| 0:16 | Type `##rysh web start 23232` | "Open your browser to localhost on port 23232. You get the full TUI -- tabs, panes, every input mode -- in the browser." |
| 0:24 | Type `##rysh web status` | "Check the server any time with web status." |
| 0:34 | Echo parity note | "The browser session shares the same NATS bus and the same actors as your terminal -- not a copy, the same workspace, live." |
| 0:42 | Type `##rysh web stop` | "When you are done, stop it with web stop. One binary, no external dependencies." |

### Key Moments to Annotate
- [0:09] Highlight `##rysh web start`
- [0:16] Callout: default port `23232`
- [0:42] Highlight `##rysh web stop`

---

## Story 100: Web Terminal Architecture (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Web Terminal Architecture" | "No separate service. The web server is baked right into the rysh binary." |
| 0:05 | Echo: embedded server | "When you run rysh web start, an embedded Go web server boots inside the same process -- nothing to install, zero external dependencies." |
| 0:13 | Echo: shared bus diagram | "The frontend does not run a second copy of your session. It connects to the very same embedded NATS bus and the very same actor hierarchy your terminal uses." |
| 0:23 | Echo: snapshot streaming | "State streams to the browser as a snapshot roughly every 200 milliseconds over a WebSocket -- so the browser stays in lockstep with the terminal." |
| 0:33 | Echo: stack summary | "React on the front, Go and NATS on the back, all in one self-contained binary -- that is the whole web terminal stack." |

### Key Moments to Annotate
- [0:05] Highlight "embedded Go web server"
- [0:23] Callout: "~200ms snapshot over WebSocket"

---

## Story 101: The Desktop App (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "The Desktop App" | "The same rysh multiplexer, as a native desktop app." |
| 0:05 | Echo: rysh-cli-app | "rysh-cli-app is the desktop client -- an Electron and React app that wraps the exact same multiplexer you run in the terminal." |
| 0:13 | Echo: same engine | "You get every mode, full mouse support, and the same tabs and panes -- just in a resizable window instead of a terminal emulator." |
| 0:23 | Echo: side panels | "What the desktop app adds is dedicated side panels: one for Agents, one for Humanoids, one for Shares -- manage them without typing a command." |
| 0:34 | Echo: wrap | "If you prefer a GUI, the desktop app gives you the full power of rysh with point-and-click access to its actors." |

### Key Moments to Annotate
- [0:05] Highlight "Electron + React"
- [0:23] Highlight side panels: Agents / Humanoids / Shares

---

## Story 102: Multi-Workspace in Desktop (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Multi-Workspace in Desktop" | "Many workspaces, one window. The desktop app stacks them two rows high." |
| 0:05 | Echo: two-row header | "The desktop header has two rows. The top row lists your workspaces; the row below lists the tabs inside the workspace you have selected." |
| 0:14 | Echo: switching | "Click a workspace up top to switch your entire context -- a different project, a different upstream, a different set of tabs and panes." |
| 0:23 | Echo: voice + pipeline panel | "The desktop app also surfaces voice prompting and a dedicated pipeline output panel, so multi-stage runs are visible right beside your panes." |
| 0:32 | Echo: wrap | "One window, every workspace -- the desktop app is built for juggling projects." |

### Key Moments to Annotate
- [0:05] Highlight two-row header (workspaces above, tabs below)
- [0:23] Callout: voice + pipeline output panel
