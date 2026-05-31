# Group 12: Voice (Stories 46-47)

Narration scripts for Rysh's voice prompting -- dictating prompts with `Ctrl+R`,
and configuring the transcription provider and audio recorder. Because live
recording can't be scripted in a tape, these stories show the config and footer
states and narrate the flow.

**Total duration:** ~1 min 25s

---

## Story 46: Voice Prompting (Ctrl+R) (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Voice Prompting" | "Talk to your terminal. Press Ctrl+R, speak your prompt, and Rysh transcribes it for you." |
| 0:03 | `cat` the config, show `[voice]` keys | "Voice prompting starts in your config. Under the voice section, set enabled to true. The default hotkey is Ctrl+R." |
| 0:12 | Type `rysh`, TUI launches | "With voice enabled, launch rysh as usual. You're in normal mode -- ready to dictate into the active pane." |
| 0:20 | Show footer state: `the red dot REC 0:04` | "Press Ctrl+R to start recording -- the footer shows a red dot, REC, and a running timer. Speak your prompt naturally." |
| 0:30 | Show `transcribing...` then filled input | "Press Ctrl+R again to stop. Rysh shows 'transcribing', then drops the text into the input field. Review it, then press Enter to submit." |
| 0:38 | Hold final frame | "Because voice just fills the input field, it works everywhere typing does -- even when you're controlling a remote shared pane." |

### Key Moments to Annotate
- [0:03] Highlight `[voice] enabled = true` and `hotkey = "ctrl+r"`
- [0:20] Footer badge: `● REC 0:04`
- [0:30] Footer badge: `⋯ transcribing…`, then `Enter` submits / `Esc` cancels

---

## Story 47: Configuring Voice Providers (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Configuring Voice Providers" | "Deepgram or Whisper, sox or ffmpeg -- pick your transcription provider and recorder." |
| 0:03 | Show `[voice_control]` block | "The voice_control section chooses your speech-to-text provider. Set tts_provider_name to deepgram -- the default -- or to whisper, and supply that provider's api_key." |
| 0:13 | Show `[voice]` recorder + max_seconds | "Back in the voice section, recorder picks how audio is captured. auto chooses the first tool on your PATH -- sox, ffmpeg, afrecord, or arecord -- and max_seconds caps a single recording." |
| 0:22 | Show env-var overrides and mic note | "Prefer environment variables? Every key has one -- like RYSH_VOICE_CONTROL_API_KEY and RYSH_VOICE_RECORDER. On macOS, grant your terminal Microphone access on first use." |
| 0:31 | Hold final frame | "Set the provider, set the recorder, grant the mic -- and your voice becomes just another way to prompt." |

### Key Moments to Annotate
- [0:03] Highlight `tts_provider_name = "deepgram"` (alias `whisper`/`openai`)
- [0:13] Highlight `recorder = "auto"` options
- [0:22] Callout: env overrides + macOS Microphone permission
