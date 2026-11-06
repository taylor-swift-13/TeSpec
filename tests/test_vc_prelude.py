"""Current native goals use a pinned import bridge, without rewriting goals."""
from __future__ import annotations

import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from spectest.core import _coq_load_path_args, _runtime_coq_module

ROOT = Path(__file__).resolve().parents[1]
QCIP = ROOT / "runtime/qcip"
RUNTIME = QCIP / "SeparationLogic"
BINARY = Path(os.environ.get("SAC_SYMEXEC", ROOT / "bin/tespec-symexec"))


class VCPreludeMappingTests(unittest.TestCase):
    def test_generated_import_resolves_to_pinned_runtime(self):
        source = RUNTIME / "Verification/VCPrelude.v"
        self.assertEqual(_runtime_coq_module("SimpleC.Verification.VCPrelude", QCIP),
                         source.resolve())
        args = _coq_load_path_args(RUNTIME, Path("unused"))
        roots = {args[i + 2]: args[i + 1] for i, item in enumerate(args)
                 if item in ("-Q", "-R")}
        self.assertEqual(roots["SimpleC.Verification"], str(source.parent))


@unittest.skipUnless(os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
                     "set TESPEC_COQ_INTEGRATION=1 for native/Coq checks")
class VCPreludeOriginalGoalTests(unittest.TestCase):
    def run_checked(self, command, cwd):
        result = subprocess.run(command, cwd=cwd, capture_output=True, text=True,
                                timeout=300 if "coqchk" in command else 90,
                                env={**os.environ, "ASAN_OPTIONS": "detect_leaks=0"})
        self.assertEqual(result.returncode, 0, result.stdout[-3000:] + result.stderr[-3000:])
        return result.stdout + result.stderr

    def test_current_pure_and_frame_goals_compile_and_original_proofs_check(self):
        with tempfile.TemporaryDirectory() as directory:
            folder = Path(directory)
            bridge = folder / "Verification"
            bridge.mkdir()
            shutil.copyfile(RUNTIME / "Verification/VCPrelude.v", bridge / "VCPrelude.v")
            args = _coq_load_path_args(RUNTIME, folder)
            args[args.index(str(RUNTIME / "Verification"))] = str(bridge)
            prefix = ["opam", "exec", "--switch=qcp-8.20", "--"]
            self.run_checked(prefix + ["coqc", *args, str(bridge / "VCPrelude.v")], folder)
            samples = {
                "pure": "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ { return 0; }",
                "frame": "int sample(int *p) /*@ Require emp Ensure __return == 0 && emp */ { /*@ data_at(p,int,1) which implies data_at(p,int,1) */ return 0; }",
            }
            for label, text in samples.items():
                with self.subTest(label=label):
                    work = folder / label
                    work.mkdir()
                    source = work / "input.c"
                    source.write_text(text)
                    vc = work / "vc"
                    self.run_checked([str(BINARY), f"--input-file={source}",
                        "--spec-test-no-expand", "--function=sample", "--Json-output",
                        "--full-auto", "--emit-residual-vc", "--no-strategy-gen",
                        "--no-exec-info", f"--coq-output-dir={vc}"], work)
                    goal = vc / "input_goal.v"
                    original = goal.read_bytes()
                    self.assertIn(b"From SimpleC.Verification Require Import VCPrelude.", original)
                    if label == "frame":
                        self.assertIn(b"naive_C_Rules.truep", original)
                    local_args = [*args]
                    local_args[1] = str(vc)
                    self.run_checked(prefix + ["coqc", *local_args, str(goal)], vc)
                    self.assertEqual(hashlib.sha256(goal.read_bytes()).digest(),
                                     hashlib.sha256(original).digest())
                    if label != "pure":
                        continue
                    proof = vc / "Checked.v"
                    proof.write_text("""Require Import input_goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Module Checked : VC_Correct.
Lemma proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Proof. unfold sample_safety_wit_1, derivable1; auto. Qed.
Lemma proof_of_sample_return_wit_1 : sample_return_wit_1.
Proof. unfold sample_return_wit_1, derivable1, andp, truep, coq_prop; tauto. Qed.
Lemma proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.
Proof.
  unfold sample_precondition_wit_1, derivable1, andp, truep, coq_prop, emp.
  intro H. apply (H ConAssertion.empty_state).
  split; [exact I | apply ConAssertion.empty_state_is_empty].
Qed.
End Checked.
Print Assumptions Checked.proof_of_sample_safety_wit_1.
Print Assumptions Checked.proof_of_sample_return_wit_1.
Print Assumptions Checked.proof_of_sample_precondition_wit_1.
""")
                    audit = self.run_checked(prefix + ["coqc", *local_args, str(proof)], vc)
                    self.assertEqual(audit.count("Closed under the global context"), 3, audit)
                    self.assertNotIn("Axioms:", audit)
                    self.run_checked(prefix + ["coqchk", "-silent", *local_args, "Checked"], vc)
                    self.assertEqual(goal.read_bytes(), original)


if __name__ == "__main__":
    unittest.main()
