"""Exact footprint hints must replay against all original quantified alternatives."""
import unittest
from unittest.mock import patch

try:
    import z3
except ImportError:
    z3 = None


def cell(address, typ, value=None):
    return {"kind": "cell", "address": address, "type": typ, "value": value}


def branch(*cells, exists=(), pure=()):
    return {"spatial": list(cells), "exists": list(exists), "pure": list(pure)}


def query(pre, *post, mode="exact"):
    return {"layout": {"architecture_bits": 32, "byte_order": "big", "memory_rules": "naive_C_Rules"},
            "mode": mode, "pre": [pre], "post": list(post)}


@unittest.skipUnless(z3, "optional Z3 backend")
class ExactFootprintEvidenceTest(unittest.TestCase):
    def test_one_real_heap_refutes_all_quantified_alternatives(self):
        from spectest.auto_frame_evidence import check_auto_heap

        left = branch(cell("p", "i32", 17), cell("p+4", "u16"), pure=["p == 4096"])
        right = branch(cell("x", "u8", 4), exists=["x"])
        other = branch({"kind": "array", "address": "x", "type": "u8",
                        "length": 2, "values": [3, 4]}, exists=["x"])
        q = query(left, right, other)
        result = check_auto_heap(q, timeout_ms=1000, include_smt=True)
        self.assertEqual(result["status"], "INVALID", result)
        self.assertEqual(result["antecedent_satisfiability"], "sat")
        self.assertEqual(result["exact_footprint_replay"]["post_owned_bytes"], [1, 2])
        self.assertEqual(len(result["countermodel"]["heap"]), 6)
        self.assertIn("(exists", result["smt2"])
        original = z3.Solver()
        original.from_string(result["smt2"])
        self.assertEqual(original.check(), z3.sat)
        self.assertEqual(len(q["post"]), 2)

    def test_matching_byte_width_and_frame_modes_keep_matching_heaps(self):
        from spectest.auto_frame_evidence import check_auto_heap

        left = branch(cell(4096, "u32", 0x01020304))
        wrong = branch(cell("x", "u16", 1), exists=["x"])
        bytes_at = branch(*(cell(4096+i, "u8", i+1) for i in range(4)))
        for q in (query(left, wrong, bytes_at),
                  query(left, branch(cell("x", "u8", 1), exists=["x"]), mode="frame")):
            result = check_auto_heap(q, timeout_ms=1000)
            self.assertEqual(result["status"], "VALID", result)
            self.assertNotIn("exact_footprint_replay", result)

    def test_unsatisfiable_pre_and_unsupported_alternative(self):
        from spectest.auto_frame_evidence import check_auto_heap

        right = branch(cell("x", "u8", 7), exists=["x"])
        overlapping = branch(cell(4096, "i32", 5), cell(4096, "i32", 3))
        result = check_auto_heap(query(overlapping, right), timeout_ms=1000)
        self.assertEqual(result["status"], "VALID", result)
        self.assertTrue(result["vacuous"])
        unsupported = branch(cell("x", "u8", 7) | {"extra": True}, exists=["x"])
        result = check_auto_heap(query(branch(cell(4096, "i32", 0)), right, unsupported), timeout_ms=1000)
        self.assertEqual(result["status"], "UNKNOWN", result)

    def test_invalid_candidate_is_rejected_by_original_query(self):
        from spectest.auto_frame_evidence import check_exact_countermodel

        left = branch(cell(4096, "u32", 42))
        right = branch(cell("x", "u8", 7), exists=["x"])
        fake = {"status": "INVALID", "countermodel": {"variables": {}, "pre_witnesses": {}, "heap": []}}
        with patch("spectest.auto_frame_evidence.check", return_value=fake):
            self.assertIsNone(check_exact_countermodel(query(left, right), timeout_ms=1000))

    def test_no_hint_preserves_budget_and_programming_errors_surface(self):
        from spectest.auto_frame_evidence import check_auto_heap

        simple = query(branch(cell(4096, "u32", 42)), branch())
        with patch("spectest.auto_frame_evidence._replay") as attempt:
            with patch("spectest.auto_frame_evidence.check", return_value={"status": "X"}) as original:
                self.assertEqual(check_auto_heap(simple, timeout_ms=1000), {"status": "X"})
            attempt.assert_not_called()
            self.assertEqual(original.call_args.kwargs["timeout_ms"], 1000)

        quantified = query(simple["pre"][0], branch(cell("x", "u8", 7), exists=["x"]))
        with patch("spectest.auto_frame_evidence._replay", side_effect=RuntimeError("bug")):
            with self.assertRaisesRegex(RuntimeError, "bug"):
                check_auto_heap(quantified, timeout_ms=1000)

    def test_unsuccessful_candidate_time_counts_toward_fallback_and_total(self):
        from spectest.auto_frame_evidence import check_auto_heap

        q = query(branch(cell(4096, "u32", 42)), branch(cell("x", "u8", 7), exists=["x"]))
        with patch("spectest.auto_frame_evidence.time.monotonic", side_effect=[0, .125, .25]):
            with patch("spectest.auto_frame_evidence._replay", return_value=None) as attempt:
                with patch("spectest.auto_frame_evidence.check", return_value={"status": "X"}) as original:
                    result = check_auto_heap(q, timeout_ms=1000)
        self.assertEqual(attempt.call_args.args[2], 500)
        self.assertEqual(original.call_args.kwargs["timeout_ms"], 875)
        self.assertEqual(result["wall_seconds"], .25)
