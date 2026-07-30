from __future__ import annotations

from pathlib import Path
import runpy
import unittest


ROOT = Path(__file__).resolve().parents[1]
EXPERIMENT = (
    ROOT
    / "benchmark/experiments/multidomain-four-class-tool-policy-20260730"
)
ANALYZE = EXPERIMENT / "analyze_results.py"


class ToolPolicyExperimentTests(unittest.TestCase):
    def test_experiments_do_not_publish_skill_snapshots(self) -> None:
        snapshots = list(
            (ROOT / "benchmark/experiments").glob(
                "*/conditions/*/SKILL.md"
            )
        )
        self.assertEqual(snapshots, [])

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
