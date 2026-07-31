from __future__ import annotations

import hashlib
import json
from pathlib import Path
import runpy
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
EXPERIMENT = ROOT / "benchmark/experiments/spec-synthesis-tester-ablation-20260731"


class BidirectionalSynthesisTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.runner = runpy.run_path(str(EXPERIMENT / "run.py"))
        cls.checker = runpy.run_path(str(EXPERIMENT / "syntax_checker.py"))

    def test_dataset_manifest_locks_public_and_hidden_artifacts(self) -> None:
        manifest = json.loads(
            (EXPERIMENT / "dataset-manifest.json").read_text(encoding="utf-8")
        )
        self.assertEqual(manifest["judge"]["training_cases"], 0)
        self.assertEqual(manifest["judge"]["hidden_bind_count"], 30)
        self.assertEqual(manifest["judge"]["hidden_mutant_count"], 12)
        self.assertFalse(manifest["public_interface"]["semantic_feedback"])
        for relative, expected in manifest["sha256"].items():
            path = (
                ROOT / relative
                if relative.startswith("e2e/")
                else EXPERIMENT / relative
            )
            self.assertEqual(
                hashlib.sha256(path.read_bytes()).hexdigest(),
                expected,
                msg=relative,
            )

    def test_hidden_suite_is_six_groups_of_five_without_prompt_leakage(self) -> None:
        split, binds = self.runner["load_protocol"]()
        self.assertEqual(len(split["groups"]), 6)
        self.assertTrue(all(len(group["cases"]) == 5 for group in split["groups"]))
        self.assertEqual(len(binds), 30)

        prompts = (
            self.runner["task_prompt"]("code-to-spec"),
            self.runner["task_prompt"]("spec-to-code"),
        )
        mutant_names = {
            path.name
            for directory in self.runner["MUTANT_DIRS"]
            for path in directory.glob("*.c")
        }
        for prompt in prompts:
            self.assertTrue(all(item["id"] not in prompt for item in binds))
            self.assertTrue(all(name not in prompt for name in mutant_names))

    def test_public_syntax_checkers_accept_both_gold_artifacts(self) -> None:
        spec_report = self.checker["check_spec"](
            EXPERIMENT / "input/impl.c",
            EXPERIMENT / "input/spec.qcp",
            "ModeConvert_AMMFun",
        )
        self.assertTrue(spec_report["syntax_valid"])

        with tempfile.TemporaryDirectory(prefix="tespec-code-syntax-test-") as temp:
            code = Path(temp) / "candidate.c"
            code.write_text(self.runner["gold_function"](), encoding="utf-8")
            code_report = self.checker["check_code"](
                EXPERIMENT / "input/interface.h",
                code,
                "ModeConvert_AMMFun",
            )
        self.assertTrue(code_report["syntax_valid"])
        self.assertNotIn("bind", json.dumps(spec_report).lower())

    def test_public_spec_checker_rejects_malformed_qcp(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-spec-syntax-test-") as temp:
            candidate = Path(temp) / "candidate.qcp"
            candidate.write_text(
                "With (x: Z)\nRequire (\nEnsure true\n",
                encoding="utf-8",
            )
            report = self.checker["check_spec"](
                EXPERIMENT / "input/impl.c",
                candidate,
                "ModeConvert_AMMFun",
            )
        self.assertFalse(report["syntax_valid"])

    def test_public_spec_checker_does_not_return_a_semantic_verdict(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-spec-syntax-only-") as temp:
            candidate = Path(temp) / "candidate.qcp"
            candidate.write_text(
                "With (v: Z)\n"
                "Require x == v && v < 2147483647\n"
                "Ensure __return == v + 999\n",
                encoding="utf-8",
            )
            report = self.checker["check_spec"](
                EXPERIMENT / "demo/add_one.c",
                candidate,
                "add_one",
            )
        self.assertTrue(report["syntax_valid"])
        self.assertEqual(
            set(report),
            {"schema", "syntax_valid", "stage", "diagnostic"},
        )

    def test_gold_artifacts_pass_both_hidden_directions(self) -> None:
        split, binds = self.runner["load_protocol"]()
        with tempfile.TemporaryDirectory(prefix="tespec-bidirectional-oracle-") as temp:
            report = self.runner["oracle_audit"](Path(temp), split, binds)
        self.assertTrue(report["code_to_spec"]["correct"])
        self.assertTrue(report["spec_to_code"]["correct"])
        self.assertEqual(
            [item["score"] for item in report["code_to_spec"]["groups"]],
            [1.0] * 6,
        )
        self.assertEqual(
            [item["score"] for item in report["spec_to_code"]["groups"]],
            [1.0] * 6,
        )


if __name__ == "__main__":
    unittest.main()
