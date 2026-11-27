import unittest
from types import SimpleNamespace

from spectest.auto_resource_match import _first_spatial_arm, _prove


class OriginalResourceTests(unittest.TestCase):
    predicate = SimpleNamespace(result="Assertion", args=(("p", "Z"), ("items", "list Z")))

    def prove(self, text):
        return _prove(text, {"segment": self.predicate}, {"segment"}, 500)

    def test_existential_and_opaque_frame(self):
        left = "(segment p l) ** (a # Int |-> v)"
        right = "EX (q: Z) (w: Z) (ys: (@list Z)), “ (ys = l2) ” && (a # Int |-> w) ** (segment q ys)"
        self.assertTrue(self.prove("forall (p: Z) (a: Z) (v: Z) (l: (@list Z)) (l2: (@list Z)) "
                                   "(PreH1: (l = l2)), " + left + " |-- " + right))

    def test_distinct_or_missing_resources(self):
        prefix = "forall (p: Z) (q: Z) (v: Z) (l: (@list Z)), (segment p l) ** (q # Ptr |-> v) |-- "
        for conclusion in ["(segment q l) ** (q # Ptr |-> v)", "(segment p l)", "(segment p l) ** (q # Int |-> v)",
                           "(segment p l) ** (segment p l)", "(segment p l) ** (q # Ptr |-> p)"]:
            with self.subTest(conclusion=conclusion):
                self.assertFalse(self.prove(prefix + conclusion))

    def test_consequent_guard_must_follow(self):
        self.assertFalse(self.prove("forall (p: Z) (l: (@list Z)), (segment p l) |-- "
                                    "EX (q: Z), “ (q <> p) ” && (segment q l)"))

    def test_disjunction_and_multiplicity(self):
        self.assertTrue(self.prove("forall (p: Z) (q: Z) (l: (@list Z)), (segment p l) ** (segment p l) |-- "
                                   "((segment q l) ** (segment p l)) || ((segment p l) ** (segment p l))"))

    def test_disjunction_under_implication_is_not_a_sufficient_arm(self):
        from tools.finite_spatial_smt.finite_spatial_smt import Unsupported
        with self.assertRaises(Unsupported):
            _first_spatial_arm(r"(forall (x: Z), emp |-- emp) \/ (False) -> False")

    def test_scoped_slots_stay_distinct_as_terms_without_an_alias_assumption(self):
        outer, inner = '&( "v_spec_4" )', '&( "v_spec_51" )'
        pre = f"forall (x: Z) (y: Z), ({outer} # Int |-> x) ** ({inner} # Int |-> y) |-- "
        reordered = f"({inner} # Int |-> y) ** ({outer} # Int |-> x)"
        self.assertTrue(self.prove(_first_spatial_arm(f"({pre}{reordered}) \\/ (False)")))
        swapped = f"({inner} # Int |-> x) ** ({outer} # Int |-> y)"
        self.assertFalse(self.prove(pre + swapped))
        self.assertFalse(self.prove(f"forall (x: Z), emp |-- “ ({inner} <> {outer}) ” && emp"))
