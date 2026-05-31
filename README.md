# Rysh Video Tutorials

111 short video tutorials explaining every major feature of the Rysh project, organized into 26 groups.

Rysh is an **agentic terminal multiplexer** written in Go — inspired by Zellij/tmux, but built for AI-assisted development. Every pane is both a PTY-backed shell and an autonomous AI agent workspace, with cloud sharing, autonomous agents, humanoids (agents with external channels), pipelines, a web terminal, desktop & mobile apps, a Chrome extension, and an upstream server with billing.

## Directory Structure

```
video-tutorials/
├── README.md                          # This file -- overview and index
├── video-stories.md                   # Master story document (all 111 stories)
├── production-guide.md                # Recording setup, tools, visual style
├── scripts/                           # Per-group narration scripts (26 files)
├── narration/                         # Voiceover tips and tone guide
├── checklists/                        # Pre-recording checklists
├── assets/                            # Diagrams, screenshots, overlays
└── tapes/                             # VHS tapes + TTS voiceover pipeline
    ├── tape/                          # story-NNN-*.tape (VHS scripts)
    ├── say/                           # story-NNN-*.say (timed narration)
    ├── Makefile                       # say / tts / vover pipeline
    └── *.py                           # generate_say / tts_openai / merge_voiceover
```

## Story Index

| # | Group | Stories | Focus |
|---|-------|---------|-------|
| 1 | Getting Started | 1-4 | What Rysh is, install, build, configure |
| 2 | Sessions & Daemon | 5-9 | Named/detached sessions, attach/detach, persistence |
| 3 | Tabs | 10-13 | Tab mode, navigation, renaming, `##tab` |
| 4 | Panes & Splits | 14-18 | Pane mode, split right/down, close, `##pane` |
| 5 | Stacked Panes & Groups | 19-22 | Stacks, stack mode, pane groups, lanes, layout tree |
| 6 | Layout & Resize | 23-26 | Layout mode, resize, equalize/swap/fullscreen, navigate |
| 7 | Navigation & Mouse | 27-29 | Pane/tab navigation, scrollback, mouse |
| 8 | Grid & Bulk Ops | 30-33 | `##new grid`, stacks, `##cmd`, lanes |
| 9 | Input Modes | 34-38 | Shell, prompt, rysh, chat, mode cycling |
| 10 | System Commands | 39-41 | Help/history, inspection, snapshots & clipboard |
| 11 | Interactive Terminal | 42-45 | vim/htop, raw mode, `##raw`, PTY resize |
| 12 | Voice | 46-47 | Voice prompting, provider config |
| 13 | Tools: File & Shell | 48-52 | Toolbelt, read/search, edit, bash, symbols |
| 14 | Tools: Git/Build/Test | 53-56 | Git tools, build, test, lint |
| 15 | Tools: Background & Web | 57-60 | Background bash, web search, web fetch |
| 16 | Approval & Safety | 61-64 | Approval flow, loop detection, approval panes |
| 17 | Context & Memory | 65-68 | Context store, project notes, todos, history |
| 18 | Cross-Pane Coordination | 69-72 | Pane listening, inspect/send, hop, cross-pane tools |
| 19 | Autonomous Agents | 73-78 | Spawn, skill files, spawn-all, `@`/`@@`, output routing |
| 20 | Humanoids | 79-84 | Channels: Slack, Email, WhatsApp, Phone; vs agents |
| 21 | Pipelines & Events | 85-89 | Pipeline mode, `##pipe`, `##>` events, softdev |
| 22 | Collaboration & Sharing | 90-94 | Share pane/group/lane/tab, view vs control, redaction |
| 23 | Upstream & Remote | 95-98 | Upstream connect, subscribe, remote control, workspaces |
| 24 | Web & Desktop | 99-102 | Web terminal, architecture, desktop app, multi-workspace |
| 25 | Mobile App | 103-106 | Mobile, per-mode streams/scrollback, overflow, shared tabs |
| 26 | Chrome, Server & Billing | 107-111 | Browser automation, server, Stripe billing, chatbot |
| **Total** | **26 groups** | **111 stories** | **~95 min** |

## Quick Start

1. Read `video-stories.md` for the full story breakdown.
2. Read `production-guide.md` for recording setup.
3. Pick a group from `scripts/` and follow the narration script.
4. Render demos from `tapes/tape/` with VHS, then run the TTS pipeline (`tapes/Makefile`).
5. Place diagrams and screenshots in `assets/`.

## Video Production Pipeline (tapes/)

```bash
cd tapes
vhs tape/story-001-what-is-rysh.tape   # render one demo -> mp4 + gif
make say                               # extract .say narration from all tapes
make tts                               # OpenAI TTS -> mp3 per story
make vover-all                         # merge voiceover onto every video
```

## Recommended Recording Order

Record in group order (1 → 26). Groups 1-12 cover the local TUI and are the
foundation; groups 13-18 cover the agentic engine; groups 19-23 cover agents,
humanoids, pipelines and collaboration; groups 24-26 cover the other client
surfaces and the server.
