"""Check original-arm certificates against full original propositions."""

from hashlib import sha256
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from spectest.auto_original_arm import _arm_term, _check_terms, prove_original_arm


ROOT = Path(__file__).resolve().parents[1]
HEADER = """From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.
Definition saved_input : Z := 7.
"""


class OriginalArmTest(unittest.TestCase):
    def test_ignores_heap_disjunct_only_by_disjunction_introduction(self):
        heap = "(forall (x: Z), x # Int |-> 2 |-- x # Int |-> 3)"
        pure = "(forall (x: Z) (H: (x = 3)), TT && emp |-- “ (x = 3) ” && emp)"
        self.assertIsNone(_arm_term(heap))
        self.assertIn("or_intror", _arm_term(heap + r" \/ " + pure))
        self.assertIn("or_introl", _arm_term(pure + r" \/ " + heap))
        self.assertIsNone(_arm_term(heap + r" \/ " + heap))

    def test_entire_original_root_is_typechecked(self):
        compiler = shutil.which(os.environ.get("COQC", "coqc"))
        if not compiler or "version 8.20" not in subprocess.check_output(
            [compiler, "-v"], text=True
        ):
            self.skipTest("requires the compiled QCP Coq 8.20 environment")
        with (
            tempfile.TemporaryDirectory() as tmp,
            patch.dict(os.environ, COQC=compiler),
        ):
            path = Path(tmp) / "Original.v"
            manifest = {
                "files": {"goal": str(path)},
                "runtime_dependencies": [],
                "coq_dependencies": [],
                "generated_coq_dependencies": [],
                "qcip_root": str(ROOT / "runtime/qcip"),
            }
            for n, valid in [(7, True), (8, False)]:
                with self.subTest(n=n):
                    goal = (
                        r"False \/ " + "(forall (a: Z) (H : (a = 2)), TT && emp |-- "
                        f"“ (a = 2) ” && “ (saved_input = {n}) ” && emp)"
                    )
                    raw = (HEADER + "Definition root := " + goal + ".\n").encode()
                    terms = {"root": _arm_term(goal)}
                    if valid:
                        _check_terms(manifest, None, raw, terms, 10000)
                    else:
                        with self.assertRaises(subprocess.CalledProcessError):
                            _check_terms(manifest, None, raw, terms, 10000)

    def test_missing_second_root_rejects_whole_record(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "Original.v"
            path.write_text(
                HEADER
                + "Definition good := forall (x: Z), TT && emp |-- “ (x = x) ” && emp.\n"
            )
            case = {
                "vc": {
                    "files": {"goal": str(path)},
                    "immutable_sha256": {"goal": sha256(path.read_bytes()).hexdigest()},
                }
            }
            record = {"check_mode": "exact", "vc": {"proof_roots": ["good", "missing"]}}
            self.assertIsNone(prove_original_arm(case, record, 1000))

    def test_goal_hash_is_required(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "Original.v"
            path.write_text("Definition good := True.\n")
            case = {
                "vc": {
                    "files": {"goal": str(path)},
                    "immutable_sha256": {"goal": "0" * 64},
                }
            }
            self.assertIsNone(
                prove_original_arm(
                    case, {"check_mode": "exact", "vc": {"proof_roots": ["good"]}}, 1000
                )
            )
