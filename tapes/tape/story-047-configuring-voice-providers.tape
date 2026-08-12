# Story 47: Configuring Voice Providers (40s)
# Hook: "Deepgram or Whisper, sox or ffmpeg -- pick your transcription provider and recorder."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - This tape shows the [voice_control] config and narrates setup.
#
# Run: vhs story-047-configuring-voice-providers.tape

# --- Output Settings ---
Output story-047-configuring-voice-providers.mp4
Output story-047-configuring-voice-providers.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:03  Title / Hook
# "Deepgram or Whisper, sox or ffmpeg --
#  pick your transcription provider and recorder."
# ============================================================
Sleep 3.53s

# ============================================================
# 0:03-0:13  Show the [voice_control] section
# "The voice_control section chooses your speech-to-text provider.
#  Set tts_provider_name to deepgram -- the default -- or to whisper,
#  and supply that provider's api_key."
# ============================================================
Type "rysh"
Enter
Sleep 1.32s
Type "echo '[voice_control]'"
Enter
Type "echo 'tts_provider_name = deepgram   # or whisper (alias: openai)'"
Enter
Type "echo 'api_key = ...'"
Enter
Sleep 1.76s

# ============================================================
# 0:13-0:22  The recorder option
# "Back in the voice section, recorder picks how audio is captured.
#  auto chooses the first tool on your PATH -- sox, ffmpeg, afrecord,
#  or arecord -- and max_seconds caps a single recording."
# ============================================================
Type "echo '[voice]'"
Enter
Type "echo 'recorder    = auto   # sox | ffmpeg | afrecord | arecord'"
Enter
Type "echo 'max_seconds = 120'"
Enter
Sleep 2.8s

# ============================================================
# 0:22-0:31  Env overrides + mic permission
# "Prefer environment variables? Every key has one --
#  like RYSH_VOICE_CONTROL_API_KEY and RYSH_VOICE_RECORDER.
#  On macOS, grant your terminal Microphone access on first use."
# ============================================================
Type "echo 'export RYSH_VOICE_ENABLED=true RYSH_VOICE_CONTROL_API_KEY=...'"
Enter
Sleep 0.11s
Type "echo '# macOS: System Settings -> Privacy & Security -> Microphone'"
Enter
Sleep 0.22s

# ============================================================
# 0:31-0:40  Hold final frame
# "Set the provider, set the recorder, grant the mic --
#  and your voice becomes just another way to prompt."
# ============================================================
Sleep 10.6s
