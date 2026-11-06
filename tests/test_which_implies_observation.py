"""Inline which-implies checks observe the current state without replacing it."""
from __future__ import annotations

import json
import os
from pathlib import Path
import tempfile
import unittest

from spectest.core import run_job

ROOT = Path(__file__).resolve().parents[1]
BINARY = Path(os.environ.get("SAC_SYMEXEC", ROOT / "bin/tespec-symexec"))
INCLUDES = ROOT / "runtime/qcip/QCP_examples/QCP_demos_human"


@unittest.skipUnless(BINARY.is_file(), "requires the native executor")
class WhichImpliesObservationTests(unittest.TestCase):
    def run_source(self, source, args=None, strategy="inline", mode="all-boundaries"):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        folder = Path(temporary.name)
        path = folder / "input.c"
        path.write_text('#include "verification_stdlib.h"\n' + source)
        job = folder / "job.json"
        job.write_text(json.dumps({
            "source": str(path), "function": "sample",
            "binds": [{"id": "entry", "args": args or {}, "values": {}}],
            "qcp": {
                "binary": str(BINARY), "execution_strategy": strategy,
                "execution_mode": mode, "include_dirs": [str(INCLUDES)],
            },
        }))
        report = run_job(job, folder / "run", spatial_smt=True)
        return report["results"][0]

    def assert_pass(self, case):
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertTrue(case["execution_completed"], case)
        self.assertEqual(case["status"], "PASS", case)

    def test_matching_pure_precondition_is_accepted(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ { "
            "/*@ 1 == 1 && emp which implies 1 == 1 && emp */ return 0; }\n"
        )
        self.assert_pass(self.run_source(source))

    def test_impossible_precondition_does_not_pass_vacuously(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ { "
            "/*@ 0 == 1 && emp which implies 0 == 1 && emp */ return 0; }\n"
        )
        case = self.run_source(source)
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertTrue(case["execution_completed"], case)
        self.assertEqual(case["status"], "FAIL", case)

    def test_helper_logical_value_is_instantiated_before_implication(self):
        source = (
            "int helper(int n) /*@ With k Require n == k && emp "
            "Ensure __return == k && emp */ { "
            "/*@ n == k && emp which implies n == 1 && emp */ return n; }\n"
            "int sample(void) /*@ Require emp Ensure __return == 1 && emp */ "
            "{ return helper(1); }\n"
        )
        self.assert_pass(self.run_source(source))

    def test_wrong_helper_postcondition_is_rejected(self):
        source = (
            "int helper(int n) /*@ With k Require n == k && emp "
            "Ensure __return == k && emp */ { "
            "/*@ n == k && emp which implies n == k + 1 && emp */ return n; }\n"
            "int sample(void) /*@ Require emp Ensure __return == 1 && emp */ "
            "{ return helper(1); }\n"
        )
        case = self.run_source(source)
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertEqual(case["status"], "FAIL", case)

    def test_missing_heap_precondition_is_rejected(self):
        source = (
            "int sample(int *p) /*@ Require emp Ensure __return == 0 && emp */ { "
            "/*@ data_at(p,int,7) which implies data_at(p,int,7) */ return 0; }\n"
        )
        case = self.run_source(source, args={"p": 4096})
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertTrue(case["execution_completed"], case)
        self.assertEqual(case["status"], "FAIL", case)

    def test_matching_heap_precondition_allows_external_frame(self):
        source = (
            "int sample(int *p, int *q) "
            "/*@ Require data_at(p,int,7) * data_at(q,int,9) "
            "Ensure __return == 16 && data_at(p,int,7) * data_at(q,int,9) */ { "
            "/*@ data_at(p,int,7) which implies data_at(p,int,7) */ "
            "return *p + *q; }\n"
        )
        self.assert_pass(self.run_source(source, args={"p": 4096, "q": 8192}))

    def test_weaker_annotation_does_not_replace_actual_heap_value(self):
        source = (
            "int sample(int *p) /*@ Require data_at(p,int,7) "
            "Ensure __return == 7 && data_at(p,int,7) */ { "
            "/*@ data_at(p,int,7) which implies exists v, data_at(p,int,v) */ "
            "return *p; }\n"
        )
        self.assert_pass(self.run_source(source, args={"p": 4096}))

    def test_entry_exit_mode_does_not_check_which_implies_annotation(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ { "
            "/*@ 0 == 1 && emp which implies 0 == 1 && emp */ return 0; }\n"
        )
        self.assert_pass(self.run_source(source, mode="entry-exit"))

    def test_modular_mode_keeps_native_which_implies_behavior(self):
        source = (
            "int sample(int *p) /*@ Require data_at(p,int,7) "
            "Ensure __return == 7 && data_at(p,int,7) */ { "
            "/*@ data_at(p,int,7) which implies data_at(p,int,7) */ return *p; }\n"
        )
        self.assert_pass(self.run_source(source, args={"p": 4096}, strategy="modular"))

    def test_opaque_precondition_preserves_execution_and_original_itp_goal(self):
        source = (
            "/*@ Extern Coq (mystery : Z -> Assertion) */\n"
            "int sample(int *p) /*@ Require emp Ensure __return == 0 && emp */ { "
            "/*@ mystery(p) which implies mystery(p) */ return 0; }\n"
        )
        case = self.run_source(source, args={"p": 4096})
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertTrue(case["execution_completed"], case)
        self.assertEqual(case["status"], "UNKNOWN", case)
        self.assertTrue(case["spatial_smt"]["itp_required"], case)
        self.assertTrue(case["vc"]["residual_goals"], case)
        files = case["vc"]["files"]
        goal = Path(files["goal"]).read_text()
        self.assertIn("mystery", goal)
        self.assertIn("naive_C_Rules.truep", goal)
        self.assertTrue(Path(files["proof_manual"]).is_file(), case)
