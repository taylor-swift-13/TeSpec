import copy
import unittest

try:
    import z3
except ImportError:
    z3 = None


@unittest.skipUnless(z3, "optional Z3 backend")
class FiniteListPartitionTests(unittest.TestCase):
    def setUp(self):
        from spectest.auto_definitions import Reduction, native_list, parse_library

        self.literal = lambda xs: native_list([str(x) for x in xs])
        self.layout = {"architecture_bits": 32, "byte_order": "big", "memory_rules": "naive_C_Rules",
                       "field_address_semantics": "base-plus-byte-offset/v1"}
        lib = """From SimpleC.Verification Require Import VCPrelude.
            Import naive_C_Rules. Local Open Scope Z_scope. Local Open Scope sac.
            Fixpoint band (p:Z) (s:list Z) : Assertion := match s with
            | nil => emp | n::ns => p # Int |-> n ** band (p + 4) ns end."""
        defs = parse_library(lib, {})
        self.red = Reduction(defs, self.layout, set(defs))

    def check(self, guard, cells, *, extra="", names="alpha beta"):
        from spectest.auto_list_relations import expand_post
        from tools.finite_spatial_smt import qcp_import
        from tools.finite_spatial_smt.finite_spatial_smt import check

        pre = "PROP[]LOCAL[]SEP[" + ";".join(f"store({p},{v},signed int)" for p, v in cells) + "]"
        post = f"EX {names} \nPROP[{guard}{extra}]LOCAL[]SEP[band(4096,alpha);band(8192,beta)]"
        evidence = []
        actual = expand_post(self.red, qcp_import.assertion_parts(post)[0], {}, evidence, scope_check=lambda: True)
        ir = qcp_import.import_record({"layout": self.layout, "vc": {"kind": "return", "path": pre, "goal": actual}})
        return check(ir), evidence

    def test_both_orientations_and_reversal(self):
        target = self.literal([3, 5, 7])
        relation = "app{Z_1}(rev{Z_1}(alpha),beta)"
        heap = [(4096, 5), (4100, 3), (8192, 7)]
        for lhs, rhs in ((target, relation), (relation, target)):
            result, record = self.check(f"{lhs} == {rhs}", heap)
            self.assertEqual(result["status"], "VALID", result)
            self.assertEqual(result["antecedent_satisfiability"], "sat")
            self.assertEqual(record[0]["cuts"], 4)
        result, _ = self.check(f"{target} == app{{Z_1}}(alpha, rev{{Z_1}}(beta))",
                               [(4096, 3), (8192, 7), (8196, 5)])
        self.assertEqual(result["status"], "VALID", result)

    def test_keeps_other_guards_values_and_ownership(self):
        guard = f"{self.literal([3, 5])} == app{{Z_1}}(alpha,beta)"
        for heap, extra, status in (
            ([(4096,3), (8192,5)], "", "VALID"),
            ([(4096,3), (8192,5)], ";prop_false", "INVALID"),
            ([(4096,3), (8192,4)], "", "INVALID"),
            ([(4096,3)], "", "INVALID"),
            ([(4096,3), (8192,5), (8196,0)], "", "INVALID"),
        ):
            result, _ = self.check(guard, heap, extra=extra)
            self.assertEqual(result["status"], status, result)

    def test_frozen_goal_scope_excludes_shadowed_library_operations(self):
        import hashlib
        import tempfile
        from pathlib import Path
        from spectest.auto_list_relations import original_list_scope

        header = "From Coq Require Import List ZArith.\n"
        goal = "Definition sample := forall (n: Z), EX (xs: list Z), rev xs = xs.\n"
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "input_goal.v"
            for source, expected in (
                (header + goal, True),
                (header + goal.replace("(n: Z)", "(rev: list Z -> list Z)"), False),
                (header + goal.replace("(xs: list Z)", "(nil: list Z)"), False),
                (header + "Definition rev := foo.\n" + goal, False),
                (header + "Definition unrelated := 0.\nImport Foo.\n" + goal, False),
            ):
                data = source.encode()
                path.write_bytes(data)
                vc = {"files": {"goal": str(path)}, "immutable_sha256": {"goal": hashlib.sha256(data).hexdigest()}}
                self.assertEqual(original_list_scope({"vc": vc}, {"proof_roots": ["sample"]}), expected)

    def test_integer_notation_needs_original_import_hash_and_scope(self):
        import hashlib
        import tempfile
        from pathlib import Path
        from unittest.mock import patch
        from spectest.auto_list_relations import original_list_scope
        from spectest.auto_definitions import QCP_INTEGER_PRELUDE
        from tools.finite_spatial_smt.finite_spatial_smt import Unsupported

        runtime = Path(__file__).resolve().parents[1] / "runtime/qcip"
        goal = "Definition sample := forall (x: Z), x = INT_MAX."
        prelude = "From SimpleC.Verification Require Import VCPrelude.\n"
        native = "PROP[x == INT_MAX]LOCAL[]SEP[]"
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "input_goal.v"

            def scope(text, diagnostic):
                data = text.encode()
                path.write_bytes(data)
                manifest = {"files": {"goal": str(path)}, "qcip_root": str(runtime),
                            "immutable_sha256": {"goal": hashlib.sha256(data).hexdigest()}}
                return original_list_scope({"vc": manifest}, {"proof_roots": ["sample"],
                                           "path": diagnostic, "goal": native})

            self.assertTrue(scope(prelude + goal, native))
            self.assertFalse(scope("From Coq Require Import ZArith.\n" + goal, native))
            self.assertFalse(scope(prelude + "Definition INT_MAX := 7.\n" + goal, native))
            self.assertFalse(scope(prelude + goal.replace("(x: Z)", "(INT_MAX: Z)"), native))
            self.assertFalse(scope(prelude + goal, "EX UINT_MAX INT_MAX\n" + native))
            polluted = dict(QCP_INTEGER_PRELUDE, **{"IntLib.v": "0" * 64})
            with patch("spectest.auto_definitions.QCP_INTEGER_PRELUDE", polluted):
                with self.assertRaises(Unsupported):
                    scope(prelude + goal, native)

        guard = "app{Z_1}(alpha,beta) == cons{Z_1}(INT_MAX,nil{Z_1})"
        for value, status in ((2147483647, "VALID"), (7, "INVALID")):
            result, evidence = self.check(guard, [(8192, value)])
            self.assertEqual(result["status"], status)
            self.assertEqual(evidence[0]["checked_integer_notations"], ["INT_MAX"])
        self.red.defs["INT_MAX"] = self.red.defs["band"]
        with self.assertRaises(Unsupported):
            self.check(guard, [(8192, 2147483647)])

    def test_no_unbound_aliased_or_shadowed_witnesses(self):
        from spectest.auto_list_relations import _relation
        from tools.finite_spatial_smt.finite_spatial_smt import Unsupported
        lit = self.literal([3, 5])
        for expr in (
            f"app{{Z_1}}(alpha, beta) == free_list",
            f"app{{Z_1}}(alpha, beta) == cons{{Z_1}}(INT_MAX, nil{{Z_1}})",
            f"app{{Z_1}}(alpha, alpha) == {lit}",
            f"app{{Z_1}}(alpha, global_list) == {lit}",
            f"app{{Z_1}}(alpha, beta) != {lit}",
            f"app{{Z_1}}(alpha, beta) == {lit} || prop_true",
            f"app{{bool}}(alpha, beta) == {lit}",
            f"app{{Z_1}}(custom(alpha), beta) == {lit}",
            f"app{{Z_1}}(alpha, beta) == {self.literal(range(13))}",
        ):
            self.assertIsNone(_relation(expr, ["alpha","beta"]), expr)
        self.red.defs = copy.copy(self.red.defs)
        self.red.defs["rev"] = self.red.defs["band"]
        with self.assertRaises(Unsupported):
            self.check(f"app{{Z_1}}(rev{{Z_1}}(alpha),beta) == {lit}", [])
