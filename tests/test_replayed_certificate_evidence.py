import hashlib
import json
from pathlib import Path
import sys
import tempfile
import unittest

BENCHMARK_TOOLS = Path(__file__).resolve().parents[1] / "tools/benchmark"
sys.path.insert(0, str(BENCHMARK_TOOLS))
from publish_replayed_certificate import canonical, check_stages, link, source_candidate, submit_json


class ReplayedCertificateEvidence(unittest.TestCase):
    def test_reconstructs_the_original_target_and_rejects_another_input(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            def write(name, data):
                path = root / name
                path.write_text(data)
                return link(root, path)
            goal = write("ExecutionGoal.v",
                         "Definition entry := True.\nModule Type VC_Correct.\n"
                         "Axiom proof_of_entry : entry.\nEnd VC_Correct.\n")
            proof = write("Candidate.v", "Require Import ExecutionGoal.\n"
                          "Lemma resolved_entry : ExecutionGoal.entry. Proof. exact I. Qed.\n")
            sample = {"args": {"x": 1}, "values": {}}
            ctx = write("context.json", json.dumps({"coq_dependencies": [], "runtime_dependencies": []}))
            origin = {"schema": "tespec-current-proof/v1", "kind": "test", "status": "PASS",
                      "coverage_style": "direct-original-targets", "targets": ["proof_of_entry"],
                      "target_theorems": {"proof_of_entry": "resolved_entry"},
                      "goal": goal, "source": write("f.c", "int f(void);"), "candidate": proof,
                      "dependencies": [], "input": [dict(sample, id="x")], "native_input": sample,
                      "logical_context": ctx}
            code = source_candidate(root, origin, origin)
            self.assertIn("Definition proof_of_entry : Goal.entry := resolved_entry.", code)
            self.assertIn("Lemma resolved_entry : Goal.entry.", code)
            with self.assertRaisesRegex(ValueError, "context differs"):
                source_candidate(root, origin, dict(origin, native_input={"args": {"x": 2}, "values": {}}))
            (root / "Candidate.v").write_text("Lemma resolved_entry : True. Proof. exact I. Qed.")
            with self.assertRaisesRegex(ValueError, "hash mismatch"):
                source_candidate(root, origin, origin)

    def test_same_execution_can_publish_new_costs_without_invalidating_old_references(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            file = root / "checks/current-example.json"
            first = submit_json(file, {"wall_seconds": 1}, root)
            again = submit_json(file, {"wall_seconds": 1}, root)
            second = submit_json(file, {"wall_seconds": 2}, root)
            self.assertEqual(first, again)
            self.assertNotEqual(first["path"], second["path"])
            for receipt in (first, second):
                self.assertEqual(link(root, root / receipt["path"]), receipt)

    def test_checker_rejects_missing_full_kernel_replay_or_substituted_cost(self):
        names = ["version", "compile_Goal.v", "compile_Candidate.v", "compile_Coverage.v",
                 "compile_Assumptions.v", "kernel_replay"]
        output = hashlib.sha256(b"measured log").hexdigest()
        def rows():
            return {name: {"tool": "tespec", "stage": "kernel" if name == "kernel_replay" else "coq",
                           "label": name, "command": ["coqchk", "Coverage"] if name == "kernel_replay" else
                           ["coqc", "--version" if name == "version" else name.removeprefix("compile_")],
                           "exit_code": 0, "tokens": 0, "wall_seconds": 1.2, "max_process_rss_kib": 120,
                           "combined_output_sha256": output} for name in names}
        def receipt(measures):
            return {"source_logs": dict.fromkeys(names, output),
                    "measurements_sha256": hashlib.sha256(canonical(list(measures.values()))).hexdigest()}
        measures = rows()
        check_stages(measures, names, {"dependencies": []}, receipt(measures), set())
        captured = receipt(measures)
        measures["kernel_replay"]["max_process_rss_kib"] = 10
        with self.assertRaisesRegex(ValueError, "Costs differ"):
            check_stages(measures, names, {"dependencies": []}, captured, set())
        measures["kernel_replay"]["command"].insert(1, "-norec")
        with self.assertRaisesRegex(ValueError, "full independent"):
            check_stages(measures, names, {"dependencies": []}, receipt(measures), set())
