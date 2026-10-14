from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from spectest.cli import _run_parser
from spectest.core import JobError, _parse_qcp_config, _qcp_command, run_job

ROOT = Path(__file__).resolve().parents[1]


class ExecutionModeTests(unittest.TestCase):
    def test_cli_and_job_aliases_use_canonical_names_and_same_binary_flags(self):
        for old, new, flag in (
            ("expand", "entry-exit", "--concrete-bindings"),
            ("no-expand", "all-boundaries", "--spec-test-no-expand"),
        ):
            commands = []
            for mode in (old, new):
                with self.subTest(mode=mode):
                    args = _run_parser().parse_args([
                        "input.c", "--function", "sample", "--binds", "binds.json",
                        "--execution-mode", mode,
                    ])
                    self.assertEqual(args.execution_mode, new)
                    config = _parse_qcp_config(
                        {"qcp": {"execution_mode": mode}}, ROOT, ROOT
                    )
                    self.assertEqual(config.execution_mode, new)
                    commands.append(_qcp_command(
                        config, ROOT / "input.c", "sample", None, ROOT / "vc"
                    ))
                    self.assertIn(flag, commands[-1])
            self.assertEqual(*commands)
        self.assertEqual(_parse_qcp_config({}, ROOT, ROOT).execution_mode, "entry-exit")

    def test_invalid_mode_and_conflicting_policy_are_rejected(self):
        for mode in (None, [], "invalid"):
            with self.subTest(mode=mode), self.assertRaises(JobError):
                _parse_qcp_config({"qcp": {"execution_mode": mode}}, ROOT, ROOT)
        for mode in ("all-boundaries", "no-expand"):
            with self.subTest(mode=mode), self.assertRaises(JobError):
                _parse_qcp_config({"qcp": {
                    "execution_mode": mode, "annotation_policy": "ignore",
                }}, ROOT, ROOT)

    def test_bundled_binary_preserves_behavior_and_reports_canonical_modes(self):
        # A false intermediate assertion distinguishes the two presets.
        with tempfile.TemporaryDirectory(dir=ROOT) as directory:
            root = Path(directory)
            source = root / "input.c"
            source.write_text(
                "int sample(void) /*@ Require emp Ensure __return==2 && emp */ "
                "{ int i=0; while(i<2) { i++; } /*@ Assert i==3 && emp */ return i; }"
            )
            for mode, canonical, expected in (
                ("entry-exit", "entry-exit", "PASS"),
                ("expand", "entry-exit", "PASS"),
                ("all-boundaries", "all-boundaries", "FAIL"),
                ("no-expand", "all-boundaries", "FAIL"),
            ):
                with self.subTest(mode=mode):
                    job = root / "job.json"
                    job.write_text(json.dumps({
                        "source": str(source), "function": "sample",
                        "binds": [{"id": "one", "values": {}}],
                        "qcp": {"execution_mode": mode, "loop_unroll_limit": 4},
                    }))
                    report = run_job(job, root / mode)
                    result = report["results"][0]
                    self.assertEqual(result["status"], expected, result)
                    self.assertEqual(result["mode"], canonical)
                    self.assertTrue(result["execution_completed"])
