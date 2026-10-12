"""Prevent failed baseline setup/generation from inflating bug counts."""

import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location(
    "allocator",
    Path(__file__).resolve().parents[1] / "scripts/run-allocator-baseline.py",
)
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)
ANALYSIS_SPEC = importlib.util.spec_from_file_location(
    "allocator_analysis",
    Path(__file__).resolve().parents[1] / "scripts/analyze-allocator-baseline.py",
)
ANALYSIS = importlib.util.module_from_spec(ANALYSIS_SPEC)
ANALYSIS_SPEC.loader.exec_module(ANALYSIS)
QCP_SPEC = importlib.util.spec_from_file_location(
    "qcp_baseline",
    Path(__file__).resolve().parents[1] / "scripts/run-qcp-baseline-smoke.py",
)
QCP = importlib.util.module_from_spec(QCP_SPEC)
QCP_SPEC.loader.exec_module(QCP)
CONTROL_SPEC = importlib.util.spec_from_file_location(
    "allocator_controls",
    Path(__file__).resolve().parents[1] / "scripts/compare-allocator-controls.py",
)
CONTROLS = importlib.util.module_from_spec(CONTROL_SPEC)
CONTROL_SPEC.loader.exec_module(CONTROLS)
NATIVE_SPEC = importlib.util.spec_from_file_location(
    "native_allocator",
    Path(__file__).resolve().parents[1] / "scripts/archive-native-allocator.py",
)
NATIVE = importlib.util.module_from_spec(NATIVE_SPEC)
NATIVE_SPEC.loader.exec_module(NATIVE)


class BaselineClassificationTests(unittest.TestCase):
    def test_native_build_errors_cannot_count_as_runtime_failures(self):
        classify = NATIVE.native.native_outcome
        self.assertEqual(classify("build", 1, "Failed at"), "BUILD_ERROR")
        self.assertEqual(classify("execution", 2, "Failed at"), "RUNTIME_CHECK_FAILURE")
        self.assertEqual(
            classify("execution", 1, "segmentation fault"), "NATIVE_EXECUTION_ERROR"
        )
        self.assertEqual(
            classify("execution", "TIMEOUT", "Failed at"), "EXECUTION_TIMEOUT"
        )

    def test_native_archive_rejects_missing_stages_duplicates_and_tampering(self):
        stages = [
            dict(stage=name, returncode=0, wall_seconds=1, log_sha256=NATIVE.sha(b""))
            for name in [
                "checkout",
                "patch",
                "preprocess",
                "instrument",
                "build",
                "execution",
            ]
        ]
        row = dict(case=1, stages=stages, status="NATIVE_CHECKS_PASSED")
        report = dict(scope="test", selected_cases=[1], runs=[row])
        self.assertTrue(NATIVE.analyze(report, lambda _: b"")["inventory_complete"])
        with self.assertRaisesRegex(ValueError, "hash"):
            NATIVE.analyze(report, lambda _: b"changed")
        with self.assertRaisesRegex(ValueError, "duplicate"):
            NATIVE.analyze(dict(report, runs=[row, row]), lambda _: b"")
        with self.assertRaisesRegex(ValueError, "incomplete"):
            NATIVE.analyze(
                dict(report, runs=[dict(row, stages=stages[:-1])]), lambda _: b""
            )

    def test_qcp_uses_target_obligations_not_an_unrelated_proved_main(self):
        output = {
            "result": "success",
            "verificationStatus": "proved",
            "WitnessList": [
                {
                    "functionName": name,
                    "Witness": {
                        "total_witness_count": {"auto_solved": 4, "manual": manual}
                    },
                }
                for name, manual in [("sample", 1), ("main", 0)]
            ],
        }
        self.assertEqual(QCP.target_outcome(0, output, "sample")[0], "RESIDUAL")
        self.assertEqual(
            QCP.target_outcome(0, output, "missing")[0], "MISSING_OR_DUPLICATE_TARGET"
        )
        self.assertEqual(QCP.target_outcome(1, output, "main")[0], "TOOL_ERROR")

    def test_control_pairing_requires_matching_inputs_and_a_passed_control(self):
        config = {
            "source_revision": "revision",
            "catalog_sha256": "catalog",
            "switch": "switch",
            "samples": 10,
            "trials": 1,
            "timeout_seconds": 120,
            "selected_cases": [1],
            "seed_policy": "trial index",
            "engines": ["darcy"],
        }
        raw = {
            "case": 1,
            "engine": "darcy",
            "trial": 0,
            "seed": 0,
            "command": ["driver", "--seed=0"],
            "entry": {"fut": "sample"},
        }
        buggy = dict(config, variant="buggy", runs=[raw])
        controls = dict(config, variant="correct", runs=[dict(raw)])
        failure = {"runs": [dict(raw, status="TEST_FAILURE_REPORTED")]}
        passed = {"runs": [dict(raw, status="SAMPLES_PASSED")]}
        paired = CONTROLS.pair_runs(buggy, controls, failure, passed)
        self.assertEqual(paired[0]["status"], "FAILURE_WITH_PASSING_CONTROL")
        paired = CONTROLS.pair_runs(buggy, controls, failure, {"runs": []})
        self.assertEqual(paired[0]["status"], "MISSING_PAIR")
        paired = CONTROLS.pair_runs(buggy, controls, failure, failure)
        self.assertEqual(paired[0]["status"], "CONTROL_NOT_PASSED")
        controls["runs"][0]["seed"] = 1
        with self.assertRaisesRegex(ValueError, "seed"):
            CONTROLS.pair_runs(buggy, controls, failure, passed)

    def test_duplicate_runs_cannot_complete_inventory(self):
        original = {"selected_cases": [1, 2], "engines": ["darcy"], "trials": 1}
        first = {"case": 1, "engine": "darcy", "trial": 0, "status": "SAMPLES_PASSED"}
        second = dict(first, case=2)
        self.assertTrue(ANALYSIS.inventory_complete(original, [first, second]))
        self.assertFalse(ANALYSIS.inventory_complete(original, [first, first]))

    def test_compiler_failure_is_not_a_detected_bug(self):
        self.assertEqual(
            MODULE.classify(1, "Failed to compile 'alloc.exec.c'"), "BUILD_ERROR"
        )

    def test_input_generation_exhaustion_is_not_a_detected_bug(self):
        self.assertEqual(
            MODULE.classify(
                1,
                "FAILED TO GENERATE VALID INPUT\ncases: 1, passed: 0, failed: 0, errored: 1, skipped: 0",
            ),
            "GENERATION_FAILED",
        )

    def test_disabled_replay_reports_failure_without_claiming_witness(self):
        summary = "FAILED\ncases: 1, passed: 0, failed: 1, errored: 0, skipped: 0"
        self.assertEqual(MODULE.classify(1, summary), "TEST_FAILURE_REPORTED")
        self.assertEqual(
            MODULE.classify(1, "Failing input\n" + summary), "COUNTEREXAMPLE_REPORTED"
        )
        self.assertEqual(MODULE.classify("TIMEOUT", summary), "TIMEOUT")

    def test_success_requires_complete_consistent_summary(self):
        self.assertEqual(
            MODULE.classify(
                0, "cases: 1, passed: 1, failed: 0, errored: 0, skipped: 0"
            ),
            "SAMPLES_PASSED",
        )
        self.assertEqual(
            MODULE.classify(
                0, "cases: 1, passed: 1, failed: 1, errored: 0, skipped: 0"
            ),
            "UNEXPECTED_SUMMARY",
        )
        self.assertEqual(MODULE.classify(0, ""), "MISSING_TEST_SUMMARY")
