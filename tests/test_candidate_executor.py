from __future__ import annotations

import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time
import unittest

from spectest.core import _run_measured, bundled_qcip_root, run_job

CANDIDATE = os.environ.get("SAC_SYMEXEC")


class ResourceMeasurementTests(unittest.TestCase):
    def test_nonzero_exit_still_records_memory(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            completed, rss, cpu = _run_measured(
                [sys.executable, "-c", "a = bytearray(2000000); raise SystemExit(3)"],
                cwd=root,
                timeout=5,
                metrics_path=root / "rss",
            )
            self.assertEqual(completed.returncode, 3)
            if Path("/usr/bin/time").is_file():
                self.assertIsInstance(rss, int)
                self.assertGreater(rss, 0)
                self.assertIsInstance(cpu, float)

    def test_timeout_kills_process_group(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            started = time.monotonic()
            with self.assertRaises(subprocess.TimeoutExpired):
                _run_measured(
                    [
                        sys.executable,
                        "-c",
                        "import subprocess,sys,time; "
                        'subprocess.Popen([sys.executable,"-c","import time; time.sleep(10)"]); '
                        "time.sleep(10)",
                    ],
                    cwd=root,
                    timeout=0.1,
                    metrics_path=root / "rss",
                )
            self.assertLess(time.monotonic() - started, 3)


@unittest.skipUnless(CANDIDATE, "set SAC_SYMEXEC to test the candidate sac binary")
class CandidateExecutorTests(unittest.TestCase):
    def test_instance_trace_through_binary_controller(self):
        for mode in ("expand", "no-expand"):
            result = self.run_source(
                "int sample(void) /*@ Require emp Ensure __return==4 && emp */ "
                "{ int x=2; x++; /*@ Assert x>=0 */ x++; return x; }",
                mode,
                instance_trace=True,
            )
            self.assertEqual(result["status"], "PASS", result)
            self.assertIn("--instance-trace", result["command"])

    def test_bodyless_call_is_incomplete_in_both_modes(self):
        for mode in ("expand", "no-expand"):
            result = self.run_source(
                "int external(int x) /*@ Require x == 2 && emp "
                "Ensure __return == 3 && emp */;\n"
                "int sample(void) /*@ Require emp Ensure __return == 3 && emp */ "
                "{ return external(2); }",
                mode,
            )
            self.assertEqual(result["status"], "UNKNOWN")
            self.assertEqual(result["reason"], "missing_function_body")
            result = self.run_source(
                "int external(int x);\n"
                "int sample(void) /*@ Require emp Ensure __return == 3 && emp */ "
                "{ return external(2); }",
                mode,
            )
            self.assertEqual(result["status"], "ERROR")

    def run_source(self, source, mode, spec=None, values=None, **options):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root / "input.c"
            path.write_text(source)
            job = root / "job.json"
            job.write_text(
                json.dumps(
                    {
                        "source": str(path),
                        "function": "sample",
                        "binds": [{"id": "one", "values": values or {}, "spec": spec}],
                        "qcp": {
                            "binary": CANDIDATE,
                            "qcip_root": str(bundled_qcip_root()),
                            "execution_mode": mode,
                            **options,
                        },
                    }
                )
            )
            return run_job(job, root / "output")["results"][0]

    def test_contract_cannot_forget_executed_memory_write(self):
        for forgotten in (False, True):
            ensures = (
                "exists w, data_at(p, int, w)"
                if forgotten
                else "data_at(p, int, v + 1)"
            )
            source = (
                "void step(int *p) /*@ With v Require data_at(p, int, v) Ensure "
                + ensures
                + " */ { *p = *p + 1; }\n"
                "int sample(int *p) /*@ Require data_at(p, int, 3) "
                "Ensure __return == 4 && data_at(p, int, 4) */ "
                "{ step(p); return *p; }"
            )
            for mode in ("expand", "no-expand"):
                with self.subTest(forgotten=forgotten, mode=mode):
                    result = self.run_source(source, mode)
                    expected = "PASS"
                    self.assertEqual(result["status"], expected, result)

    def test_alias_write_invalidates_old_value(self):
        for mode in ("expand", "no-expand"):
            result = self.run_source(
                "int sample(int *p, int *q) /*@ Require p == q && data_at(p, int, 3) "
                "Ensure __return == 4 && data_at(p, int, 4) */ "
                "{ *q = 4; return *p; }",
                mode,
            )
            self.assertEqual(result["status"], "PASS", result)

    def test_annotation_check_preserves_execution_state(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 4 && emp */ "
            "{ int x = 3; /*@ Assert x == 99 */ x = x + 1; return x; }"
        )
        ignored = self.run_source(source, "expand", annotation_policy="ignore")
        checked = self.run_source(source, "expand", annotation_policy="check-preserve")
        self.assertEqual(ignored["status"], "PASS", ignored)
        self.assertEqual(checked["status"], "UNKNOWN", checked)
        self.assertEqual(checked["phases"]["postcondition"], "PASS", checked)
        self.assertEqual(checked["phases"]["annotations"], "UNKNOWN", checked)

    def test_invariant_checked_at_each_actual_iteration(self):
        for correct in (True, False):
            invariant = "0 <= i && i <= 2" if correct else "i == 0"
            source = (
                "int sample(void) /*@ Require emp Ensure __return == 2 && emp */ "
                "{ int i = 0; /*@ Inv " + invariant + " */ "
                "while (i < 2) { i++; } return i; }"
            )
            for mode in ("expand", "no-expand"):
                with self.subTest(correct=correct, mode=mode):
                    result = self.run_source(source, mode)
                    expected = (
                        "UNKNOWN" if not correct and mode == "no-expand" else "PASS"
                    )
                    self.assertEqual(result["status"], expected, result)

    def test_loop_limit_is_unknown(self):
        result = self.run_source(
            "int sample(void) /*@ Require emp Ensure emp */ { while(1) {} return 0; }",
            "expand",
            loop_unroll_limit=2,
        )
        self.assertEqual(result["status"], "UNKNOWN", result)
        self.assertEqual(result["reason"], "loop_unroll_limit", result)

    def test_selects_contract_from_an_earlier_declaration(self):
        source = (
            "int sample(int *p) /*@ chosen Require data_at(p, int, 3) "
            "Ensure __return == 3 && data_at(p, int, 3) */; "
            "int sample(int *p) /*@ implementation Require data_at(p, int, 9) "
            "Ensure __return == 9 && data_at(p, int, 9) */ { return *p; }"
        )
        for mode in ("expand", "no-expand"):
            result = self.run_source(source, mode, spec="chosen")
            self.assertEqual(result["status"], "PASS", result)

    def test_partial_instance_keeps_unbound_logic_variables(self):
        source = (
            "int sample(int *p) /*@ With (n: Z) (v: Z) "
            "Require n == 2 && data_at(p, int, v) "
            "Ensure __return == v && data_at(p, int, v) */ { return *p; }"
        )
        for mode in ("expand", "no-expand"):
            result = self.run_source(source, mode, values={"n": 2})
            self.assertEqual(result["status"], "PASS", result)

    def test_shape_cells_are_fresh_symbolic_values(self):
        result = self.run_source(
            "int sample(int *p) /*@ Require IntArray::full_shape(p, 2) "
            "Ensure __return == 0 && IntArray::full_shape(p, 2) */ "
            "{ return p[0] + p[1]; }",
            "expand",
        )
        self.assertEqual(result["phases"]["precondition"], "SAT", result)
        self.assertEqual(result["status"], "UNKNOWN", result)
        self.assertEqual(result["phases"]["postcondition"], "UNKNOWN", result)

    def test_repeated_contract_calls_use_updated_contents(self):
        source = (
            "void step(int *p) /*@ With v Require data_at(p, int, v) "
            "Ensure data_at(p, int, v + 1) */ { *p = *p + 1; } "
            "int sample(int *p, int *q) /*@ Require data_at(p, int, 3) * data_at(q, int, 8) "
            "Ensure __return == 5 && data_at(p, int, 5) * data_at(q, int, 8) */ "
            "{ step(p); step(p); return *p; }"
        )
        for mode in ("expand", "no-expand"):
            result = self.run_source(source, mode)
            self.assertEqual(result["status"], "PASS", result)

    def test_empty_nested_loop_state_does_not_crash_on_following_if(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ "
            "{ int i; /*@ Inv 0 <= i && i <= 0 */ for(i=0;i<0;i++) { "
            "int j; /*@ Inv 0 <= i && i < 0 && 0 <= j && j <= 0 */ "
            "for(j=0;j<0;j++) {} if(i) i++; } return 0; }"
        )
        result = self.run_source(source, "no-expand")
        self.assertEqual(result["status"], "PASS", result)

    def test_invalid_require_stops_execution_in_both_modes(self):
        source = (
            "int sample(int *p) /*@ Require 0 == 1 && emp Ensure emp */ { return *p; }"
        )
        for mode in ("expand", "no-expand"):
            result = self.run_source(source, mode)
            self.assertEqual(result["status"], "INVALID", result)
            self.assertEqual(result["phases"]["safety"], "NOT_RUN", result)
            self.assertEqual(result["phases"]["postcondition"], "NOT_RUN", result)

    def test_declaration_only_reports_checked_scope(self):
        for mode in ("expand", "no-expand"):
            with self.subTest(mode=mode):
                result = self.run_source(
                    "int sample(void) /*@ Require emp Ensure emp */;", mode
                )
                self.assertEqual(result["status"], "PASS")
                self.assertEqual(result["scope"], "specification-only")
                self.assertEqual(
                    result["phases"],
                    {
                        "precondition": "SAT",
                        "execution": "NOT_RUN",
                        "safety": "NOT_RUN",
                        "postcondition": "NOT_RUN",
                        "annotations": "NOT_RUN",
                    },
                )
                self.assertEqual(result["vc"]["status"], "auto_proved")

    def test_declaration_unknown_keeps_residual_vc(self):
        for mode in ("expand", "no-expand"):
            result = self.run_source(
                "/*@ Extern Coq (opaque : Z -> Assertion) */\n"
                "int sample(void) /*@ Require opaque(0) Ensure emp */;",
                mode,
            )
            self.assertEqual(result["status"], "UNKNOWN")
            self.assertEqual(result["phases"]["execution"], "NOT_RUN")
            self.assertTrue(result["vc"]["residual_goals"])

    def test_declaration_without_spec_is_error(self):
        for mode in ("expand", "no-expand"):
            self.assertEqual(
                self.run_source("int sample(void);", mode)["status"], "ERROR"
            )

    def test_symbolic_overlapping_cells_are_unsatisfiable(self):
        for mode in ("expand", "no-expand"):
            result = self.run_source(
                "void sample(int *p, int *q) /*@ Require "
                "(p == q + 0) && data_at(p, int, 1) * data_at(q, int, 2) "
                "Ensure emp */;",
                mode,
            )
            self.assertEqual(result["phases"]["precondition"], "UNSAT")
            self.assertEqual(result["status"], "INVALID")


if __name__ == "__main__":
    unittest.main()
