from __future__ import annotations

from collections import Counter
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
MANAGER = ROOT / "skills/tespec-artifacts/scripts/manage_artifacts.py"
RESULT_WRITER = ROOT / "skills/tespec-four-class/scripts/write_result.py"
DIFFICULTY_AUDITOR = ROOT / "scripts/audit-four-class-question-plan.py"
QUESTION_PLAN = ROOT / "benchmark/catalog/question-plan-600.json"
PROGRAM_CATALOG = ROOT / "benchmark/catalog/selected-programs.json"
NANO_REJECTIONS = ROOT / "benchmark/catalog/nano-rejected-bases.json"


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

    def test_question_plan_is_balanced_and_difficulty_gated(self) -> None:
        payload = json.loads(QUESTION_PLAN.read_text(encoding="utf-8"))
        expected = {
            "correct": 150,
            "soundness": 150,
            "complete": 150,
            "incomparable": 150,
        }
        self.assertEqual(payload["question_count"], 600)
        self.assertEqual(payload["questions_per_base"], 6)
        self.assertEqual(payload["class_counts"], expected)
        self.assertEqual(
            payload["difficulty_tier_counts"],
            {"hard": 300, "expert": 300},
        )
        self.assertEqual(
            {question["target_label"] for question in payload["questions"]},
            set(expected),
        )
        base_slots: dict[str, list[tuple[str, str]]] = {}
        for question in payload["questions"]:
            self.assertEqual(question["public_inputs"], ["impl.c", "spec.qcp"])
            self.assertNotIn("paired_impl_mutation", question)
            self.assertEqual(question["mutation_lineage"]["visibility"], "hidden")
            self.assertIn(
                "gpt5_nano_three_attempt_gate",
                question["difficulty"]["anti_shortcut_checks"],
            )
            self.assertIn(
                "gpt5_nano_difficulty_gate",
                question["required_gold"],
            )
            tier = question["difficulty"]["tier"]
            minimum_score = 22 if tier == "hard" else 40
            minimum_steps = 1 if tier == "hard" else 2
            minimum_dimensions = 2 if tier == "hard" else 3
            self.assertGreaterEqual(question["difficulty"]["score"], minimum_score)
            self.assertGreaterEqual(
                question["difficulty"]["spec_mutation_step_count"],
                minimum_steps,
            )
            self.assertGreaterEqual(
                len(set(question["difficulty"]["reasoning_dimensions"])),
                minimum_dimensions,
            )
            if tier == "expert":
                self.assertTrue(question["mutation_lineage"]["spec"]["camouflage"])
                self.assertIn(
                    "composed_mutation_nonredundancy_certificate",
                    question["required_gold"],
                )
            base_slots.setdefault(question["base_id"], []).append(
                (question["target_label"], tier)
            )
        self.assertEqual(len(base_slots), 100)
        for slots in base_slots.values():
            self.assertEqual(len(slots), 6)
            self.assertEqual(
                Counter(tier for _label, tier in slots),
                {"hard": 3, "expert": 3},
            )
            self.assertEqual({label for label, _tier in slots}, set(expected))
            for label, count in Counter(label for label, _tier in slots).items():
                if count == 2:
                    self.assertEqual(
                        {
                            tier
                            for current_label, tier in slots
                            if current_label == label
                        },
                        {"hard", "expert"},
                    )

    def test_difficulty_auditor_accepts_frozen_plan(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-difficulty-audit-") as temp:
            output = Path(temp) / "audit.json"
            self.run_script(
                DIFFICULTY_AUDITOR,
                "--plan",
                str(QUESTION_PLAN),
                "--output",
                str(output),
            )
            report = json.loads(output.read_text(encoding="utf-8"))
            self.assertTrue(report["passed"])
            self.assertEqual(report["error_count"], 0)
            self.assertFalse(report["release_ready"])
            self.assertEqual(
                report["authoritative_nano_gate_status"],
                "pending-materialized-three-attempt-runs",
            )

    def test_selected_bases_exclude_static_and_nano_simple_candidates(self) -> None:
        catalog = json.loads(PROGRAM_CATALOG.read_text(encoding="utf-8"))
        rejections = json.loads(NANO_REJECTIONS.read_text(encoding="utf-8"))
        tasks = catalog["tasks"]
        rejected_ids = {item["base_id"] for item in rejections["rejections"]}
        selected_ids = {item["id"] for item in tasks}
        selected_body_hashes = {item["body_sha256"] for item in tasks}
        rejected_body_hashes = set(
            catalog["selection_policy"]["nano_rejected_body_sha256"]
        )
        self.assertEqual(len(tasks), 100)
        self.assertGreaterEqual(
            min(item["difficulty_score"] for item in tasks),
            30,
        )
        self.assertTrue(rejected_ids)
        self.assertTrue(rejected_ids.isdisjoint(selected_ids))
        self.assertEqual(
            catalog["selection_policy"]["nano_rejected_base_ids"],
            sorted(rejected_ids),
        )
        self.assertTrue(rejected_body_hashes)
        self.assertTrue(rejected_body_hashes.isdisjoint(selected_body_hashes))
        qcip_candidates = [
            item for item in tasks if item["corpus"] in {"qcp", "qcip_output"}
        ]
        self.assertGreaterEqual(len(qcip_candidates), 40)
        bundled_qcip = [item for item in qcip_candidates if item["corpus"] == "qcp"]
        self.assertTrue(
            all(
                item["source"].startswith("runtime/qcip/QCP_examples/")
                for item in bundled_qcip
            )
        )

    def test_difficulty_auditor_rejects_downgraded_expert_item(self) -> None:
        payload = json.loads(QUESTION_PLAN.read_text(encoding="utf-8"))
        expert = next(
            question
            for question in payload["questions"]
            if question["difficulty"]["tier"] == "expert"
        )
        expert["mutation_lineage"]["spec"]["operators"] = [
            expert["mutation_lineage"]["spec"]["operators"][0]
        ]
        expert["difficulty"]["spec_mutation_step_count"] = 1
        with tempfile.TemporaryDirectory(prefix="tespec-difficulty-reject-") as temp:
            root = Path(temp)
            plan = root / "plan.json"
            output = root / "audit.json"
            plan.write_text(
                json.dumps(payload, ensure_ascii=False),
                encoding="utf-8",
            )
            completed = subprocess.run(
                [
                    sys.executable,
                    str(DIFFICULTY_AUDITOR),
                    "--plan",
                    str(plan),
                    "--output",
                    str(output),
                ],
                cwd=ROOT,
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(completed.returncode, 1)
            report = json.loads(output.read_text(encoding="utf-8"))
            self.assertFalse(report["passed"])
            self.assertTrue(
                any(
                    "at least 2 spec mutation steps" in error
                    for error in report["errors"]
                )
            )


if __name__ == "__main__":
    unittest.main()
