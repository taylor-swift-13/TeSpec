from __future__ import annotations

import contextlib
import importlib.util
import io
import json
import os
from pathlib import Path
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    "query_replay", ROOT / "scripts/replay-query-simplification.py"
)
REPLAY = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPLAY)
CANDIDATE = os.environ.get("SAC_SYMEXEC")


class FrozenQueryCaseTests(unittest.TestCase):
    def test_sources_match_frozen_manifest(self):
        cases = REPLAY.load_cases()
        self.assertEqual(len(cases), len({c["id"] for c in cases}))
        self.assertEqual(len(cases), 34)

    def test_unknown_selection_is_rejected(self):
        with self.assertRaisesRegex(ValueError, "Unknown cases"):
            REPLAY.load_cases(["not-a-case"])


@unittest.skipUnless(CANDIDATE, "set SAC_SYMEXEC to test the candidate sac binary")
class QueryIsolationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.directory = tempfile.TemporaryDirectory()
        cls.addClassCleanup(cls.directory.cleanup)
        cls.output = Path(cls.directory.name) / "replay"
        with contextlib.redirect_stdout(io.StringIO()):
            cls.report = REPLAY.replay(CANDIDATE, cls.output, REPLAY.load_cases())

    def payload(self, case, mode):
        paths = list(
            (self.output / case / mode / "result/artifacts").glob("*/executor.json")
        )
        self.assertEqual(len(paths), 1)
        return json.loads(paths[0].read_text())["spec_test"]

    def test_fixed_cases_and_known_limits(self):
        for row in self.report["runs"]:
            with self.subTest(case=row["case"], mode=row["mode"]):
                if row["expectations_met"] is not None:
                    self.assertTrue(row["expectations_met"], row)

    def test_queries_do_not_replace_live_field_addresses_or_values(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                payload = self.payload("field_call_alias", mode)
                self.assertEqual(payload["query_semantics"], "copy-only/v1")
                trace = [
                    e
                    for e in payload["instance_trace"]
                    if e["state_role"] == "execution"
                ]
                self.assertTrue(trace)
                final = trace[-1]["memory"]
                self.assertRegex(
                    final, r"store\(&\(p_\d+_pre->value\), \(p_pre_value_\d+ \+ 1\)"
                )
                self.assertNotIn("store(4100,", final)
                returns = [v for v in payload["vc_results"] if v["kind"] == "return"]
                self.assertEqual([v["status"] for v in returns], ["VALID"])
                self.assertIn("store(4100, 4,", returns[0]["path"])

    def test_loop_prunes_using_bindings_while_state_keeps_expressions(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                payload = self.payload("bound_loop", mode)
                trace = [
                    e
                    for e in payload["instance_trace"]
                    if e["state_role"] == "execution"
                ]
                self.assertRegex(trace[-1]["P"], r"n_\d+_pre == 3")
                self.assertIn("(((0 + 1) + 1) + 1)", trace[-1]["memory"])
                self.assertEqual(payload["overall"], "PASS")
                self.assertIsNone(payload["limit_reason"])

    def test_partial_heap_keeps_both_feasible_paths(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                payload = self.payload("two_feasible_branches", mode)
                returns = [v for v in payload["vc_results"] if v["kind"] == "return"]
                self.assertEqual(len(returns), 2)
                self.assertTrue(all(v["status"] == "VALID" for v in returns))
                goals = "\n".join(v["goal"] for v in returns)
                self.assertIn("store(4096, 0,", goals)
                self.assertIn("store(4096, 1,", goals)

    def test_fixed_loop_feasibility_avoids_smt(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                payload = self.payload("bound_loop", mode)
                counts = payload["branch_evaluation"]
                self.assertGreater(counts["evaluated_true"], 0)
                self.assertGreater(counts["evaluated_false"], 0)
                self.assertEqual(counts["smt_fallback"], 0)
                self.assertEqual(counts["pure_queries"],
                                 counts["evaluated_true"] + counts["evaluated_false"])
                self.assertTrue(payload["completed"])
                self.assertIsNone(payload["limit_reason"])

    def test_unfixed_heap_keeps_symbolic_branch_fallback(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                payload = self.payload("two_feasible_branches", mode)
                counts = payload["branch_evaluation"]
                self.assertGreater(counts["smt_fallback"], 0)
                self.assertEqual(counts["pure_queries"], counts["evaluated_true"]
                                 + counts["evaluated_false"] + counts["smt_fallback"])
                returns = [v for v in payload["vc_results"] if v["kind"] == "return"]
                self.assertEqual(len(returns), 2)

    def test_fixed_logical_lists_terminate(self):
        for case in (
            "qcp_sll_loop_call",
            "qcp_sll_recursive",
            "qcp_original_polymorphic_reverse",
        ):
            for mode in REPLAY.MODES:
                with self.subTest(case=case, mode=mode):
                    payload = self.payload(case, mode)
                    self.assertTrue(payload["completed"])
                    self.assertIsNone(payload["limit_reason"])
                    returns = [
                        v for v in payload["vc_results"] if v["kind"] == "return"
                    ]
                    self.assertTrue(returns)
                    self.assertEqual(payload["phases"]["safety"], "PASS")

    def test_nested_array_updates_remain_symbolic(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                payload = self.payload("closed_struct_array_nested_positive", mode)
                memory = "\n".join(
                    e["memory"]
                    for e in payload["instance_trace"]
                    if e["state_role"] == "execution"
                )
                self.assertIn("replace_Znth", memory)
                self.assertIn("row0_", memory)
                self.assertEqual(payload["overall"], "PASS")

    def test_tree_unfolding_reads_equalities_and_preserves_symbolic_addresses(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                payload = self.payload("qcp_tree_size_input_2", mode)
                trace = [
                    e
                    for e in payload["instance_trace"]
                    if e["state_role"] == "execution"
                ]
                self.assertTrue(payload["completed"])
                self.assertNotIn(
                    payload["limit_reason"],
                    ("loop_unroll_limit", "call_depth_limit", "predicate_unfold_limit"),
                )
                self.assertRegex(trace[-1]["P"], r"t_\w+ == make_tree")
                self.assertRegex(trace[-1]["memory"], r"store\(&\(p_\d+_pre->left\)")
                self.assertNotIn("store(4104,", trace[-1]["memory"])

    def test_large_nested_loop_and_empty_custom_list_preserve_baseline_results(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                loop = self.payload("nested_loop_thirty_by_thirty", mode)
                self.assertTrue(loop["completed"])
                self.assertEqual(loop["overall"], "PASS")
                empty = self.payload("xizi_single_link_empty_empty", mode)
                self.assertEqual(empty["phases"]["postcondition"], "PASS")

    def test_mutant_is_rejected_by_return_vc(self):
        for mode in REPLAY.MODES:
            with self.subTest(mode=mode):
                payload = self.payload("bound_loop_bad_return", mode)
                self.assertEqual(payload["overall"], "FAIL")
                self.assertTrue(
                    any(
                        v["kind"] == "return" and v["status"] == "INVALID"
                        for v in payload["vc_results"]
                    )
                )


if __name__ == "__main__":
    unittest.main()
