from __future__ import annotations

import json
from pathlib import Path
import runpy
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
EXPERIMENT = (
    ROOT
    / "benchmark/experiments/multidomain-four-class-tool-policy-20260730"
)
BUILD = EXPERIMENT / "build_datasets.py"
ANALYZE = EXPERIMENT / "analyze_results.py"


class ToolPolicyExperimentTests(unittest.TestCase):
    def test_skill_variants_share_the_decision_procedure(self) -> None:
        enabled = (
            EXPERIMENT
            / "conditions/four-class-tool-enabled/SKILL.md"
        ).read_text(encoding="utf-8")
        forbidden = (
            EXPERIMENT
            / "conditions/four-class-tool-forbidden/SKILL.md"
        ).read_text(encoding="utf-8")
        marker = "## Decision procedure\n"
        self.assertEqual(
            enabled.split(marker, 1)[1],
            forbidden.split(marker, 1)[1],
        )

    def test_builder_preserves_inputs_and_removes_lineage_hints(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-tool-policy-") as temp:
            output = Path(temp) / "dataset"
            completed = subprocess.run(
                [
                    sys.executable,
                    str(BUILD),
                    "--output-root",
                    str(output),
                ],
                cwd=ROOT,
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(completed.returncode, 0, completed.stderr)
            for question_id in ("h01", "h02", "h03", "h04"):
                for relative in (
                    "input/impl.c",
                    "input/spec.qcp",
                    "dependencies/definitions.v",
                    "dependencies/SEMANTICS.md",
                ):
                    enabled = (
                        output / "tool-enabled" / question_id / relative
                    ).read_bytes()
                    forbidden = (
                        output / "tool-forbidden" / question_id / relative
                    ).read_bytes()
                    self.assertEqual(enabled, forbidden)
                task = (
                    output / "tool-enabled" / question_id / "TASK.md"
                ).read_text(encoding="utf-8")
                self.assertNotIn("mutant", task.lower())
                self.assertNotIn("two implementations", task.lower())
            gold = json.loads(
                (output / "tool-enabled/gold.json").read_text(encoding="utf-8")
            )
            self.assertEqual(gold["questions"]["h02"]["label"], "complete")
            self.assertEqual(gold["questions"]["h03"]["label"], "soundness")

    def test_trace_audit_distinguishes_reads_and_successful_probe(self) -> None:
        module = runpy.run_path(str(ANALYZE))
        trace = [
            {
                "kind": "ObservationEvent",
                "tool_name": "terminal",
                "command": "sed -n '1,200p' impl.c spec.qcp",
                "exit_code": 0,
                "is_error": False,
            },
            {
                "kind": "ObservationEvent",
                "tool_name": "terminal",
                "command": "cc harness.c impl.c -o harness && ./harness",
                "exit_code": 0,
                "is_error": False,
            },
        ]
        self.assertTrue(module["successful_read"](trace, "impl.c"))
        self.assertTrue(module["successful_read"](trace, "spec.qcp"))
        self.assertTrue(module["successful_probe"](trace))
        trace[1]["exit_code"] = 1
        self.assertFalse(module["successful_probe"](trace))


if __name__ == "__main__":
    unittest.main()
