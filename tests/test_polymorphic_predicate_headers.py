import unittest
import tempfile
from pathlib import Path
from unittest.mock import patch

from spectest.normalization_association import NormalizationCompatibilityError
from spectest.normalized_execution import run_normalized_case

from spectest.core import JobError
from spectest.rocq_predicates import parse_predicate, emit_rules, emit_equations


class PolymorphicPredicateHeaderTests(unittest.TestCase):
    def wrapper(self, name="envelope", typ="T", payload="payload"):
        return f"""Definition {name} {{{typ}: Type}}
          ({payload}: addr -> {typ} -> Assertion) (p: addr)
          (items: list ({typ})) (value: {typ}): Assertion :=
          EX (next: addr), p # Ptr |-> next ** {payload} next value.
        """

    def test_type_parameter_is_retained_in_rule_and_equation(self):
        clauses = parse_predicate(self.wrapper(), "envelope")
        self.assertIn("envelope{?T}(?payload, ?p, ?items, ?value)", emit_rules(clauses))
        equation = emit_equations(clauses, "Fixture", "envelope")
        self.assertIn("forall T payload p items value,", equation)
        self.assertIn("Fixture.envelope (T := T) payload p items value", equation)
        self.assertIn("payload next value", equation)

    def test_renamed_predicate_uses_same_generic_path(self):
        clauses = parse_predicate(
            self.wrapper("renamed", "Element", "cells"), "renamed"
        )
        self.assertIn(
            "renamed{?Element}(?cells, ?p, ?items, ?value)", emit_rules(clauses)
        )
        self.assertEqual(clauses[0][2].type_parameters, ("Element",))

    def test_nested_function_and_record_types_are_balanced(self):
        source = "Definition wrap {A: Type} (f: (Z -> A) -> Assertion) (xs: list (Box A)): Assertion := emp."
        clauses = parse_predicate(source, "wrap")
        self.assertIn("wrap{?A}(?f, ?xs)", emit_rules(clauses))

    def test_implicit_values_and_malformed_binders_are_rejected(self):
        for source in [
            "Definition wrap {n: Z}: Assertion := emp.",
            "Definition wrap (p: list (Z): Assertion := emp.",
            "Definition wrap {A: Type) (p: Z): Assertion := emp.",
            "Definition wrap {A: Type} (A: Z): Assertion := emp.",
        ]:
            with self.subTest(source=source), self.assertRaises(JobError):
                parse_predicate(source, "wrap")

    def test_unsupported_polymorphic_model_inference_is_rejected(self):
        clauses = parse_predicate(self.wrapper(), "envelope")
        with self.assertRaisesRegex(JobError, "polymorphic constructor inference"):
            emit_rules(clauses, infer_models=True)


class CompatibilityOutcomeTests(unittest.TestCase):
    def test_unproved_layout_stops_execution_as_unknown(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / "run"
            with patch(
                "spectest.normalized_execution._run_normalized_case",
                side_effect=NormalizationCompatibilityError(
                    "field normalization requires actual computational layout"
                ),
            ):
                report = run_normalized_case("job", "normalization", "digest", output)
            self.assertEqual(report["status"], "UNKNOWN")
            self.assertEqual(report["reason"], "normalization_layout_unproved")
            self.assertEqual(report["execution"], "NOT_RUN")
            self.assertEqual(report["results"], [])

    def test_corrupt_context_remains_error(self):
        with tempfile.TemporaryDirectory() as directory:
            with patch(
                "spectest.normalized_execution._run_normalized_case",
                side_effect=JobError("normalization immutable input changed"),
            ):
                report = run_normalized_case(
                    "job", "normalization", "digest", Path(directory) / "run"
                )
            self.assertEqual(report["status"], "ERROR")
            self.assertEqual(report["execution"], "NOT_RUN")


if __name__ == "__main__":
    unittest.main()
