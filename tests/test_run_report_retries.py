"""Rejected retries cannot leave an earlier successful execution report."""
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import spectest.core as core

from spectest.core import JobError, bundled_qcp_binary, run_job


@unittest.skipUnless(bundled_qcp_binary().is_file(), "requires the native executor")
class RunReportRetryTests(unittest.TestCase):
    def setUp(self):
        temp = tempfile.TemporaryDirectory(prefix="tespec-run-retry-")
        self.addCleanup(temp.cleanup)
        self.root = Path(temp.name)
        self.output = self.root / "run"
        source = self.root / "sample.c"
        source.write_text("int sample(void) /*@ Require emp Ensure __return == 0 && emp */ { return 0; }\n")
        self.job = self.root / "job.json"
        self.payload = {"source": str(source), "function": "sample",
                        "binds": [{"id": "x", "args": {}, "values": {}}],
                        "output_dir": str(self.output)}
        self.write_job()
        first = run_job(self.job)
        self.assertEqual(first["results"][0]["status"], "PASS")
        self.report = self.output / "report.json"
        self.original_goal = Path(first["results"][0]["vc"]["files"]["goal"])
        self.goal_bytes = self.original_goal.read_bytes()

    def write_job(self):
        self.job.write_text(json.dumps(self.payload))

    def assert_old_verdict_retired(self):
        self.assertFalse(self.report.exists())
        self.assertEqual(self.original_goal.read_bytes(), self.goal_bytes)

    def test_rejected_configuration_clears_previous_report(self):
        self.payload["qcp"] = {"execution_strategy": "unsupported"}
        self.write_job()
        with self.assertRaises(JobError):
            run_job(self.job)
        self.assert_old_verdict_retired()
        self.payload.pop("qcp")
        self.write_job()
        retry = run_job(self.job)
        self.assertEqual(retry["results"][0]["status"], "PASS")
        self.assertEqual(json.loads(self.report.read_text())["summary"]["PASS"], 1)

    def test_rejected_bindings_clear_report_before_reusing_artifacts(self):
        self.payload["binds"].append(dict(self.payload["binds"][0]))
        self.write_job()
        with self.assertRaisesRegex(JobError, "duplicate bind case id"):
            run_job(self.job)
        self.assert_old_verdict_retired()

    def test_inputs_changed_during_execution_cannot_publish_mismatched_pass(self):
        measured = core._run_measured
        source = Path(self.payload["source"])
        for target, change in ((source, "int sample(void) { return 1; }\n"),
                               (self.job, "{changed request}")):
            with self.subTest(target=target.name):
                before = target.read_bytes()
                def changed_after_execution(*args, **kwargs):
                    result = measured(*args, **kwargs)
                    target.write_text(change)
                    return result
                try:
                    with patch("spectest.core._run_measured", side_effect=changed_after_execution):
                        with self.assertRaisesRegex(JobError, "run input changed during execution"):
                            run_job(self.job)
                    self.assertFalse(self.report.exists())
                finally:
                    target.write_bytes(before)
        correct = run_job(self.job)
        self.assertEqual(correct["results"][0]["status"], "PASS")
        self.assertEqual(correct["provenance"]["source_sha256"],
                         hashlib.sha256(source.read_bytes()).hexdigest())
        self.assertEqual(correct["provenance"]["job_sha256"],
                         hashlib.sha256(self.job.read_bytes()).hexdigest())

    def test_unreadable_job_with_explicit_output_clears_previous_report(self):
        self.job.write_text("{unfinished")
        with self.assertRaisesRegex(JobError, "cannot read job file"):
            run_job(self.job, self.output)
        self.assert_old_verdict_retired()


if __name__ == "__main__":
    unittest.main()
