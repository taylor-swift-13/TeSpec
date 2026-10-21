"""Execution strategies have explicit expectations independent of spatial SMT."""
import sys
from pathlib import Path
import unittest
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools/benchmark"))
from evaluation_expectations import expected


class StrategyExpectationTests(unittest.TestCase):
    def test_only_tespec_strategy_changes(self):
        row = {"expected": "PASS", "expected_by_execution_strategy": {"inline": "PASS", "modular": "FAIL"}}
        for mode in ("off", "on"):
            self.assertEqual(expected(row, "tespec_" + mode, "inline"), "PASS")
            self.assertEqual(expected(row, "tespec_" + mode, "modular"), "FAIL")
        self.assertEqual(expected(row, "fulminate_test", "modular"), "PASS")

    def test_legacy_expectations_still_default_to_inline(self):
        row = {"plan_case": {"expected": "PASS", "expected_by_tool": {"tespec_on": "ERROR"}}}
        self.assertEqual(expected(row, "tespec_on"), "ERROR")
        self.assertEqual(expected(row, "tespec_off", "modular"), "PASS")

    def test_invalid_override_is_rejected(self):
        with self.assertRaises(ValueError):
            expected({"expected": "PASS", "expected_by_execution_strategy": {"modular": "UNKNOWN"}}, "tespec_on", "modular")


class StrategyRegressionGuardTests(unittest.TestCase):
    def test_changed_oracle_never_masks_execution_regression(self):
        from tools.finite_spatial_smt.regress_completed_groups import strategy_comparison
        for kind in ["INVOCATION_FAILED", "PRECONDITION_REGRESSION", "EXECUTION_REGRESSION"]:
            before = {"kind": kind, "ok": False}
            self.assertEqual(strategy_comparison(before, {"status": "FAIL"}, "FAIL", True), before)

    def test_completed_expected_negative_can_match(self):
        from tools.finite_spatial_smt.regress_completed_groups import strategy_comparison
        self.assertTrue(strategy_comparison({"kind": "DECISION_REGRESSION"}, {"status": "FAIL"}, "FAIL", True)["ok"])
