"""Run contract-instance safety regressions against an explicitly selected native build.

SAC_SYMEXEC is required so these tests do not accidentally exercise an older
bundled executor. No allocator names receive special treatment in these inputs.
"""
from __future__ import annotations

import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

CANDIDATE = os.environ.get("SAC_SYMEXEC")

FIXTURES = {'contradictory_post': 'int external_value(void)\n'
                       '/*@ Require emp Ensure __return < 0 && __return > 0 && emp '
                       '*/;\n'
                       'int sample(void)\n'
                       '/*@ Require emp Ensure emp */\n'
                       '{ return external_value(); }\n',
 'double_alloc': 'int *fresh(void)\n'
                 '/*@ Require emp Ensure __return != 0 && undef_data_at(__return, int) '
                 '*/;\n'
                 'void release(int *p)\n'
                 '/*@ Require undef_data_at(p, int) Ensure emp */;\n'
                 'int sample(void)\n'
                 '/*@ Require emp Ensure __return == 33 && emp */\n'
                 '{ int *a = fresh(); int *b = fresh(); *a = 11; *b = 22; int result = '
                 '*a + *b; release(a); release(b); return result; }\n',
 'frame': 'int *fresh(void)\n'
          '/*@ Require emp Ensure __return != 0 && undef_data_at(__return, int) */;\n'
          'void release(int *p)\n'
          '/*@ Require undef_data_at(p, int) Ensure emp */;\n'
          'int sample(int *q)\n'
          '/*@ Require q == 4096 && data_at(q, int, 9) Ensure __return == 9 && '
          'data_at(q, int, 9) */\n'
          '{ int *p = fresh(); *p = 1; release(p); return *q; }\n',
 'old_heap_value': 'void advance(int *p)\n'
                   '/*@ With old Require data_at(p, int, old) Ensure data_at(p, int, '
                   'old + 1) */;\n'
                   'int sample(int *p)\n'
                   '/*@ Require p == 4096 && data_at(p, int, 5) Ensure __return == 6 '
                   '&& data_at(p, int, 6) */\n'
                   '{ advance(p); return *p; }\n',
 'old_input_range': 'int external_value(int x)\n'
                    '/*@ With old Require x == old && emp Ensure old <= __return && '
                    '__return <= old + 2 && emp */;\n'
                    'int sample(void)\n'
                    '/*@ Require emp Ensure 100000 <= __return && __return <= 100002 '
                    '&& emp */\n'
                    '{ return external_value(100000); }\n',
 'undef_read': 'int *fresh(void)\n'
               '/*@ Require emp Ensure __return != 0 && undef_data_at(__return, int) '
               '*/;\n'
               'void release(int *p)\n'
               '/*@ Require undef_data_at(p, int) Ensure emp */;\n'
               'int sample(void)\n'
               '/*@ Require emp Ensure emp */\n'
               '{ int *p = fresh(); return *p; }\n',
 'weak_return': 'int external_value(void)\n'
                '/*@ Require emp Ensure emp */;\n'
                'int sample(void)\n'
                '/*@ Require emp Ensure __return == __return && emp */\n'
                '{ int x = external_value(); return x; }\n',
 'wide_range': 'int external_value(int x)\n'
               '/*@ Require x == 100000 && emp Ensure 100000 <= __return && __return '
               '<= 100002 && emp */;\n'
               'int sample(void)\n'
               '/*@ Require emp Ensure 100000 <= __return && __return <= 100002 && emp '
               '*/\n'
               '{ return external_value(100000); }\n'}

FIXTURES["conditional_return"] = """int external_abs(int x)
/*@ With old Require x == old && -2147483648 < old && emp
    Ensure ((old >= 0 && __return == old) ||
            (old < 0 && __return == -old)) && emp */;
int sample(void)
/*@ Require emp Ensure __return == 2147483647 && emp */
{ return external_abs(-2147483647); }
"""
FIXTURES["all_false_alternatives"] = """int external_value(int x)
/*@ With old Require x == old && emp
    Ensure ((old > 0 && __return == 1) ||
            (old < 0 && __return == -1)) && emp */;
int sample(void)
/*@ Require emp Ensure emp */
{ return external_value(0); }
"""

FIXTURES["range_not_singleton"] = """int external_value(void)
/*@ Require emp Ensure 100000 <= __return && __return <= 100002 && emp */;
int sample(void)
/*@ Require emp Ensure __return == 100001 && emp */
{ return external_value(); }
"""
FIXTURES["unconstrained_return_not_zero"] = """int external_value(void)
/*@ Require emp Ensure emp */;
int sample(void)
/*@ Require emp Ensure __return == 0 && emp */
{ return external_value(); }
"""

FIXTURES["opaque_frame"] = """/*@ Extern Coq (opaque : Z -> Assertion) */
int *fresh(void)
/*@ Require emp Ensure __return != 0 && undef_data_at(__return, int) */;
void release(int *p)
/*@ Require undef_data_at(p, int) Ensure emp */;
int sample(int *q)
/*@ Require q == 4096 && data_at(q, int, 9) * opaque(7)
    Ensure __return == 9 && data_at(q, int, 9) * opaque(7) */
{ int *p = fresh(); *p = 1; release(p); return *q; }
"""

FIXTURES["unsigned_byte_return"] = """unsigned char external_byte(void)
/*@ Require emp Ensure emp */;
int sample(void)
/*@ Require emp Ensure 0 <= __return && __return <= 255 && emp */
{ return external_byte(); }
"""

FIXTURES["out_of_int_return"] = """int external_value(void)
/*@ Require emp Ensure __return == 2147483648 && emp */;
int sample(void)
/*@ Require emp Ensure __return == 0 && emp */
{ external_value(); return 0; }
"""
FIXTURES["unreachable_inconsistent_call"] = """int external_value(void)
/*@ Require emp Ensure __return < 0 && __return >= 0 && emp */;
int sample(int x)
/*@ Require x == 0 && emp Ensure __return == 0 && emp */
{ if (x != 0) return external_value(); return 0; }
"""


@unittest.skipUnless(CANDIDATE, "set SAC_SYMEXEC to run native contract-instance checks")
class ContractInstantiationTests(unittest.TestCase):
    def run_fixture(self, name, strategy, policy):
        with tempfile.TemporaryDirectory(prefix="tespec-contract-instance-") as temporary:
            source = Path(temporary) / (name + ".c")
            source.write_text(FIXTURES[name])
            result = subprocess.run(
                [str(Path(CANDIDATE).resolve()), "--input-file=" + str(source),
                 "--spec-test", "--function=sample", "--full-auto", "--Json-output",
                 "--no-strategy-gen", "--emit-residual-vc",
                 "--coq-output-dir=" + str(Path(temporary) / "vc"),
                 "--arch=32", "--execution-strategy=" + strategy,
                 "--annotation-policy=" + policy],
                capture_output=True, text=True, timeout=20,
            )
            self.assertIn(result.returncode, (0, 1, 3) if name == "opaque_frame" else (0, 1), result.stderr)
            if result.returncode == 3:
                self.assertEqual(json.loads(result.stdout)["spec_test"]["precondition_result"], "UNKNOWN")
            report = json.loads(result.stdout)
            native = report["spec_test"]
            self.assertEqual(native["execution_strategy"], strategy)
            self.assertEqual(native["annotation_policy"], policy)
            self.assertEqual(native["declaration_call_policy"], "contract-symbolic/v1")
            return native, report

    def test_native_rejects_removed_modular_sampling_option(self):
        with tempfile.TemporaryDirectory(prefix="tespec-no-modular-sampling-") as temporary:
            source = Path(temporary) / "input.c"
            source.write_text(FIXTURES["weak_return"])
            result = subprocess.run(
                [str(Path(CANDIDATE).resolve()), "--input-file=" + str(source),
                 "--spec-test", "--function=sample", "--execution-strategy=modular",
                 "--modular-instantiation=on"], capture_output=True, text=True, timeout=20,
            )
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("--modular-instantiation", result.stdout + result.stderr)

    def variants(self, name):
        results = []
        for strategy in ("inline", "modular"):
            for policy in ("ignore", "check-preserve"):
                with self.subTest(fixture=name, strategy=strategy, policy=policy):
                    results.append(self.run_fixture(name, strategy, policy))
        return results

    def assert_symbolic_success(self, native):
        self.assertEqual(native["overall"], "PASS", native)
        self.assertTrue(native["completed"], native)
        self.assertIsNone(native["limit_reason"], native)
        self.assertEqual(native["sampling_events"], [], native)

    def test_wide_return_range_remains_constrained(self):
        for native, _ in self.variants("wide_range"):
            self.assert_symbolic_success(native)

    def test_caller_argument_and_old_value_remain_bound(self):
        for native, _ in self.variants("old_input_range"):
            self.assert_symbolic_success(native)

    def test_postcondition_uses_old_heap_value_without_overwriting_it(self):
        for native, _ in self.variants("old_heap_value"):
            self.assert_symbolic_success(native)

    def test_weak_emp_contract_keeps_a_symbolic_c_return(self):
        for native, _ in self.variants("weak_return"):
            self.assert_symbolic_success(native)

    def test_weak_unsigned_byte_contract_retains_c_return_range(self):
        for native, _ in self.variants("unsigned_byte_return"):
            self.assert_symbolic_success(native)

    def test_symbolic_returns_do_not_gain_sampled_equalities(self):
        for name in ("range_not_singleton", "unconstrained_return_not_zero"):
            for native, _ in self.variants(name):
                # Neither contract entails the caller's singleton result. A
                # sampled satisfying value must not make this a successful test.
                self.assertIn(native["overall"], ("FAIL", "UNKNOWN"), native)
                self.assertEqual(native["sampling_events"], [], native)

    def test_allocation_and_release_preserve_unrelated_frame_value(self):
        for native, _ in self.variants("frame"):
            self.assert_symbolic_success(native)

    def test_external_calls_preserve_an_opaque_unrelated_frame(self):
        for native, _ in self.variants("opaque_frame"):
            self.assertTrue(native["completed"], native)
            self.assertIsNone(native["limit_reason"], native)
            self.assertEqual(native["sampling_events"], [], native)
            self.assertEqual(native["phases"]["postcondition"], "PASS", native)
            # The opaque entry predicate may still require an independent SAT
            # proof; carrying its exact frame must not manufacture that proof.
            self.assertIn(native["overall"], ("PASS", "UNKNOWN"), native)

    def test_fresh_objects_and_preexisting_local_frame_are_disjoint(self):
        # Both allocations must remain separate resources: aliasing either one
        # with the other or the caller's result local invalidates this result.
        for native, _ in self.variants("double_alloc"):
            self.assert_symbolic_success(native)

    def test_impossible_postcondition_is_not_a_vacuous_pass(self):
        for native, _ in self.variants("contradictory_post"):
            self.assertEqual(native["overall"], "UNKNOWN", native)
            self.assertEqual(native["limit_reason"], "contract_postcondition_inconsistent")
            self.assertEqual(native["sampling_events"], [], native)

    def test_out_of_c_int_return_range_is_an_inconsistent_contract(self):
        for native, _ in self.variants("out_of_int_return"):
            self.assertEqual(native["overall"], "UNKNOWN", native)
            self.assertEqual(native["limit_reason"], "contract_postcondition_inconsistent")
            self.assertEqual(native["sampling_events"], [], native)

    def test_proved_unreachable_inconsistent_call_does_not_poison_return(self):
        for native, _ in self.variants("unreachable_inconsistent_call"):
            self.assert_symbolic_success(native)
            self.assertFalse(any(event["kind"] == "contract-use"
                                 for event in native["abstraction_events"]), native)

    def test_infeasible_conditional_post_sibling_does_not_poison_valid_path(self):
        for native, _ in self.variants("conditional_return"):
            self.assert_symbolic_success(native)
            events = native["abstraction_events"]
            self.assertEqual(sum(e["count"] for e in events if e["kind"] == "contract-use"), 1)
            self.assertEqual(sum(e["count"] for e in events if e["kind"] == "contract_state_symbolic"), 1)

    def test_entirely_infeasible_post_disjunction_remains_unknown(self):
        for native, _ in self.variants("all_false_alternatives"):
            self.assertEqual(native["overall"], "UNKNOWN", native)
            self.assertEqual(native["limit_reason"], "contract_postcondition_inconsistent")
            self.assertEqual(native["sampling_events"], [], native)

    def test_contract_application_does_not_initialize_undefined_resources(self):
        for native, report in self.variants("undef_read"):
            self.assertEqual(native["overall"], "ERROR", native)
            self.assertFalse(native["completed"], native)
            self.assertIn("does not prove readable memory",
                          report["errormessage"]["Main Error Message"])
            self.assertEqual(native["sampling_events"], [], native)


if __name__ == "__main__":
    unittest.main()
