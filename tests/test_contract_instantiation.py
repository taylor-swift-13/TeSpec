"""Run contract-instance safety regressions against an explicitly selected native build.

SAC_SYMEXEC is required so these tests do not accidentally exercise an older
bundled executor. No allocator names receive special treatment in these inputs.
"""
from __future__ import annotations

import json
import os
from pathlib import Path
import re
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


@unittest.skipUnless(CANDIDATE, "set SAC_SYMEXEC to run native contract-instance checks")
class ContractInstantiationTests(unittest.TestCase):
    def run_fixture(self, name, strategy, policy):
        with tempfile.TemporaryDirectory(prefix="tespec-contract-instance-") as temporary:
            source = Path(temporary) / (name + ".c")
            source.write_text(FIXTURES[name])
            result = subprocess.run(
                [str(Path(CANDIDATE).resolve()), "--input-file=" + str(source),
                 "--spec-test", "--function=sample", "--full-auto", "--Json-output",
                 "--no-strategy-gen", "--arch=32", "--execution-strategy=" + strategy,
                 "--annotation-policy=" + policy],
                capture_output=True, text=True, timeout=20,
            )
            self.assertIn(result.returncode, (0, 1), result.stderr)
            report = json.loads(result.stdout)
            native = report["spec_test"]
            self.assertEqual(native["execution_strategy"], strategy)
            self.assertEqual(native["annotation_policy"], policy)
            self.assertEqual(native["declaration_call_policy"], "contract-sample-or-symbolic/v2" if strategy == "modular" else "contract-sample/v1")
            return native, report

    def variants(self, name):
        results = []
        for strategy in ("inline", "modular"):
            for policy in ("ignore", "check-preserve"):
                with self.subTest(fixture=name, strategy=strategy, policy=policy):
                    results.append(self.run_fixture(name, strategy, policy))
        return results

    def assert_successful_samples(self, native):
        self.assertEqual(native["overall"], "PASS", native)
        self.assertTrue(native["completed"], native)
        self.assertIsNone(native["limit_reason"], native)
        events = native["sampling_events"]
        self.assertTrue(events, native)
        self.assertTrue(all(event["status"] == "SAMPLED" for event in events), events)
        self.assertTrue(all(event["selected_state"] for event in events), events)
        self.assertIn("contract-prestate", {event["kind"] for event in events})
        self.assertIn("contract", {event["kind"] for event in events})

    def test_wide_range_uses_constraints_outside_small_candidate_constants(self):
        for native, _ in self.variants("wide_range"):
            self.assert_successful_samples(native)
            chosen = re.findall(r"retval_\d+ == (\d+)",
                                "\n".join(e["selected_state"] for e in native["sampling_events"]))
            self.assertTrue(chosen, native)
            self.assertTrue(all(100000 <= int(value) <= 100002 for value in chosen))

    def test_caller_argument_and_old_value_remain_bound(self):
        for native, _ in self.variants("old_input_range"):
            self.assert_successful_samples(native)

    def test_postcondition_uses_old_heap_value_without_overwriting_it(self):
        for native, _ in self.variants("old_heap_value"):
            self.assert_successful_samples(native)

    def test_weak_emp_contract_still_selects_a_concrete_c_return(self):
        for native, _ in self.variants("weak_return"):
            self.assert_successful_samples(native)
            selected = "\n".join(event["selected_state"]
                                   for event in native["sampling_events"]
                                   if event["kind"] == "contract")
            self.assertRegex(selected, r"retval_\d+ == (?:\(- \d+\)|\d+)")

    def test_allocation_and_release_preserve_unrelated_frame_value(self):
        for native, _ in self.variants("frame"):
            self.assert_successful_samples(native)
            for event in native["sampling_events"]:
                self.assertRegex(event["selected_state"], r"q_\d+_pre == 4096")
                self.assertRegex(event["selected_state"], r"store\(q_\d+_pre, 9, signed int\)")

    def test_fresh_objects_and_preexisting_local_frame_are_disjoint(self):
        for native, _ in self.variants("double_alloc"):
            self.assert_successful_samples(native)
            returned = {}
            local_values = set()
            for event in native["sampling_events"]:
                selected = event["selected_state"]
                for identifier, value in re.findall(r"(retval_\d+) == (\d+)", selected):
                    value = int(value)
                    self.assertEqual(returned.setdefault(identifier, value), value)
                locals_here = re.findall(r"result_\d+_addr == (\d+)", selected)
                if locals_here:
                    # This frame cell exists before release consumes either
                    # allocation. Post-only sampling used to alias freed data.
                    if not local_values:
                        self.assertEqual(event["kind"], "contract-prestate")
                    local_values.update(map(int, locals_here))
            self.assertEqual(len(returned), 2, returned)
            self.assertEqual(len(set(returned.values())), 2, returned)
            self.assertEqual(len(local_values), 1, local_values)
            self.assertFalse(local_values.intersection(returned.values()))

    def test_impossible_postcondition_is_not_a_vacuous_pass(self):
        for native, _ in self.variants("contradictory_post"):
            self.assertEqual(native["overall"], "UNKNOWN", native)
            if native["execution_strategy"] == "modular":
                # Symbolic continuation may reach the syntactic exit, but an
                # inconsistent contract must keep the whole test UNKNOWN.
                self.assertEqual(native["limit_reason"], "contract_postcondition_inconsistent")
                self.assertTrue(any(event["status"] == "SYMBOLIC_FALLBACK"
                                    for event in native["sampling_events"]))
            else:
                self.assertFalse(native["completed"], native)
                self.assertEqual(native["limit_reason"], "contract_instantiation_unknown")
                self.assertTrue(any(event["status"] == "UNKNOWN"
                                    for event in native["sampling_events"]))

    def test_infeasible_conditional_post_sibling_does_not_poison_valid_sample(self):
        for native, _ in self.variants("conditional_return"):
            self.assert_successful_samples(native)
            post_samples = [event for event in native["sampling_events"]
                            if event["kind"] == "contract"]
            self.assertEqual(len(post_samples), 1, native)

    def test_entirely_infeasible_post_disjunction_remains_unknown(self):
        for native, _ in self.variants("all_false_alternatives"):
            self.assertEqual(native["overall"], "UNKNOWN", native)
            if native["execution_strategy"] == "modular":
                # Symbolic continuation may reach the syntactic exit, but an
                # inconsistent contract must keep the whole test UNKNOWN.
                self.assertEqual(native["limit_reason"], "contract_postcondition_inconsistent")
                self.assertTrue(any(event["status"] == "SYMBOLIC_FALLBACK"
                                    for event in native["sampling_events"]))
            else:
                self.assertFalse(native["completed"], native)
                self.assertEqual(native["limit_reason"], "contract_instantiation_unknown")
                self.assertTrue(any(event["status"] == "UNKNOWN"
                                    for event in native["sampling_events"]))

    def test_sampling_does_not_initialize_uninitialized_resources(self):
        for native, report in self.variants("undef_read"):
            self.assertEqual(native["overall"], "ERROR", native)
            self.assertFalse(native["completed"], native)
            self.assertIn("does not prove readable memory",
                          report["errormessage"]["Main Error Message"])
            allocations = [event for event in native["sampling_events"]
                           if event["kind"] == "contract"]
            self.assertTrue(allocations, native)
            self.assertRegex(allocations[0]["selected_state"],
                             r"has_permission\(retval_\d+, signed int\)")


if __name__ == "__main__":
    unittest.main()
