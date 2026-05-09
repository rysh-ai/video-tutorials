# Recording Checklist

Use this checklist before each recording session. Check off items as you complete them.

---

## Environment Setup

### Terminal
- [ ] Terminal emulator set: iTerm2 / Alacritty / WezTerm
- [ ] Theme: Catppuccin Mocha (dark, high contrast)
- [ ] Font: JetBrains Mono or Fira Code, 16px
- [ ] Line height: 1.2-1.3
- [ ] Window padding: 10-20px
- [ ] Cursor: block, blinking
- [ ] Opacity: 100% (no transparency)
- [ ] Window resized to recording resolution (1920x1080 or 2560x1440)

### System
- [ ] Close all unnecessary applications
- [ ] Disable notifications (Do Not Disturb mode)
- [ ] Disable system sounds
- [ ] Disable screen saver and auto-sleep
- [ ] Close Slack, Discord, email clients
- [ ] Hide dock/taskbar if possible

### Audio
- [ ] Microphone connected and selected
- [ ] Sample rate: 48kHz, bit depth: 24-bit
- [ ] Noise gate set to -40dB
- [ ] Test recording: 10 seconds, play back, check levels
- [ ] No background noise (AC, fans, traffic)
- [ ] Pop filter in position (if using condenser mic)

---

## Rysh Setup

### Clean State
- [ ] `rysh delete-session default` -- remove default session
- [ ] `rysh delete-session demo` -- remove demo session (if exists)
- [ ] Clear terminal history: `history -c`
- [ ] Remove any leftover test files from previous recordings
- [ ] Clear `~/.local/state/rysh/` if needed for a fresh start

### Build & Verify
- [ ] `rysh` binary is up to date: `make build` or `go build`
- [ ] `rysh --version` shows expected version
- [ ] `rysh` launches without errors
- [ ] API key is configured (for AI demos): check `rysh.config` or `RYSH_API_KEY`
- [ ] Provider works: test a quick prompt in prompt mode

### Per-Group Setup

#### Group 1: Getting Started
- [ ] Have a sample project directory ready
- [ ] Config file (`~/.config/rysh/rysh.config`) has example values

#### Group 2: Multiplexer Basics
- [ ] Start with a clean single-pane session
- [ ] Prepare a few short commands to type (ls, git status, etc.)

#### Group 3: Input Modes
- [ ] Verify all four modes work: shell (>), prompt (<), rysh (##), chat (@)
- [ ] Verify AI responds in prompt mode

#### Group 4: Interactive Terminal
- [ ] `vim` is installed and works
- [ ] `htop` is installed
- [ ] Have a test file (main.go) ready for vim demo
- [ ] Verify raw mode auto-detection works

#### Group 5: AI Agentic Features
- [ ] API key configured
- [ ] Have a project with files the AI can read/edit
- [ ] Create a file with a deliberate bug for the approval demo
- [ ] Prepare context for cross-pane coordination demo

#### Group 6: Autonomous Agents
- [ ] Prepare agent skill files in `.rysh/agents/`
- [ ] At least 3 files: planner.md, builder.md, tester.md (or similar)
- [ ] Verify `##agent spawn` works

#### Group 7: Humanoids
- [ ] Prepare a humanoid skill file with contacts section
- [ ] Set required environment variables (SLACK_BOT_TOKEN, etc.) -- or use dummy values
- [ ] Verify `##humanoid spawn` works

#### Group 8: Collaboration & Sharing
- [ ] If showing cloud sharing: upstream server must be running
- [ ] Have a second session or second machine for remote subscriber demo
- [ ] Prepare data in a pane for the ##hop demo

#### Group 9: Pipelines & Events
- [ ] Prepare a Go project for the softdev pipeline demo
- [ ] Verify `go vet` and `go test` work in the project
- [ ] Prepare a pipeline YAML file if showing ##pipe commands

#### Group 10: Web Terminal
- [ ] Verify web server starts: `##rysh web start`
- [ ] Browser ready with localhost:23232
- [ ] Browser zoom level appropriate for recording

#### Group 11: Mobile App
- [ ] Mobile device or emulator ready
- [ ] App installed and can connect to server
- [ ] Server running with test workspace

#### Group 12: Chrome Extension
- [ ] Extension installed in Chrome
- [ ] Server running and extension configured
- [ ] Prepare a target website for browser automation demo (GitHub, etc.)

#### Group 13: Server & Billing
- [ ] Docker Compose stack running (or ready to start)
- [ ] Test user registered
- [ ] Stripe test keys configured (for billing demo)
- [ ] Session management: have a session to demonstrate attach/detach

---

## Recording Software

### OBS Studio
- [ ] Scene configured with screen capture
- [ ] Output resolution: 1920x1080 (or 2560x1440)
- [ ] Frame rate: 30fps
- [ ] Encoder: x264 or NVENC
- [ ] Audio source: selected microphone
- [ ] Recording format: MKV (remux to MP4 after)
- [ ] Output directory has enough disk space

### Alternative: Screenflow / DaVinci Resolve
- [ ] Project settings match target resolution
- [ ] Audio input source selected
- [ ] Auto-save enabled

---

## Final Checks

- [ ] Read the story script one more time
- [ ] Practice the typing sequences
- [ ] Do a 10-second test recording
- [ ] Verify test recording has clean audio and video
- [ ] Take a deep breath
- [ ] Hit record

---

## Post-Recording

- [ ] Review the raw footage
- [ ] Check for mistakes or dead air that need cutting
- [ ] Save raw footage to backup before editing
- [ ] Name the file: `raw-story-{NN}-{title}.mkv`
- [ ] Note any retakes needed
