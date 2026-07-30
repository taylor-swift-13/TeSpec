from __future__ import annotations

import hashlib
import json
from pathlib import Path
import runpy
import unittest


ROOT = Path(__file__).resolve().parents[1]
EXPERIMENT = ROOT / "benchmark/experiments/codex-nano-binds-ablation-20260731"
FIXTURES = (
    ROOT / "benchmark/experiments/switch-four-class-binds-ablation-20260730/fixtures"
)


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


class CodexNanoAblationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.runner = runpy.run_path(str(EXPERIMENT / "run.py"))
        cls.manifest = json.loads(
            (EXPERIMENT / "dataset-manifest.json").read_text(encoding="utf-8")
        )
        cls.report = json.loads(
            (EXPERIMENT / "report.json").read_text(encoding="utf-8")
        )

    def test_exact_six_case_binds_are_required(self) -> None:
        binds = [
            {
                "id": f"case_{index:03d}",
                "args": {"n": value},
                "values": {"N": value},
            }
            for index, value in enumerate((-1, 0, 1, 2, 9, 10), start=1)
        ]
        self.assertTrue(self.runner["validate_binds"](binds)["valid"])
        binds[-1]["values"]["N"] = 9
        self.assertFalse(self.runner["validate_binds"](binds)["valid"])

    def test_manifest_locks_two_input_mutation_group(self) -> None:
        self.assertEqual(
            self.manifest["original_semantic_inputs"],
            ["impl.c", "spec.qcp"],
        )
        self.assertEqual(
            {
                question_id: item["label"]
                for question_id, item in self.manifest["questions"].items()
            },
            {
                "q01": "correct",
                "q02": "complete",
                "q03": "soundness",
                "q04": "incomparable",
            },
        )
        for question_id, item in self.manifest["questions"].items():
            self.assertEqual(item["impl_sha256"], sha256(FIXTURES / "impl.c"))
            self.assertEqual(
                item["spec_sha256"],
                sha256(FIXTURES / f"{question_id}.qcp"),
            )
        protocol = self.manifest["protocol_artifacts"]
        self.assertEqual(protocol["runner_sha256"], sha256(EXPERIMENT / "run.py"))
        self.assertEqual(
            protocol["label_schema_sha256"],
            sha256(EXPERIMENT / "output-schema.json"),
        )
        self.assertEqual(
            protocol["binds_schema_sha256"],
            sha256(EXPERIMENT / "binds-output-schema.json"),
        )

    def test_checked_report_preserves_observed_comparison(self) -> None:
        self.assertTrue(self.report["valid"])
        self.assertEqual(self.report["tool_enabled"]["strict_adherent_attempts"], 12)
        self.assertTrue(self.report["tool_enabled"]["all_binds_valid"])
        self.assertTrue(self.report["tool_enabled"]["all_reports_valid"])
        self.assertEqual(self.report["comparison"]["tool_correct"], 8)
        self.assertEqual(self.report["comparison"]["no_tool_correct"], 9)
        self.assertAlmostEqual(
            self.report["comparison"]["tool_minus_no_tool_allocated_accuracy"],
            -1 / 12,
        )


if __name__ == "__main__":
    unittest.main()
