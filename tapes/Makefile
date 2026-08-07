# Rysh Video Tutorials - TTS Voiceover Pipeline
#
# Prerequisites:
#   brew install uv ffmpeg
#   cp .env.example .env   # then add your OPENAI_API_KEY
#
# Usage:
#   make install           # install Python dependencies
#   make say               # generate .say files from .tape files
#   make tts               # generate MP3 voiceovers from all .say files
#   make tts-one F=say/story-001-what-is-rysh.say   # single file
#   make vover-all         # merge voiceover onto every video -> final/
#   make vover-one F=out/story-005-your-first-session.mp4  # single file
#   make qc                # quality-gate the voiced masters in final/
#   make clean             # remove generated .say and .vover.mp4 (keeps .mp3)

# --- Config ---
VOICE   ?= nova
MODEL   ?= tts-1-hd
SPEED   ?= 1.0
VOLUME  ?= 1.0
# Interpreter. `uv run python` by default; override to test or to use a
# system interpreter, e.g. `make vover-all PY=python3`.
PY      ?= uv run python

# --- Layout ---
# Sources and artifacts live in subdirectories, not in tapes/ itself:
#   tape/  story-NNN-*.tape   VHS sources          (tracked)
#   say/   story-NNN-*.say    narration scripts    (tracked)
#          story-NNN-*.mp3    TTS audio            (gitignored, costs an API run)
#   out/   story-NNN-*.mp4    rendered, silent     (gitignored)
#   final/ story-NNN-*.vover.mp4  voiced masters   (gitignored) — what gets published
# Story ids are THREE digits. This block used to glob story-*.{say,mp4} in tapes/
# and hardcode two-digit ids, so every target silently expanded to nothing.
TAPE_DIR  := tape
SAY_DIR   := say
OUT_DIR   := out
FINAL_DIR := final

SAY_FILES  := $(wildcard $(SAY_DIR)/story-*.say)
TAPE_FILES := $(wildcard $(TAPE_DIR)/story-*.tape)
VOVER_MP4S := $(shell ls -1 $(OUT_DIR)/story-[0-9][0-9][0-9]-*.mp4 2>/dev/null | grep -v '.vover.mp4')

.PHONY: help install say tts tts-one vover vover-all vover-one qc clean clean-say clean-mp3 clean-vover list voices

# --- Default ---
help:
	@echo ""
	@echo "Rysh Video TTS Pipeline"
	@echo "======================="
	@echo ""
	@echo "Setup:"
	@echo "  make install              Install Python dependencies via uv"
	@echo "  cp .env.example .env      Then add your OPENAI_API_KEY"
	@echo ""
	@echo "Generate:"
	@echo "  make say                  Extract .say scripts from all .tape files"
	@echo "  make tts                  Generate MP3 voiceovers from all .say files"
	@echo "  make tts-one F=<file>     Generate MP3 for a single .say file"
	@echo ""
	@echo "Merge voiceover onto video:"
	@echo "  make vover-all            Merge voiceover onto every video -> $(FINAL_DIR)/"
	@echo "  make vover-one F=<file>   Merge voiceover onto a single video"
	@echo ""
	@echo "Verify:"
	@echo "  make qc                   Quality-gate the voiced masters in $(FINAL_DIR)/"
	@echo ""
	@echo "Options (override via env):"
	@echo "  VOICE=nova                TTS voice (default: nova)"
	@echo "  MODEL=tts-1-hd            TTS model (default: tts-1-hd)"
	@echo "  SPEED=1.0                 Speech speed 0.25-4.0 (default: 1.0)"
	@echo "  VOLUME=1.0                Voiceover volume multiplier (default: 1.0)"
	@echo ""
	@echo "  Example: make tts VOICE=echo MODEL=tts-1 SPEED=1.1"
	@echo "  Example: make vover VOLUME=1.2"
	@echo ""
	@echo "Cleanup:"
	@echo "  make clean-say            Remove all .say files"
	@echo "  make clean-mp3 FORCE=1    Remove .mp3 files (costs a paid TTS run to redo)"
	@echo "  make clean-vover          Remove all .vover.mp4 files"
	@echo "  make clean                Remove .say + .vover.mp4 (keeps .mp3)"
	@echo ""
	@echo "Info:"
	@echo "  make list                 Count .tape / .say / .mp3 / .mp4 / .vover.mp4"
	@echo "  make voices               Show available TTS voices"
	@echo ""

# --- Setup ---
install:
	uv sync

# --- Generate .say files from .tape files ---
say:
	$(PY) generate_say_files.py

# --- Generate MP3 voiceovers ---
tts: say
	$(PY) tts_openai.py $(SAY_DIR)/story-*.say \
		--voice $(VOICE) \
		--model $(MODEL) \
		--speed $(SPEED)

# --- Generate MP3 for a single .say file ---
tts-one:
ifndef F
	@echo "Error: specify file with F=<filename>"
	@echo "  make tts-one F=story-01-what-is-rysh.say"
	@exit 1
endif
	$(PY) tts_openai.py $(F) \
		--voice $(VOICE) \
		--model $(MODEL) \
		--speed $(SPEED)

# --- Merge voiceover onto all videos ---
# `vover` used to mean "first 30", selected by a two-digit glob that matched
# nothing once ids went to three digits. Dead code with a misleading name, so it
# is now an alias for the real thing rather than a second, subtly different path.
vover: vover-all

vover-all:
	$(PY) merge_voiceover.py \
		$(VOVER_MP4S) \
		--audio-dir $(SAY_DIR) \
		--output-dir $(FINAL_DIR) \
		--volume $(VOLUME)

# --- Merge voiceover onto a single video ---
vover-one:
ifndef F
	@echo "Error: specify file with F=<filename>"
	@echo "  make vover-one F=out/story-005-your-first-session.mp4"
	@exit 1
endif
	$(PY) merge_voiceover.py $(F) \
		--audio-dir $(SAY_DIR) \
		--output-dir $(FINAL_DIR) \
		--volume $(VOLUME)

# --- Quality gate on the voiced masters ---
qc:
	./qc_videos.sh $(FINAL_DIR) $(SAY_DIR)

# --- Cleanup ---
clean-say:
	rm -f $(SAY_DIR)/story-*.say
	@echo "Removed all .say files"

# The 111 .mp3 files cost a paid OpenAI TTS run to regenerate, so this is not
# part of `clean` and asks before deleting. Use FORCE=1 to skip the prompt.
clean-mp3:
ifndef FORCE
	@echo "This deletes $(words $(wildcard $(SAY_DIR)/story-*.mp3)) .mp3 files that cost a paid TTS run to regenerate."
	@echo "Re-run as: make clean-mp3 FORCE=1"
	@exit 1
endif
	rm -f $(SAY_DIR)/story-*.mp3
	@echo "Removed all .mp3 files"

clean-vover:
	rm -f $(FINAL_DIR)/story-*.vover.mp4
	@echo "Removed all .vover.mp4 files"

# Deliberately excludes clean-mp3 — see above.
clean: clean-say clean-vover

# --- Info ---
list:
	@echo "=== Tape files ($(TAPE_DIR)/) ==="
	@ls -1 $(TAPE_DIR)/story-*.tape 2>/dev/null | wc -l | tr -d ' '
	@echo "=== Say files ($(SAY_DIR)/) ==="
	@ls -1 $(SAY_DIR)/story-*.say 2>/dev/null | wc -l | tr -d ' '
	@echo "=== MP3 files ($(SAY_DIR)/) ==="
	@ls -1 $(SAY_DIR)/story-*.mp3 2>/dev/null | wc -l | tr -d ' '
	@echo "=== Rendered videos ($(OUT_DIR)/) ==="
	@ls -1 $(OUT_DIR)/story-*.mp4 2>/dev/null | grep -v '.vover.mp4' | wc -l | tr -d ' '
	@echo "=== Voiced masters ($(FINAL_DIR)/) ==="
	@ls -1 $(FINAL_DIR)/story-*.vover.mp4 2>/dev/null | wc -l | tr -d ' '

voices:
	@echo "Available OpenAI TTS voices:"
	@echo "  alloy    - neutral, balanced"
	@echo "  ash      - warm, conversational"
	@echo "  ballad   - expressive, storytelling"
	@echo "  coral    - clear, informative"
	@echo "  echo     - smooth, calm"
	@echo "  fable    - expressive, British accent"
	@echo "  nova     - energetic, friendly (default)"
	@echo "  onyx     - deep, authoritative"
	@echo "  sage     - wise, measured"
	@echo "  shimmer  - warm, gentle"
