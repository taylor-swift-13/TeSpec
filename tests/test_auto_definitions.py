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
        self.assertEqual(self.check_entry(entry)["status"], "UNKNOWN")

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
