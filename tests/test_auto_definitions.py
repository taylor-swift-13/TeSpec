"""Definition reduction tests use fresh predicate names and the original typed query."""

import hashlib
import json
from pathlib import Path
import tempfile
import unittest

try:
    import z3
except ImportError:
    z3 = None


LIBRARY = """
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sac.
Definition unrelated (f : bool -> bool) : bool := f true.
Lemma harmless (a:Z) : a=a. Proof. reflexivity. Qed.
Definition address_cell (x v:Z) : Assertion := x # Int |-> v.
Fixpoint trail (x:Z) (items:list Z) : Assertion := match items with
| nil => emp
| value::rest => address_cell x value ** trail (x + 4) rest end.
Definition wrapper (x:Z) (xs:list Z) : Assertion := trail x xs.
Definition successor (n:Z) : Z := n + 1.
Definition rest_of (s:list Z) := match s with nil => nil | _::u => u end.
"""
LAYOUT = {
    "architecture_bits": 32,
    "byte_order": "big",
    "memory_rules": "naive_C_Rules",
    "field_address_semantics": "base-plus-byte-offset/v1",
}


@unittest.skipUnless(z3, "optional z3 backend")
class AutoDefinitionsTest(unittest.TestCase):
    def setUp(self):
        from spectest.auto_definitions import solve_entry, solve_path

        self.entry = solve_entry
        self.path = solve_path
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        self.root = Path(temp.name)

    def case(self, lib, goal=""):
        dep = self.root / "Library.v"
        dep.write_text(lib)
        g = self.root / "Goal.v"
        g.write_text(
            "Require Import Library.\nDefinition start := "
            + goal
            + ".\nModule Type VC_Correct.\nAxiom proof_of_start : start.\nEnd VC_Correct.\n"
        )
        manifest = self.root / "manifest.json"
        vc = {
            "coq_dependencies": [
                {
                    "module": "Library",
                    "staged": str(dep),
                    "sha256": hashlib.sha256(dep.read_bytes()).hexdigest(),
                }
            ],
            "target_layout": LAYOUT,
            "runtime_dependencies": [],
            "manifest": str(manifest),
            "files": {"goal": str(g)},
            "immutable_sha256": {"goal": hashlib.sha256(g.read_bytes()).hexdigest()},
        }
        manifest.write_text(json.dumps(vc))
        return {"vc": vc}

    def entail(self, pre, post, lib=LIBRARY):
        case = self.case(lib)
        record = {
            "layout": LAYOUT,
            "check_mode": "exact",
            "vc": {"kind": "return", "path": pre, "goal": post},
        }
        return self.path(record, case, timeout_ms=2000)

    def check_entry(self, formula):
        case = self.case(LIBRARY, formula)
        return self.entry(
            case,
            {"preconditions": [{"status": "UNKNOWN", "goal": "start"}]},
            {"interface_roots": ["proof_of_start"], "files": case["vc"]["files"]},
            timeout_ms=2000,
        )

    def test_compiled_pure_interface_is_bound_to_source_and_exported_names(self):
        import os
        import shutil
        import subprocess
        from spectest.auto_route import _solve_auto_record
        from spectest.opaque_imports import (
            checked_names,
            compiled_interface,
            passive_declarations,
        )

        compiler = os.environ.get("COQC") or shutil.which("coqc")
        if not compiler:
            self.skipTest("Coq compiler is unavailable")
        source = (
            "From Coq Require Import ZArith List.\n"
            "Definition limit_value : Z := 8%Z.\n"
            "Definition opaque_increment (n : Z) := (n + 1)%Z.\n"
        )
        for extra in (
            'Notation "plusone" := limit_value.',
            "Export ListNotations.",
            "Coercion opaque_increment : Z >-> Z.",
            "Axiom guessed : False.",
        ):
            self.assertFalse(passive_declarations(source + extra))
        case = self.case(source)
        subprocess.run([compiler, "-q", "Library.v"], cwd=self.root, check=True)
        interface = compiled_interface("Library", source, self.root, [compiler, "-q"])
        self.assertEqual(
            checked_names(source.encode(), interface),
            ["limit_value", "opaque_increment"],
        )
        with self.assertRaises(ValueError):
            checked_names((source + " ").encode(), interface)
        with self.assertRaises(ValueError):
            checked_names(source.encode(), dict(interface, exports=["limit_value"]))
        with self.assertRaises(ValueError):
            checked_names(source.encode(), dict(interface, exports_sha256="0" * 64))
        case["vc"]["opaque_imports"] = {"Library": interface}
        Path(case["vc"]["manifest"]).write_text(json.dumps(case["vc"]))
        for prop, status in [
            ("4 == 4", "VALID"),
            ("4 == 5", "INVALID"),
            ("limit_value == 8", "UNKNOWN"),
            ("opaque_increment(3) == 4", "VALID"),
            ("opaque_increment(3) == 5", "INVALID"),
            ("opaque_increment(x) == 4", "UNKNOWN"),
        ]:
            rec = {
                "layout": LAYOUT,
                "check_mode": "exact",
                "vc": {
                    "kind": "return",
                    "path": "PROP[]LOCAL[]SEP[]",
                    "goal": f"PROP[{prop}]LOCAL[]SEP[]",
                },
            }
            for result in (
                self.path(rec, case, timeout_ms=2000),
                _solve_auto_record(rec, case, 2000, set(interface["exports"])),
            ):
                self.assertEqual(result["status"], status, result)

    def test_closed_list_reduction_uses_the_original_recursive_definition(self):
        import os
        import shutil
        import subprocess
        from unittest.mock import patch
        from spectest.opaque_imports import compiled_interface
        from spectest.auto_route import _solve_auto_record

        cc = os.environ.get("COQC") or shutil.which("coqc")
        if not cc:
            self.skipTest("Coq compiler is unavailable")
        # Different identifier, recursion and arity from the benchmark library.
        source = """From Coq Require Import List ZArith.
Fixpoint add_each (n : Z) (xs : list Z) : list Z :=
  match xs with nil => nil | cons h t => cons ((n+h)%Z) (add_each n t) end.
"""
        case = self.case(source)
        subprocess.run([cc, "-q", "Library.v"], cwd=self.root, check=True)
        interface = compiled_interface("Library", source, self.root, [cc, "-q"])
        vc = case["vc"]

        def install(receipt):
            vc["opaque_imports"] = {"Library": receipt}
            Path(vc["manifest"]).write_text(json.dumps(vc))

        install(interface)
        cache = {}

        def query(prop):
            rec = {
                "layout": LAYOUT,
                "check_mode": "exact",
                "vc": {
                    "kind": "return",
                    "path": "PROP[]LOCAL[]SEP[]",
                    "goal": f"PROP[{prop}]LOCAL[]SEP[]",
                },
            }
            return _solve_auto_record(rec, case, 2000, {"add_each"}, cache)

        closed = "add_each((- 2),cons{Z_1}(5,nil{Z_1}))"
        result = query(closed + " == cons{Z_1}(3,nil{Z_1})")
        self.assertEqual(result["status"], "VALID", result)
        self.assertEqual(result["ground_equalities"][0]["value"], (3,))
        with patch(
            "spectest.ground_reduction.checked_batch", side_effect=AssertionError
        ):
            self.assertEqual(query(closed + " == nil{Z_1}")["status"], "INVALID")
            self.assertEqual(
                query("add_each(x,nil{Z_1}) == nil{Z_1}")["status"], "UNKNOWN"
            )
        nested = f"add_each(3,{closed}) == cons{{Z_1}}(6,nil{{Z_1}})"
        self.assertEqual(query(nested)["status"], "VALID")
        with patch("spectest.ground_reduction.read_value", return_value=(998,)):
            wrong = query(
                "add_each(10,cons{Z_1}(2,nil{Z_1})) == cons{Z_1}(998,nil{Z_1})"
            )
            self.assertEqual(wrong["reason"], "ground_conversion_not_closed")
        install(
            {
                k: v
                for k, v in interface.items()
                if k not in {"ground_signatures", "object_sha256"}
            }
        )
        self.assertEqual(query(closed + " == nil{Z_1}")["status"], "UNKNOWN")
        install(dict(interface, object_sha256="0" * 64))
        self.assertEqual(
            query(closed + " == nil{Z_1}")["reason"], "ground_compiled_module_mismatch"
        )
        install(dict(interface, ground_signatures={"add_each": ["Z", "Z", "list Z"]}))
        self.assertEqual(query("add_each(0,1) == nil{Z_1}")["status"], "UNKNOWN")

    def test_integer_record_declarations_are_opaque(self):
        lib = LIBRARY + "\nRecord Parcel : Type := pack { item : Z; weight : Z }."
        empty = "PROP[]LOCAL[]SEP[]"
        for post, status in [
            ("PROP[4 == 4]LOCAL[]SEP[]", "VALID"),
            ("PROP[4 == 5]LOCAL[]SEP[]", "INVALID"),
            ("PROP[item == 5]LOCAL[]SEP[]", "UNKNOWN"),
            ("PROP[]LOCAL[]SEP[store(400,weight,signed int)]", "UNKNOWN"),
        ]:
            self.assertEqual(self.entail(empty, post, lib)["status"], status)
        for field in ("INT_MAX", "item : Z; item"):
            self.assertEqual(
                self.entail(empty, empty, lib.replace("weight", field))["status"],
                "UNKNOWN",
            )

    def test_append_witnesses_preserve_contents_and_scope(self):
        for side in ("app prefix (cons last nil)", "app (cons last nil) prefix"):
            for last, expected in [(7, "SAT"), (9, "UNSAT")]:
                body = (
                    f"EX (last : Z) (prefix : list Z), “ (last = {last}) ” && "
                    f"“ (cons 7 nil = {side}) ” && “ (prefix = nil) ” && emp"
                )
                result = self.check_entry(f"~ (({body}) |-- “ False ”)")
                self.assertEqual(result["status"], expected, result)
            body = f"EX (last : Z) (prefix : list Z), “ (nil = {side}) ” && emp"
            self.assertEqual(
                self.check_entry(f"~ (({body}) |-- “ False ”)")["status"], "UNSAT"
            )
            body = (
                f"EX (last : Z) (prefix : list Z), “ (last = 7) ” && "
                f"“ (cons 7 (cons 7 nil) = {side}) ” && wrapper 400 prefix"
            )
            result = self.check_entry(f"~ (({body}) |-- “ False ”)")
            self.assertEqual(result["status"], "SAT", result)
            self.assertTrue(result["owned_addresses"])
        body = "EX (a b : list Z), “ (app a b = cons 1 nil) ” && emp"
        self.assertEqual(
            self.check_entry(f"~ (({body}) |-- “ False ”)")["status"], "UNKNOWN"
        )

    def test_unsigned_limit_uses_qcp_intlib_value(self):
        for value, expected in [(4294967295, "SAT"), (-1, "UNSAT")]:
            r = self.check_entry(f"~ ((“ (UINT_MAX = {value}) ” && emp) |-- “ False ”)")
            self.assertEqual(r["status"], expected, r)

    def test_reads_hash_checked_runtime_definition(self):
        case = self.case(LIBRARY, "~ ((address_cell 400 1) |-- \u201c False \u201d)")
        vc = case["vc"]
        dep = vc["coq_dependencies"].pop()
        dep["source"] = dep.pop("staged")
        vc["runtime_dependencies"].append(dep)
        Path(vc["manifest"]).write_text(json.dumps(vc))
        args = (
            case,
            {"preconditions": [{"status": "UNKNOWN", "goal": "start"}]},
            {"interface_roots": ["proof_of_start"], "files": vc["files"]},
        )
        self.assertEqual(self.entry(*args, timeout_ms=2000)["status"], "SAT")
        Path(dep["source"]).write_text(LIBRARY + "\n(* changed *)")
        self.assertEqual(
            self.entry(*args, timeout_ms=2000)["reason"],
            "definition_dependency_hash_mismatch",
        )

    def test_generated_module_is_bound_to_the_original_goal(self):
        case = self.case(LIBRARY, "~ ((address_cell 400 1) |-- “ False ”)")
        vc = case["vc"]
        vc["generated_coq_dependencies"] = vc["coq_dependencies"]
        vc["coq_dependencies"] = []
        Path(vc["manifest"]).write_text(json.dumps(vc))
        args = (
            case,
            {"preconditions": [{"status": "UNKNOWN", "goal": "start"}]},
            {"interface_roots": ["proof_of_start"], "files": vc["files"]},
        )
        self.assertEqual(self.entry(*args, timeout_ms=2000)["status"], "SAT")
        dep = vc["generated_coq_dependencies"][0]
        Path(dep["staged"]).write_text(LIBRARY + "\n(* altered *)")
        self.assertEqual(
            self.entry(*args, timeout_ms=2000)["reason"],
            "definition_dependency_hash_mismatch",
        )

    def test_legacy_list_uses_only_supported_definitional_reduction(self):
        root = Path(__file__).resolve().parents[1] / "runtime/qcip"
        source = root / "SeparationLogic/examples/QCP_demos_human/sll_lib.v"
        module = "SimpleC.EE.QCP_demos_human.sll_lib"
        for address, value, status in (
            (0, "(@nil Z)", "SAT"),
            (400, "(@nil Z)", "UNSAT"),
            (400, "(cons 7 (@nil Z))", "UNKNOWN"),
        ):
            with self.subTest(address=address, value=value):
                case = self.case(
                    "", f"~ ((sll {address} {value}) |-- \u201c False \u201d)"
                )
                vc = case["vc"]
                goal = Path(vc["files"]["goal"])
                goal.write_text(
                    goal.read_text().replace(
                        "Require Import Library.", f"Require Import {module}."
                    )
                )
                vc["immutable_sha256"]["goal"] = hashlib.sha256(
                    goal.read_bytes()
                ).hexdigest()
                vc["coq_dependencies"] = []
                vc["qcip_root"] = str(root)
                vc["runtime_dependencies"] = [
                    {
                        "module": module,
                        "source": str(source),
                        "sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
                    }
                ]
                Path(vc["manifest"]).write_text(json.dumps(vc))
                result = self.entry(
                    case,
                    {"preconditions": [{"status": "UNKNOWN", "goal": "start"}]},
                    {"interface_roots": ["proof_of_start"], "files": vc["files"]},
                    timeout_ms=2000,
                )
                self.assertEqual(result["status"], status, result)

    def test_changed_names_recursive_alias_and_nested_term(self):
        pre = "PROP[]LOCAL[]SEP[wrapper(400, cons{Z_1}(3,cons{Z_1}(4,nil{Z_1})))]"
        for value, status in [(3, "VALID"), (9, "INVALID")]:
            post = f"PROP[successor(0)==1]LOCAL[]SEP[store(400,{value},signed int); wrapper(404,rest_of(cons{{Z_1}}(3,cons{{Z_1}}(4,nil{{Z_1}}))))]"
            r = self.entail(pre, post)
            self.assertEqual(r["status"], status, r.get("reason"))
            self.assertEqual(
                set(r["expanded_definitions"]),
                {"wrapper", "trail", "address_cell", "rest_of", "successor"},
            )

    def test_scalar_helpers_in_raw_cell_addresses_and_values(self):
        r = self.entail(
            "PROP[]LOCAL[]SEP[store(404, 2, signed int)]",
            "PROP[]LOCAL[]SEP[store(successor(403), successor(successor(0)), signed int)]",
        )
        self.assertEqual(r["status"], "VALID", r)
        self.assertIn("successor", r["expanded_definitions"])

    def test_entry_heap_exists_and_alias_failure(self):
        for address, status in [(404, "SAT"), (400, "UNSAT")]:
            entry = f"exists (x:Z), ~ ((“ (x = 400) ” && address_cell x 1 ** address_cell {address} 1) |-- “ False ”)"
            r = self.check_entry(entry)
            self.assertEqual(r["status"], status, r.get("reason"))

    def test_free_list_in_consequent_is_not_a_rewrite_assumption(self):
        r = self.entail("PROP[]LOCAL[]SEP[]", "PROP[xs == nil{Z_1}]LOCAL[]SEP[]")
        self.assertEqual(r["status"], "UNKNOWN", r)

    def test_disjunctive_antecedent_shapes_are_not_shared(self):
        pre = (
            "PROP[xs == nil{Z_1}]LOCAL[]SEP[]\n"
            "PROP[xs == cons{Z_1}(1,nil{Z_1})]LOCAL[]SEP[]"
        )
        r = self.entail(pre, "PROP[xs == nil{Z_1}]LOCAL[]SEP[]")
        self.assertEqual(r["status"], "UNKNOWN", r)

    def test_unfixed_symbolic_tail_stays_unknown(self):
        r = self.entail("PROP[]LOCAL[]SEP[]", "PROP[]LOCAL[]SEP[wrapper(400,xs)]")
        self.assertEqual(r["status"], "UNKNOWN", r)

    def test_existential_guard_does_not_escape_alternative(self):
        entry = (
            "exists (xs : (@list Z)), ~ (((“ (xs = (@nil Z)) ” && emp) || "
            "(“ (xs = (cons 9 (@nil Z))) ” && emp)) |-- “ False ”)"
        )
        self.assertEqual(self.check_entry(entry)["status"], "SAT")

    def test_entry_branch_bindings_preserve_contradictions(self):
        left = "\u201c (xs = (@nil Z)) \u201d && \u201c (xs = (cons 7 (@nil Z))) \u201d && emp"
        right = "\u201c (xs = (cons 9 (@nil Z))) \u201d && \u201c (xs = (@nil Z)) \u201d && emp"
        formula = f"exists (xs : (@list Z)), ~ ((({left}) || ({right})) |-- \u201c False \u201d)"
        self.assertEqual(self.check_entry(formula)["status"], "UNSAT")

    def test_unknown_list_branch_is_not_discarded(self):
        entry = (
            "exists (xs : (@list Z)), ~ (((\u201c (xs = (@nil Z)) \u201d && emp) || "
            "(wrapper 400 xs)) |-- \u201c False \u201d)"
        )
        self.assertEqual(self.check_entry(entry)["status"], "UNKNOWN")

    def test_typed_existentials_across_names_orders_and_arities(self):
        for x, y, xs, ys in [
            ("n", "m", "xs", "ys"),
            ("payload", "offset", "trailA", "trailB"),
        ]:
            for required, status in [(7, "SAT"), (8, "UNSAT")]:
                with self.subTest(x=x, required=required):
                    body = (
                        f"EX ({x} {y} : Z) ({xs} {ys} : (@list Z)), "
                        f"“ ({xs} = {ys}) ” && “ ({ys} = cons {x} nil) ” && "
                        f"“ ({x} = 7) ” && “ ({xs} = cons {required} nil) ” && emp"
                    )
                    result = self.check_entry(f"~ (({body}) |-- “ False ”)")
                    self.assertEqual(result["status"], status, result)

    def test_scoped_list_constraint_never_leaks_or_masks_an_unknown(self):
        for right, expected in [
            ("“ (xs = cons 6 nil) ” && wrapper 400 xs", "SAT"),
            ("wrapper 400 xs", "UNKNOWN"),
        ]:
            left = "“ (xs = nil) ” && “ (k <> k) ” && emp"
            body = f"EX (k : Z) (xs : list Z), (({left}) || ({right}))"
            r = self.check_entry(f"~ (({body}) |-- “ False ”)")
            self.assertEqual(r["status"], expected, r)

    def test_nested_list_witness_cannot_escape_its_quantifier(self):
        body = "(EX (n : Z), “ (xs = cons n nil) ” && emp) && “ (xs <> nil) ”"
        r = self.check_entry(f"exists (xs : list Z), ~ (({body}) |-- “ False ”)")
        self.assertEqual(r["status"], "UNKNOWN", r)

    def test_typed_binders_in_imported_assertion(self):
        lib = LIBRARY + (
            "\nDefinition hidden (a : Z) : Assertion := "
            "EX (v : Z) (items : list Z), "
            "“ (v = 3) ” && “ (items = cons v nil) ” && trail a items."
        )
        for value, expected in [(3, "VALID"), (4, "INVALID")]:
            result = self.entail(
                "PROP[]LOCAL[]SEP[hidden(400)]",
                f"PROP[]LOCAL[]SEP[store(400,{value},signed int)]",
                lib,
            )
            self.assertEqual(result["status"], expected, result)

    def test_coq_remainder_preserves_sign_and_sorts(self):
        for term in ("(dividend % 3)", "(Z.rem dividend 3)"):
            for expected, status in [(-1, "SAT"), (2, "UNSAT")]:
                body = f"“ (dividend = -7) ” && “ ({term} = {expected}) ” && emp"
                r = self.check_entry(
                    f"exists (dividend : Z), ~ (({body}) |-- “ False ”)"
                )
                self.assertEqual(r["status"], status, r)
        for term, expected in [("Z.rem 7 divisor", 1), ("7 % 0", 7)]:
            body = f"“ (divisor = -3) ” && “ (({term}) = {expected}) ” && emp"
            r = self.check_entry(f"exists (divisor : Z), ~ (({body}) |-- “ False ”)")
            self.assertEqual(r["status"], "SAT", r)
        for term in ("nil % 3", "Z.rem 7 nil"):
            body = f"“ (({term}) = 1) ” && emp"
            r = self.check_entry(f"exists (divisor : Z), ~ (({body}) |-- “ False ”)")
            self.assertEqual(r["status"], "UNKNOWN", r)

    def test_append_slice_checks_original_elements_and_owned_cells(self):
        whole = "cons{Z_1}(5, cons{Z_1}(8, nil{Z_1}))"
        for side, kept, fixed in (("prefix", 5, 8), ("suffix", 8, 5)):
            fragment = "cons{Z_1}(item, nil{Z_1})"
            args = ("part", fragment) if side == "prefix" else (fragment, "part")
            concat = f"app{{Z_1}}({', '.join(args)})"
            for equality in (f"{whole} == {concat}", f"{concat} == {whole}"):
                for value, expected in ((kept, "VALID"), (kept + 1, "INVALID")):
                    with self.subTest(equality=equality, value=value):
                        pre = f"PROP[]LOCAL[]SEP[store(4096, {value}, signed int)]"
                        post = (f"EX part item \nPROP[{equality}; item == {fixed}]"
                                "LOCAL[]SEP[wrapper(4096, part)]")
                        result = self.entail(pre, post)
                        self.assertEqual(result["status"], expected, result)
                        self.assertEqual(result["list_splits"][0]["value"], [kept])
                post = f"EX part item \nPROP[{equality}; item != {fixed}]LOCAL[]SEP[wrapper(4096, part)]"
                result = self.entail(f"PROP[]LOCAL[]SEP[store(4096, {kept}, signed int)]", post)
                self.assertEqual(result["status"], "INVALID", result)
                self.assertNotIn("heap_witnesses", result)

    def test_append_slice_does_not_bind_a_free_post_or_guess_a_partition(self):
        whole = "cons{Z_1}(4, nil{Z_1})"
        for post in (
            f"PROP[{whole} == app{{Z_1}}(rest, nil{{Z_1}})]LOCAL[]SEP[wrapper(4096, rest)]",
            f"EX x y \nPROP[{whole} == app{{Z_1}}(x,y)]LOCAL[]SEP[wrapper(4096,x)]",
            f"EX x \nPROP[({whole} == app{{Z_1}}(x,nil{{Z_1}})) || prop_true]LOCAL[]SEP[wrapper(4096,x)]",
        ):
            result = self.entail("PROP[]LOCAL[]SEP[store(4096,4,signed int)]", post)
            self.assertEqual(result["status"], "UNKNOWN", result)
            self.assertNotIn("list_splits", result)

    def test_heap_witnesses_follow_pointers_in_original_scopes(self):
        from spectest.auto_heap_witnesses import check_cell_witnesses
        from tools.finite_spatial_smt import qcp_import

        # The arbitrary pre address collides in spelling with the post binder.
        left = "EX dest \nPROP[dest == 4096]LOCAL[]SEP[store(8192, dest, PTR);store(dest, 17, signed int)]"
        def check_goal(cells, guard="dest == 17"):
            post = f"EX dest where_to \nPROP[{guard}]LOCAL[]SEP[{cells}]"
            ir = qcp_import.import_record({"layout": LAYOUT, "vc": {"kind": "return", "path": left, "goal": post}})
            return check_cell_witnesses(ir, 500)
        cells = "store(where_to, dest, signed int);store(8192, where_to, PTR)"
        ok = check_goal(cells)
        self.assertEqual(ok["status"], "VALID", ok)
        self.assertEqual(ok["antecedent_satisfiability"], "sat")
        self.assertIsNone(check_goal(cells, "dest == 18"))
        self.assertIsNone(check_goal("store(8192, where_to, PTR)"))
        self.assertIsNone(check_goal(cells.replace("signed int", "PTR")))

        # A failed witness for the first disjunct leaves the second available.
        alternatives = "".join(f"EX dest where_to \nPROP[dest == {n}]LOCAL[]SEP[{cells}]\n"
                               for n in (18, 17))
        ir = qcp_import.import_record({"layout": LAYOUT, "vc": {"kind": "return", "path": left, "goal": alternatives}})
        self.assertEqual(check_cell_witnesses(ir, 1000)["heap_witnesses"]["post_alternative"], 1)

    def test_append_witness_does_not_cover_missing_heap_or_a_wrong_link(self):
        post = ("EX tail q \nPROP[cons{Z_1}(4, nil{Z_1}) == app{Z_1}(tail,nil{Z_1})]"
                "LOCAL[]SEP[store(100,q,PTR);wrapper(q,tail)]")
        for sep, expected in (
            ("store(100,200,PTR);store(200,4,signed int)", "VALID"),
            ("store(100,204,PTR);store(200,4,signed int)", "INVALID"),
            ("store(100,200,PTR)", "INVALID"),
            ("store(100,200,PTR);has_permission(200,signed int)", "INVALID"),
        ):
            with self.subTest(sep=sep):
                result = self.entail(f"PROP[]LOCAL[]SEP[{sep}]", post)
                self.assertEqual(result["status"], expected, result)
                self.assertEqual("heap_witnesses" in result, expected == "VALID")

    def test_infeasible_list_path_precedes_heap_expansion(self):
        empty = "nil{Z_1}"
        pair = "cons{Z_1}(a, cons{Z_1}(b, rest))"
        one = f"cons{{Z_1}}(v, {empty})"
        for equality in (f"{one} == app{{Z_1}}(prefix, {pair})",
                         f"app{{Z_1}}(prefix, {pair}) == {one}"):
            with self.subTest(equality=equality):
                path = f"PROP[{equality}]LOCAL[]SEP[unhandled_heap(p)]"
                out = self.entail(path, "PROP[]LOCAL[]SEP[unhandled_goal(q)]")
                self.assertEqual(out["status"], "VALID", out)
                self.assertTrue(out["vacuous"])
                witness, = out["infeasible_list_branches"]
                self.assertEqual(witness["equality"], equality)
                self.assertEqual((witness["exact_length"], witness["opposite_minimum"]), (1, 2))

    def test_dead_alternative_does_not_hide_live_heap(self):
        dead = "PROP[nil{Z_1} == app{Z_1}(xs, cons{Z_1}(v, nil{Z_1}))]LOCAL[]SEP[unknown(p)]"
        live = "PROP[]LOCAL[]SEP[store(4096, 9, signed int)]"
        for pre in (dead + "\n" + live, live + "\n" + dead):
            for value, expected in [(9, "VALID"), (10, "INVALID")]:
                goal = f"PROP[]LOCAL[]SEP[store(4096, {value}, signed int)]"
                out = self.entail(pre, goal)
                self.assertEqual(out["status"], expected, out)
                self.assertFalse(out["vacuous"])

    def test_list_feasibility_uses_only_mandatory_typed_equalities(self):
        nil = "nil{Z_1}"
        one = f"cons{{Z_1}}(v, {nil})"
        appended = f"app{{Z_1}}(xs, {one})"
        for guard in (f"{one} == {appended}", f"{nil} != {appended}",
                      f"({nil} == {appended}) || prop_true",
                      f"({nil} == {appended}) == prop_false",
                      f"{nil} == user_app(Z_1, xs, {one})",
                      f"{nil} == app{{bool}}(xs, {one})"):
            with self.subTest(guard=guard):
                out = self.entail(f"PROP[{guard}]LOCAL[]SEP[unknown(p)]", "PROP[prop_false]LOCAL[]SEP[]")
                self.assertEqual(out["status"], "UNKNOWN", out)
                self.assertNotIn("infeasible_list_branches", out)

    def test_contradiction_in_goal_cannot_discharge_the_path(self):
        impossible = "nil{Z_1} == app{Z_1}(xs, cons{Z_1}(v, nil{Z_1}))"
        out = self.entail("PROP[]LOCAL[]SEP[]", f"PROP[{impossible}]LOCAL[]SEP[]")
        self.assertNotEqual(out["status"], "VALID", out)
        self.assertNotIn("infeasible_list_branches", out)

    def test_infeasible_path_still_checks_scope_and_native_vc_kind(self):
        path = "PROP[nil{Z_1} == cons{Z_1}(head, tail)]LOCAL[]SEP[]"
        record = {"layout": LAYOUT, "check_mode": "frame",
                  "vc": {"kind": "safety", "path": path, "goal": "PROP[]LOCAL[]SEP[store(42, 9, PTR)]"}}
        out = self.path(record, self.case(LIBRARY), timeout_ms=2000)
        self.assertEqual(out["reason"], "safety_goal_not_pure")
        out = self.entail("EX cons \n" + path, "PROP[]LOCAL[]SEP[unhandled_goal(q)]")
        self.assertEqual(out["status"], "UNKNOWN", out)
        self.assertNotIn("infeasible_list_branches", out)

    def test_list_length_needs_only_the_spine(self):
        for term in (
            "Zlength xs",
            "@Zlength Z xs",
            "Coq.ZArith.Zcomplements.Zlength xs",
        ):
            for length, expected in [(2, "SAT"), (1, "UNSAT")]:
                body = (
                    "EX (a b : Z) (xs : list Z), "
                    f"“ (xs = cons a (cons b nil)) ” && “ (({term}) = {length}) ” && emp"
                )
                r = self.check_entry(f"~ (({body}) |-- “ False ”)")
                self.assertEqual(r["status"], expected, r)
        for term in ("Zlength missing", "Zlength 4", "@Zlength bool nil"):
            r = self.check_entry(f"~ ((“ (({term}) = 0) ” && emp) |-- “ False ”)")
            self.assertEqual(r["status"], "UNKNOWN", r)

    def test_scalar_actual_is_an_arithmetic_atom(self):
        lib = LIBRARY + "\nDefinition twice (p:Z) : Z := p * 2."
        for target, expected in [(6, "INVALID"), (10, "VALID")]:
            r = self.entail(
                "PROP[x == 4]LOCAL[]SEP[]",
                f"PROP[twice(x + 1) == {target}]LOCAL[]SEP[]",
                lib,
            )
            self.assertEqual(r["status"], expected, r)

    def test_assertion_parameter_or_binder_cannot_shadow_primitive(self):
        for dep, query in [
            ("Definition Alias (emp : Assertion) : Assertion := emp.", "Alias(1)"),
            ("Definition Alias (emp : Z) : Assertion := emp.", "Alias(1)"),
            ("Definition Alias (v:Z) : Assertion := EX emp:Z, emp.", "Alias(1)"),
            (
                "Fixpoint Alias (xs:list Z) : Assertion := match xs with | nil => emp | emp::tl => emp end.",
                "Alias(cons{Z_1}(1,nil{Z_1}))",
            ),
        ]:
            r = self.entail(
                "PROP[]LOCAL[]SEP[]", "PROP[]LOCAL[]SEP[" + query + "]", dep
            )
            self.assertEqual(r["status"], "UNKNOWN", r)

    def test_definition_scope_excludes_later_module(self):
        from spectest.auto_definitions import Reduction, parse_library
        from tools.finite_spatial_smt.finite_spatial_smt import Unsupported

        a = parse_library(
            "From Coq Require Import Lists.List. Definition pick (xs:list Z) : Z := last xs 0.",
            {},
        )
        b = parse_library(
            "Definition last (xs:list Z) (n:Z) : Z := 99.", {"A": tuple(a)}
        )
        red = Reduction(a | b, LAYOUT, {"pick", "last"})
        with self.assertRaisesRegex(Unsupported, "unbound_definition_at_declaration"):
            red.apply("pick", [()], False, 0)
        for prefix, permitted in [
            ("Require Import B.", True),
            ("", False),
            ("Require Import B. From Coq Require Import Lists.List.", False),
        ]:
            c = parse_library(
                prefix + " Definition use (xs:list Z) : Z := last xs 0.",
                {"B": tuple(b)},
            )
            r = Reduction(b | c, LAYOUT, {"use"})
            if permitted:
                self.assertEqual(r.apply("use", [()], False, 0), "99")
            else:
                with self.assertRaises(Unsupported):
                    r.apply("use", [()], False, 0)

    def test_rejects_shadow_and_custom_notation(self):
        for declaration in [
            "Definition INT_MAX : Z := 0.",
            "Notation \"'emp'\" := bogus.",
            "Require Import ExternalUnknown.",
        ]:
            r = self.entail(
                "PROP[]LOCAL[]SEP[]", "PROP[]LOCAL[]SEP[]", declaration + "\n" + LIBRARY
            )
            self.assertEqual(r["status"], "UNKNOWN", r)

    def test_source_and_frozen_context_must_match(self):
        case = self.case(LIBRARY)
        Path(case["vc"]["coq_dependencies"][0]["staged"]).write_text(
            "Definition wrong := emp."
        )
        r = self.path(
            {"layout": LAYOUT, "vc": {"kind": "return", "path": "", "goal": ""}},
            case,
            timeout_ms=2000,
        )
        self.assertEqual(r["reason"], "definition_dependency_hash_mismatch")
