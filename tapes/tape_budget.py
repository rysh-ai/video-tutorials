#!/usr/bin/env python3
"""tape_budget.py — the STATIC duration budget of a VHS tape.

This is T2's measuring instrument, not T1's re-timing model. It answers exactly
one question: if VHS honoured every directive at its nominal cost, how long
would this tape run? That number is the denominator of the drift ratio in
RENDERING.md; the numerator is what ffprobe reports about the real mp4.

The budget has three parts:

  Sleep      the literal `Sleep <n><unit>` directives
  typing     `Type "..."` costs len(text) x TypingSpeed
  keys       `Enter`, `Escape`, `Ctrl+p`, `Tab`, ... each cost one TypingSpeed
             tick, and each honours an optional repeat count (`Enter 3`)

VHS also accepts a per-command `@<duration>` override (`Type@50ms "..."`,
`Enter@1s`); it is parsed here because a tape that uses it would otherwise be
mis-budgeted in silence.

Usage:
  ./tape_budget.py tape/story-019-stacked-panes.tape
  ./tape_budget.py tape/*.tape --tsv
"""
# The only python3 on this box is the macOS system 3.9.6 (no `uv` venv is
# provisioned for tapes/ by default), and 3.9 evaluates `float | None`
# annotations at def time. This import defers them so the tool runs there.
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

# `Set TypingSpeed 75ms` — VHS's own default is 50ms when a tape is silent on it.
DEFAULT_TYPING_SPEED = 0.050

DUR_RE = re.compile(r"^\s*([0-9]*\.?[0-9]+)\s*(ms|s|m)?\s*$", re.I)

# Commands that consume one typing tick per press. Sourced from the directives
# the 121 tapes actually use, not from the full VHS grammar.
KEY_CMDS = {
    "Enter", "Escape", "Backspace", "Tab", "Space", "Delete",
    "Up", "Down", "Left", "Right", "PageUp", "PageDown", "Home", "End",
}
KEY_PREFIXES = ("Ctrl+", "Alt+", "Shift+")


def parse_duration(tok: str, default: float | None = None) -> float | None:
    """'750ms' -> 0.75, '3s' -> 3.0, '1m' -> 60.0."""
    m = DUR_RE.match(tok)
    if not m:
        return default
    value, unit = float(m.group(1)), (m.group(2) or "s").lower()
    return value * {"ms": 0.001, "s": 1.0, "m": 60.0}[unit]


def budget(path: Path) -> dict:
    sleep_s = typing_s = keys_s = 0.0
    n_sleep = n_type = n_keys = n_chars = 0
    speed = DEFAULT_TYPING_SPEED
    explicit_speed = False

    for raw in path.read_text(errors="replace").splitlines():
        line = raw.strip()
        # A '#' only starts a comment at the head of a line; the tapes type
        # rysh's own `##` commands, and stripping those would erase real cost.
        if not line or line.startswith("#"):
            continue

        if line.startswith("Set "):
            parts = line.split()
            if len(parts) >= 3 and parts[1] == "TypingSpeed":
                got = parse_duration(parts[2])
                if got is not None:
                    speed, explicit_speed = got, True
            continue

        # Split the command word from any '@<duration>' override.
        head = line.split(None, 1)[0]
        cmd, _, at = head.partition("@")
        override = parse_duration(at) if at else None

        if cmd == "Sleep":
            rest = line.split(None, 1)
            got = parse_duration(rest[1].strip(), 0.0) if len(rest) > 1 else override
            sleep_s += got or 0.0
            n_sleep += 1
            continue

        if cmd == "Type":
            m = re.search(r'"(.*)"\s*$|\'(.*)\'\s*$', line)
            text = (m.group(1) if m and m.group(1) is not None else
                    (m.group(2) if m and m.group(2) is not None else ""))
            per = override if override is not None else speed
            typing_s += len(text) * per
            n_type += 1
            n_chars += len(text)
            continue

        if cmd in KEY_CMDS or cmd.startswith(KEY_PREFIXES):
            # `Enter 3` repeats the press three times.
            tail = line.split()[1:]
            repeat = 1
            if tail and tail[0].isdigit():
                repeat = int(tail[0])
            per = override if override is not None else speed
            keys_s += repeat * per
            n_keys += repeat
            continue

    return {
        "tape": path.name,
        "sleep_s": sleep_s,
        "typing_s": typing_s,
        "keys_s": keys_s,
        "total_s": sleep_s + typing_s + keys_s,
        "n_sleep": n_sleep,
        "n_type": n_type,
        "n_chars": n_chars,
        "n_keys": n_keys,
        "typing_speed_s": speed,
        "typing_speed_explicit": explicit_speed,
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("tapes", nargs="+", type=Path)
    ap.add_argument("--tsv", action="store_true", help="one row per tape, tab separated")
    args = ap.parse_args()

    missing = [t for t in args.tapes if not t.is_file()]
    if missing:
        print(f"no such tape: {missing[0]}", file=sys.stderr)
        return 2

    rows = [budget(t) for t in args.tapes]

    if args.tsv:
        print("tape\tsleep_s\ttyping_s\tkeys_s\ttotal_s")
        for r in rows:
            print(f"{r['tape']}\t{r['sleep_s']:.3f}\t{r['typing_s']:.3f}"
                  f"\t{r['keys_s']:.3f}\t{r['total_s']:.3f}")
        return 0

    for r in rows:
        speed_note = "" if r["typing_speed_explicit"] else "  (VHS default, tape is silent on it)"
        print(f"{r['tape']}")
        print(f"  TypingSpeed      {r['typing_speed_s']*1000:.0f}ms{speed_note}")
        print(f"  Sleep            {r['sleep_s']:8.3f}s  over {r['n_sleep']} directives")
        print(f"  Type             {r['typing_s']:8.3f}s  over {r['n_type']} directives, {r['n_chars']} chars")
        print(f"  keys             {r['keys_s']:8.3f}s  over {r['n_keys']} presses")
        print(f"  STATIC BUDGET    {r['total_s']:8.3f}s")
        print()
    return 0


if __name__ == "__main__":
    sys.exit(main())
