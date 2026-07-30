from __future__ import annotations

import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
MANAGER = ROOT / "skills/tespec-artifacts/scripts/manage_artifacts.py"
RESULT_WRITER = ROOT / "skills/tespec-four-class/scripts/write_result.py"


class ArtifactManagementTests(unittest.TestCase):
    def run_script(
        self, script: Path, *arguments: str
    ) -> subprocess.CompletedProcess[str]:
        completed = subprocess.run(
            [sys.executable, str(script), *arguments],
            cwd=ROOT,
            capture_output=True,
            text=True,
            check=False,
        )
        self.assertEqual(
            completed.returncode,
            0,
            msg=f"{completed.stdout}\n{completed.stderr}",
        )
        return completed

    def write_four_class_inputs(self, root: Path) -> None:
        for relative in (
            "input/impl.c",
            "input/spec.qcp",
        ):
            path = root / relative
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(f"artifact: {relative}\n", encoding="utf-8")

    def test_all_four_class_labels_finalize_and_validate(self) -> None:
        labels = {
            (True, True): "correct",
            (True, False): "soundness",
            (False, True): "complete",
            (False, False): "incomparable",
        }
        with tempfile.TemporaryDirectory(prefix="tespec-four-class-") as temp:
            base = Path(temp)
            for (sound, complete), expected in labels.items():
                with self.subTest(label=expected):
                    root = base / expected
                    self.run_script(
                        MANAGER,
                        "init",
                        "--kind",
                        "four-class",
                        "--task-id",
                        expected,
                        "--root",
                        str(root),
                    )
                    self.write_four_class_inputs(root)
                    soundness = root / "evidence/soundness/evidence.json"
                    completeness = root / "evidence/completeness/evidence.json"
                    soundness.write_text("{}\n", encoding="utf-8")
                    completeness.write_text("{}\n", encoding="utf-8")
                    self.run_script(
                        RESULT_WRITER,
                        "--root",
                        str(root),
                        "--sound",
                        str(sound).lower(),
                        "--complete",
                        str(complete).lower(),
                        "--soundness-evidence",
                        "evidence/soundness/evidence.json",
                        "--completeness-evidence",
                        "evidence/completeness/evidence.json",
                    )
                    self.run_script(
                        MANAGER,
                        "finalize",
                        "--kind",
                        "four-class",
                        "--task-id",
                        expected,
                        "--root",
                        str(root),
                    )
                    manifest = root / "artifact-manifest.json"
                    payload = json.loads(manifest.read_text(encoding="utf-8"))
                    self.assertEqual(payload["classification"], expected)
                    self.run_script(
                        MANAGER,
                        "validate",
                        "--manifest",
                        str(manifest),
                    )

    def test_clean_removes_only_allowlisted_transients(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-artifact-clean-") as temp:
            root = Path(temp)
            proof_source = root / "reports/proof.v"
            proof_object = root / "reports/proof.vo"
            report = root / "reports/report.json"
            proof_source.parent.mkdir(parents=True)
            proof_source.write_text("Lemma kept : True. Proof. exact I. Qed.\n")
            proof_object.write_bytes(b"compiled")
            report.write_text("{}\n", encoding="utf-8")

            preview = self.run_script(MANAGER, "clean", "--root", str(root))
            self.assertEqual(json.loads(preview.stdout)["files"], 1)
            self.assertTrue(proof_object.exists())

            self.run_script(MANAGER, "clean", "--root", str(root), "--apply")
            self.assertFalse(proof_object.exists())
            self.assertTrue(proof_source.exists())
            self.assertTrue(report.exists())

    def test_four_class_rejects_extra_public_inputs(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-four-class-input-") as temp:
            root = Path(temp)
            self.run_script(
                MANAGER,
                "init",
                "--kind",
                "four-class",
                "--task-id",
                "input-shape",
                "--root",
                str(root),
            )
            self.write_four_class_inputs(root)
            (root / "input/mutant.c").write_text(
                "void mutant(void) {}\n", encoding="utf-8"
            )
            completed = subprocess.run(
                [
                    sys.executable,
                    str(MANAGER),
                    "finalize",
                    "--kind",
                    "four-class",
                    "--task-id",
                    "input-shape",
                    "--root",
                    str(root),
                ],
                cwd=ROOT,
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(completed.returncode, 2)
            self.assertIn(
                "input must contain only impl.c and spec.qcp",
                completed.stderr,
            )

    def test_e2e_manifest_uses_relative_inventory_paths(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-e2e-artifacts-") as temp:
            root = Path(temp) / "case"
            self.run_script(
                MANAGER,
                "init",
                "--kind",
                "e2e",
                "--task-id",
                "case",
                "--root",
                str(root),
            )
            (root / "source/original/source.c").write_text(
                "void f(void) {}\n", encoding="utf-8"
            )
            (root / "spec/final_spec.c").write_text(
                "void f(void) {}\n", encoding="utf-8"
            )
            (root / "tests/binds.json").write_text("[]\n", encoding="utf-8")
            (root / "manifest.json").write_text("{}\n", encoding="utf-8")
            self.run_script(
                MANAGER,
                "finalize",
                "--kind",
                "e2e",
                "--task-id",
                "case",
                "--root",
                str(root),
            )
            manifest = json.loads(
                (root / "artifact-manifest.json").read_text(encoding="utf-8")
            )
            self.assertTrue(
                all(
                    not Path(item["path"]).is_absolute()
                    and ".." not in Path(item["path"]).parts
                    for item in manifest["inventory"]
                )
            )
            self.run_script(
                MANAGER,
                "validate",
                "--manifest",
                str(root / "artifact-manifest.json"),
            )

    def test_question_plan_uses_only_canonical_four_class_labels(self) -> None:
        payload = json.loads(
            (ROOT / "benchmark/catalog/question-plan-600.json").read_text(
                encoding="utf-8"
            )
        )
        expected = {
            "correct": 150,
            "soundness": 150,
            "complete": 150,
            "incomparable": 150,
        }
        self.assertEqual(payload["class_counts"], expected)
        self.assertEqual(
            {question["target_label"] for question in payload["questions"]},
            set(expected),
        )
        for question in payload["questions"]:
            self.assertEqual(question["public_inputs"], ["impl.c", "spec.qcp"])
            self.assertNotIn("paired_impl_mutation", question)
            self.assertEqual(question["mutation_lineage"]["visibility"], "hidden")


if __name__ == "__main__":
    unittest.main()
