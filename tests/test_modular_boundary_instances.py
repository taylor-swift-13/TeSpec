"""Entry and modular boundaries share explicit-instance checking, not SAT guesses."""
from __future__ import annotations

import os
from pathlib import Path
import unittest

from tests import test_execution_strategies as support

ROOT = Path(__file__).resolve().parents[1]
HEAD = '#include "verification_stdlib.h"\n#include "int_array_def.h"\n'


def source(post: str, pre: str | None = None) -> str:
    contents = "IntArray::full(p,2,cons(9,cons(13,nil)))"
    return HEAD + """void preserve(int *p)
/*@ With (xs : list Z) Require IntArray::full(p,2,xs)
    Ensure """ + post + """ */;
int sample(int *p)
/*@ Require p == 4096 && """ + (pre or contents) + """
    Ensure __return == 13 && """ + contents + """ */
{ preserve(p); return p[1]; }
"""


@unittest.skipUnless(os.environ.get("SAC_SYMEXEC"), "select a native candidate")
class ModularBoundaryInstanceTests(unittest.TestCase):
    def run_instance(self, text, mode="all-boundaries", sampling="on"):
        return support.NativeExecutionStrategyTests().run_source(
            text, "modular", mode, modular_instantiation=sampling,
            include_dirs=[str(ROOT / "runtime/qcip/QCP_examples/QCP_demos_human")],
        )

    def test_explicit_array_contents_sample_without_replacing_qcp_heap(self):
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                case, _ = self.run_instance(source("IntArray::full(p,2,xs)"), mode)
                self.assertEqual(case["status"], "PASS", case)
                self.assertTrue(case["execution_completed"])
                self.assertTrue(case["sampling_events"])
                for event in case["sampling_events"]:
                    self.assertEqual(event["status"], "SAMPLED", event)
                    self.assertIn("IntArray.full", event["selected_state"])
                    self.assertIn("cons(Z_1, 9, cons(Z_1, 13", event["selected_state"])
                    self.assertRegex(event["selected_state"], r"p_\d+_pre == 4096")

    def test_symbolic_switch_keeps_same_explicit_array_result(self):
        case, _ = self.run_instance(source("IntArray::full(p,2,xs)"), sampling="off")
        self.assertEqual(case["status"], "PASS", case)
        self.assertEqual(case["sampling_events"], [])

    def test_shape_only_post_keeps_original_state_and_unproved_obligations(self):
        case, _ = self.run_instance(source("IntArray::full_shape(p,2)"))
        self.assertNotEqual(case["status"], "PASS", case)
        events = [e for e in case["sampling_events"] if e["kind"] == "contract"]
        self.assertEqual(len(events), 1, events)
        self.assertEqual(events[0]["status"], "SYMBOLIC_FALLBACK")
        self.assertEqual(events[0]["constraint_state"], events[0]["selected_state"])
        self.assertTrue(case["vc_results"], case)

    def test_overlapping_array_and_cell_is_invalid_entry(self):
        case, _ = self.run_instance(source("IntArray::full(p,2,xs)",
            "IntArray::full(p,2,cons(9,cons(13,nil))) * data_at(p,int,9)"))
        self.assertNotEqual(case["status"], "PASS", case)
        self.assertEqual(case["precondition_result"], "UNSAT", case)

    def test_incorrect_array_length_is_invalid_entry(self):
        case, _ = self.run_instance(source("IntArray::full(p,2,xs)",
            "IntArray::full(p,2,cons(9,nil))"))
        self.assertNotEqual(case["status"], "PASS", case)
        self.assertEqual(case["precondition_result"], "UNSAT", case)


if __name__ == "__main__":
    unittest.main()
