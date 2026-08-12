#!/usr/bin/env python3
"""
Tests for retime_tapes.py.

Run:  python3 tapes/test_retime_tapes.py        (stdlib unittest, no pytest needed)

These pin the contract T1 needs: the *shape* comes from the `# M:SS-M:SS`
section headers, the *scale* comes from the narration mp3, `Type`/key lines
survive byte-for-byte, their typing cost is charged against the section budget
before any `Sleep` is distributed, and no `Sleep` is ever emitted at zero or
below.
"""

from __future__ import annotations

import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import retime_tapes as rt  # noqa: E402  (module under test may not exist yet)


HERE = os.path.dirname(os.path.abspath(__file__))


# A synthetic tape with a 1:3 shape: 0:00-0:05 then 0:05-0:20.
SYNTHETIC = """\
Output demo.mp4

Set FontSize 16
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:05  First beat
# "narration line one"
# ============================================================
Type "abcd"
Enter
Sleep 2s

# ============================================================
# 0:05-0:20  Second beat
# "narration line two"
# ============================================================
Type "efgh"
Enter
Sleep 3s
Escape
Sleep 6s
"""


class TestDurationHelpers(unittest.TestCase):
    def test_parse_duration_units(self):
        self.assertAlmostEqual(rt.parse_duration("2s"), 2.0)
        self.assertAlmostEqual(rt.parse_duration("0.3s"), 0.3)
        self.assertAlmostEqual(rt.parse_duration("500ms"), 0.5)
        self.assertAlmostEqual(rt.parse_duration("1m"), 60.0)

    def test_format_duration_keeps_round_values_tidy(self):
        self.assertEqual(rt.format_duration(2.0), "2s")
        self.assertEqual(rt.format_duration(0.3), "0.3s")
        self.assertEqual(rt.format_duration(2.35), "2.35s")

    def test_format_parse_roundtrip(self):
        for v in (0.1, 0.3, 1.0, 2.35, 12.07):
            self.assertAlmostEqual(rt.parse_duration(rt.format_duration(v)), v, places=2)


class TestHeaderParsing(unittest.TestCase):
    def test_parse_section_header(self):
        self.assertEqual(rt.parse_header("# 0:04-0:10  Launch rysh"), (4.0, 10.0))
        self.assertEqual(rt.parse_header("# 1:05-1:20  Later beat"), (65.0, 80.0))

    def test_non_header_comments_are_not_headers(self):
        self.assertIsNone(rt.parse_header('# "A terminal that thinks."'))
        self.assertIsNone(rt.parse_header("# ============================"))
        self.assertIsNone(rt.parse_header("Sleep 2s"))

    def test_sections_take_their_weight_from_the_header_span(self):
        tape = rt.parse_tape(SYNTHETIC)
        self.assertEqual(len(tape.sections), 2)
        self.assertAlmostEqual(tape.sections[0].weight, 5.0)
        self.assertAlmostEqual(tape.sections[1].weight, 15.0)


class TestTypingCost(unittest.TestCase):
    def test_type_costs_characters_times_tape_typing_speed(self):
        tape = rt.parse_tape(SYNTHETIC)
        self.assertAlmostEqual(tape.typing_speed, 0.075)
        # `Type "abcd"` -> 4 chars * 75ms
        self.assertAlmostEqual(rt.directive_cost('Type "abcd"', 0.075), 0.3)

    def test_type_honours_per_directive_speed_override(self):
        # `Type@40ms "abc"` -> 3 chars * 40ms, ignoring the tape-level speed
        self.assertAlmostEqual(rt.directive_cost('Type@40ms "abc"', 0.075), 0.12)

    def test_key_press_costs_one_typing_unit(self):
        self.assertAlmostEqual(rt.directive_cost("Enter", 0.075), 0.075)
        self.assertAlmostEqual(rt.directive_cost("Escape", 0.075), 0.075)
        self.assertAlmostEqual(rt.directive_cost("Ctrl+p", 0.075), 0.075)

    def test_settings_and_sleeps_cost_nothing_here(self):
        # Sleep is the adjustable budget, not fixed cost; Set/Output are free.
        self.assertAlmostEqual(rt.directive_cost("Sleep 3s", 0.075), 0.0)
        self.assertAlmostEqual(rt.directive_cost("Set FontSize 16", 0.075), 0.0)
        self.assertAlmostEqual(rt.directive_cost("Output demo.mp4", 0.075), 0.0)
        self.assertAlmostEqual(rt.directive_cost('# 0:04-0:10  Launch', 0.075), 0.0)

    def test_section_fixed_cost_is_the_sum_of_its_typing(self):
        tape = rt.parse_tape(SYNTHETIC)
        # Type "abcd" (0.3) + Enter (0.075)
        self.assertAlmostEqual(tape.sections[0].fixed_cost, 0.375)
        # Type "efgh" (0.3) + Enter (0.075) + Escape (0.075)
        self.assertAlmostEqual(tape.sections[1].fixed_cost, 0.45)


class TestRetime(unittest.TestCase):
    def test_predicted_duration_hits_the_target(self):
        out, report = rt.retime_tape_text(SYNTHETIC, 30.0)
        self.assertAlmostEqual(rt.predict_duration(out), 30.0, places=1)
        self.assertAlmostEqual(report.predicted, 30.0, places=1)
        self.assertTrue(report.ok)

    def test_type_and_key_lines_are_preserved_byte_for_byte(self):
        out, _ = rt.retime_tape_text(SYNTHETIC, 30.0)
        for line in ('Type "abcd"', 'Type "efgh"', "Enter", "Escape",
                     "Set TypingSpeed 75ms", 'Set Shell "bash"', "Output demo.mp4"):
            self.assertIn(line + "\n", out, "lost or mangled: %r" % line)
        # comment/banner lines survive too
        self.assertIn("# 0:05-0:20  Second beat\n", out)

    def test_section_proportions_follow_the_header_shape(self):
        out, _ = rt.retime_tape_text(SYNTHETIC, 30.0)
        tape = rt.parse_tape(out)
        d0 = tape.sections[0].current_duration()
        d1 = tape.sections[1].current_duration()
        # header shape is 5:15 == 1:3
        self.assertAlmostEqual(d1 / d0, 3.0, places=1)

    def test_typing_cost_is_subtracted_before_sleep_is_distributed(self):
        out, _ = rt.retime_tape_text(SYNTHETIC, 30.0)
        tape = rt.parse_tape(out)
        s0 = tape.sections[0]
        # section total == typing + sleep, so sleep is short by the typing cost
        self.assertAlmostEqual(s0.sleep_total() + s0.fixed_cost,
                               s0.current_duration(), places=3)
        self.assertLess(s0.sleep_total(), s0.current_duration())

    def test_never_emits_a_zero_or_negative_sleep(self):
        # 1s is far below the tape's floor: every sleep must clamp, not go <= 0.
        out, report = rt.retime_tape_text(SYNTHETIC, 1.0)
        tape = rt.parse_tape(out)
        for sec in tape.sections:
            for value in sec.sleep_values():
                self.assertGreaterEqual(value, rt.MIN_SLEEP)
                self.assertGreater(value, 0.0)
        self.assertFalse(report.ok)
        self.assertTrue(report.clamped_sections,
                        "an unreachable target must be recorded, not silently missed")

    def test_rewrite_is_idempotent(self):
        once, _ = rt.retime_tape_text(SYNTHETIC, 30.0)
        twice, _ = rt.retime_tape_text(once, 30.0)
        self.assertEqual(once, twice)

    def test_preamble_pre_roll_counts_against_the_total(self):
        # The `Sleep 1s` before the first section is real recorded time, and the
        # voiceover starts at t=0 (merge_voiceover.py mixes with no delay), so it
        # must be inside the budget, not added on top of it.
        out, _ = rt.retime_tape_text(SYNTHETIC, 30.0)
        tape = rt.parse_tape(out)
        self.assertAlmostEqual(tape.preamble_duration(), 1.0, places=3)
        self.assertAlmostEqual(
            tape.preamble_duration() + sum(s.current_duration() for s in tape.sections),
            30.0, places=1)


class TestRealTape(unittest.TestCase):
    TAPE = os.path.join(HERE, "tape", "story-001-what-is-rysh.tape")

    def test_real_tape_retimes_to_its_narration_length(self):
        with open(self.TAPE) as fh:
            text = fh.read()
        target = 63.23  # story-001's narration length, per E5-video.md §1
        out, report = rt.retime_tape_text(text, target)
        self.assertLess(abs(report.predicted - target), 1.0)
        self.assertLess(abs(rt.predict_duration(out) - target), 1.0)
        self.assertTrue(report.ok)

    def test_real_tape_keeps_every_non_sleep_line(self):
        with open(self.TAPE) as fh:
            text = fh.read()
        out, _ = rt.retime_tape_text(text, 63.23)
        before = [ln for ln in text.splitlines() if not ln.startswith("Sleep ")]
        after = [ln for ln in out.splitlines() if not ln.startswith("Sleep ")]
        self.assertEqual(before, after)


class TestReportHonesty(unittest.TestCase):
    """
    The report is the deliverable non-engineers read, so its caveats are part of
    the contract, not prose. worker-2's render measurement (static budget
    20.550s -> 2.000s actual, drift 0.097; 0.354 on 2026-05-29) means a re-timed
    tape is still an unvalidated model, and the report has to say so.
    """

    def _report(self):
        import tempfile
        out, report = rt.retime_tape_text(SYNTHETIC, 30.0, name="synthetic")
        _, miss = rt.retime_tape_text(SYNTHETIC, 1.0, name="synthetic-miss")
        path = os.path.join(tempfile.mkdtemp(), "REPORT.md")
        rt.write_report(path, [report, miss], rt.TOLERANCE)
        with open(path) as fh:
            return fh.read()

    def test_report_says_it_is_unvalidated_and_cites_the_measurement(self):
        text = self._report()
        self.assertIn("NOT been validated by rendering", text)
        self.assertIn("20.550s", text)
        self.assertIn("2.000s", text)
        self.assertIn("0.097", text)
        self.assertIn("0.354", text)
        self.assertIn("worker-2", text)
        self.assertIn("no constant correction factor exists", text)

    def test_report_does_not_claim_qc_will_pass(self):
        text = self._report()
        self.assertIn("will not make the 111 masters pass QC", text)
        lowered = text.lower()
        for forbidden in ("now correctly timed", "qc now passes", "qc will pass",
                          "the overrun is fixed", "narration overrun is fixed"):
            self.assertNotIn(forbidden, lowered, "report over-claims: %r" % forbidden)

    def test_report_names_the_scale_source(self):
        # The scale is a measured input, and the report must say which one.
        text = self._report()
        self.assertIn("ffprobe", text)
        self.assertIn("say/*.mp3", text)


if __name__ == "__main__":
    unittest.main(verbosity=2)
