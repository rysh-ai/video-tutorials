#!/usr/bin/env python3
"""
Generate MP3 voiceover from .say script files using OpenAI TTS.

Usage:
    # Single file
    python tts_openai.py story-01-what-is-rysh.say

    # With options
    python tts_openai.py story-01-what-is-rysh.say --voice nova --model tts-1-hd

    # Batch mode (all .say files)
    python tts_openai.py *.say

    # Custom output directory
    python tts_openai.py *.say --output-dir ../voiceovers/

Requirements:
    uv sync                    # installs openai, python-dotenv
    brew install ffmpeg        # used for audio assembly
    cp .env.example .env       # then add your OpenAI key

Voices:
    alloy, ash, ballad, coral, echo, fable, nova, onyx, sage, shimmer

Models:
    tts-1      -- faster, cheaper ($15/1M chars)
    tts-1-hd   -- higher quality ($30/1M chars)
"""

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

from dotenv import load_dotenv

# Load .env, searching this script's directory and its parent directories.
# This finds video-tutorials/.env even though the script lives in tapes/.
_script_dir = Path(__file__).resolve().parent
for _candidate in [_script_dir, *_script_dir.parents]:
    _env_path = _candidate / ".env"
    if _env_path.exists():
        load_dotenv(_env_path)
        break

from openai import OpenAI


def check_ffmpeg():
    """Verify ffmpeg is installed."""
    if not shutil.which("ffmpeg") or not shutil.which("ffprobe"):
        print("Error: ffmpeg is not installed.")
        print("  brew install ffmpeg")
        sys.exit(1)


def get_audio_duration(path: str) -> float:
    """Get audio file duration in seconds using ffprobe."""
    result = subprocess.run(
        [
            "ffprobe",
            "-v", "quiet",
            "-print_format", "json",
            "-show_format",
            path,
        ],
        capture_output=True,
        text=True,
    )
    info = json.loads(result.stdout)
    return float(info["format"]["duration"])


def generate_silence(duration_s: float, output_path: str):
    """Generate a silent MP3 of the given duration."""
    subprocess.run(
        [
            "ffmpeg",
            "-y",
            "-f", "lavfi",
            "-i", f"anullsrc=r=24000:cl=mono",
            "-t", str(duration_s),
            "-c:a", "libmp3lame",
            "-b:a", "192k",
            output_path,
        ],
        capture_output=True,
    )


def concatenate_audio(file_list_path: str, output_path: str):
    """Concatenate audio files listed in a text file using ffmpeg."""
    subprocess.run(
        [
            "ffmpeg",
            "-y",
            "-f", "concat",
            "-safe", "0",
            "-i", file_list_path,
            "-c:a", "libmp3lame",
            "-b:a", "192k",
            output_path,
        ],
        capture_output=True,
    )


def parse_say_file(path: str) -> tuple[dict, list[dict]]:
    """
    Parse a .say file.
    Returns (metadata, segments) where each segment is {start, end, text}.
    """
    metadata = {}
    segments = []

    with open(path) as f:
        lines = f.readlines()

    # Extract metadata from header comments
    for line in lines:
        line = line.rstrip("\n")
        if line.startswith("# Story "):
            metadata["title"] = line[2:]
        elif line.startswith("# Duration: "):
            metadata["duration"] = line[12:].strip()
        elif line.startswith("# Total segments: "):
            metadata["total_segments"] = int(line[18:].strip())
        elif not line.startswith("#"):
            break

    # Parse timed segments
    i = 0
    while i < len(lines):
        line = lines[i].strip()

        # Match [MM:SS.0 --> MM:SS.0]
        m = re.match(
            r"\[(\d+):(\d+)\.(\d+)\s*-->\s*(\d+):(\d+)\.(\d+)\]", line
        )
        if m:
            start = int(m.group(1)) * 60 + int(m.group(2)) + int(m.group(3)) / 10
            end = int(m.group(4)) * 60 + int(m.group(5)) + int(m.group(6)) / 10

            # Collect text lines until blank line or next timestamp
            i += 1
            text_lines = []
            while i < len(lines) and lines[i].strip():
                text_lines.append(lines[i].strip())
                i += 1

            text = " ".join(text_lines)
            if text:
                segments.append({"start": start, "end": end, "text": text})
        i += 1

    return metadata, segments


def generate_segment_audio(
    client: OpenAI,
    text: str,
    voice: str,
    model: str,
    speed: float,
    output_path: str,
):
    """Generate TTS audio for a single text segment via OpenAI API."""
    with client.audio.speech.with_streaming_response.create(
        model=model,
        voice=voice,
        speed=speed,
        input=text,
    ) as response:
        response.stream_to_file(output_path)


def build_voiceover(
    segments: list[dict],
    client: OpenAI,
    voice: str,
    model: str,
    speed: float,
    output_path: str,
):
    """
    Build the full voiceover MP3 with timing aligned to the video.

    Strategy:
      1. Generate TTS audio for each segment via OpenAI.
      2. Build a timeline: insert silence gaps so each segment starts
         at its designated timestamp.
      3. Concatenate everything with ffmpeg into the final MP3.
    """
    if not segments:
        print("  No segments found.")
        return

    total_chars = sum(len(s["text"]) for s in segments)
    print(f"  Segments: {len(segments)}, Characters: {total_chars}")

    with tempfile.TemporaryDirectory() as tmpdir:
        # Step 1: Generate TTS for each segment
        seg_paths = []
        seg_durations = []

        for i, seg in enumerate(segments):
            window_s = seg["end"] - seg["start"]
            label = seg["text"][:65] + ("..." if len(seg["text"]) > 65 else "")

            print(
                f"  [{i + 1:2d}/{len(segments)}] "
                f"{seg['start']:5.1f}s - {seg['end']:5.1f}s "
                f"({window_s:.1f}s window)  {label}"
            )

            seg_path = os.path.join(tmpdir, f"seg_{i:03d}.mp3")
            generate_segment_audio(client, seg["text"], voice, model, speed, seg_path)

            duration = get_audio_duration(seg_path)
            seg_paths.append(seg_path)
            seg_durations.append(duration)

            # Warn if audio overflows the time window
            if duration > window_s + 0.5:
                overflow = duration - window_s
                print(
                    f"         ** overflow: audio is {duration:.1f}s "
                    f"but window is {window_s:.1f}s "
                    f"(+{overflow:.1f}s over)"
                )

        # Step 2: Build the timeline with silence gaps
        # The concat list alternates: [silence, segment, silence, segment, ...]
        concat_parts = []
        cursor = 0.0  # current position in seconds

        for i, seg in enumerate(segments):
            gap = seg["start"] - cursor
            if gap > 0.01:
                # Insert silence from cursor to segment start
                sil_path = os.path.join(tmpdir, f"sil_{i:03d}.mp3")
                generate_silence(gap, sil_path)
                concat_parts.append(sil_path)

            concat_parts.append(seg_paths[i])
            cursor = seg["start"] + seg_durations[i]

        # Add trailing silence to reach the last segment's end time + 1s
        total_target = segments[-1]["end"] + 1.0
        trailing = total_target - cursor
        if trailing > 0.01:
            sil_path = os.path.join(tmpdir, "sil_trailing.mp3")
            generate_silence(trailing, sil_path)
            concat_parts.append(sil_path)

        # Step 3: Write ffmpeg concat list and merge
        list_path = os.path.join(tmpdir, "concat.txt")
        with open(list_path, "w") as f:
            for part in concat_parts:
                f.write(f"file '{part}'\n")

        concatenate_audio(list_path, output_path)

        duration_s = get_audio_duration(output_path)
        size_kb = os.path.getsize(output_path) / 1024
        print(f"  Output: {output_path} ({duration_s:.1f}s, {size_kb:.0f} KB)")


def main():
    parser = argparse.ArgumentParser(
        description="Generate MP3 voiceover from .say files using OpenAI TTS",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python tts_openai.py story-01-what-is-rysh.say
  python tts_openai.py story-*.say --voice echo --model tts-1
  python tts_openai.py story-*.say --output-dir ../voiceovers/

Voices: alloy, ash, ballad, coral, echo, fable, nova, onyx, sage, shimmer
Models: tts-1 (fast, $15/1M chars), tts-1-hd (quality, $30/1M chars)
        """,
    )
    parser.add_argument("files", nargs="+", help=".say file(s) to process")
    parser.add_argument(
        "--voice",
        default="nova",
        choices=[
            "alloy", "ash", "ballad", "coral", "echo",
            "fable", "nova", "onyx", "sage", "shimmer",
        ],
        help="TTS voice (default: nova)",
    )
    parser.add_argument(
        "--model",
        default="tts-1-hd",
        choices=["tts-1", "tts-1-hd"],
        help="TTS model (default: tts-1-hd)",
    )
    parser.add_argument(
        "--speed",
        type=float,
        default=1.0,
        help="Speech speed, 0.25 to 4.0 (default: 1.0)",
    )
    parser.add_argument(
        "--output-dir",
        default=None,
        help="Output directory (default: same directory as input file)",
    )

    args = parser.parse_args()

    # Validate speed
    if not 0.25 <= args.speed <= 4.0:
        print("Error: --speed must be between 0.25 and 4.0")
        sys.exit(1)

    # Check prerequisites
    check_ffmpeg()

    api_key = os.environ.get("OPENAI_API_KEY")
    if not api_key:
        print("Error: OPENAI_API_KEY not set.")
        print("  cp .env.example .env   # then add your key")
        sys.exit(1)

    client = OpenAI()

    processed = 0
    for say_file in args.files:
        if not os.path.exists(say_file):
            print(f"File not found: {say_file}")
            continue

        basename = os.path.basename(say_file)
        print(f"\n{'=' * 60}")
        print(f"Processing: {basename}")
        print(f"{'=' * 60}")

        metadata, segments = parse_say_file(say_file)
        if metadata.get("title"):
            print(f"  Title: {metadata['title']}")

        if not segments:
            print(f"  No segments found, skipping.")
            continue

        # Determine output path
        if args.output_dir:
            os.makedirs(args.output_dir, exist_ok=True)
            stem = os.path.splitext(basename)[0]
            output_path = os.path.join(args.output_dir, f"{stem}.mp3")
        else:
            output_path = say_file.replace(".say", ".mp3")

        build_voiceover(segments, client, args.voice, args.model, args.speed, output_path)
        processed += 1

    print(f"\n{'=' * 60}")
    print(f"Done. Processed {processed} file(s).")
    print(f"Voice: {args.voice}, Model: {args.model}, Speed: {args.speed}")


if __name__ == "__main__":
    main()
