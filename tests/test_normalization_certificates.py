import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from spectest.certificates import digest, goal_interface
from spectest.core import JobError
from spectest.normalization_certificates import (
    check_predicate_normalization,
    prepare_predicate_normalization,
    seal_predicate_normalization,
)


ROOT = Path(__file__).resolve().parents[1]
DEFINITION = """Fixpoint forest (base: addr) (shape: Branches): Assertion :=
match shape with
| Vacant => “ base = NULL ” && emp
| Fork a payload b => “ base <> NULL ” && EX x y: addr,
  &(base # "record" ->ₛ "value") # Int |-> payload **
  &(base # "record" ->ₛ "first") # Ptr |-> x **
  &(base # "record" ->ₛ "second") # Ptr |-> y **
  forest x a ** forest y b
end.
"""


class NormalizationCertificateTests(unittest.TestCase):
    def test_pure_projection_pins_equations_without_emitting_layout_actions(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "Definitions.v"
            source.write_text(DEFINITION)
            request = prepare_predicate_normalization(
                source,
                "Definitions",
                "forest",
                ROOT / "runtime/qcip",
                root / "bundle",
                execution_scope="checked_facts",
                pure_facts_only=True,
            )
            bundle = json.loads(Path(request["manifest"]).read_text())
            details = bundle["normalization"]
            self.assertEqual(details["normalization_kind"], "pure-fact-projection")
            self.assertFalse(details["uses_field_addresses"])
            rules = (
                Path(request["manifest"]).parent / "Normalization.strategies"
            ).read_text()
            self.assertNotIn("field_addr", rules)
            self.assertNotIn("left_erase", rules)
            self.assertEqual(details["rule_ids"], [10000, 10001])
            with self.assertRaisesRegex(JobError, "cannot propose"):
                prepare_predicate_normalization(
                    source,
                    "Definitions",
                    "forest",
                    ROOT / "runtime/qcip",
                    root / "invalid",
                    pure_facts_only=True,
                    infer_models=True,
                )
            self.assertFalse((root / "invalid").exists())

    def test_original_dependencies_are_imported_before_qualified_definition(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "Definitions.v"
            source.write_text(
                "(* Require Import Ignored. *)\n"
                "From SimpleC.EE.QCP_demos_human Require Import sll_lib.\n"
                "Require Import Coq.Lists.List.\n"
                "Definition f(p: addr)(xs: list Z): Assertion := sll p xs."
            )
            request = prepare_predicate_normalization(
                source, "Definitions", "f", ROOT / "runtime/qcip", root / "bundle"
            )
            bundle = json.loads(Path(request["manifest"]).read_text())
            goal = (Path(request["manifest"]).parent / "Goal.v").read_text()
            self.assertEqual(
                bundle["normalization"]["context_modules"],
                ["SimpleC.EE.QCP_demos_human.sll_lib", "Coq.Lists.List"],
            )
            self.assertLess(
                goal.index("Require Import SimpleC.EE.QCP_demos_human.sll_lib."),
                goal.index("Require Import Definitions."),
            )
            self.assertIn("Definitions.f p xs =", goal)
            self.assertEqual(
                bundle["normalization"]["symbol_references"]["f"], "Definitions.f"
            )

    def test_cell_and_existential_interpretations_and_memory_model_are_frozen(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "Definitions.v"
            source.write_text(
                "Definition f(p: addr): Assertion := EX v: Z, p # UInt64 |-> v."
            )
            request = prepare_predicate_normalization(
                source,
                "Definitions",
                "f",
                ROOT / "runtime/qcip",
                root / "bundle",
                target_layout={"memory_rules": "Snaive_C_Rules"},
            )
            bundle = json.loads(Path(request["manifest"]).read_text())
            details = bundle["normalization"]
            self.assertEqual(details["memory_rules"], "Snaive_C_Rules")
            self.assertEqual(
                details["semantic_bindings"]["store_UInt64"],
                "(fun (a v : Z) => a # UInt64 |-> v)",
            )
            self.assertIn("exists_Z", details["semantic_bindings"])
            goal = (Path(request["manifest"]).parent / "Goal.v").read_text()
            self.assertIn("Import Snaive_C_Rules.", goal)
            self.assertIn("normalization_semantics_store_UInt64", goal)

    def test_nested_offsets_pin_layout_bytes_and_semantic_digest(self):
        from tests.test_rocq_predicates import RocqPredicateTests
        from spectest.layout import target_layout_digest

        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            layout = RocqPredicateTests().nested_layout()
            definition = root / "Definitions.v"
            definition.write_text(
                'Definition f(p: addr)(v: Z): Assertion := &(p # "Envelope" ->ₛ "payload" .ₛ "part" .ₛ "value") # Int |-> v.'
            )
            request = prepare_predicate_normalization(
                definition,
                "Definitions",
                "f",
                ROOT / "runtime/qcip",
                root / "bundle",
                target_layout=layout,
                execution_scope="checked_defs",
            )
            path = Path(request["manifest"])
            bundle = json.loads(path.read_text())
            self.assertEqual(
                bundle["normalization"]["layout_sha256"], target_layout_digest(layout)
            )
            self.assertTrue(bundle["normalization"]["uses_field_addresses"])
            self.assertEqual(bundle["target_layout"], layout)
            self.assertEqual(
                json.loads((path.parent / "TargetLayout.json").read_text()), layout
            )
            self.assertEqual(
                bundle["immutable_sha256"]["TargetLayout.json"],
                digest(path.parent / "TargetLayout.json"),
            )

    def test_sealing_selects_only_certified_left_clauses(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "Definitions.v"
            source.write_text(DEFINITION)
            request = prepare_predicate_normalization(
                source,
                "Definitions",
                "forest",
                ROOT / "runtime/qcip",
                root / "bundle",
                execution_scope="checked_defs",
                infer_models=True,
            )
            with patch(
                "spectest.normalization_certificates.check_predicate_normalization",
                return_value={"status": "PASS"},
            ) as checker:
                result = seal_predicate_normalization(
                    request["manifest"], request["manifest_sha256"], root / "activation"
                )
            checker.assert_called_once()
            self.assertEqual(result["executor_args"][-1], "10000,10002")
            self.assertEqual(result["program_association"], "NOT_CHECKED")
            self.assertEqual(digest(Path(result["rules"])), result["rules_sha256"])
            self.assertIn(request["manifest_sha256"], Path(result["rules"]).stem)

    def test_failed_or_modified_proof_never_produces_activation(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "Definitions.v"
            source.write_text(DEFINITION)
            request = prepare_predicate_normalization(
                source,
                "Definitions",
                "forest",
                ROOT / "runtime/qcip",
                root / "bundle",
                execution_scope="checked_defs",
            )
            with patch(
                "spectest.normalization_certificates.check_predicate_normalization",
                return_value={"status": "UNKNOWN"},
            ):
                result = seal_predicate_normalization(
                    request["manifest"], request["manifest_sha256"], root / "activation"
                )
            self.assertEqual(result["activation"], "UNAVAILABLE")
            self.assertFalse((root / "activation").exists())
            rules = Path(request["manifest"]).parent / "Normalization.strategies"

            def mutate(*args, **kwargs):
                rules.write_text(rules.read_text() + "\n")
                return {"status": "PASS"}

            with patch(
                "spectest.normalization_certificates.check_predicate_normalization",
                side_effect=mutate,
            ):
                with self.assertRaisesRegex(JobError, "rules changed"):
                    seal_predicate_normalization(
                        request["manifest"],
                        request["manifest_sha256"],
                        root / "activation",
                    )
            self.assertFalse((root / "activation").exists())

    def test_execution_scope_and_notation_context_are_fixed(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "Definitions.v"
            source.write_text(DEFINITION)
            for scope in ("core", "post", "bad scope"):
                with self.assertRaisesRegex(JobError, "dedicated"):
                    prepare_predicate_normalization(
                        source,
                        "Definitions",
                        "forest",
                        ROOT / "runtime/qcip",
                        root / "bundle",
                        execution_scope=scope,
                    )
                self.assertFalse((root / "bundle").exists())
            request = prepare_predicate_normalization(
                source,
                "Definitions",
                "forest",
                ROOT / "runtime/qcip",
                root / "bundle",
                execution_scope="checked_defs",
                notation_imports=("Layout.AddressNotations",),
            )
            path = Path(request["manifest"])
            manifest = json.loads(path.read_text())
            self.assertEqual(
                manifest["normalization"]["execution_scope"], "checked_defs"
            )
            self.assertEqual(
                manifest["normalization"]["notation_imports"],
                ["Layout.AddressNotations"],
            )
            self.assertIn(
                "priority : checked_defs(3)",
                (path.parent / "Normalization.strategies").read_text(),
            )
            self.assertIn(
                "Import Layout.AddressNotations.", (path.parent / "Goal.v").read_text()
            )

    def test_rule_ids_validate_before_producing_output(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "Definitions.v"
            source.write_text(DEFINITION)
            for start in (-1, True, 2147483647):
                with self.assertRaises(JobError):
                    prepare_predicate_normalization(
                        source,
                        "Definitions",
                        "forest",
                        ROOT / "runtime/qcip",
                        root / "bundle",
                        first_rule_id=start,
                    )
                self.assertFalse((root / "bundle").exists())

    def test_runtime_definition_preserves_qualified_identity(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            runtime = root / "qcip/SeparationLogic"
            source = runtime / "examples/Arbitrary/Definitions.v"
            source.parent.mkdir(parents=True)
            source.write_text(DEFINITION)
            (runtime / "_CoqProject").write_text("")
            request = prepare_predicate_normalization(
                source,
                "SimpleC.EE.Arbitrary.Definitions",
                "forest",
                root / "qcip",
                root / "bundle",
                runtime_definition=True,
                first_rule_id=24000,
            )
            manifest = Path(request["manifest"])
            bundle = json.loads(manifest.read_text())
            self.assertEqual(bundle["dependencies"], [])
            self.assertIn(
                "Require Import SimpleC.EE.Arbitrary.Definitions.",
                (manifest.parent / "Goal.v").read_text(),
            )
            self.assertIn(
                "id : 24000", (manifest.parent / "Normalization.strategies").read_text()
            )
            self.assertEqual(
                bundle["normalization"]["definition_origin"], "pinned-runtime"
            )
            self.assertEqual(
                bundle["normalization"]["rule_ids"], [24000, 24001, 24002, 24003]
            )

    def test_wrong_runtime_identity_and_namespace_shadow_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "Definitions.v"
            source.write_text(DEFINITION)
            for options, message in (
                ({"runtime_definition": True}, "load path"),
                ({}, "shadows a trusted library"),
            ):
                with self.assertRaisesRegex(JobError, message):
                    prepare_predicate_normalization(
                        source,
                        "SimpleC.EE.Arbitrary.Definitions",
                        "forest",
                        ROOT / "runtime/qcip",
                        root / "bundle",
                        **options,
                    )
                self.assertFalse((root / "bundle").exists())

    def test_complete_interface_and_rules_are_pinned_before_check(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "Definitions.v"
            source.write_text(DEFINITION)
            request = prepare_predicate_normalization(
                source,
                "Definitions",
                "forest",
                ROOT / "runtime/qcip",
                root / "bundle",
                infer_models=True,
            )
            path = Path(request["manifest"])
            self.assertEqual(request["status"], "PREPARED_UNCHECKED")
            self.assertEqual(
                len(goal_interface((path.parent / "Goal.v").read_text())), 4
            )
            bundle = json.loads(path.read_text())
            rules = path.parent / "Normalization.strategies"
            self.assertEqual(bundle["immutable_sha256"][rules.name], digest(rules))
            stale = path.parent / "normalization-report.json"
            stale.write_text('{"activation":"CHECKED"}')
            rules.write_text(
                rules.read_text().replace("record, second", "record, first")
            )
            with self.assertRaisesRegex(
                JobError, "immutable certificate input changed"
            ):
                check_predicate_normalization(path, request["manifest_sha256"])
            self.assertFalse(stale.exists())

    def test_unsupported_definition_never_gets_a_bundle(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "Definitions.v"
            source.write_text(DEFINITION.replace("emp", "mysterious unbound"))
            with self.assertRaises(JobError):
                prepare_predicate_normalization(
                    source,
                    "Definitions",
                    "forest",
                    ROOT / "runtime/qcip",
                    root / "bundle",
                )
            self.assertFalse((root / "bundle").exists())
