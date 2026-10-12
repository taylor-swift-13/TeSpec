"""Path-sensitive validity and test verdicts, exercised through the executor."""

import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from spectest.verdict import _executor_result

BINARY = os.environ.get("SAC_SYMEXEC")


@unittest.skipUnless(BINARY, "set SAC_SYMEXEC to exercise the executor")
class VCStatusTests(unittest.TestCase):
    def run_case(self, require, ensure, body, declarations=""):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "case.c"
            source.write_text(
                declarations + f"\nint sample(int x) /*@ Require {require} "
                f"Ensure {ensure} */ {{ {body} }}"
            )
            run = subprocess.run(
                [
                    BINARY,
                    f"--input-file={source}",
                    "--spec-test-no-expand",
                    "--function=sample",
                    "--Json-output",
                    "--full-auto",
                    "--emit-residual-vc",
                    "--no-strategy-gen",
                    f"--coq-output-dir={root / 'vc'}",
                ],
                capture_output=True,
                text=True,
                timeout=20,
            )
            payload = json.loads(run.stdout)
            self.assertFalse(payload.get("errormessage"), payload)
            vcs = payload["spec_test"]["vc_results"]
            result = _executor_result(
                run.stdout,
                run.returncode,
                {
                    "status": "generated",
                    "residual_goals": [
                        str(i) for i, v in enumerate(vcs) if v["status"] != "VALID"
                    ],
                },
            )
            return result

    def test_invalid_branch_fails(self):
        r = self.run_case(
            "0<=x && x<=10", "__return>0", "if(x>5) return x+1; else return x-1;"
        )
        self.assertEqual(r["status"], "FAIL", r)
        self.assertFalse(r["satisfied"])
        self.assertEqual(r["precondition_result"], "SAT")
        self.assertEqual(r["test_result"], "FAIL")
        self.assertTrue(any(v["status"] == "INVALID" for v in r["vc_results"]))

    def test_invalid_obligation_wins_over_unresolved_obligation(self):
        r = self.run_case(
            "x==0",
            "mystery(__return)",
            "/*@ Assert x==99 */ return x;",
            "/*@ Extern Coq (mystery : Z -> Prop) */",
        )
        self.assertEqual(r["test_result"], "FAIL", r)
        self.assertTrue(any(v["status"] == "INVALID" for v in r["vc_results"]))
        self.assertTrue(any(v["status"] == "UNKNOWN" for v in r["vc_results"]))

    def test_unreachable_bad_branch_is_not_invalid(self):
        r = self.run_case("x==0", "__return==0", "if(x>5) return 99; else return 0;")
        self.assertEqual(r["status"], "PASS", r)
        self.assertTrue(all(v["status"] == "VALID" for v in r["vc_results"]))

    def test_partial_violation_is_invalid_not_only_total_contradiction(self):
        r = self.run_case("0<=x && x<=10", "__return>5", "return x;")
        self.assertEqual(r["status"], "FAIL", r)

    def test_opaque_goal_stays_unknown(self):
        r = self.run_case(
            "x==0",
            "mystery(__return)",
            "return x;",
            "/*@ Extern Coq (mystery : Z -> Prop) */",
        )
        self.assertEqual(r["status"], "UNKNOWN", r)
        self.assertFalse(any(v["status"] == "INVALID" for v in r["vc_results"]))

    def test_wrong_internal_assertion_keeps_actual_return(self):
        r = self.run_case("x==0", "__return==1", "/*@ Assert x==99 */ x++; return x;")
        self.assertEqual(r["status"], "FAIL", r)
        self.assertEqual(r["phases"]["postcondition"], "PASS")

    def test_valid_disjunction_is_not_refuted_one_alternative_at_a_time(self):
        r = self.run_case("0<=x && x<=1", "__return==0 || __return==1", "return x;")
        self.assertNotEqual(r["status"], "FAIL", r)

    def test_existential_choice_failure_is_not_invalid(self):
        r = self.run_case("x==0", "exists y, y>0 && __return==x", "return x;")
        self.assertNotEqual(r["status"], "FAIL", r)

    def test_unsat_entry_skips_execution(self):
        r = self.run_case("x>0 && x<0", "__return==99", "return 0;")
        self.assertEqual(r["phases"]["precondition"], "UNSAT", r)
        self.assertEqual(r["phases"]["execution"], "NOT_RUN")
        self.assertFalse(r["vc_results"])
        self.assertEqual(r["precondition_result"], "UNSAT")
        self.assertEqual(r["test_result"], "FAIL")

    def test_finite_array_wrong_posts_are_refuted(self):
        root = Path(__file__).resolve().parents[1]
        cases = root / "benchmark/paper-cn-qcp/cases"
        for name in ("cn_array_swap", "qcp_array_sum", "qcp_array_sum_zero"):
            with self.subTest(name=name), tempfile.TemporaryDirectory() as directory:
                source = cases / name / "wrong_post.qcp.c"
                binds = cases / name / "binds.json"
                report_dir = Path(directory) / "report"
                command = [
                    sys.executable, "-m", "spectest", "run", str(source),
                    "--function", json.loads((cases / name / "case.json").read_text())["function"],
                    "--binds", str(binds), "--output-dir", str(report_dir),
                    "--execution-mode", "expand", "--compact", "--timeout", "30",
                    "-I", str(root / "runtime/qcip/QCP_examples/QCP_demos_human"),
                ]
                run = subprocess.run(command, cwd=root, text=True, capture_output=True,
                                     timeout=120, env={**os.environ, "SAC_SYMEXEC": BINARY})
                self.assertEqual(run.returncode, 1, run.stderr[-2000:])
                report = json.loads((report_dir / "report.json").read_text())
                self.assertEqual([r["test_result"] for r in report["results"]],
                                 ["FAIL"] * 4)
                self.assertTrue(all(r["precondition_result"] == "SAT" for r in report["results"]))
                self.assertTrue(all(any(v["status"] == "INVALID" for v in r["vc_results"])
                                    for r in report["results"]))

    def test_tree_strategy_allows_field_reads(self):
        root = Path(__file__).resolve().parents[1]
        case = root / "benchmark/paper-cn-qcp/cases/control_tree_size"
        with tempfile.TemporaryDirectory() as directory:
            run = subprocess.run(
                [sys.executable, "-m", "spectest", "run", str(case / "subject.qcp.c"),
                 "--function", "sample", "--binds", str(case / "binds.json"),
                 "--output-dir", str(Path(directory) / "report"),
                 "--execution-mode", "expand", "--compact", "--timeout", "30",
                 "-I", str(root / "runtime/qcip/QCP_examples/QCP_demos_human"),
                 "-I", str(root / "runtime/qcip/QCP_examples")],
                cwd=root, text=True, capture_output=True, timeout=120,
                env={**os.environ, "SAC_SYMEXEC": BINARY},
            )
            self.assertEqual(run.returncode, 1, run.stderr[-2000:])
            report = json.loads((Path(directory) / "report/report.json").read_text())
            self.assertEqual(len(report["results"]), 4)
            self.assertTrue(all(r["execution_completed"] for r in report["results"]))
            self.assertTrue(all(r["test_result"] == "UNKNOWN" for r in report["results"]))
            self.assertTrue(all(r["executor_error"] is None for r in report["results"]))
