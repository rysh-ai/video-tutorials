# Story 46: Voice Prompting (Ctrl+R) (45s)
# Hook: "Talk to your terminal. Press Ctrl+R, speak your prompt, and Rysh transcribes it for you."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - [voice] enabled in config; a recorder (sox/ffmpeg) on PATH
#   - No existing default session (run: rysh delete-session default)
#   - Recording itself can't be scripted; this tape shows config + flow.
#
# Run: vhs story-046-voice-prompting.tape

# --- Output Settings ---
Output story-046-voice-prompting.mp4
Output story-046-voice-prompting.gif

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
# "Talk to your terminal. Press Ctrl+R, speak your prompt,
#  and Rysh transcribes it for you."
# ============================================================
Sleep 3.01s

# ============================================================
# 0:03-0:12  Show the [voice] config
# "Voice prompting starts in your config. Under the voice section,
#  set enabled to true. The default hotkey is Ctrl+R."
# ============================================================
Type "cat ~/.config/rysh/rysh.config"
Enter
Sleep 0.1s
Type "# [voice]"
Enter
Type "#   enabled = true"
Enter
Type "#   hotkey  = 'ctrl+r'"
Enter
Type "#   recorder = 'auto'   # auto | sox | ffmpeg | afrecord | arecord"
Enter
Sleep 0.1s

# ============================================================
# 0:12-0:20  Launch rysh
# "With voice enabled, launch rysh as usual.
#  You're in normal mode -- ready to dictate into the active pane."
# ============================================================
Type "rysh"
Enter
Sleep 7.65s

# ============================================================
# 0:20-0:30  Narrate the record flow
# "Press Ctrl+R to start recording -- the footer shows a red dot,
#  REC, and a running timer. Speak your prompt naturally."
# ============================================================
Type "# Press Ctrl+R --> footer shows:  the red dot REC 0:04"
Enter
Sleep 5.91s

# ============================================================
# 0:30-0:38  Stop, transcribe, submit
# "Press Ctrl+R again to stop. Rysh shows 'transcribing', then drops
#  the text into the input field. Review it, then press Enter to submit."
# ============================================================
Type "# Press Ctrl+R again --> transcribing... --> text fills the input"
Enter
Sleep 0.1s
Type "# Enter to submit, or Esc while recording to cancel"
Enter
Sleep 0.1s

# ============================================================
# 0:38-0:45  Hold final frame
# "Because voice just fills the input field, it works everywhere typing does --
#  even when you're controlling a remote shared pane."
# ============================================================
Sleep 7.02s
