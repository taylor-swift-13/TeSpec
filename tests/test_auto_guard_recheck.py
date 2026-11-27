import hashlib
import os
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

from spectest.auto_guard_recheck import alignment_proof_source, recheck
from spectest.errors import FieldLayoutMismatch


class AlignmentRecheckTest(unittest.TestCase):
    def setUp(self):
        self.source = """Definition UndefStructPredparcel (x : Z) : Assertion :=
  ((&(x # "parcel" ->ₛ "first")) # Int |->_) **
  ((&(x # "parcel" ->ₛ "second")) # Ptr |->_).
Lemma undefstore_Predparcel_to_align : forall x,
  UndefStructPredparcel x |-- store_align_n 8.
Proof.
  intros.
  cancel.
Qed.
Definition after := 12.
"""
        self.fields = [
            dict(name=n, computational=True, offset=i * 4, size=4)
            for i, n in enumerate(("first", "second"))
        ]
        self.aggregate = dict(
            name="parcel", defined=True, kind="struct", size=8, fields=self.fields
        )
        self.layout = dict(pointer_size=4, aggregates=[self.aggregate])

    def test_only_alignment_body_changes(self):
        revised = alignment_proof_source(self.source, self.layout)
        self.assertEqual(self.source.split("Proof.")[0], revised.split("Proof.")[0])
        self.assertEqual(self.source.split("Qed.")[1], revised.split("Qed.")[1])
        self.assertIn('undef_store_int_align4 (&(x # "parcel" ->ₛ "first"))', revised)
        self.assertIn('undef_store_ptr_align4 (&(x # "parcel" ->ₛ "second"))', revised)
        self.assertIn("store_align_merge 4 4", revised)

    def test_coq_checks_mixed_field_widths(self):
        compiler = shutil.which(os.environ.get("COQC", "coqc"))
        if not compiler or "version 8.20" not in subprocess.check_output(
            [compiler, "-v"], text=True
        ):
            self.skipTest("compiled QCP libraries require Coq 8.20")
        from spectest.core import _coq_load_path_args

        prefix = "From SimpleC.Verification Require Import VCPrelude.\nImport naive_C_Rules.\nLocal Open Scope sac.\n"
        fields = []
        cells = []
        total = 0
        for name, ty, width in [
            ("a", "Char", 1),
            ("b", "UChar", 1),
            ("c", "Short", 2),
            ("d", "Int", 4),
            ("e", "Int64", 8),
        ]:
            fields.append(dict(name=name, offset=total, size=width, computational=True))
            cells.append(f'((&(x # "parcel" ->ₛ "{name}")) # {ty} |->_)')
            total += width
        source = (
            prefix
            + "Definition UndefStructPredparcel (x : Z) : Assertion :=\n  "
            + " **\n  ".join(cells)
            + ".\nLemma undefstore_Predparcel_to_align : forall x,\n"
            + f"  UndefStructPredparcel x |-- store_align_n {total}.\nProof.\n  cancel.\nQed.\n"
        )
        layout = dict(
            pointer_size=4,
            aggregates=[self.aggregate | {"fields": fields, "size": total}],
        )
        proof = alignment_proof_source(source, layout)
        self.assertNotEqual(proof, source)
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            unit = root / "Mixed.v"
            unit.write_text(proof)
            runtime = (
                Path(__file__).resolve().parents[1] / "runtime/qcip/SeparationLogic"
            )
            args = _coq_load_path_args(runtime, root)
            proc = subprocess.run(
                [compiler, "-q", *args, str(unit)],
                cwd=root,
                capture_output=True,
                text=True,
            )
            self.assertEqual(proc.returncode, 0, proc.stderr)

    def test_mismatched_offset_and_padding_are_ineligible(self):
        for offset, size in [(5, 9), (4, 12), (0, 8)]:
            self.fields[1]["offset"] = offset
            self.aggregate["size"] = size
            self.assertEqual(
                alignment_proof_source(self.source, self.layout), self.source
            )

    def test_unrecognized_proof_cannot_absorb_a_declaration(self):
        source = self.source.replace(
            "  cancel.", "Defined.\nLemma another : True.\nProof. exact I."
        )
        self.assertEqual(alignment_proof_source(source, self.layout), source)

    def test_unrelated_header_change_is_rejected_before_compilation(self):
        with tempfile.TemporaryDirectory() as tmp:
            goal = Path(tmp) / "goal.v"
            goal.write_text(
                "Require Import Extra.\nRequire Import input_def.\nModule Type VC_Correct.\n"
            )
            manifest = {
                "files": {"goal": str(goal)},
                "immutable_sha256": {
                    "goal": hashlib.sha256(goal.read_bytes()).hexdigest()
                },
                "generated_coq_dependencies": [{"module": "input_def"}],
            }
            context = {
                "generated_modules": {},
                "header_sha256": hashlib.sha256(b"").hexdigest(),
            }
            with self.assertRaisesRegex(FieldLayoutMismatch, "beyond"):
                recheck(context, manifest, [])
