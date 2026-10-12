import json
import os
from pathlib import Path
import tempfile
import subprocess
import unittest
from unittest.mock import patch

from spectest.core import JobError, bundled_qcip_root
from spectest.preflight import export_program_preflight


class PreflightSelectionTests(unittest.TestCase):
    def test_normal_executor_result_is_not_a_preflight_receipt(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "source.c").write_text(
                "int sample(void) /*@ Require emp Ensure emp */ { return 0; }"
            )
            job = root / "job.json"
            job.write_text(
                json.dumps(
                    {
                        "source": "source.c",
                        "function": "sample",
                        "binds": [{"values": {}}],
                    }
                )
            )
            completed = subprocess.CompletedProcess(
                [], 0, json.dumps({"spec_test": {"status": "PASS"}}), ""
            )
            with patch(
                "spectest.preflight._run_measured", return_value=(completed, 1, 0)
            ):
                with self.assertRaisesRegex(
                    JobError, "invalid executor preflight status"
                ):
                    export_program_preflight(job, root / "output")
            self.assertFalse((root / "output" / "manifest.json").exists())

    def test_ambiguous_or_missing_case_does_not_start_executor(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "source.c").write_text("int sample(void);")
            job = root / "job.json"
            job.write_text(
                json.dumps(
                    {
                        "source": "source.c",
                        "function": "sample",
                        "binds": [{"id": name, "values": {}} for name in ("a", "b")],
                    }
                )
            )
            with patch("spectest.preflight._run_measured") as run:
                for selected in (None, "missing"):
                    with self.assertRaisesRegex(JobError, "exactly one case"):
                        export_program_preflight(job, root / "output", case_id=selected)
                run.assert_not_called()
            self.assertFalse((root / "output").exists())


@unittest.skipUnless(os.environ.get("SAC_SYMEXEC"), "requires candidate executor")
class PreflightIntegrationTests(unittest.TestCase):
    def test_preflight_header_preserves_the_executed_import_order(self):
        import subprocess

        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "source.c"
            source.write_text(
                "/*@ Import Coq Require Import CustomDefinitions */\n"
                "int sample(void) /*@ Require emp Ensure __return==0 && emp */ { return 0; }"
            )
            headers = []
            for preflight in (True, False):
                context = root / ("preflight" if preflight else "execution")
                command = [
                    os.environ["SAC_SYMEXEC"],
                    "--input-file=" + str(source),
                    "--full-auto",
                    "--emit-residual-vc",
                    "--concrete-bindings",
                    "--no-strategy-gen",
                    "--function=sample",
                    "--coq-output-dir=" + str(context),
                ]
                if preflight:
                    command.append("--spec-test-preflight")
                result = subprocess.run(
                    command, capture_output=True, text=True, timeout=5
                )
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                headers.append((context / "source_goal.v").read_text())
            self.assertTrue(headers[1].startswith(headers[0]))
            self.assertLess(
                headers[0].index("Import naive_C_Rules."),
                headers[0].index("Require Import CustomDefinitions."),
            )

    def test_bound_job_exports_context_in_both_modes_without_execution(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "source.c").write_text(
                "struct Cell { int value; struct Cell *next; };\n"
                "int sample(int *p) /*@ With n Require n==0 && emp Ensure emp */ "
                "{ while(1) { sample(p); } }"
            )
            job = root / "job.json"
            for mode in ("expand", "no-expand"):
                job.write_text(
                    json.dumps(
                        {
                            "source": "source.c",
                            "function": "sample",
                            "binds": [{"id": "contradiction", "values": {"n": 2}}],
                            "qcp": {
                                "binary": os.environ["SAC_SYMEXEC"],
                                "qcip_root": str(bundled_qcip_root()),
                                "execution_mode": mode,
                                "timeout_seconds": 5,
                            },
                        }
                    )
                )
                output = root / mode
                receipt = export_program_preflight(job, output)
                self.assertEqual(receipt["execution"], "NOT_RUN")
                self.assertEqual(receipt["precondition"], "NOT_CHECKED")
                self.assertEqual(receipt["program_association"], "NOT_CHECKED")
                self.assertEqual(receipt["bindings"], {"n": 2})
                from spectest.certificates import digest

                self.assertEqual(receipt["provenance"]["job_sha256"], digest(job))
                self.assertEqual(
                    receipt["provenance"]["source_sha256"], digest(root / "source.c")
                )
                self.assertEqual(
                    receipt["provenance"]["binary_sha256"], receipt["binary"]["sha256"]
                )
                self.assertEqual(
                    {item["path"] for item in receipt["original_inputs"]},
                    {str(job), str(root / "source.c")},
                )
                self.assertEqual(receipt["target_layout"]["architecture_bits"], 32)
                self.assertTrue(Path(receipt["generated_layout"]["path"]).is_file())
                self.assertTrue(Path(receipt["coq_header"]["path"]).is_file())
                self.assertGreater(len(receipt["context_files"]), 0)
                self.assertNotIn("verdict", receipt)
                self.assertEqual(
                    json.loads((output / "manifest.json").read_text()), receipt
                )
                with self.assertRaisesRegex(JobError, "must be fresh"):
                    export_program_preflight(job, output)


if __name__ == "__main__":
    unittest.main()
