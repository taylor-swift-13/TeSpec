"""Published trial accounting must retain incompleteness and log ambiguity."""

import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location(
    "published_pbt",
    Path(__file__).resolve().parents[1] / "scripts/analyze-published-pbt.py",
)
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class PublishedPbtTests(unittest.TestCase):
    def setUp(self):
        self.catalog = [
            dict(path="patch-01", fut="f", found=True),
            dict(path="patch-02", fut="f", found=True),
            dict(path="patch-03", fut="g", found=False),
        ]
        self.row = dict(
            patch="patch-01",
            function="f",
            trial_num="1",
            bug_found="False",
            elapsed_time="180.1",
            num_runs="3",
            num_discards="",
        )

    def test_partial_non_detection_is_not_a_passing_test(self):
        report = MODULE.analyze(self.catalog, [self.row])
        self.assertFalse(report["complete"])
        self.assertEqual(report["expected_trials"], 20)
        self.assertEqual(report["reported_detections"], 0)
        self.assertEqual(report["excluded_catalog_patches"], 1)
        self.assertEqual(report["repeated_function_names"], {"f": 2})

    def test_reject_duplicate_mismatched_and_nonfinite_trials(self):
        for rows in (
            [self.row, self.row],
            [dict(self.row, function="g")],
            [dict(self.row, elapsed_time="nan")],
            [dict(self.row, bug_found="yes")],
            [dict(self.row, trial_num="11")],
        ):
            with self.subTest(rows=rows), self.assertRaises(ValueError):
                MODULE.analyze(self.catalog, rows)

    def test_complete_inventory_counts_all_trials(self):
        rows = [
            dict(self.row, patch=p["path"], trial_num=str(i), bug_found="True")
            for p in self.catalog
            if p["found"]
            for i in range(1, 11)
        ]
        report = MODULE.analyze(self.catalog, rows)
        self.assertTrue(report["complete"])
        self.assertEqual(report["reported_detections"], 20)


if __name__ == "__main__":
    unittest.main()
