from __future__ import annotations

import json
import os
from pathlib import Path
import tempfile
import unittest

from spectest.certificates import (
    assumptions_from_output,
    check_candidate_commands,
    check_certificate,
    check_dependency_namespace,
    digest,
    goal_interface,
    prepare_certificate,
    strip_comments,
)
from spectest.core import JobError
from spectest.kernel_replay import KernelReplayCache

ROOT = Path(__file__).resolve().parents[1]


class CertificateInputTests(unittest.TestCase):
    def test_task_dependencies_cannot_shadow_controller_modules(self):
        with tempfile.TemporaryDirectory() as directory:
            _, runtime = self.prepare_fixture(Path(directory))
            for module in (
                "Goal",
                "Candidate",
                "Coverage",
                "Assumptions",
                "AssumptionIdentities.Helper",
            ):
                with (
                    self.subTest(module=module),
                    self.assertRaisesRegex(JobError, "shadows"),
                ):
                    check_dependency_namespace(module, runtime)
            check_dependency_namespace("Domain.Candidate", runtime)

    def test_import_module_name_is_not_an_axiom_declaration(self):
        check_candidate_commands("From AUXLib Require Import Axioms ListLib.")
        check_candidate_commands("Require Import AUXLib.Axioms.")
        with self.assertRaisesRegex(JobError, "forbidden"):
            check_candidate_commands("Require Import AUXLib.Axioms. Axiom bad : False.")

    def test_complete_interface_including_nonresidual_goals(self):
        source = """Definition pre := True.
Definition ret := True.
Module Type VC_Correct.
(* automatic (* nested *) proof *) Axiom proof_of_pre : pre.
Axiom proof_of_ret : ret.
End VC_Correct.
"""
        self.assertEqual(
            goal_interface(source), [("proof_of_pre", "pre"), ("proof_of_ret", "ret")]
        )

    def test_unrecognized_interface_is_rejected_not_truncated(self):
        source = "Module Type VC_Correct. Axiom proof_of_x : x. Parameter omitted : False. End VC_Correct."
        with self.assertRaises(JobError):
            goal_interface(source)

    def test_nested_comments_and_strings(self):
        self.assertRegex(
            strip_comments('"(*still string*)" (* (* hidden *) *) True').strip(),
            r'^"\(\*still string\*\)"\s+True$',
        )
        self.assertEqual(strip_comments("Axiom(**)bad : False."), "Axiom bad : False.")

    def test_multiline_assumption_names(self):
        self.assertEqual(
            assumptions_from_output(
                "Axioms:\nClassical_Prop.classic\n : forall P, P \\/ ~P\nBad.proof : False\n"
            ),
            {"Classical_Prop.classic", "Bad.proof"},
        )

    def test_import_warning_is_not_an_assumption_but_axiom_named_warning_is(self):
        self.assertEqual(
            assumptions_from_output(
                "Warning: import masks a name\nAxioms:\nWarning : False\n"
            ),
            {"Warning"},
        )
        self.assertEqual(
            assumptions_from_output(
                "Warning: import masks a name\nClosed under the global context\n"
            ),
            set(),
        )

    def prepare_fixture(self, root, layout=None):
        vc = root / "original"
        vc.mkdir()
        goal = vc / "input_goal.v"
        goal.write_text(
            "Definition entry := True.\nModule Type VC_Correct.\nAxiom proof_of_entry : entry.\nEnd VC_Correct.\n"
        )
        runtime = root / "runtime" / "SeparationLogic"
        runtime.mkdir(parents=True)
        (runtime / "_CoqProject").write_text("")
        # A compiled dependency is independently pinned, even with unchanged source.
        (runtime / "Lib.vo").write_bytes(b"compiled library version 1")
        original = vc / "manifest.json"
        original.write_text(
            json.dumps(
                {
                    "schema": "qcp-spectest-vc-manifest/v1",
                    "files": {"goal": str(goal)},
                    "immutable_sha256": {"goal": digest(goal)},
                    "qcip_root": str(runtime.parent),
                    "coq_dependencies": [],
                    "target_layout": layout,
                }
            )
        )
        result = prepare_certificate(original, root / "certificate")
        return result, runtime

    def test_target_layout_is_frozen_with_certificate_inputs(self):
        layout = {
            "schema": "sac-target-layout/v1",
            "architecture_bits": 64,
            "aggregates": [{"id": 7, "fields": [{"id": 9, "offset": 8}]}],
        }
        with tempfile.TemporaryDirectory() as directory:
            result, _ = self.prepare_fixture(Path(directory), layout)
            path = Path(result["manifest"])
            bundle = json.loads(path.read_text())
            self.assertEqual(bundle["target_layout"], layout)
            bundle["target_layout"]["aggregates"][0]["fields"][0]["offset"] = 4
            path.write_text(json.dumps(bundle))
            with self.assertRaisesRegex(JobError, "controller digest"):
                check_certificate(path, result["manifest_sha256"])

    def test_changed_manifest_rejected_against_controller_digest(self):
        with tempfile.TemporaryDirectory() as directory:
            result, _ = self.prepare_fixture(Path(directory))
            manifest = Path(result["manifest"])
            manifest.write_text(manifest.read_text() + " ")
            with self.assertRaisesRegex(JobError, "controller digest"):
                check_certificate(manifest, result["manifest_sha256"])

    def test_changed_goal_rejected_before_proof_compilation(self):
        with tempfile.TemporaryDirectory() as directory:
            result, _ = self.prepare_fixture(Path(directory))
            manifest = Path(result["manifest"])
            (manifest.parent / "Goal.v").write_text("Definition entry := True.")
            with self.assertRaisesRegex(JobError, "immutable"):
                check_certificate(manifest, result["manifest_sha256"])

    def test_changed_compiled_runtime_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            result, runtime = self.prepare_fixture(Path(directory))
            (runtime / "Lib.vo").write_bytes(b"replaced library")
            with self.assertRaisesRegex(JobError, "runtime changed"):
                check_certificate(Path(result["manifest"]), result["manifest_sha256"])

    def test_admitted_candidate_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            result, _ = self.prepare_fixture(Path(directory))
            manifest = Path(result["manifest"])
            candidate = manifest.parent / "Candidate.v"
            candidate.write_text(candidate.read_text().replace("Abort.", "Admitted."))
            stale = manifest.parent / "certificate-report.json"
            stale.write_text('{"status":"PASS"}')
            with self.assertRaisesRegex(JobError, "forbidden"):
                check_certificate(manifest, result["manifest_sha256"])
            self.assertFalse(stale.exists())


@unittest.skipUnless(
    os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
    "set TESPEC_COQ_INTEGRATION=1 for real kernel checks",
)
class CertificateKernelTests(unittest.TestCase):
    def check_fixture(
        self, proposition, proof, dependencies=None, refute=None, kernel_cache=None
    ):
        with tempfile.TemporaryDirectory(prefix="tespec-certificate-kernel-") as temp:
            root = Path(temp)
            goal = root / "input_goal.v"
            goal.write_text(
                f"Definition required : Prop := {proposition}.\nModule Type VC_Correct.\nAxiom proof_of_required : required.\nEnd VC_Correct.\n"
            )
            original = root / "original.json"
            deps = []
            for module, text in (dependencies or {}).items():
                source = root / (module + ".v")
                source.write_text(text)
                deps.append(
                    {"module": module, "staged": str(source), "sha256": digest(source)}
                )
            original.write_text(
                json.dumps(
                    {
                        "schema": "qcp-spectest-vc-manifest/v1",
                        "files": {"goal": str(goal)},
                        "immutable_sha256": {"goal": digest(goal)},
                        "qcip_root": str(ROOT / "runtime/qcip"),
                        "coq_dependencies": deps,
                    }
                )
            )
            prepared = prepare_certificate(original, root / "bundle", refute=refute)
            candidate = Path(prepared["editable"])
            candidate.write_text(proof)
            return check_certificate(
                Path(prepared["manifest"]),
                prepared["manifest_sha256"],
                kernel_cache=kernel_cache,
            )

    def test_checked_reuse_still_checks_a_changed_proof(self):
        cache = KernelReplayCache()
        first = self.check_fixture(
            "True",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs.",
            kernel_cache=cache,
        )
        self.assertEqual(first["status"], "PASS", first)
        self.assertEqual(first["kernel_replay_mode"], "full", first)
        second = self.check_fixture(
            "True",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact (id I). Qed. End Proofs.",
            kernel_cache=cache,
        )
        self.assertEqual(second["status"], "PASS", second)
        self.assertEqual(
            second["kernel_replay_mode"], "checked-dependency-reuse", second
        )
        self.assertEqual(second["kernel_dependency_reuse"]["checked_task_modules"], 3)
        self.assertEqual(
            second["kernel_dependency_reuse"]["full_replay_origin"]["manifest_sha256"],
            first["manifest_sha256"],
        )
        wrong = self.check_fixture(
            "False",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : True. Proof. exact I. Qed. End Proofs.",
            kernel_cache=cache,
        )
        self.assertEqual(wrong["status"], "UNKNOWN", wrong)
        self.assertEqual(wrong["reason"], "coq_compile_failed_or_timeout", wrong)

    def test_new_library_import_falls_back_to_full_replay(self):
        cache = KernelReplayCache()
        proof = "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs."
        self.assertEqual(
            self.check_fixture("True", proof, kernel_cache=cache)["status"], "PASS"
        )
        result = self.check_fixture(
            "True", "Require Import Coq.Arith.PeanoNat. " + proof, kernel_cache=cache
        )
        self.assertEqual(result["status"], "PASS", result)
        self.assertEqual(result["kernel_replay_mode"], "full", result)
        self.assertIn(
            "kernel_replay_full_fallback", [s["stage"] for s in result["stages"]]
        )

    def test_true_goal_accepted_with_independent_replay(self):
        report = self.check_fixture(
            "True",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs.",
        )
        self.assertEqual(report["status"], "PASS", report)
        self.assertEqual(report["assumptions"], [])
        self.assertEqual(report["stages"][-1]["stage"], "kernel_replay")

    def test_refutation_does_not_claim_execution_failure(self):
        report = self.check_fixture(
            "False",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : ~ Goal.required. Proof. intro H. exact H. Qed. End Proofs.",
            refute="proof_of_required",
        )
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["proof_status"], "VALID")
        self.assertEqual(report["polarity"], "negative")
        self.assertEqual(report["execution_counterexample"], "NOT_ESTABLISHED")

    def test_positive_proof_cannot_satisfy_refutation_request(self):
        report = self.check_fixture(
            "True",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs.",
            refute="proof_of_required",
        )
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["stages"][-1]["stage"], "compile_Coverage.v")

    def test_weakened_statement_fails_original_interface(self):
        report = self.check_fixture(
            "False",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : True. Proof. exact I. Qed. End Proofs.",
        )
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["stages"][-1]["stage"], "compile_Coverage.v")

    def test_missing_goal_fails_original_interface(self):
        report = self.check_fixture(
            "True", "Require Import Goal. Module Proofs. End Proofs."
        )
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["stages"][-1]["stage"], "compile_Coverage.v")

    def test_imported_axiom_is_not_a_certificate(self):
        report = self.check_fixture(
            "False",
            "Require Import Goal SpecAxiom. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact unsound. Qed. End Proofs.",
            {"SpecAxiom": "Axiom unsound : False.\n"},
        )
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["reason"], "unapproved_transitive_assumptions")
        self.assertTrue(report["unexpected_assumptions"])

    def test_task_axiom_cannot_impersonate_runtime_short_name(self):
        report = self.check_fixture(
            "False",
            "Require Import Goal. Require CNotation. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact CNotation.eval_addr_expr. Qed. End Proofs.",
            {"CNotation": "Axiom eval_addr_expr : False.\n"},
        )
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["reason"], "assumption_identity_mismatch")

    def test_existing_runtime_address_axioms_cannot_certify_false(self):
        # This uses only declarations already present in the bundled runtime.
        # Kernel compilation alone cannot detect inconsistent imported axioms.
        report = self.check_fixture(
            "False",
            """Require Import Goal Coq.ZArith.ZArith Coq.Strings.String.
From SimpleC.SL Require Import CNotation SeparationLogic.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope string_scope.
Module Proofs.
Lemma proof_of_required : Goal.required.
Proof.
  unfold Goal.required.
  pose (R := RE_add_pi (RE_const 0 FET_int) 0).
  assert (eval_addr_expr (RE_addr_of (LE_arrow_field
    (RE_const (eval_addr_expr R) FET_int) "field")) =
    eval_addr_expr (RE_addr_of (LE_arrow_field R "field"))) as H.
  { apply eval_addr_expr_congr. apply RE_addr_of_congr.
    apply LE_arrow_field_congr; [apply eval_addr | reflexivity]. }
  apply addr_of_arrow_field_inv in H.
  unfold R in H. discriminate H.
Qed.
End Proofs.
""",
        )
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["reason"], "unapproved_transitive_assumptions")
        self.assertIn(
            "CNotation.addr_of_arrow_field_inv", report["unexpected_assumptions"]
        )
        self.assertEqual(report["stages"][-1]["stage"], "compile_Assumptions.v")

    def test_task_dependency_cannot_shadow_runtime_namespace(self):
        with self.assertRaisesRegex(JobError, "shadows"):
            self.check_fixture("True", "", {"SimpleC": "Axiom bad : False.\n"})


if __name__ == "__main__":
    unittest.main()
