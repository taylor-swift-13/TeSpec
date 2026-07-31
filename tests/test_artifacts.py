from __future__ import annotations

import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
MANAGER = ROOT / "skills/tespec-artifacts/scripts/manage_artifacts.py"


class ArtifactManagementTests(unittest.TestCase):
    def run_manager(self, *arguments: str) -> subprocess.CompletedProcess[str]:
        completed = subprocess.run(
            [sys.executable, str(MANAGER), *arguments],
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

            preview = self.run_manager("clean", "--root", str(root))
            self.assertEqual(json.loads(preview.stdout)["files"], 1)
            self.assertTrue(proof_object.exists())

            self.run_manager("clean", "--root", str(root), "--apply")
            self.assertFalse(proof_object.exists())
            self.assertTrue(proof_source.exists())
            self.assertTrue(report.exists())

    def test_e2e_manifest_uses_relative_inventory_paths(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-e2e-artifacts-") as temp:
            root = Path(temp) / "case"
            self.run_manager(
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
            self.run_manager(
                "finalize",
                "--kind",
                "e2e",
                "--task-id",
                "case",
                "--root",
                str(root),
            )
            manifest_path = root / "artifact-manifest.json"
            manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
            self.assertTrue(
                all(
                    not Path(item["path"]).is_absolute()
                    and ".." not in Path(item["path"]).parts
                    for item in manifest["inventory"]
                )
            )
            self.run_manager(
                "validate",
                "--manifest",
                str(manifest_path),
            )


if __name__ == "__main__":
    unittest.main()
