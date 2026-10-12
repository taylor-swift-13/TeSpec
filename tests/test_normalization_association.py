import json
import os
from pathlib import Path
import tempfile
import unittest

from spectest.certificates import check_certificate, digest, tree_digest
from spectest.core import JobError
from spectest.normalization_association import prepare_normalization_association


class AssociationPreparationTests(unittest.TestCase):
    def fixture(self, root):
        runtime = root / "runtime/SeparationLogic"
        runtime.mkdir(parents=True)
        (runtime / "_CoqProject").write_text("")
        files = {}
        for name, text in {
            "input.c": "int example(void);",
            "binary": "unit fixture, not an executable",
            "layout.v": "unused abstract-layout fixture",
            "header.v": "Require Import Definitions.\nRequire Import Other.\n",
            "Definitions.v": "Definition predicate := True.\n",
        }.items():
            path = root / name
            path.write_text(text)
            files[name] = {"path": str(path), "sha256": digest(path)}
        dependencies = [
            {
                "module": "Definitions",
                "staged": files["Definitions.v"]["path"],
                "sha256": files["Definitions.v"]["sha256"],
            }
        ]
        program = {
            "schema": "tespec-program-preflight/v1",
            "execution": "NOT_RUN",
            "status": "PARSED",
            "qcip_root": str(runtime.parent),
            "input": files["input.c"],
            "binary": files["binary"],
            "generated_layout": files["layout.v"],
            "coq_header": files["header.v"],
            "context_files": [],
            "coq_dependencies": dependencies,
            "target_layout": None,
        }
        normal = root / "normal"
        (normal / "dependencies").mkdir(parents=True)
        definition = normal / "dependencies/Definitions.v"
        definition.write_bytes(Path(files["Definitions.v"]["path"]).read_bytes())
        normalization = {
            "scope": "predicate-normalization-equations",
            "runtime": str(runtime),
            "runtime_sha256": tree_digest(runtime),
            "immutable_sha256": {},
            "dependencies": [
                {
                    "module": "Definitions",
                    "file": "dependencies/Definitions.v",
                    "sha256": digest(definition),
                }
            ],
            "normalization": {
                "module": "Definitions",
                "predicate": "predicate",
                "definition_origin": "task-dependency",
                "definition_sha256": digest(definition),
            },
        }
        preflight = root / "preflight.json"
        manifest = normal / "manifest.json"
        preflight.write_text(json.dumps(program))
        manifest.write_text(json.dumps(normalization))
        return preflight, manifest

    def test_identity_uses_original_import_order_without_new_import(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            request = prepare_normalization_association(
                p, digest(p), n, digest(n), root / "result"
            )
            goal = (root / "result/certificate/Goal.v").read_text()
            self.assertTrue(
                goal.startswith("Require Import Definitions.\nRequire Import Other.\n")
            )
            self.assertIn("@predicate = @Definitions.predicate", goal)
            self.assertEqual(goal.count("Require Import Definitions."), 1)
            self.assertEqual(request["status"], "PREPARED_UNCHECKED")
            bundle = json.loads(Path(request["manifest"]).read_text())
            self.assertEqual(bundle["association"]["authorization"], "NOT_GRANTED")

    def test_changed_header_rejected_before_preparation(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            (root / "header.v").write_text("Require Import Imposter.")
            with self.assertRaisesRegex(JobError, "context changed"):
                prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "result"
                )
            self.assertFalse((root / "result").exists())

    def test_different_program_definition_rejected_even_with_fresh_manifest_hash(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            definition = root / "Definitions.v"
            definition.write_text("Definition predicate := False.")
            program = json.loads(p.read_text())
            program["coq_dependencies"][0]["sha256"] = digest(definition)
            p.write_text(json.dumps(program))
            with self.assertRaisesRegex(JobError, "definition mismatch"):
                prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "result"
                )
            self.assertFalse((root / "result").exists())

    def add_bindings(self, manifest):
        normalization = json.loads(manifest.read_text())
        bindings = {
            "predicate": "normalization_binding_0",
            "Constructor": "normalization_binding_1",
            "relation": "normalization_binding_2",
        }
        goal = manifest.parent / "Goal.v"
        goal.write_text(
            "Require Import Definitions.\n"
            + "".join(
                f"Definition {alias} := @{name}.\n" for name, alias in bindings.items()
            )
        )
        normalization["normalization"]["symbol_bindings"] = bindings
        normalization["immutable_sha256"]["Goal.v"] = digest(goal)
        manifest.write_text(json.dumps(normalization))

    def test_all_symbols_captured_before_importing_equations(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            self.add_bindings(n)
            request = prepare_normalization_association(
                p, digest(p), n, digest(n), root / "result"
            )
            bundle = json.loads(Path(request["manifest"]).read_text())
            goal = (root / "result/certificate/Goal.v").read_text()
            imported = "TeSpecNormalizationEquations_" + digest(n)
            for index, symbol in enumerate(("predicate", "Constructor", "relation")):
                self.assertLess(
                    goal.index(f"tespec_program_binding_{index} := @{symbol}"),
                    goal.index(f"Require Import {imported}"),
                )
                self.assertIn(f"@{imported}.normalization_binding_{index}", goal)
            self.assertEqual(
                bundle["association"]["binding_scope"], "all-referenced-symbols"
            )
            self.assertEqual(len(bundle["goals"]), 4)
            self.assertIn(
                f"@{imported}.normalization_binding_0 = @Definitions.predicate",
                goal,
            )
            self.assertEqual(bundle["dependencies"][-1]["module"], imported)

    def test_qualified_binding_is_frozen_and_program_name_stays_captured(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            self.add_bindings(n)
            normal = json.loads(n.read_text())
            refs = {
                symbol: symbol for symbol in normal["normalization"]["symbol_bindings"]
            }
            refs["predicate"] = "Definitions.predicate"
            normal["normalization"]["symbol_references"] = refs
            frozen = n.parent / "Goal.v"
            frozen.write_text(
                frozen.read_text().replace("@predicate.", "@Definitions.predicate.")
            )
            normal["immutable_sha256"]["Goal.v"] = digest(frozen)
            n.write_text(json.dumps(normal))
            request = prepare_normalization_association(
                p, digest(p), n, digest(n), root / "result"
            )
            goal = (Path(request["manifest"]).parent / "Goal.v").read_text()
            self.assertIn("tespec_program_binding_0 := @predicate.", goal)
            self.assertIn("= @Definitions.predicate.", goal)
            for refs in [
                {"predicate": "Definitions.predicate"},
                {**refs, "predicate": "Invalid reference"},
            ]:
                normal["normalization"]["symbol_references"] = refs
                n.write_text(json.dumps(normal))
                with self.assertRaisesRegex(JobError, "symbol references"):
                    prepare_normalization_association(
                        p, digest(p), n, digest(n), root / "invalid"
                    )

    def test_unfrozen_binding_context_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            self.add_bindings(n)
            normal = json.loads(n.read_text())
            normal["immutable_sha256"] = {}
            n.write_text(json.dumps(normal))
            with self.assertRaisesRegex(JobError, "context is not immutable"):
                prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "result"
                )

    def test_memory_model_mismatch_rejected_before_preparation(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            self.add_bindings(n)
            normal = json.loads(n.read_text())
            normal["normalization"].update(
                memory_rules="naive_C_Rules",
                semantic_bindings={"emp": "emp"},
            )
            n.write_text(json.dumps(normal))
            program = json.loads(p.read_text())
            program["target_layout"] = {"memory_rules": "Snaive_C_Rules"}
            p.write_text(json.dumps(program))
            with self.assertRaisesRegex(JobError, "memory rules differ"):
                prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "result"
                )
            self.assertFalse((root / "result").exists())

    def test_semantic_inventory_is_frozen_and_captured_before_import(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            self.add_bindings(n)
            normal = json.loads(n.read_text())
            expression = "(fun (a v : Z) => a # Int |-> v)"
            normal["normalization"].update(
                memory_rules="naive_C_Rules",
                semantic_bindings={"store_Int": expression},
            )
            goal = n.parent / "Goal.v"
            goal.write_text(
                goal.read_text()
                + f"Definition normalization_semantics_store_Int := {expression}.\n"
            )
            normal["immutable_sha256"]["Goal.v"] = digest(goal)
            n.write_text(json.dumps(normal))
            program = json.loads(p.read_text())
            program["target_layout"] = {"memory_rules": "naive_C_Rules"}
            p.write_text(json.dumps(program))
            request = prepare_normalization_association(
                p, digest(p), n, digest(n), root / "result"
            )
            emitted = (root / "result/certificate/Goal.v").read_text()
            self.assertLess(
                emitted.index("Definition tespec_program_semantics_store_Int"),
                emitted.index("Require Import TeSpecNormalizationEquations_"),
            )
            bundle = json.loads(Path(request["manifest"]).read_text())
            self.assertEqual(
                bundle["association"]["semantic_binding_scope"],
                "formula-notation-interpretations",
            )
            del normal["normalization"]["semantic_bindings"]["store_Int"]
            normal["normalization"]["semantic_bindings"]["emp"] = "emp"
            n.write_text(json.dumps(normal))
            with self.assertRaisesRegex(JobError, "semantics differ from frozen"):
                prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "omitted"
                )

    def test_offset_certificate_cannot_migrate_to_another_target_layout(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            normal = json.loads(n.read_text())
            normal["normalization"]["layout_sha256"] = "0" * 64
            n.write_text(json.dumps(normal))
            with self.assertRaisesRegex(
                JobError, "offsets differ from actual target layout"
            ):
                prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "result"
                )

    def test_omitted_constructor_binding_cannot_claim_complete_coverage(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            self.add_bindings(n)
            normal = json.loads(n.read_text())
            del normal["normalization"]["symbol_bindings"]["Constructor"]
            n.write_text(json.dumps(normal))
            with self.assertRaisesRegex(
                JobError, "inventory differs from frozen context"
            ):
                prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "result"
                )

    def test_field_rules_require_computational_layout_even_without_metadata(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            p, n = self.fixture(root)
            rules = n.parent / "Normalization.strategies"
            rules.write_text("left_add(data_at(field_addr(p, S, x), int, v))")
            normal = json.loads(n.read_text())
            normal["immutable_sha256"][rules.name] = digest(rules)
            n.write_text(json.dumps(normal))
            with self.assertRaisesRegex(
                JobError, "requires actual computational layout"
            ):
                prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "result"
                )

    @unittest.skipUnless(
        os.environ.get("TESPEC_TEST_ROCQ") == "1", "opt-in Rocq replay"
    )
    def test_kernel_checks_constructor_and_rhs_callee_shadowing(self):
        for kind in ("matching", "constructor", "callee", "shared-predicate"):
            with self.subTest(kind=kind), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                p, n = self.fixture(root)
                definition = root / "Definitions.v"
                definition.write_text(
                    "Inductive Shape := Empty | Constructor.\n"
                    "Definition predicate (s: Shape) : Prop := True.\n"
                    "Definition relation (s: Shape) : Prop := True.\n"
                )
                other = root / "Other.v"
                other.write_text(
                    "Require Import Definitions.\n"
                    + {
                        "matching": "Definition unrelated := True.\n",
                        "constructor": "Definition Constructor := Definitions.Empty.\n",
                        "callee": "Definition relation (s: Shape) : Prop := False.\n",
                        "shared-predicate": "Definition predicate (s: Shape) : Prop := False.\n",
                    }[kind]
                )
                program = json.loads(p.read_text())
                program["coq_dependencies"][0]["sha256"] = digest(definition)
                program["coq_dependencies"].append(
                    {"module": "Other", "staged": str(other), "sha256": digest(other)}
                )
                p.write_text(json.dumps(program))
                frozen = n.parent / "dependencies/Definitions.v"
                frozen.write_bytes(definition.read_bytes())
                normal = json.loads(n.read_text())
                normal["dependencies"][0]["sha256"] = digest(frozen)
                normal["normalization"]["definition_sha256"] = digest(frozen)
                n.write_text(json.dumps(normal))
                self.add_bindings(n)
                if kind == "shared-predicate":
                    # Both captured aliases agree on the wrong predicate. The
                    # extra qualified anchor must still reject activation.
                    equations = n.parent / "Goal.v"
                    equations.write_text(
                        equations.read_text().replace(
                            "Require Import Definitions.\n",
                            "Require Import Definitions Other.\n",
                        )
                    )
                    normal = json.loads(n.read_text())
                    normal["immutable_sha256"]["Goal.v"] = digest(equations)
                    n.write_text(json.dumps(normal))
                request = prepare_normalization_association(
                    p, digest(p), n, digest(n), root / "result"
                )
                report = check_certificate(
                    Path(request["manifest"]), request["manifest_sha256"], timeout=30
                )
                self.assertEqual(
                    report["status"], "PASS" if kind == "matching" else "UNKNOWN"
                )
                if kind != "matching":
                    self.assertEqual(report["reason"], "coq_compile_failed_or_timeout")
                    stages = {stage["stage"]: stage for stage in report["stages"]}
                    self.assertEqual(stages["compile_Goal.v"]["exit_code"], 0)
                    self.assertNotEqual(stages["compile_Candidate.v"]["exit_code"], 0)


if __name__ == "__main__":
    unittest.main()
