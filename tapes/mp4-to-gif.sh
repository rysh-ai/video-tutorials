#!/usr/bin/env bash
# mp4-to-gif.sh -- Convert MP4 to high-quality GIF using ffmpeg
#
# Usage:
#   ./mp4-to-gif.sh input.mp4              # outputs input.gif
#   ./mp4-to-gif.sh input.mp4 output.gif   # outputs output.gif
#   ./mp4-to-gif.sh input.mp4 -w 800       # scale to 800px wide
#   ./mp4-to-gif.sh input.mp4 -r 15        # 15 fps
#
# Options:
#   -w WIDTH   Output width in pixels (default: source width)
#   -r FPS     Frame rate (default: 15)
#   -h         Show this help

set -euo pipefail

usage() {
    sed -n '2,12p' "$0" | sed 's/^# \?//'
    exit 0
}

# Defaults
WIDTH=""
FPS=15
INPUT=""
OUTPUT=""

# Parse args
while [[ $# -gt 0 ]]; do
    case "$1" in
        -w) WIDTH="$2"; shift 2 ;;
        -r) FPS="$2"; shift 2 ;;
        -h|--help) usage ;;
        *)
            if [[ -z "$INPUT" ]]; then
                INPUT="$1"
            elif [[ -z "$OUTPUT" ]]; then
                OUTPUT="$1"
            else
                echo "Error: unexpected argument '$1'" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$INPUT" ]]; then
    echo "Error: no input file specified" >&2
    echo "Usage: $0 input.mp4 [output.gif] [-w WIDTH] [-r FPS]" >&2
    exit 1
fi

if [[ ! -f "$INPUT" ]]; then
    echo "Error: file not found: $INPUT" >&2
    exit 1
fi

# Default output: same name with .gif extension
if [[ -z "$OUTPUT" ]]; then
    OUTPUT="${INPUT%.mp4}.gif"
fi

# Build scale filter
if [[ -n "$WIDTH" ]]; then
    SCALE="scale=${WIDTH}:-1:flags=lanczos"
else
    SCALE="scale=trunc(iw/2)*2:trunc(ih/2)*2:flags=lanczos"
fi

echo "Converting: $INPUT -> $OUTPUT"
echo "  FPS: $FPS"
[[ -n "$WIDTH" ]] && echo "  Width: ${WIDTH}px"

# Two-pass approach for best quality:
# 1. Generate optimized palette from the video
# 2. Use palette to create the GIF
PALETTE=$(mktemp /tmp/palette-XXXXXX.png)
trap 'rm -f "$PALETTE"' EXIT

echo "  Pass 1: generating palette..."
ffmpeg -y -i "$INPUT" \
    -vf "fps=${FPS},${SCALE},palettegen=stats_mode=diff" \
    "$PALETTE" \
    -loglevel error

echo "  Pass 2: encoding GIF..."
ffmpeg -y -i "$INPUT" -i "$PALETTE" \
    -lavfi "fps=${FPS},${SCALE} [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" \
    "$OUTPUT" \
    -loglevel error

SIZE=$(du -h "$OUTPUT" | cut -f1)
echo "Done: $OUTPUT ($SIZE)"
