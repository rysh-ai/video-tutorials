# Rysh Video Tutorials -- Production Guide

## Recording Setup

### Terminal Configuration

| Setting | Value |
|---------|-------|
| Terminal emulator | iTerm2, Alacritty, or WezTerm |
| Theme | Catppuccin Mocha or Dracula (dark, high contrast) |
| Font | JetBrains Mono or Fira Code |
| Font size | 16px (for 1080p), 14px (for 4K) |
| Line height | 1.2-1.3 |
| Window padding | 10-20px |
| Cursor | Block, blinking |
| Opacity | 100% (no transparency) |

### Screen Resolution

| Platform | Resolution | Aspect Ratio |
|----------|-----------|--------------|
| YouTube | 1920x1080 or 2560x1440 | 16:9 |
| TikTok / Reels | 1080x1920 | 9:16 (vertical) |
| X / Twitter | 1280x720 | 16:9 |
| Website embed | 1920x1080 | 16:9 |

### Recording Tools

| Tool | Purpose | Platform |
|------|---------|----------|
| OBS Studio | Screen recording | All |
| Screenflow | Screen recording + editing | macOS |
| asciinema | Terminal recording (for embeds) | All |
| vhs (charmbracelet) | Scripted terminal recordings | All |
| DaVinci Resolve | Video editing | All |
| Canva | Thumbnails and overlays | Web |
| Audacity | Audio editing | All |

### Audio

| Setting | Value |
|---------|-------|
| Microphone | USB condenser or lapel mic |
| Sample rate | 48kHz |
| Bit depth | 24-bit |
| Noise gate | -40dB |
| Background music | Lo-fi or ambient, -20dB under narration |
| Music source | Epidemic Sound, Artlist, or royalty-free |

---

## Visual Style Guide

### On-Screen Elements

#### Key Binding Badges

Show keyboard shortcuts as floating badges when pressed:

```
┌──────────┐
│  Ctrl+P  │  ← Semi-transparent rounded badge
└──────────┘
```

- Background: rgba(0, 0, 0, 0.7)
- Text: white, bold, 18px
- Position: bottom-right or center
- Duration: 1.5s with fade out

#### Mode Indicators

When the mode changes, show a centered overlay:

```
┌─────────────────┐
│   TAB MODE      │
│   Ctrl+T        │
└─────────────────┘
```

- Fade in 0.3s, hold 1s, fade out 0.3s
- Large text (24px+), semi-transparent background

#### Callout Arrows

Use arrows or highlights to point to:
- The active pane border color change
- The mode indicator in the footer
- The input prompt character (`>`, `<`, `##`, `@`)

### Color Palette

| Element | Color |
|---------|-------|
| Background | #1e1e2e (dark) |
| Text | #cdd6f4 (light) |
| Accent | #89b4fa (blue) |
| Success | #a6e3a1 (green) |
| Warning | #f9e2af (yellow) |
| Error | #f38ba8 (red) |
| Highlight | #f5c2e7 (pink) |

### Transitions

- Between sections: Simple fade (0.5s)
- Between stories in a group: Cross-dissolve (0.3s)
- No flashy transitions, wipes, or zooms
- Exception: zoom-in on a specific pane when explaining a detail

### Pacing Rules

1. **Show the action** -- type the command, press the key
2. **Pause 1-2 seconds** -- let the viewer read the output
3. **Narrate the result** -- explain what happened
4. **Move on** -- don't linger

### Text Overlays

- Title card at the start of each story (2s)
- Key takeaway card at the end (3s)
- Use consistent font (Inter or system sans-serif)
- Avoid walls of text -- max 2 lines per overlay

---

## Thumbnail Guidelines

Each story needs a thumbnail (1280x720 or 1920x1080):

- Dark background matching the terminal theme
- Large, bold title text (max 5 words)
- A relevant emoji or icon
- The Rysh logo in one corner
- A small screenshot of the feature being demonstrated

### Thumbnail Template

```
┌─────────────────────────────┐
│                             │
│    🤖 AI AGENTS             │
│    IN YOUR TERMINAL         │
│                             │
│  ┌─────────────────────┐    │
│  │ terminal screenshot  │    │
│  └─────────────────────┘    │
│                       rysh  │
└─────────────────────────────┘
```

---

## Pre-Recording Checklist

Before each recording session:

- [ ] Clean terminal history (`history -c`)
- [ ] Set terminal theme to dark (Catppuccin Mocha)
- [ ] Set font size to 16px
- [ ] Close all unnecessary applications
- [ ] Disable notifications (Do Not Disturb)
- [ ] Disable desktop sounds
- [ ] Set window to exact recording resolution
- [ ] Prepare test project directory with sample files
- [ ] Verify `rysh` is built and working
- [ ] Verify API key is configured (for AI demos)
- [ ] Delete existing sessions (`rysh delete-session default`)
- [ ] Start fresh with no prior state
- [ ] Test microphone levels
- [ ] Do a 10-second test recording

---

## Post-Production Checklist

After recording:

- [ ] Trim dead air and mistakes
- [ ] Add title card (2s at start)
- [ ] Add key takeaway card (3s at end)
- [ ] Add key binding badges at relevant moments
- [ ] Add mode indicator overlays
- [ ] Normalize audio levels (-14 LUFS for YouTube)
- [ ] Add background music (if desired)
- [ ] Add captions/subtitles (highly recommended)
- [ ] Export at target resolution
- [ ] Create thumbnail
- [ ] Write video description with timestamps
- [ ] Add to playlist

---

## Platform-Specific Export Settings

### YouTube

| Setting | Value |
|---------|-------|
| Resolution | 1920x1080 or 2560x1440 |
| Frame rate | 30fps |
| Codec | H.264 |
| Bitrate | 8-12 Mbps (1080p), 35-45 Mbps (4K) |
| Audio | AAC, 320kbps |

### TikTok / Instagram Reels

| Setting | Value |
|---------|-------|
| Resolution | 1080x1920 (vertical) |
| Frame rate | 30fps |
| Duration | 30-60s max |
| Codec | H.264 |
| Audio | AAC, 256kbps |

### X / Twitter

| Setting | Value |
|---------|-------|
| Resolution | 1280x720 |
| Frame rate | 30fps |
| Duration | 30s max (for best engagement) |
| Codec | H.264 |
| File size | Under 512MB |

---

## Using VHS (charmbracelet) for Scripted Recordings

VHS lets you script terminal recordings as `.tape` files:

```tape
# Example: Story 1 - What Is Rysh?
Output story-01-what-is-rysh.gif
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"

Type "rysh"
Enter
Sleep 2s

Type "ls -la"
Enter
Sleep 1.5s

# Double-Escape to switch to prompt mode
Escape
Escape
Sleep 0.5s

Type "explain this directory structure"
Enter
Sleep 3s
```

Install: `go install github.com/charmbracelet/vhs@latest`
Run: `vhs story-01.tape`
