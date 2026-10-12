from pathlib import Path
import unittest

from spectest.core import JobError
from spectest.rocq_predicates import (
    emit_equations,
    emit_model_refinements,
    emit_pure_projection_equations,
    emit_pure_projection_rules,
    emit_rules,
    parse_predicate,
    referenced_symbols,
)


class RocqPredicateTests(unittest.TestCase):
    def test_quoted_pure_conjunction_preserves_all_constraints_and_witnesses(self):
        source = r"""Definition region(p: addr)(n: Z): Assertion :=
EX q: addr, “ (0 <= n /\ n <= 8) /\ (p <> NULL /\ q = p) ” && p # Int |-> n."""
        clauses = parse_predicate(source, "region")
        rules = emit_rules(clauses)
        for atom in ["0 <= n", "n <= 8", "p != 0", "q == p"]:
            self.assertIn("left_add(" + atom + ")", rules)
        self.assertIn("left_exist_add(q : Z)", rules)
        projection = emit_pure_projection_rules(clauses)
        self.assertIn("left_add(p != 0)", projection)
        self.assertNotIn("q == p", projection)
        for invalid in ["/\\ p <> NULL", "p <> NULL /\\", "p <> NULL /\\ /\\ n = 0"]:
            with self.subTest(invalid=invalid), self.assertRaises(JobError):
                parse_predicate(
                    "Definition f(p: addr)(n: Z): Assertion := “ "
                    + invalid
                    + " ” && emp.",
                    "f",
                )

    def test_pure_projection_retains_predicate_and_excludes_witness_facts(self):
        source = """Definition region(p: addr)(n: Z): Assertion :=
“ 0 <= n ” && EX q: addr, “ p <> NULL ” && “ q <> NULL ” &&
 &(p # "Block" ->ₛ "next") # Ptr |-> q."""
        clauses = parse_predicate(source, "region")
        rules = emit_pure_projection_rules(clauses, scope="checked_pure")
        self.assertIn("left_add(0 <= n)", rules)
        self.assertIn("left_add(p != 0)", rules)
        self.assertIn("check : absense(p != 0)", rules)
        for forbidden in ["left_erase", "exist_add", "field_addr", "q != 0"]:
            self.assertNotIn(forbidden, rules)
        equations = emit_pure_projection_equations(clauses, "Definitions", "region")
        self.assertIn("Definitions.region p n && “ p <> 0 ”", equations)
        self.assertNotIn("Lemma region_branch_", equations)

    def test_pure_projection_rejects_ownership_only_and_layout_dependent_facts(self):
        for source in [
            "Definition cells(p: addr): Assertion := p # Int |-> 7.",
            """Definition cells(p q: addr): Assertion :=
“ &(p # "Block" ->ₛ "next") = q ” && emp.""",
            "Definition cells(p: addr): Assertion := EX q: addr, “ q <> NULL ” && p # Ptr |-> q.",
        ]:
            with (
                self.subTest(source=source),
                self.assertRaisesRegex(JobError, "no eligible"),
            ):
                emit_pure_projection_rules(parse_predicate(source, "cells"))
        nested = """Definition cells(p q: addr): Assertion :=
“ &(p # "Envelope" ->ₛ "payload" .ₛ "part" .ₛ "value") = q ” && emp."""
        with self.assertRaisesRegex(JobError, "no eligible"):
            emit_pure_projection_rules(
                parse_predicate(nested, "cells", target_layout=self.nested_layout())
            )

    def test_typed_nested_list_patterns_use_declared_constructor_shapes(self):
        source = """Definition scalar := Z.
Inductive Payload : Type := Leaf : scalar -> Payload | Pair : Payload -> Payload -> Payload.
Definition Path : Type := list Payload.
Fixpoint observe(p: addr)(xs: Path): Assertion :=
match xs with
| nil => emp
| Pair (Leaf a) (Leaf b) :: tail => “ p <> NULL ” && EX q, &(p # "Cell" ->ₛ "next") # Ptr |-> q ** observe q tail
end."""
        clauses = parse_predicate(source, "observe")
        self.assertEqual(
            clauses[1][0], "observe(?p, cons{Payload}(Pair(Leaf(?a), Leaf(?b)), ?tail))"
        )
        self.assertEqual(clauses[1][2].existential_types, ("Z",))
        self.assertIn("Payload", referenced_symbols(clauses))
        equations = emit_equations(clauses, "Definitions", "observe")
        self.assertIn("(@cons Payload (Pair (Leaf a) (Leaf b)) tail)", equations)
        self.assertIn("@cons = @Coq.Init.Datatypes.cons", equations)
        rules = emit_rules(clauses, infer_models=True)
        self.assertIn(
            "right_add(xs == cons{Payload}(Pair(Leaf(a), Leaf(b)), tail))", rules
        )
        for invalid in [
            source.replace("Pair (Leaf a) (Leaf b)", "Pair (Leaf a)"),
            source.replace("Pair (Leaf a) (Leaf b)", "Pair (Leaf a) (Leaf a)"),
            source.replace("scalar -> Payload", "scalar -> Different"),
            source.replace("Definition scalar := Z.", "Definition scalar := scalar."),
            source.replace("EX q,", "EX hidden q,"),
        ]:
            with self.subTest(invalid=invalid), self.assertRaises(JobError):
                parse_predicate(invalid, "observe")

    def test_field_address_comparison_ignores_notation_arrows(self):
        source = """Definition observe(p q: addr): Assertion :=
“ &(p # "Cell" ->ₛ "next") = q ” && p # Int |-> 1."""
        clauses = parse_predicate(source, "observe")
        self.assertEqual(clauses[0][2].atoms[0][0], "field_addr(p, Cell, next) == q")

    def test_scalar_storage_resolves_aliases_and_rejects_known_aggregate_values(self):
        source = "Definition Word := Z. Definition observe(p: addr)(v: Word): Assertion := p # Int |-> v."
        self.assertIn(
            "store(p, I32, v)", emit_rules(parse_predicate(source, "observe"))
        )
        with self.assertRaisesRegex(JobError, "scalar storage"):
            parse_predicate(
                "Definition observe(p: addr)(v: list Z): Assertion := p # Int |-> v.",
                "observe",
            )

    def test_list_of_lists_patterns_keep_nested_type_arguments(self):
        source = """Definition Matrix : Type := list (list Z).
Definition observe(p: addr)(xs: Matrix): Assertion :=
match xs with
| nil => emp
| nil :: rest => emp
| (a :: inner) :: outer => p # Int |-> a
end."""
        clauses = parse_predicate(source, "observe")
        self.assertEqual(
            clauses[2][0], "observe(?p, cons{list{Z}}(cons{Z}(?a, ?inner), ?outer))"
        )
        self.assertIn(
            "(@cons (list Z) (@cons Z a inner) outer)",
            emit_equations(clauses, "Definitions", "observe"),
        )
        self.assertEqual(referenced_symbols(clauses), ["cons", "emp", "nil", "observe"])

    def test_selected_predicate_qualification_preserves_field_strings(self):
        source = """Fixpoint forest(p: addr)(xs: list Z): Assertion :=
match xs with
| nil => emp
| v :: tail => EX q: addr, &(p # "forest" ->ₛ "forest") # Ptr |-> q ** forest q tail
end."""
        clauses = parse_predicate(source, "forest")
        equations = emit_equations(clauses, "Library", "forest")
        self.assertIn('p # "forest" ->ₛ "forest"', equations)
        self.assertIn("Library.forest q tail", equations)
        self.assertIn("unfold Library.forest at 1; fold Library.forest", equations)
        self.assertIn(
            "Library.forest p ((@cons Z v tail))",
            emit_model_refinements(clauses, module="Library"),
        )

    def nested_layout(self):
        layout = {
            "schema": "sac-target-layout/v1",
            "architecture_bits": 64,
            "pointer_size": 8,
            "aliases": [],
            "aggregates": [
                {
                    "id": 1,
                    "kind": "struct",
                    "name": "Envelope",
                    "defined": True,
                    "size": 16,
                    "alignment": 8,
                    "fields": [],
                }
            ],
        }
        outer = layout["aggregates"][0]
        outer.update(name="Envelope", size=16, alignment=8)
        outer["fields"] = [
            {
                "id": 2,
                "name": "payload",
                "offset": 8,
                "size": 8,
                "alignment": 4,
                "computational": True,
                "type": {"kind": "union", "id": 3},
            }
        ]
        layout["aggregates"] += [
            {
                "id": 3,
                "name": "Payload",
                "kind": "union",
                "defined": True,
                "size": 8,
                "alignment": 4,
                "fields": [
                    {
                        "id": 4,
                        "name": "part",
                        "offset": 0,
                        "size": 8,
                        "alignment": 4,
                        "computational": True,
                        "type": {"kind": "struct", "id": 5},
                    }
                ],
            },
            {
                "id": 5,
                "name": "Part",
                "kind": "struct",
                "defined": True,
                "size": 8,
                "alignment": 4,
                "fields": [
                    {
                        "id": 6,
                        "name": "value",
                        "offset": 4,
                        "size": 4,
                        "alignment": 4,
                        "computational": True,
                        "type": {"kind": "basic", "name": "int"},
                    }
                ],
            },
        ]
        return layout

    def test_nested_struct_union_uses_each_admitted_offset(self):
        source = """Definition owned (p: addr) (v: Z): Assertion :=
 (&((p) # "Envelope" ->ₛ "payload" .ₛ "part" .ₛ "value") # Int |-> v)."""
        with self.assertRaisesRegex(JobError, "requires a target layout"):
            parse_predicate(source, "owned")
        clauses = parse_predicate(source, "owned", target_layout=self.nested_layout())
        clause = clauses[0][2]
        self.assertTrue(clause.uses_layout)
        self.assertEqual(clause.atoms[0][0], "store((((p + 8) + 0) + 4), I32, v)")
        self.assertEqual(clause.atoms[0][1], "(((p + 8) + 0) + 4) # Int |-> v")
        self.assertIn(
            "(((p + 8) + 0) + 4)", emit_equations(clauses, "Definitions", "owned")
        )

    def test_parenthesized_spatial_application_keeps_resource(self):
        clauses = parse_predicate(
            "Definition f (p: addr)(v: Z): Assertion := emp ** (cell p v).", "f"
        )
        self.assertIn("left_add(cell(p, v))", emit_rules(clauses))

    def test_original_recursive_pointer_segment_keeps_address_argument(self):
        source = (
            Path(__file__).resolve().parents[1]
            / "runtime/qcip/SeparationLogic/examples/QCP_demos_human/sll_lib.v"
        ).read_text()
        clauses = parse_predicate(source, "sllbseg")
        self.assertEqual(len(clauses), 2)
        recursive = clauses[1][2].atoms[-1]
        self.assertEqual(recursive[0], "sllbseg(field_addr(z, list, next), y, l0)")
        self.assertEqual(recursive[1], 'sllbseg (&(z # "list" ->ₛ "next")) y l0')
        self.assertIn("left_add(store(x, PTR(void), z))", emit_rules(clauses))

    def test_original_queue_preserves_typed_list_expressions_and_function_identities(
        self,
    ):
        source = (
            Path(__file__).resolve().parents[1]
            / "runtime/qcip/SeparationLogic/examples/QCP_demos_human/functional_queue_lib.v"
        ).read_text()
        clauses = parse_predicate(source, "store_queue")
        self.assertEqual(
            referenced_symbols(clauses),
            ["app", "cons", "nil", "rev", "sll", "store_queue"],
        )
        self.assertIn("left_add(l == app{Z}(l1, rev{Z}(l2)))", emit_rules(clauses))
        equations = emit_equations(clauses, "Definitions", "store_queue")
        self.assertIn("@app = @Coq.Lists.List.app", equations)
        self.assertIn("@rev = @Coq.Lists.List.rev", equations)
        self.assertIn("(@app Z l1 (@rev Z l2))", equations)

    def test_list_append_is_right_associative_and_application_precedes_it(self):
        source = """Definition relation (x a b c: list Z): Assertion :=
“ x = a ++ rev b ++ c ” && emp."""
        clauses = parse_predicate(source, "relation")
        self.assertIn("x == app{Z}(a, app{Z}(rev{Z}(b), c))", emit_rules(clauses))

    def test_nested_function_terms_are_preserved_in_pure_spatial_and_storage_atoms(
        self,
    ):
        source = """Definition relation (p: addr)(v: Z): Assertion :=
“ transform v = v ” && cell p (transform v) ** p # Int |-> (transform v)."""
        clauses = parse_predicate(source, "relation")
        self.assertEqual(referenced_symbols(clauses), ["cell", "relation", "transform"])
        rules = emit_rules(clauses)
        for expression in (
            "transform(v) == v",
            "cell(p, transform(v))",
            "store(p, I32, transform(v))",
        ):
            self.assertIn(expression, rules)

    def test_ill_typed_list_terms_and_higher_order_parameters_are_rejected(self):
        for body in ("rev x", "app xs x", "rev xs xs", "xs ++ x", "f x"):
            with self.subTest(body=body), self.assertRaises(JobError):
                parse_predicate(
                    "Definition relation (x: Z)(xs: list Z)(f: Z -> Z): Assertion := "
                    + "“ xs = "
                    + body
                    + " ” && emp.",
                    "relation",
                )

    def test_other_name_evaluated_builtins_require_a_semantic_schema(self):
        for function in ("sum", "Znth", "replace_Znth", "signed_last_nbits"):
            with (
                self.subTest(function=function),
                self.assertRaisesRegex(JobError, "registered semantic schema"),
            ):
                parse_predicate(
                    f"Definition owned(p: addr)(v: Z): Assertion := p # Int |-> ({function} v).",
                    "owned",
                )

    def test_address_arguments_share_cell_translation_with_arbitrary_names(self):
        for tag, field in (("Box", "slot"), ("RenamedRecord", "changed")):
            source = (
                f"Definition owned (p: addr)(v: Z): Assertion := "
                f'cell ((&(p # "{tag}" ->ₛ "{field}"))) (v) ** '
                f'(&(p # "{tag}" ->ₛ "{field}")) # Int |-> v.'
            )
            clause = parse_predicate(source, "owned")[0][2]
            self.assertEqual(
                clause.atoms[0][0], f"cell(field_addr(p, {tag}, {field}), v)"
            )
            self.assertEqual(
                clause.atoms[1][0], f"store(field_addr(p, {tag}, {field}), I32, v)"
            )
            self.assertEqual(
                referenced_symbols([(None, None, clause)]), ["cell", "owned"]
            )

    def test_nested_address_argument_requires_admitted_layout(self):
        source = """Definition owned(p: addr)(v: Z): Assertion :=
cell (&(p # "Envelope" ->ₛ "payload" .ₛ "part" .ₛ "value")) v."""
        with self.assertRaisesRegex(JobError, "requires a target layout"):
            parse_predicate(source, "owned")
        clause = parse_predicate(source, "owned", target_layout=self.nested_layout())[
            0
        ][2]
        self.assertTrue(clause.uses_layout)
        self.assertEqual(clause.atoms[0][0], "cell((((p + 8) + 0) + 4), v)")
        self.assertEqual(clause.atoms[0][1], "cell ((((p + 8) + 0) + 4)) v")

    def test_malformed_or_unbound_address_argument_is_rejected(self):
        for term in (
            '(&(missing # "Box" ->ₛ "slot"))',
            "(p",
            "p)",
            '"p',
            "(p + 4)",
            "unknown p",
        ):
            with self.subTest(term=term), self.assertRaises(JobError):
                parse_predicate(
                    f"Definition owned(p: addr): Assertion := cell {term}.", "owned"
                )

    def test_direct_cells_preserve_all_storage_types_and_literals(self):
        for typ, qtype in (
            ("Char", "I8"),
            ("UChar", "U8"),
            ("Short", "I16"),
            ("UShort", "U16"),
            ("Int", "I32"),
            ("UInt", "U32"),
            ("Int64", "I64"),
            ("UInt64", "U64"),
            ("Ptr", "PTR(void)"),
        ):
            with self.subTest(typ=typ):
                clauses = parse_predicate(
                    f"Definition f(p: addr)(v: Z): Assertion := p # {typ} |-> v.", "f"
                )
                self.assertEqual(clauses[0][2].atoms[0][0], f"store(p, {qtype}, v)")
                self.assertFalse(clauses[0][2].uses_layout)
                self.assertEqual(referenced_symbols(clauses), ["f"])
        literal = parse_predicate(
            "Definition f(p: addr): Assertion := p # Int |-> INT_MIN.", "f"
        )
        self.assertIn("store(p, I32, (-2147483648))", emit_rules(literal))

    def test_nested_paths_reject_pointer_traversal_and_ambiguous_tags(self):
        source = """Definition f(p: addr)(v: Z): Assertion :=
 &(p # "Envelope" ->ₛ "payload" .ₛ "part" .ₛ "value") # Int |-> v."""
        layout = self.nested_layout()
        layout["aggregates"][0]["fields"][0].update(
            type={"kind": "pointer", "target": {"kind": "struct", "id": 5}}, alignment=8
        )
        with self.assertRaisesRegex(JobError, "implicit dereference"):
            parse_predicate(source, "f", target_layout=layout)
        layout = self.nested_layout()
        layout["aggregates"].append(
            {
                "id": 99,
                "kind": "struct",
                "name": "Envelope",
                "defined": False,
                "fields": [],
            }
        )
        with self.assertRaisesRegex(JobError, "ambiguous aggregate"):
            parse_predicate(source, "f", target_layout=layout)

    def test_plain_definition_preserves_list_witness_and_called_predicate(self):
        source = (
            "Definition owned (p: addr): Assertion := EX xs: list Z, sequence p xs."
        )
        clauses = parse_predicate(source, "owned")
        self.assertEqual(clauses[0][0], "owned(?p)")
        self.assertEqual(clauses[0][2].existential_types, ("list Z",))
        self.assertEqual(referenced_symbols(clauses), ["owned", "sequence"])
        rules = emit_rules(clauses, infer_models=True)
        self.assertIn("left_exist_add(xs : list{Z})", rules)
        self.assertIn("left_add(sequence(p, xs))", rules)
        self.assertNotIn("_exist_add(p", rules)
        self.assertEqual(rules.count("id :"), 2)
        equations = emit_equations(clauses, "Definitions", "owned")
        self.assertIn("EX (xs: list Z),", equations)
        self.assertEqual(emit_model_refinements(clauses), "\n")

    def test_grouped_existentials_keep_types_and_resource_order(self):
        source = """Definition pair (p: addr): Assertion :=
EX (x y: addr) (a b: list Z), first x a ** second y b."""
        clause = parse_predicate(source, "pair")[0][2]
        self.assertEqual(clause.existentials, ("x", "y", "a", "b"))
        self.assertEqual(clause.existential_types, ("addr", "addr", "list Z", "list Z"))
        self.assertEqual(
            [atom[0] for atom in clause.atoms], ["first(x, a)", "second(y, b)"]
        )

    def test_definition_constructor_match_and_nullary_definition(self):
        matched = "Definition f (p: addr) (t: T): Assertion := match t with | C v => relation p v end."
        clauses = parse_predicate(matched, "f")
        self.assertEqual(clauses[0][0], "f(?p, C(?v))")
        empty = parse_predicate("Definition vacant : Assertion := emp.", "vacant")
        self.assertEqual(empty[0][0], "vacant()")
        self.assertNotIn("forall ,", emit_equations(empty, "Definitions", "vacant"))
        compact = parse_predicate(
            "Definition compact(p: addr)(v: Z): Assertion := cell p v.", "compact"
        )
        self.assertEqual(compact[0][0], "compact(?p, ?v)")
        listed = parse_predicate(
            "Definition f (l: list  Z): Assertion := match l with | nil => emp | x::xs => emp end.",
            "f",
        )
        self.assertEqual(listed[1][0], "f(cons{Z}(?x, ?xs))")

    def test_typed_existential_capture_and_unsupported_types_rejected(self):
        for body in (
            "EX (p: addr), emp",
            "EX (x), emp",
        ):
            with self.subTest(body=body), self.assertRaises(JobError):
                parse_predicate(
                    "Definition f (p: addr): Assertion := " + body + ".", "f"
                )

    def test_nominal_witnesses_and_pure_relations_keep_their_types(self):
        source = """Inductive Model : Type := Leaf : Model.
Definition shape(p: addr)(m: Model): Assertion := emp.
Definition observe(p: addr): Assertion := EX m, shape p m.
"""
        clauses = parse_predicate(source, "observe")
        self.assertEqual(clauses[0][2].existential_types, ("Model",))
        self.assertIn("left_exist_add(m : Model)", emit_rules(clauses))
        self.assertIn("Model", referenced_symbols(clauses))
        relation = parse_predicate(
            "Definition observe(p: addr): Assertion := EX (m: Model) (xs: list Model), “ admissible m xs ” && p # Int |-> 7.",
            "observe",
        )
        self.assertIn("left_exist_add(xs : list{Model})", emit_rules(relation))
        self.assertIn("admissible", referenced_symbols(relation))
        self.assertIn(
            "EX (m: Model) (xs: list Model)",
            emit_equations(relation, "Definitions", "observe"),
        )
        with self.assertRaisesRegex(JobError, "conflicting existential"):
            parse_predicate(
                source.replace("shape p m.", "shape p m ** m # Int |-> 0."), "observe"
            )

    def test_submodule_definition_names_are_preserved(self):
        source = """Module Parent.
Module Child.
Definition observe(p: addr): Assertion := EX m: Model, “ valid m ” && p # Int |-> 7.
End Child.
End Parent."""
        clauses = parse_predicate(source, "observe")
        self.assertEqual(clauses[0][0], "Parent::Child::observe(?p)")
        equations = emit_equations(clauses, "Definitions", "observe")
        self.assertIn("Import Definitions.Parent.Child.", equations)
        self.assertIn("Definitions.Parent.Child.observe p =", equations)
        self.assertIn("@Definitions.Parent.Child.observe", equations)

    def test_literals_and_all_global_application_heads_share_encoding(self):
        source = """Fixpoint owned (p: addr) (t: T): Assertion :=
match t with
| Empty => “ p = NULL ” && emp
| Node value => relation p INT_MIN ** owned p value
end."""
        clauses = parse_predicate(source, "owned")
        self.assertEqual(
            referenced_symbols(clauses), ["Empty", "Node", "emp", "owned", "relation"]
        )
        equations = emit_equations(clauses, "Definitions", "owned")
        self.assertIn("“ p = 0 ”", equations)
        self.assertIn("relation p (-2147483648)", equations)
        self.assertNotIn("INT_MIN", equations)
        self.assertNotIn("NULL", equations)

    def test_arbitrary_names_and_all_owned_fields_are_preserved(self):
        source = """Fixpoint forest (base: addr) (shape: Branches): Assertion :=
match shape with
| Vacant => “ base = NULL ” && emp
| Fork a payload b => “ base <> NULL ” && EX x y: addr,
  &(base # "record" ->ₛ "value") # Int |-> payload **
  &(base # "record" ->ₛ "first") # Ptr |-> x **
  &(base # "record" ->ₛ "second") # Ptr |-> y **
  forest x a ** forest y b
end."""
        clauses = parse_predicate(source, "forest")
        self.assertEqual(len(clauses), 2)
        self.assertEqual(clauses[1][2].existentials, ("x", "y"))
        rules = emit_rules(clauses)
        self.assertIn("forest(?base, Fork(?a, ?payload, ?b))", rules)
        for term in ["field_addr(base, record, value)", "forest(x, a)", "forest(y, b)"]:
            self.assertEqual(rules.count(term), 2)
        self.assertIn("base != 0", rules)
        equations = emit_equations(clauses, "Definitions", "forest")
        self.assertIn("forest base (Fork a payload b)", equations)
        self.assertIn('&(base # "record" ->ₛ "second") # Ptr |-> y', equations)

    def test_original_tree_list_and_segment_parse_without_name_dispatch(self):
        runtime = (
            Path(__file__).resolve().parents[1]
            / "runtime/qcip/SeparationLogic/examples/QCP_demos_human"
        )
        for file, name in [
            ("bst_lib.v", "store_tree"),
            ("sll_lib.v", "sll"),
            ("sll_lib.v", "sllseg"),
        ]:
            with self.subTest(name=name):
                clauses = parse_predicate((runtime / file).read_text(), name)
                self.assertEqual(len(clauses), 2)

    def test_model_choice_keeps_equality_on_goal_and_handles_literal_base(self):
        source = """Fixpoint shape (base: addr) (model: T): Assertion :=
match model with
| Stop => “ base = 7 ” && emp
| More value tail => “ base <> 7 ” && EX next: addr,
 &(base # "record" ->ₛ "value") # Int |-> value **
 &(base # "record" ->ₛ "next") # Ptr |-> next ** shape next tail
end."""
        clauses = parse_predicate(source, "shape")
        rules = emit_rules(clauses, infer_models=True)
        self.assertIn("right : shape(7, ?model)", rules)
        self.assertIn("left : (?base != 7)", rules)
        self.assertIn("right_add(model == More(value, tail))", rules)
        self.assertNotIn("left_add(model ==", rules)
        self.assertIn("right_exist_add(tail)", rules)
        self.assertIn("model = (More value tail)", emit_model_refinements(clauses))

    def test_wildcard_constructor_binder_is_rejected(self):
        with self.assertRaises(JobError):
            parse_predicate(
                "Fixpoint f (p: addr) (t: T): Assertion := "
                "match t with | C _ => emp end.",
                "f",
            )

    def test_unsupported_constructs_and_capture_are_rejected(self):
        template = (
            "Fixpoint f (p: addr) (t: T): Assertion := match t with | C x => BODY end."
        )
        for body in [
            "EX p: addr, emp",
            "EX _: addr, emp",
            "unknown free",
            "“ forall n, n = n ” && emp",
            "match x with | D => emp end",
        ]:
            with self.subTest(body=body), self.assertRaises(JobError):
                parse_predicate(template.replace("BODY", body), "f")


if __name__ == "__main__":
    unittest.main()
