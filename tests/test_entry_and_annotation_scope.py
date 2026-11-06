"""Native entry bindings and annotation frames survive calls and scopes."""
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
class EntryAndAnnotationScopeTests(unittest.TestCase):
    def run_source(self, source, strategy="inline", args=None, values=None, spec=None):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        folder = Path(temporary.name)
        path = folder / "input.c"
        path.write_text('#include "verification_stdlib.h"\n' + source)
        job = folder / "job.json"
        binding = {"id": "entry", "args": args or {}, "values": values or {}}
        if spec is not None:
            binding["spec"] = spec
        job.write_text(json.dumps({
            "source": str(path), "function": "sample",
            "binds": [binding],
            "qcp": {
                "binary": str(BINARY), "execution_strategy": strategy,
                "execution_mode": "all-boundaries", "include_dirs": [str(INCLUDES)],
            },
        }))
        report = run_job(job, folder / "run", spatial_smt=True)
        return report["results"][0]

    @staticmethod
    def aliased_entry_source(wrong=False):
        relation = "a == a0 + 4" if wrong else "a == a0"
        return (
            "int read_cell(int *p) /*@ With v Require data_at(p,int,v) "
            "Ensure __return == v && data_at(p,int,v) */ { return *p; }\n"
            "int sample(int *a) /*@ With a0 Require a == a0 && data_at(a,int,7) "
            "Ensure __return == 7 && data_at(a0,int,7) */ { "
            "int got = read_cell(a); /*@ Assert " + relation + " && got == 7 "
            "&& data_at(a,int,7) && a == a && got == got */ return got; }\n"
        )

    def test_entry_logical_alias_survives_call_and_assertion(self):
        for strategy in ("inline", "modular"):
            with self.subTest(strategy=strategy):
                case = self.run_source(self.aliased_entry_source(), strategy,
                                       args={"a": 4096}, values={"a0": 4096})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["status"], "PASS", case)

    def test_wrong_entry_alias_assertion_is_not_accepted(self):
        for strategy in ("inline", "modular"):
            with self.subTest(strategy=strategy):
                case = self.run_source(self.aliased_entry_source(wrong=True), strategy,
                                       args={"a": 4096}, values={"a0": 4096})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertEqual(case["status"], "FAIL", case)
                self.assertTrue(any(vc["status"] != "VALID"
                                    for vc in case["vc_results"]), case)

    def test_unmentioned_scalar_locals_preserve_array_annotation(self):
        source = (
            '#include "int_array_def.h"\n'
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ { "
            "int a[2] = {4,9}; int first = a[0]; int *slot = a; "
            "/*@ Assert data_at(slot,int,4) * "
            "IntArray::missing_i(a,0,0,2,cons(4,cons(9,nil))) */ "
            "return first - 4; }\n"
        )
        case = self.run_source(source)
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertTrue(case["execution_completed"], case)
        self.assertEqual(case["status"], "PASS", case)

    def test_local_frame_does_not_hide_missing_external_heap(self):
        source = (
            "int sample(int *p) /*@ Require data_at(p,int,7) "
            "Ensure __return == 0 && data_at(p,int,7) */ { int local = 9; "
            "/*@ Assert local == 9 && emp */ return 0; }\n"
        )
        case = self.run_source(source, args={"p": 4096})
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertIn(case["status"], ("FAIL", "UNKNOWN"), case)
        self.assertTrue(any(vc["kind"] == "entailment" and vc["status"] != "VALID"
                            for vc in case["vc_results"]), case)

    def test_named_spec_selection_does_not_depend_on_declaration_order(self):
        specs = [
            "/*@ one With k Require n == k && k == 1 && emp Ensure __return == k && emp */",
            "/*@ two With k Require n == k && k == 2 && emp Ensure __return == k && emp */",
        ]
        for order in (specs, list(reversed(specs))):
            source = ("int sample(int n) " + "\n".join(order)
                      + " { /*@ Assert n == k && emp */ return n; }\n")
            for chosen, value in (("one", 1), ("two", 2)):
                for strategy in ("inline", "modular"):
                    with self.subTest(first=order[0], chosen=chosen, strategy=strategy):
                        case = self.run_source(source, strategy, args={"n": value},
                                               values={"k": value}, spec=chosen)
                        self.assertEqual(case["precondition_result"], "SAT", case)
                        self.assertTrue(case["execution_completed"], case)
                        self.assertEqual(case["status"], "PASS", case)

    def test_c_local_shadow_does_not_use_frozen_parameter_value(self):
        source = (
            "int sample(int n) /*@ With k Require n == k && emp "
            "Ensure __return == k && emp */ { { int n = 6; "
            "/*@ Assert n == 6 && emp */ } "
            "/*@ Assert n == 5 && emp */ return n; }\n"
        )
        case = self.run_source(source, args={"n": 5}, values={"k": 5})
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertTrue(case["execution_completed"], case)
        self.assertEqual(case["status"], "PASS", case)

    @staticmethod
    def logical_helper_source(wrong=False):
        relation = "n == k + 1" if wrong else "n == k"
        return (
            "int helper(int n) /*@ With k Require n == k && emp "
            "Ensure __return == k && emp */ { /*@ Assert " + relation
            + " && emp */ return n; }\n"
            "int sample(int n) /*@ Require emp Ensure __return == n && emp */ "
            "{ return helper(n); }\n"
        )

    def test_inline_helper_binds_its_own_logical_value(self):
        for value in (3, 9):
            with self.subTest(value=value):
                case = self.run_source(self.logical_helper_source(), args={"n": value})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["status"], "PASS", case)

    def test_inline_helper_rejects_wrong_logical_value_assertion(self):
        for value in (3, 9):
            with self.subTest(value=value):
                case = self.run_source(self.logical_helper_source(wrong=True),
                                       args={"n": value})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertEqual(case["status"], "FAIL", case)
                self.assertTrue(any(vc["status"] != "VALID"
                                    for vc in case["vc_results"]), case)

    def test_inline_helper_calls_do_not_share_same_named_bindings(self):
        source = (
            "int helper(int n) /*@ With k Require n == k && emp "
            "Ensure __return == k && emp */ { /*@ Assert n == k && emp */ return n; }\n"
            "int sample(int n) /*@ With k Require n == k && 0 <= k && k <= 10 && emp "
            "Ensure __return == k + 1 && emp */ { int first = helper(n); "
            "int second = helper(n + 1); "
            "/*@ Assert n == k && first == k && second == k + 1 && emp */ "
            "return second; }\n"
        )
        for value in (3, 9):
            with self.subTest(value=value):
                case = self.run_source(source, args={"n": value}, values={"k": value})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["status"], "PASS", case)

    def test_inline_nested_helpers_restore_same_named_caller_binding(self):
        source = (
            "int leaf(int n) /*@ With k Require n == k && emp "
            "Ensure __return == k && emp */ { /*@ Assert n == k && emp */ return n; }\n"
            "int helper(int n) /*@ With k Require n == k && 0 <= k && k <= 20 && emp "
            "Ensure __return == k + 1 && emp */ { int got = leaf(n + 1); "
            "/*@ Assert n == k && got == k + 1 && emp */ return got; }\n"
            "int sample(int n) /*@ With k Require n == k && 0 <= k && k <= 10 && emp "
            "Ensure __return == k + 2 && emp */ { int got = helper(n + 1); "
            "/*@ Assert n == k && got == k + 2 && emp */ return got; }\n"
        )
        for value in (3, 9):
            with self.subTest(value=value):
                case = self.run_source(source, args={"n": value}, values={"k": value})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["status"], "PASS", case)

    def test_inline_recursive_calls_restore_logical_binding_on_return(self):
        source = (
            "int helper(int n) /*@ With k Require n == k && 0 <= k && k <= 3 && emp "
            "Ensure __return == k && emp */ { /*@ Assert n == k && emp */ "
            "if (n == 0) return 0; int got = helper(n - 1); "
            "/*@ Assert n == k && got == k - 1 && emp */ return got + 1; }\n"
            "int sample(int n) /*@ With k Require n == k && 0 <= k && k <= 3 && emp "
            "Ensure __return == k && emp */ { int got = helper(n); "
            "/*@ Assert n == k && got == k && emp */ return got; }\n"
        )
        for value in (1, 3):
            with self.subTest(value=value):
                case = self.run_source(source, args={"n": value}, values={"k": value})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["status"], "PASS", case)

    def test_inline_helper_uses_explicit_where_value(self):
        for chosen, expected in ((3, "PASS"), (4, "FAIL")):
            source = (
                "int helper(int n) /*@ With k Require 0 <= k && k <= 10 && emp "
                "Ensure __return == n && emp */ { /*@ Assert n == k && emp */ return n; }\n"
                "int sample(int n) /*@ Require emp Ensure __return == n && emp */ "
                "{ return helper(n) /*@ where k = " + str(chosen) + " */; }\n"
            )
            with self.subTest(chosen=chosen, expected=expected):
                case = self.run_source(source, args={"n": 3})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["status"], expected, case)

    def test_inline_named_helper_spec_selection_is_order_independent(self):
        specs = [
            "/*@ one With k Require n == k && k == 1 && emp Ensure __return == k && emp */",
            "/*@ two With k Require n == k && k == 2 && emp Ensure __return == k && emp */",
        ]
        for order in (specs, list(reversed(specs))):
            for chosen, value in (("one", 1), ("two", 2)):
                source = (
                    "int helper(int n) " + "\n".join(order)
                    + " { /*@ Assert n == k && emp */ return n; }\n"
                    "int sample(int n) /*@ Require emp Ensure __return == n && emp */ "
                    "{ return helper(n) /*@ where(" + chosen + ") */; }\n"
                )
                with self.subTest(first=order[0], chosen=chosen):
                    case = self.run_source(source, args={"n": value})
                    self.assertEqual(case["precondition_result"], "SAT", case)
                    self.assertTrue(case["execution_completed"], case)
                    self.assertEqual(case["status"], "PASS", case)

    def test_inline_helper_loop_invariant_uses_callee_binding(self):
        for relation, expected in (("n == k", "PASS"), ("n == k + 1", "FAIL")):
            source = (
                "int helper(int n) /*@ With k Require n == k && 0 <= k && k <= 3 && emp "
                "Ensure __return == k && emp */ { int i = 0; "
                "/*@ Inv " + relation + " && 0 <= i && i <= k && emp */ "
                "while (i < n) { i++; } return i; }\n"
                "int sample(int n) /*@ Require 0 <= n && n <= 3 && emp "
                "Ensure __return == n && emp */ { return helper(n); }\n"
            )
            with self.subTest(relation=relation, expected=expected):
                case = self.run_source(source, args={"n": 2})
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["status"], expected, case)

    def test_inline_named_helper_alias_does_not_accept_wrong_assertion(self):
        source = (
            "int helper(int n) "
            "/*@ one With k Require n == k && k == 1 && emp Ensure __return == k && emp */ "
            "/*@ two With k Require n == k && k == 2 && emp Ensure __return == k && emp */ "
            "{ /*@ Assert n == k + 1 && emp */ return n; }\n"
            "int sample(int n) /*@ Require emp Ensure __return == n && emp */ "
            "{ return helper(n) /*@ where(one) */; }\n"
        )
        case = self.run_source(source, args={"n": 1})
        self.assertEqual(case["precondition_result"], "SAT", case)
        self.assertTrue(case["execution_completed"], case)
        self.assertEqual(case["status"], "FAIL", case)

    def test_inline_symbolic_recursive_swap_preserves_outer_frame(self):
        contract = (
            "/*@ With x y Require 0 <= n && n <= 1 && a == x && b == y "
            "&& 0 <= x && x <= 10 && 0 <= y && y <= 10 && emp "
            "Ensure __return == 0 && emp */"
        )
        for wrapped in (False, True):
            function = "helper" if wrapped else "sample"
            source = (
                "int " + function + "(int n, int a, int b) " + contract + " { "
                "/*@ Assert a == x && b == y && emp */ "
                "if (n > 0) " + function + "(n - 1, b, a); "
                "/*@ Assert a == x && b == y && emp */ return 0; }\n"
            )
            if wrapped:
                source += ("int sample(int n, int a, int b) " + contract
                           + " { return helper(n, a, b); }\n")
            with self.subTest(wrapped=wrapped):
                case = self.run_source(
                    source,
                    args={"n": 1, "a": {"symbolic": True}, "b": {"symbolic": True}},
                    values={"x": {"symbolic": True}, "y": {"symbolic": True}},
                )
                self.assertEqual(case["precondition_result"], "SAT", case)
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["status"], "PASS", case)
