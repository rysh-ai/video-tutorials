#!/usr/bin/env bash
# Put a voiceover and subtitles on the agent-board-fleet-codex take.
#
#   ./make-voiceover.sh                 # everything
#   ./make-voiceover.sh --skip-tts      # reuse the existing mp3 (a TTS run costs money)
#
# THE SILENT TAKE IS NEVER TOUCHED. Everything is written under voiceover/ or as
# a NEW file in ../out/; ../out/agent-board-fleet-codex.mp4 is opened read-only and
# stays byte-identical.
#
# Produces, in ../out/:
#   agent-board-fleet-codex.vover.mp4      video + narration, soft subtitle track
#   agent-board-fleet-codex.vover.subs.mp4 video + narration, subtitles burned in
# and, here in voiceover/:
#   agent-board-fleet-codex.mp3 .srt .dg.json
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

TAPES="$DIR/../../../tapes"          # video-tutorials/tapes — the shared TTS pipeline
SILENT="$DIR/../out/agent-board-fleet-codex.mp4"
SAY="agent-board-fleet-codex.say"
RAW_MP3="agent-board-fleet-codex.raw.mp3"   # straight off the TTS API
MP3="agent-board-fleet-codex.mp3"           # loudness-normalised; what ships
SRT="agent-board-fleet-codex.srt"

TARGET_I="${TARGET_I:--16}"           # LUFS integrated — web playback level
TARGET_TP="${TARGET_TP:--1.5}"        # dBTP ceiling
VOVER="$DIR/../out/agent-board-fleet-codex.vover.mp4"
BURNED="$DIR/../out/agent-board-fleet-codex.vover.subs.mp4"

VOICE="${VOICE:-nova}"
TTS_MODEL="${TTS_MODEL:-tts-1-hd}"
SPEED="${SPEED:-1.0}"

say() { printf '\033[36m[vover]\033[0m %s\n' "$*"; }
die() { printf '\033[31m[vover]\033[0m %s\n' "$*" >&2; exit 1; }

[ -f "$SILENT" ] || die "no silent take at $SILENT — run ../record.sh first"
[ -f "$SAY" ]    || die "no narration script: $SAY"
command -v ffmpeg >/dev/null || die "ffmpeg is not installed"
command -v uv     >/dev/null || die "uv is not installed (the TTS pipeline runs under it)"

# --- keys, out of the session's secret store ------------------------------
# `##secret get` prints the REAL value on stdout, so it is captured straight
# into a variable and never echoed, never written to a file, and never passed on
# a command line where `ps` would show it. The scripts below read it from the
# environment. `set -u` above turns a failed fetch into an immediate error
# rather than an empty key and a confusing 401.
RYSH_BIN="${RYSH_BIN:-$HOME/.local/bin/rysh_local}"
KEY_SESSION="${KEY_SESSION:-rysh}"             # the session whose store holds the keys
# rysh state is PROJECT-LOCAL, so the fetch has to run where that session's
# .rysh lives — the repo root, four levels up from here. Run it one directory
# out and it fails with `session "rysh" not found`, an error that names the
# session and never mentions the working directory.
KEY_WORKDIR="${KEY_WORKDIR:-$DIR/../../../..}"

fetch_secret() { # fetch_secret <NAME>
  ( cd "$KEY_WORKDIR" && "$RYSH_BIN" exec --session "$KEY_SESSION" -- "##secret get $1" ) 2>/dev/null \
    | sed -E 's/^\[secret\][^=]*= //; s/[[:space:]]+\[[^]]*\][[:space:]]*$//' \
    | tr -d '\n'
}

say "reading keys from the $KEY_SESSION session's secret store"
OPENAI_API_KEY="$(fetch_secret OPENAI_API_KEY)"
DEEPGRAM_API_KEY="$(fetch_secret DEEPGRAM_API_KEY)"
export OPENAI_API_KEY DEEPGRAM_API_KEY
# Length only. Never the value, and never a prefix — a prefix of a live key is
# still a leak into a transcript that outlives this run.
[ "${#OPENAI_API_KEY}"   -gt 20 ] || die "OPENAI_API_KEY looks empty (got ${#OPENAI_API_KEY} chars)"
[ "${#DEEPGRAM_API_KEY}" -gt 20 ] || die "DEEPGRAM_API_KEY looks empty (got ${#DEEPGRAM_API_KEY} chars)"
say "keys loaded (${#OPENAI_API_KEY} and ${#DEEPGRAM_API_KEY} chars)"

# --- 1. narration ---------------------------------------------------------
if [ "${1:-}" = "--skip-tts" ] && [ -f "$RAW_MP3" ]; then
  say "reusing $RAW_MP3"
else
  say "synthesising narration ($VOICE, $TTS_MODEL, speed $SPEED)"
  ( cd "$TAPES" && uv run python tts_openai.py "$DIR/$SAY" \
      --voice "$VOICE" --model "$TTS_MODEL" --speed "$SPEED" --output-dir "$DIR" )
  [ -f "$MP3" ] || die "TTS produced no $MP3"
  mv "$MP3" "$RAW_MP3"
fi

# --- 1b. loudness ---------------------------------------------------------
# The raw TTS came back at -29.1 LUFS integrated with a -8 dB peak. Web
# playback sits around -16 LUFS, so unnormalised narration under a terminal
# recording is a video people turn up and still cannot hear.
#
# It cannot be fixed with a gain: +13 dB on a -8 dB peak clips hard. loudnorm
# is used because it brings the average up and limits the peaks in one pass,
# and it is run TWO-pass — the first pass measures, the second corrects against
# those measurements. Single-pass loudnorm works from a running estimate and
# pumps on speech with long silences, which this narration is full of.
say "normalising loudness to ${TARGET_I} LUFS"
measured=$(ffmpeg -hide_banner -nostats -i "$RAW_MP3" \
  -af "loudnorm=I=$TARGET_I:TP=$TARGET_TP:LRA=11:print_format=json" -f null - 2>&1 \
  | sed -n '/^{/,/^}/p')
mi=$(printf '%s' "$measured" | sed -n 's/.*"input_i" *: *"\([^"]*\)".*/\1/p')
mtp=$(printf '%s' "$measured" | sed -n 's/.*"input_tp" *: *"\([^"]*\)".*/\1/p')
mlra=$(printf '%s' "$measured" | sed -n 's/.*"input_lra" *: *"\([^"]*\)".*/\1/p')
mthresh=$(printf '%s' "$measured" | sed -n 's/.*"input_thresh" *: *"\([^"]*\)".*/\1/p')
[ -n "$mi" ] || die "loudnorm measurement pass produced no JSON"
ffmpeg -hide_banner -loglevel error -y -i "$RAW_MP3" \
  -af "loudnorm=I=$TARGET_I:TP=$TARGET_TP:LRA=11:measured_I=$mi:measured_TP=$mtp:measured_LRA=$mlra:measured_thresh=$mthresh:linear=true" \
  -c:a libmp3lame -b:a 192k "$MP3"
say "narration $mi LUFS -> $(ffmpeg -hide_banner -nostats -i "$MP3" -af ebur128=framelog=quiet -f null - 2>&1 | sed -n 's/^ *I: *\(.*\) LUFS/\1/p' | tail -1) LUFS"

vdur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$SILENT")
adur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$MP3")
say "video ${vdur}s · narration ${adur}s"
# The merge uses -shortest, so narration past the end of the video is CUT, not
# heard. Overrun is a content bug in the .say file, not something to paper over.
awk -v a="$adur" -v v="$vdur" 'BEGIN{ if (a > v + 1.0) exit 1 }' \
  || say "WARNING: narration outruns the video by $(awk -v a="$adur" -v v="$vdur" 'BEGIN{printf "%.1f", a-v}')s — the tail will be truncated"

# --- 2. subtitles, timed off the audio that actually exists ---------------
say "timing subtitles with deepgram"
python3 srt_from_deepgram.py "$MP3" "$SAY" ${DG_REUSE:+--reuse}
[ -f "$SRT" ] || die "no $SRT produced"

# --- 3. voiceover onto a NEW file ----------------------------------------
say "merging narration onto the video"
( cd "$TAPES" && uv run python merge_voiceover.py "$SILENT" --audio-dir "$DIR" --output-dir "$DIR/../out" )
[ -f "$VOVER" ] || die "merge produced no $VOVER"

# Soft subtitle track on the voiced master: selectable in a player, and it does
# not touch a pixel of the picture.
tmp="$(mktemp -t vover).mp4"
ffmpeg -hide_banner -loglevel error -y -i "$VOVER" -i "$SRT" \
  -c copy -c:s mov_text -metadata:s:s:0 language=eng "$tmp"
mv "$tmp" "$VOVER"
say "voiced master (soft subs): $VOVER"

# --- 4. burned-in subtitles ----------------------------------------------
# Via an ASS file with an EXPLICIT PlayRes, not `subtitles=...:force_style`.
#
# ffmpeg converts SRT to ASS with a default script resolution of 384x288, and
# libass then scales every size by 1080/288 = 3.75. So `Fontsize=21` rendered at
# roughly 79 pixels — subtitles that covered three panes. Sizes only mean
# anything once the script resolution matches the video, and then they are plain
# pixels: 30px text, 14px up from the bottom edge.
#
# That lands the text in the empty band the TUI leaves under its status line, so
# even two lines never touch a pane. Re-encoding is unavoidable when burning in;
# the soft-sub master above is the lossless one.
say "burning in subtitles"
ASS="$(mktemp -t vsubs).ass"
ffmpeg -hide_banner -loglevel error -y -i "$SRT" "$ASS"
python3 - "$ASS" <<'PY'
import re, sys
p = sys.argv[1]
s = open(p).read()
s = re.sub(r"^PlayResX:.*$", "PlayResX: 1920", s, flags=re.M)
s = re.sub(r"^PlayResY:.*$", "PlayResY: 1080", s, flags=re.M)
if "PlayResX" not in s:
    s = s.replace("[Script Info]", "[Script Info]\nPlayResX: 1920\nPlayResY: 1080", 1)
style = ("Style: Default,Helvetica,30,&H00FFFFFF,&H000000FF,&H00101010,&H80000000,"
         "0,0,0,0,100,100,0,0,1,2.2,1.2,2,40,40,14,1")
s = re.sub(r"^Style: Default,.*$", style, s, flags=re.M)
open(p, "w").write(s)
PY
ffmpeg -hide_banner -loglevel error -y -i "$VOVER" -vf "ass=$ASS" \
  -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p -c:a copy "$BURNED"
rm -f "$ASS"
say "burned-in subs: $BURNED"

say "silent take untouched: $SILENT"
ls -la "$SILENT" "$VOVER" "$BURNED"
