"""Symbolic array shapes must preserve all values and binder scopes."""
import unittest
from tools.finite_spatial_smt.qcp_import import import_record
from tools.finite_spatial_smt.finite_spatial_smt import check, Unsupported

LAYOUT = {"architecture_bits": 32, "byte_order": "big", "memory_rules": "naive_C_Rules",
          "field_address_semantics": "base-plus-byte-offset/v1"}


def decision(pre, post):
    def assertion(spatial):
        return "PROP[]\nLOCAL[]\nSEP[" + spatial + "]\n"
    vc = import_record({"layout": LAYOUT, "vc": {"kind": "return",
        "path": pre if "PROP[" in pre else assertion(pre),
        "goal": post if "PROP[" in post else assertion(post)}})
    return check(vc, timeout_ms=2000)


class SymbolicArrayTests(unittest.TestCase):
    def test_unknown_contents_are_not_assumed_equal_to_expected(self):
        result = decision("IntArray.full(4096, 3, contents)",
                          "IntArray.full(4096, 3, cons(Z_1,0,cons(Z_1,1,cons(Z_1,2,nil(Z_1)))))")
        self.assertEqual(result["status"], "INVALID")
        self.assertEqual(result["antecedent_satisfiability"], "sat")
        self.assertEqual(len(result["countermodel"]["heap"]), 12)

    def test_same_unknown_array_is_preserved(self):
        self.assertEqual(decision("IntArray.full(4096, 3, xs)", "IntArray.full(4096, 3, xs)")["status"], "VALID")

    def test_other_array_types_and_lengths(self):
        for module, n in [("ShortArray", 2), ("UIntArray", 1), ("IntArray", 0)]:
            atom = f"{module}.full(4096, {n}, xs)"
            self.assertEqual(decision(atom, atom)["status"], "VALID")

    def test_post_existential_does_not_rebind_pre_array(self):
        pre = "IntArray.full(4096, 3, xs)"
        post = "EX xs\nPROP[]\nLOCAL[]\nSEP[IntArray.full(4096, 3, xs)]\n"
        self.assertEqual(decision(pre, post)["status"], "VALID")

    def test_pre_existential_is_local(self):
        pre = "EX xs\nPROP[]\nLOCAL[]\nSEP[IntArray.full(4096, 2, xs)]\n"
        post = "EX ys\nPROP[]\nLOCAL[]\nSEP[IntArray.full(4096, 2, ys)]\n"
        self.assertEqual(decision(pre, post)["status"], "VALID")

    def test_post_shape_cannot_restrict_a_free_input(self):
        with self.assertRaisesRegex(Unsupported, "free_list_shape_not_constrained"):
            decision("", "IntArray.full(4096, 2, xs)")

    def test_ambiguous_or_oversize_shapes_are_not_approximated(self):
        for pre in ["IntArray.full(4096, 129, xs)",
                    "IntArray.full(4096, 2, xs);IntArray.full(8192, 3, xs)"]:
            with self.assertRaises(Unsupported):
                decision(pre, pre)

    def test_materialized_names_cannot_capture_input_variables(self):
        pre = "PROP[qcp_free_list_xs_0 == 4]\nLOCAL[]\nSEP[IntArray.full(4096,1,xs)]\n"
        with self.assertRaisesRegex(Unsupported, "collision"):
            decision(pre, pre)
