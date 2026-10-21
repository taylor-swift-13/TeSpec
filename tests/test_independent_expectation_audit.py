"""Guard the independent oracle against boundary/ownership classification mistakes."""

import unittest
from tools.benchmark.audit_group_expectations import (
    MAX,
    MOD,
    SignedOverflow,
    aggregate_derive,
    expression,
    simple_derive,
)


class IndependentOracleTests(unittest.TestCase):
    def source(self, body, post, pre="emp", signature="int f(int n)"):
        return (
            signature
            + "\n/*@ Require "
            + pre
            + " Ensure "
            + post
            + " */\n{ "
            + body
            + " }"
        )

    def test_unsigned_wrap_is_not_signed_overflow(self):
        self.assertEqual(expression("n+1", {"n": MOD - 1}, True), 0)
        with self.assertRaises(SignedOverflow):
            expression("n+1", {"n": MAX}, False)

    def test_each_intermediate_c_operation_is_checked(self):
        with self.assertRaises(SignedOverflow):
            expression("(n+1)-1", {"n": MAX}, False)
        self.assertEqual(expression("(n+1)-1", {"n": MAX}), MAX)

    def test_spec_math_does_not_implicitly_wrap(self):
        self.assertEqual(expression("n+1", {"n": MOD - 1}), MOD)

    def test_negative_variant_can_pass_a_wrapping_input(self):
        s = self.source(
            "return 0;",
            "__return == (2*n)%4294967296 && emp",
            signature="unsigned int f(unsigned int n)",
        )
        st, _ = simple_derive(s, "f", {"args": {"n": 2**31}, "values": {}})
        self.assertEqual(st["inline"], "PASS")
        st, _ = simple_derive(s, "f", {"args": {"n": 1}, "values": {}})
        self.assertEqual(st["inline"], "FAIL")

    def test_emp_read_does_not_gain_ownership_from_input_value(self):
        s = self.source("return *p;", "emp", signature="int f(int *p)")
        st, _ = simple_derive(
            s, "f", {"args": {"p": 4096}, "values": {"unowned_value": 7}}
        )
        self.assertEqual(
            st, {"inline": "ERROR", "modular": "ERROR", "fulminate": "FAIL"}
        )

    def test_uninitialized_read_is_error_but_noop_bad_post_is_fail(self):
        for body, expected in [("return *p;", "ERROR"), ("return 0;", "FAIL")]:
            s = self.source(
                body, "data_at(p,int,0)", "undef_data_at(p,int)", "int f(int *p)"
            )
            st, _ = simple_derive(s, "f", {"args": {"p": 4096}, "values": {}})
            self.assertEqual(st["inline"], expected)

    def test_ownership_cannot_be_dropped_into_emp(self):
        s = self.source("return *p;", "emp", "data_at(p,int,v)", "int f(int *p)")
        st, _ = simple_derive(s, "f", {"args": {"p": 4096}, "values": {"v": 7}})
        self.assertEqual(st["inline"], "FAIL")

    def test_weak_post_is_valid_for_actual_body(self):
        s = self.source(
            "return *p;",
            "exists w, data_at(p,int,w)",
            "data_at(p,int,v)",
            "int f(int *p)",
        )
        st, _ = simple_derive(s, "f", {"args": {"p": 4096}, "values": {"v": 7}})
        self.assertEqual(st["inline"], "PASS")

    def test_unsatisfied_precondition_is_not_a_negative_test(self):
        s = self.source("return n;", "emp", "n > 0 && emp")
        with self.assertRaisesRegex(ValueError, "precondition"):
            simple_derive(s, "f", {"args": {"n": 0}, "values": {}})

    def test_unsupported_statement_does_not_default_to_pass(self):
        s = self.source("while (n>0) { n=n-1; } return 0;", "emp")
        with self.assertRaises(ValueError):
            simple_derive(s, "f", {"args": {"n": 1}, "values": {}})

    def test_weak_client_changes_only_modular_expectation(self):
        weak = "int read(int *p, int n, int i) /*@ With l Require IntArray::full(p,n,l) Ensure exists l2, IntArray::full(p,n,l2) */ { return p[i]; }"
        client = "int main() /*@ Require emp Ensure __return == 0 && emp */ { /* zero == 0; one == 1; two == 2 */ return 0; }"
        st, w = aggregate_derive(
            "array_load", weak + client, "main", {"args": {}, "values": {}}
        )
        self.assertEqual(st, {"inline": "PASS", "modular": "FAIL", "fulminate": "PASS"})
        self.assertEqual(w["modular_counterexample"]["first_call_return"], 1)


class HarnessAlignmentTests(unittest.TestCase):
    def test_changed_literal_is_detected(self):
        from types import SimpleNamespace
        from unittest.mock import patch
        from tools.benchmark.audit_group_expectations import check_cn_inputs

        harness = SimpleNamespace(
            read_text=lambda: "int main() { add(1, 2); return 0; }"
        )
        row = {"group": "add", "function": "add", "case": "example", "cn_harness": {}}
        with patch(
            "tools.benchmark.audit_group_expectations.checked", return_value=harness
        ):
            with self.assertRaises(AssertionError):
                check_cn_inputs(row, {"args": {"x": 1, "y": 3}, "values": {}})

    def test_changed_alias_relation_is_detected(self):
        from types import SimpleNamespace
        from unittest.mock import patch
        from tools.benchmark.audit_group_expectations import check_cn_inputs

        harness = SimpleNamespace(
            read_text=lambda: "int main() { unsigned int a=1u; unsigned int b=1u; transfer(&a,&b); return 0; }"
        )
        row = {
            "group": "transfer",
            "function": "transfer",
            "case": "example",
            "cn_harness": {},
        }
        with patch(
            "tools.benchmark.audit_group_expectations.checked", return_value=harness
        ):
            with self.assertRaises(AssertionError):
                check_cn_inputs(
                    row, {"args": {"p": 4096, "q": 4096}, "values": {"v": 1}}
                )
