"""The residual-proof CLI must reject escapes and overwrite failed retry results."""
from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from spectest.core import JobError, check_vc_proof

ROOT = Path(__file__).resolve().parents[1]


class LegacyProofReplayTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="tespec-proof-retry-")
        self.addCleanup(self.temp.cleanup)
        self.folder = Path(self.temp.name)
        self.manifest = self.folder / "manifest.json"
        self.saved = self.folder / "proof_report.json"
        self.sources = {
            "goal": "Definition wanted : Prop := True.\nModule Type VC_Correct. Axiom proof_of_wanted : wanted. End VC_Correct.\n",
            "proof_auto": "(* No automatic obligations. *)\n",
            "proof_manual": "Require Import Goal.\nLemma proof_of_wanted : wanted.\nProof. exact I. Qed.\n",
            "goal_check": "Require Import Goal Manual.\nModule Checked : VC_Correct.\nDefinition proof_of_wanted : wanted := Manual.proof_of_wanted.\nEnd Checked.\n",
        }
        names = dict(goal="Goal.v", proof_auto="Auto.v", proof_manual="Manual.v", goal_check="Check.v")
        self.files = {k: self.folder / value for k, value in names.items()}
        for key, text in self.sources.items():
            self.files[key].write_text(text)
        self.write_manifest()

    def write_manifest(self):
        self.manifest.write_text(json.dumps({
            "schema": "qcp-spectest-vc-manifest/v1", "case_id": "x", "function": "f",
            "files": {k: str(p) for k, p in self.files.items()},
            "immutable_sha256": {k: hashlib.sha256(self.files[k].read_bytes()).hexdigest()
                                  for k in ("goal", "proof_auto", "goal_check")},
            "residual_goals": ["proof_of_wanted"],
            "qcip_root": str(ROOT / "runtime/qcip"),
        }))

    def stale_pass(self):
        self.saved.write_text(json.dumps({"status": "PASS", "satisfied": True}))

    def check(self):
        return check_vc_proof(self.manifest,
            coqc_command=["opam", "exec", "--switch=qcp-8.20", "--", "coqc"],
            timeout_seconds=20)

    def test_commands_after_a_period_cannot_introduce_assumptions(self):
        for command in ("Axiom bogus : False.", "Parameter bogus : False.",
                        "Unset Guard Checking.", "Unset Positivity Checking.",
                        "Unset Universe Checking."):
            with self.subTest(command=command):
                self.stale_pass()
                self.files["proof_manual"].write_text("Require Import Goal. " + command +
                                                     "\n" + self.sources["proof_manual"])
                with patch("spectest.core.subprocess.run") as compiler:
                    with self.assertRaisesRegex(JobError, "forbidden command"):
                        self.check()
                    compiler.assert_not_called()
                self.assertFalse(self.saved.exists())

    def test_automatic_proof_cannot_hide_same_line_assumptions(self):
        self.files["proof_auto"].write_text("Require Import Goal. Axiom bogus : False.\n")
        self.write_manifest()
        self.stale_pass()
        with self.assertRaisesRegex(JobError, "forbidden command"):
            self.check()
        self.assertFalse(self.saved.exists())

    def test_modified_immutable_goal_removes_previous_pass(self):
        self.stale_pass()
        self.files["goal"].write_text("Definition wanted : Prop := False.\n")
        with self.assertRaisesRegex(JobError, "generated VC file was modified"):
            self.check()
        self.assertFalse(self.saved.exists())

    def test_version_timeout_persists_unknown_instead_of_raising(self):
        self.stale_pass()
        probe = self.folder / "slow_version.py"
        probe.write_text("import time\nprint('version probe started', flush=True)\ntime.sleep(5)\n")
        report = check_vc_proof(
            self.manifest, coqc_command=[sys.executable, str(probe)], timeout_seconds=0.2)
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["reason"], "coq_version_timeout")
        self.assertEqual(report["compiled"], [])
        self.assertIsNone(report["satisfied"])
        self.assertEqual(json.loads(self.saved.read_text()), report)

    def test_compile_failure_persists_unknown_instead_of_old_pass(self):
        self.stale_pass()
        responses = [subprocess.CompletedProcess([], 0, "version 8.20.1", ""),
                     subprocess.CompletedProcess([], 1, "", "Error: wrong proof")]
        with patch("spectest.core.subprocess.run", side_effect=responses):
            report = self.check()
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["reason"], "coq_proof_failed")
        self.assertEqual(json.loads(self.saved.read_text()), report)
        self.assertIsNone(report["satisfied"])

    def test_compile_timeout_persists_unknown_instead_of_old_pass(self):
        self.stale_pass()
        responses = [subprocess.CompletedProcess([], 0, "version 8.20.1", ""),
                     subprocess.TimeoutExpired(["coqc"], 20, output=b"unfinished")]
        with patch("spectest.core.subprocess.run", side_effect=responses):
            report = self.check()
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["reason"], "coq_proof_timeout")
        self.assertEqual(json.loads(self.saved.read_text()), report)
        self.assertIsNone(report["satisfied"])

    @unittest.skipUnless(os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
                         "set TESPEC_COQ_INTEGRATION=1 for real Coq compilation")
    def test_real_valid_proof_then_invalid_retry_replaces_saved_result(self):
        success = self.check()
        self.assertEqual(success["status"], "PASS", success)
        self.assertEqual(json.loads(self.saved.read_text()), success)
        self.assertEqual(success["assumptions"], [])
        self.assertEqual(success["assumptions_audited_goals"], 1)
        self.assertEqual(success["independent_kernel_replay"], "NOT_RUN")
        self.files["proof_manual"].write_text(self.sources["proof_manual"].replace("exact I", "exact 0"))
        failed = self.check()
        self.assertEqual(failed["status"], "UNKNOWN", failed)
        self.assertEqual(failed["reason"], "coq_proof_failed", failed)
        self.assertEqual(json.loads(self.saved.read_text()), failed)


    def prepare_dependency_axiom(self, dependency_source, assumption, module="TaskAxiom"):
        self.files["goal"].write_text(self.sources["goal"].replace(":= True", ":= False"))
        self.write_manifest()
        folder = self.folder / "dependencies"
        folder.mkdir()
        dependency = folder / (module + ".v")
        dependency.write_text(dependency_source)
        manifest = json.loads(self.manifest.read_text())
        manifest["coq_dependencies"] = [{"module": module, "staged": str(dependency),
            "sha256": hashlib.sha256(dependency.read_bytes()).hexdigest()}]
        self.manifest.write_text(json.dumps(manifest))
        self.files["proof_manual"].write_text(
            f"Require Import Goal {module}.\nLemma proof_of_wanted : wanted.\n"
            f"Proof. exact {assumption}. Qed.\n")

    @unittest.skipUnless(os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
                         "set TESPEC_COQ_INTEGRATION=1 for real Coq compilation")
    def test_dependency_axiom_cannot_establish_false_goal(self):
        self.prepare_dependency_axiom("Axiom bogus : False.\n", "bogus")
        self.stale_pass()
        report = self.check()
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["reason"], "unapproved_transitive_assumptions", report)
        self.assertTrue(any(name.endswith("bogus") for name in report["unexpected_assumptions"]))
        self.assertEqual(json.loads(self.saved.read_text()), report)

    @unittest.skipUnless(os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
                         "set TESPEC_COQ_INTEGRATION=1 for real Coq compilation")
    def test_trusted_classical_assumption_is_recorded_and_accepted(self):
        self.files["goal"].write_text(
            "Require Import Coq.Logic.Classical_Prop.\n"
            + self.sources["goal"].replace(":= True", ":= forall P : Prop, P \/ ~ P"))
        self.files["proof_manual"].write_text(
            self.sources["proof_manual"].replace("exact I", "exact Classical_Prop.classic"))
        self.write_manifest()
        report = self.check()
        self.assertEqual(report["status"], "PASS", report)
        self.assertEqual(report["assumptions"], ["Classical_Prop.classic"], report)
        self.assertEqual(report["assumption_identities"], ["Coq.Logic.Classical_Prop.classic"], report)
        self.assertEqual(report["independent_kernel_replay"], "NOT_RUN")

    @unittest.skipUnless(os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
                         "set TESPEC_COQ_INTEGRATION=1 for real Coq compilation")
    def test_runtime_like_task_assumption_cannot_impersonate_trusted_identity(self):
        self.prepare_dependency_axiom(
            "Axiom eval_addr_expr : False.\n",
            "CNotation.eval_addr_expr", module="CNotation")
        report = self.check()
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["reason"], "assumption_identity_mismatch", report)
        self.assertNotEqual(report["assumption_identities"], ["SimpleC.SL.CNotation.eval_addr_expr"])


if __name__ == "__main__":
    unittest.main()
