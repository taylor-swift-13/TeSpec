import hashlib
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest


SPEC = importlib.util.spec_from_file_location(
    "paired_summary",
    Path(__file__).resolve().parents[1] / "scripts/summarize-paired-results.py",
)
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class PairedSummaryTests(unittest.TestCase):
    def test_failure_and_inconclusive_are_distinct(self):
        self.assertEqual(
            MODULE.classify("cn_verify", 1, "Unprovable constraint"), "UNPROVED"
        )
        self.assertEqual(
            MODULE.classify("fulminate", 2, "Failed at postcondition"),
            "RUNTIME_VIOLATION",
        )
        self.assertEqual(
            MODULE.classify("fulminate", 2, "compiler error"), "TOOL_ERROR"
        )
        self.assertEqual(
            MODULE.classify("fulminate", "TIMEOUT", "Failed at"), "TIMEOUT"
        )

    def test_changed_evidence_is_rejected_before_output(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            log = root / "cn_verify.log"
            log.write_text("changed")
            report = root / "report.json"
            report.write_text(
                json.dumps(
                    {
                        "runs": [
                            {
                                "tool": "cn_verify",
                                "variant": "valid",
                                "log": str(log),
                                "log_sha256": hashlib.sha256(b"original").hexdigest(),
                            }
                        ]
                    }
                )
            )
            output = root / "output"
            with self.assertRaisesRegex(ValueError, "changed log"):
                MODULE.summarize([report], output)
            self.assertFalse(output.exists())


if __name__ == "__main__":
    unittest.main()
