import shutil
import subprocess
import tempfile
from pathlib import Path
import unittest

from spectest.core import JobError
from spectest.rocq_evaluation import evaluate_z_terms, validate_term


class RocqEvaluationTests(unittest.TestCase):
    def test_vernacular_and_tactics_are_not_terms(self):
        for term in [
            "1). Axiom bad : False.",
            "ltac:(admit)",
            "1; 2",
            "(* hi *) 1",
            "(1",
            "1)",
        ]:
            with self.subTest(term=term), self.assertRaises(JobError):
                validate_term(term)
        validate_term("Library.measure (Fork (-3) Empty Empty) + 7")

    @unittest.skipUnless(
        shutil.which("coqc") and shutil.which("coqtop"), "Rocq required"
    )
    def test_generic_recursion_negative_values_and_opaque_term(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "Measures.v"
            source.write_text("""Require Import Coq.ZArith.ZArith.
Local Open Scope Z_scope.
Inductive Shape := End | Join : Shape -> Z -> Shape -> Shape.
Fixpoint weight (s: Shape) : Z := match s with
| End => 0 | Join l x r => weight l + x + weight r end.
Parameter opaque : Z.
""")
            args = ["-Q", str(root), ""]
            subprocess.run(
                ["coqc", *args, str(source)], check=True, capture_output=True
            )
            report = evaluate_z_terms(
                ["weight (Join End (-7) (Join End 2 End))", "opaque", "2 * 3 + 1"],
                ["Measures"],
                root / "evaluation",
                load_path_args=args,
            )
            self.assertEqual([row["value"] for row in report["terms"]], [-5, None, 7])
            self.assertEqual(
                [row["status"] for row in report["terms"]],
                ["COQC_CHECKED", "UNKNOWN", "COQC_CHECKED"],
            )
            # A changed candidate result must fail proof checking.
            proof = root / "evaluation/Equalities.v"
            mutation = proof.read_text().replace("= (-5 : Z)", "= (-4 : Z)")
            self.assertNotEqual(proof.read_text(), mutation)
            (root / "Mutant.v").write_text(mutation)
            result = subprocess.run(
                ["coqc", *args, str(root / "Mutant.v")], capture_output=True
            )
            self.assertNotEqual(result.returncode, 0)

    @unittest.skipUnless(
        shutil.which("coqc") and shutil.which("coqtop"), "Rocq required"
    )
    def test_wrong_type_is_unknown_not_false(self):
        with tempfile.TemporaryDirectory() as temporary:
            report = evaluate_z_terms(["True"], [], Path(temporary) / "evaluation")
            self.assertEqual(report["terms"][0]["status"], "UNKNOWN")
            self.assertIsNone(report["terms"][0]["value"])


if __name__ == "__main__":
    unittest.main()
