#!/usr/bin/env python3
"""
Merge MP3 voiceover audio onto MP4 video to produce .vover.mp4 files.

Usage:
    # Single file (auto-matches mp3 by name)
    python merge_voiceover.py story-05-tabs-and-panes.mp4

    # Multiple files
    python merge_voiceover.py story-01-*.mp4 story-02-*.mp4

    # All files
    python merge_voiceover.py story-*.mp4

    # Custom output directory
    python merge_voiceover.py story-*.mp4 --output-dir ../final/

    # Adjust voiceover volume (default 1.0)
    python merge_voiceover.py story-*.mp4 --volume 1.2

Requirements:
    brew install ffmpeg
"""

import argparse
import json
import os
import shutil
import subprocess
import sys


def check_ffmpeg():
    """Verify ffmpeg is installed."""
    if not shutil.which("ffmpeg") or not shutil.which("ffprobe"):
        print("Error: ffmpeg is not installed.")
        print("  brew install ffmpeg")
        sys.exit(1)


def get_duration(path: str) -> float:
    """Get media file duration in seconds."""
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
    if result.returncode != 0:
        return 0.0
    info = json.loads(result.stdout)
    return float(info["format"]["duration"])


def merge_video_audio(
    video_path: str,
    audio_path: str,
    output_path: str,
    volume: float = 1.0,
):
    """
    Merge MP3 voiceover onto MP4 video.

    - Video is copied without re-encoding (fast).
    - Audio is mixed: if the video already has audio, both tracks are merged.
      If not, the voiceover is the sole audio track.
    - If voiceover is shorter than video, silence fills the rest.
    - If voiceover is longer than video, it's truncated to video length.
    """
    video_dur = get_duration(video_path)
    audio_dur = get_duration(audio_path)

    # Build volume filter
    vol_filter = f"volume={volume}" if volume != 1.0 else None

    # Check if video has an existing audio stream
    probe = subprocess.run(
        [
            "ffprobe",
            "-v", "quiet",
            "-print_format", "json",
            "-show_streams",
            "-select_streams", "a",
            video_path,
        ],
        capture_output=True,
        text=True,
    )
    has_audio = len(json.loads(probe.stdout).get("streams", [])) > 0

    if has_audio:
        # Mix existing audio with voiceover
        filter_parts = []
        if vol_filter:
            filter_parts.append(f"[1:a]{vol_filter}[vo];[0:a][vo]amix=inputs=2:duration=first")
        else:
            filter_parts.append("[0:a][1:a]amix=inputs=2:duration=first")

        cmd = [
            "ffmpeg", "-y",
            "-i", video_path,
            "-i", audio_path,
            "-filter_complex", filter_parts[0],
            "-c:v", "copy",
            "-c:a", "aac",
            "-b:a", "192k",
            "-shortest",
            output_path,
        ]
    else:
        # No existing audio — use voiceover as sole audio track
        if vol_filter:
            cmd = [
                "ffmpeg", "-y",
                "-i", video_path,
                "-i", audio_path,
                "-af", vol_filter,
                "-c:v", "copy",
                "-c:a", "aac",
                "-b:a", "192k",
                "-shortest",
                output_path,
            ]
        else:
            cmd = [
                "ffmpeg", "-y",
                "-i", video_path,
                "-i", audio_path,
                "-c:v", "copy",
                "-c:a", "aac",
                "-b:a", "192k",
                "-shortest",
                output_path,
            ]

    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"    ffmpeg error: {result.stderr[-300:]}")
        return False

    return True


def main():
    parser = argparse.ArgumentParser(
        description="Merge MP3 voiceover onto MP4 video → .vover.mp4",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python merge_voiceover.py story-05-tabs-and-panes.mp4
  python merge_voiceover.py story-*.mp4 --volume 1.2
  python merge_voiceover.py story-*.mp4 --output-dir ../final/
        """,
    )
    parser.add_argument("files", nargs="+", help=".mp4 file(s) to process")
    parser.add_argument(
        "--volume",
        type=float,
        default=1.0,
        help="Voiceover volume multiplier (default: 1.0)",
    )
    parser.add_argument(
        "--output-dir",
        default=None,
        help="Output directory (default: same directory as input file)",
    )

    args = parser.parse_args()

    check_ffmpeg()

    processed = 0
    skipped = 0
    failed = 0

    for mp4_file in sorted(args.files):
        if not os.path.exists(mp4_file):
            print(f"  Video not found: {mp4_file}")
            skipped += 1
            continue

        # Skip files that are already voiceover outputs
        if mp4_file.endswith(".vover.mp4"):
            continue

        # Derive the matching MP3 path
        base = mp4_file.rsplit(".mp4", 1)[0]
        mp3_file = f"{base}.mp3"

        if not os.path.exists(mp3_file):
            print(f"  Audio not found: {mp3_file} — skipping")
            skipped += 1
            continue

        # Determine output path
        if args.output_dir:
            os.makedirs(args.output_dir, exist_ok=True)
            out_name = os.path.basename(base) + ".vover.mp4"
            output_path = os.path.join(args.output_dir, out_name)
        else:
            output_path = f"{base}.vover.mp4"

        video_dur = get_duration(mp4_file)
        audio_dur = get_duration(mp3_file)

        print(
            f"  [{processed + skipped + failed + 1:2d}] "
            f"{os.path.basename(mp4_file):45s} "
            f"video={video_dur:.1f}s  audio={audio_dur:.1f}s"
        )

        ok = merge_video_audio(mp4_file, mp3_file, output_path, args.volume)

        if ok:
            out_dur = get_duration(output_path)
            size_mb = os.path.getsize(output_path) / (1024 * 1024)
            print(f"       → {os.path.basename(output_path)} ({out_dur:.1f}s, {size_mb:.1f} MB)")
            processed += 1
        else:
            print(f"       ✗ FAILED")
            failed += 1

    print(f"\nDone. Processed: {processed}, Skipped: {skipped}, Failed: {failed}")


if __name__ == "__main__":
    main()
