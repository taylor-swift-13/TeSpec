"""The diagnostic allowlist must never hide logical or proof differences."""
import json
from pathlib import Path
import tempfile
import unittest
from tools.benchmark.regress_inline_vc_storage import capture, compare

class DifferentialDiagnosticTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)

    def snapshot(self, label, count=1, vc_status="VALID"):
        folder = self.root / label
        folder.mkdir()
        branch = {"schema": "instance-first-branch-query/v1", "pure_queries": count,
                  "evaluated_true": count, "evaluated_false": 0, "smt_fallback": 0}
        raw = {"spec_test": {"branch_evaluation": branch,
                            "vc_results": [{"status": vc_status, "goal": "original"}]}}
        (folder / "raw.json").write_text(json.dumps(raw))
        report = {"results": [{"stdout": str(folder / "raw.json"), "status": "PASS",
                              "generated_source_sha256": "unchanged", "vc": {"files": {}}}]}
        (folder / "report.json").write_text(json.dumps(report))
        return folder / "report.json"

    def test_runtime_counts_can_change_after_validation(self):
        a = capture(self.snapshot("old"), (), ("branch_evaluation",))
        b = capture(self.snapshot("new", 9), (), ("branch_evaluation",))
        self.assertTrue(compare(a, b)["passed"])
        self.assertEqual(b["runtime_metrics"]["branch_evaluation"]["pure_queries"], 9)

    def test_vc_status_and_formula_are_never_excluded(self):
        a = capture(self.snapshot("old"), (), ("branch_evaluation",))
        b = capture(self.snapshot("new", 9, "UNKNOWN"), (), ("branch_evaluation",))
        self.assertFalse(compare(a, b)["passed"])

    def test_arbitrary_runtime_exclusion_is_rejected(self):
        with self.assertRaises(ValueError):
            capture(self.snapshot("old"), (), ("vc_results",))

    def test_broken_counter_conservation_is_rejected(self):
        report = self.snapshot("old")
        p = report.parent / "raw.json"
        raw = json.loads(p.read_text())
        raw["spec_test"]["branch_evaluation"]["pure_queries"] = 7
        p.write_text(json.dumps(raw))
        with self.assertRaises(ValueError):
            capture(report, (), ("branch_evaluation",))

    def test_existing_field_cannot_be_hidden_as_new(self):
        a = capture(self.snapshot("old"), ("branch_evaluation",))
        b = capture(self.snapshot("new"), ("branch_evaluation",))
        self.assertFalse(compare(a, b)["passed"])

if __name__ == "__main__":
    unittest.main()
