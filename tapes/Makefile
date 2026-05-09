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
#   make tts-one F=story-01-what-is-rysh.say   # single file
#   make vover             # merge voiceover onto first 30 videos
#   make vover-all         # merge voiceover onto all videos
#   make vover-one F=story-05-tabs-and-panes.mp4  # single file
#   make clean             # remove all generated files

# --- Config ---
VOICE   ?= nova
MODEL   ?= tts-1-hd
SPEED   ?= 1.0
VOLUME  ?= 1.0
UV      := uv run

SAY_FILES  := $(wildcard story-*.say)
TAPE_FILES := $(wildcard story-*.tape)

# First 30 MP4 files (stories 01-30)
VOVER_MP4S := $(shell ls -1 story-{01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30}-*.mp4 2>/dev/null | grep -v '.vover.mp4')

.PHONY: help install say tts tts-one vover vover-all vover-one clean clean-say clean-mp3 clean-vover list voices

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
	@echo "  make vover                Merge voiceover onto first 30 videos"
	@echo "  make vover-all            Merge voiceover onto all videos"
	@echo "  make vover-one F=<file>   Merge voiceover onto a single video"
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
	@echo "  make clean-mp3            Remove all generated .mp3 files"
	@echo "  make clean-vover          Remove all .vover.mp4 files"
	@echo "  make clean                Remove all generated files"
	@echo ""
	@echo "Info:"
	@echo "  make list                 List all .tape / .say / .mp3 / .vover.mp4 files"
	@echo "  make voices               Show available TTS voices"
	@echo ""

# --- Setup ---
install:
	uv sync

# --- Generate .say files from .tape files ---
say:
	$(UV) python generate_say_files.py

# --- Generate MP3 voiceovers ---
tts: say
	$(UV) python tts_openai.py story-*.say \
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
	$(UV) python tts_openai.py $(F) \
		--voice $(VOICE) \
		--model $(MODEL) \
		--speed $(SPEED)

# --- Merge voiceover onto first 30 videos ---
vover:
	$(UV) python merge_voiceover.py \
		$(VOVER_MP4S) \
		--volume $(VOLUME)

# --- Merge voiceover onto all videos ---
vover-all:
	$(UV) python merge_voiceover.py \
		$$(ls -1 story-*.mp4 2>/dev/null | grep -v '.vover.mp4') \
		--volume $(VOLUME)

# --- Merge voiceover onto a single video ---
vover-one:
ifndef F
	@echo "Error: specify file with F=<filename>"
	@echo "  make vover-one F=story-05-tabs-and-panes.mp4"
	@exit 1
endif
	$(UV) python merge_voiceover.py $(F) \
		--volume $(VOLUME)

# --- Cleanup ---
clean-say:
	rm -f story-*.say
	@echo "Removed all .say files"

clean-mp3:
	rm -f story-*.mp3
	@echo "Removed all .mp3 files"

clean-vover:
	rm -f story-*.vover.mp4
	@echo "Removed all .vover.mp4 files"

clean: clean-say clean-mp3 clean-vover

# --- Info ---
list:
	@echo "=== Tape files ==="
	@ls -1 story-*.tape 2>/dev/null || echo "  (none)"
	@echo ""
	@echo "=== Say files ==="
	@ls -1 story-*.say 2>/dev/null || echo "  (none)"
	@echo ""
	@echo "=== MP3 files ==="
	@ls -1 story-*.mp3 2>/dev/null || echo "  (none)"
	@echo ""
	@echo "=== Voiceover videos ==="
	@ls -1 story-*.vover.mp4 2>/dev/null || echo "  (none)"

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
