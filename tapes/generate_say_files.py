#!/usr/bin/env python3
"""
Parse VHS .tape files and generate .say voiceover script files.

Each .say file contains timed narration cues extracted from the
tape file's comment blocks, ready for a TTS engine.

Format:
    [MM:SS.0 --> MM:SS.0]
    Narration text to speak in this window.
"""

import re
import os
import glob
import sys

TAPE_DIR = os.path.dirname(os.path.abspath(__file__))


def parse_time(t: str) -> float:
    """Convert 'M:SS' to total seconds."""
    parts = t.split(":")
    return int(parts[0]) * 60 + int(parts[1])


def fmt_time(t: str) -> str:
    """Convert 'M:SS' to 'MM:SS.0' display format."""
    parts = t.split(":")
    return f"{int(parts[0]):02d}:{int(parts[1]):02d}.0"


def extract_sections(lines: list[str]) -> list[dict]:
    """Extract timed narration sections from tape file lines."""
    sections = []
    i = 0
    while i < len(lines):
        line = lines[i].rstrip("\n")

        # Detect separator: # ====...====
        if re.match(r"^# ={4,}$", line):
            i += 1
            if i >= len(lines):
                break

            # Next line should have timestamp: # 0:00-0:03  Description
            header = lines[i].rstrip("\n")
            ts_match = re.match(r"^#\s+(\d+:\d+)-(\d+:\d+)\s+(.*)", header)

            if ts_match:
                start = ts_match.group(1)
                end = ts_match.group(2)
                desc = ts_match.group(3).strip()
                i += 1

                # Collect narration lines (quoted text)
                narration_parts = []
                in_quote = False

                while i < len(lines):
                    line = lines[i].rstrip("\n")
                    if re.match(r"^# ={4,}$", line):
                        break

                    if not in_quote:
                        # Start of quote: # "text  or  # "text"
                        qm = re.match(r'^#\s+"(.*)', line)
                        if qm:
                            text = qm.group(1)
                            if text.endswith('"'):
                                # Single-line quote: # "text"
                                narration_parts.append(text[:-1])
                            else:
                                narration_parts.append(text)
                                in_quote = True
                    else:
                        # Continuation line: #  text  or  #  text"
                        cm = re.match(r"^#\s+(.*)", line)
                        if cm:
                            text = cm.group(1)
                            if text.endswith('"'):
                                narration_parts.append(text[:-1])
                                in_quote = False
                            else:
                                narration_parts.append(text)
                        else:
                            # Non-comment line inside quote — shouldn't happen, close quote
                            in_quote = False

                    i += 1

                narration = " ".join(narration_parts).strip()
                if narration:
                    duration = parse_time(end) - parse_time(start)
                    sections.append(
                        {
                            "start": start,
                            "end": end,
                            "duration": duration,
                            "desc": desc,
                            "text": narration,
                        }
                    )
            else:
                i += 1
        else:
            i += 1

    return sections


def extract_metadata(lines: list[str]) -> tuple[str, str, str]:
    """Extract title, hook, and duration from file header."""
    title = ""
    hook = ""
    duration = ""

    for line in lines:
        line = line.rstrip("\n")
        # Title: # Story N: Title (Xs)
        tm = re.match(r"^# (Story \d+:.+)$", line)
        if tm:
            title = tm.group(1)
            # Extract duration from parentheses
            dm = re.search(r"\((\d+s)\)", title)
            if dm:
                duration = dm.group(1)

        # Hook: # Hook: "text"
        hm = re.match(r'^# Hook:\s+"?(.*?)"?\s*$', line)
        if hm:
            hook = hm.group(1)

    return title, hook, duration


def generate_say_file(tape_path: str) -> tuple[str, int]:
    """Generate a .say file from a .tape file. Returns (say_path, segment_count)."""
    with open(tape_path) as f:
        lines = f.readlines()

    title, hook, duration = extract_metadata(lines)
    sections = extract_sections(lines)

    say_path = tape_path.replace(".tape", ".say")
    basename = os.path.basename(tape_path)

    with open(say_path, "w") as f:
        f.write(f"# {title}\n")
        if hook:
            f.write(f"# Hook: {hook}\n")
        if duration:
            f.write(f"# Duration: {duration}\n")
        f.write(f"# Source: {basename}\n")
        f.write(f"#\n")
        f.write(f"# Voiceover script with timing cues.\n")
        f.write(f"# Format: [START --> END] narration text\n")
        f.write(f"# Each entry should be spoken within its time window.\n")
        f.write(f"# Gaps between entries are silent (viewer watches the demo).\n")
        f.write(f"#\n")
        f.write(f"# Total segments: {len(sections)}\n")
        f.write(f"\n")

        for sec in sections:
            window = sec["duration"]
            f.write(f"[{fmt_time(sec['start'])} --> {fmt_time(sec['end'])}]\n")
            f.write(f"{sec['text']}\n")
            f.write(f"\n")

    return say_path, len(sections)


def main():
    tape_files = sorted(glob.glob(os.path.join(TAPE_DIR, "story-*.tape")))

    if not tape_files:
        print(f"No story-*.tape files found in {TAPE_DIR}")
        sys.exit(1)

    total_segments = 0
    for tape_path in tape_files:
        say_path, count = generate_say_file(tape_path)
        total_segments += count
        print(f"  {os.path.basename(say_path):50s}  {count:2d} segments")

    print(f"\nGenerated {len(tape_files)} .say files ({total_segments} total segments)")


if __name__ == "__main__":
    main()
