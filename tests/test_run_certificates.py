"""Run reconciliation must not turn incomplete execution into proof success."""

import copy
import json
import os
import subprocess
import sys
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from spectest.certificates import digest
from spectest.core import JobError
from spectest.run_certificates import prepare_run_certificates, check_run_certificates


class RunCertificateTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        runtime = self.root / "runtime/SeparationLogic"
        runtime.mkdir(parents=True)
        (runtime / "_CoqProject").write_text("")
        goal = self.root / "goal.v"
        goal.write_text(
            "Definition entry : Prop := True.\nDefinition result : Prop := True.\n"
            "Module Type VC_Correct.\nAxiom proof_of_entry : entry.\n"
            "Axiom proof_of_result : result.\nEnd VC_Correct.\n"
        )
        self.vc = dict(
            schema="qcp-spectest-vc-manifest/v1",
            case_id="x",
            function="f",
            files={"goal": str(goal)},
            immutable_sha256={"goal": digest(goal)},
            qcip_root=str(runtime.parent),
            coq_dependencies=[],
            status="residual",
            residual_goals=[
                "proof_of_result",
                "proof_of_result_split_goal_1",
                "proof_of_result_split_goal_spatial",
            ],
        )
        manifest = self.root / "vc.json"
        manifest.write_text(json.dumps(self.vc))
        self.case = dict(
            id="x",
            status="UNKNOWN",
            overall="UNKNOWN",
            satisfied=None,
            reason="residual_vc_requires_proof",
            scope="execution",
            execution_completed=True,
            execution_semantics="inline-preserve/v1",
            executor_error=None,
            phases=dict(
                precondition="SAT",
                safety="PASS",
                postcondition="UNKNOWN",
                annotations="NOT_RUN",
                execution="PASS",
            ),
            preconditions=[dict(goal="entry", status="SAT")],
            residual_vcs=self.vc["residual_goals"],
            vc=dict(self.vc, manifest=str(manifest)),
        )

    def prepare(self, cases=None, refute=None, refute_vcs=None):
        automatic = self.root / "automatic.json"
        automatic.write_text(
            json.dumps(
                dict(
                    schema="qcp-spectest-report/v1",
                    function="f",
                    results=cases or [self.case],
                    summary={},
                    itp_vcs=[dict(case_id="x")],
                )
            )
        )
        return prepare_run_certificates(
            automatic, self.root / "proof", refute_preconditions=refute, refute_vcs=refute_vcs
        )

    def check(self, request, status="PASS", refuted_goal=None):
        with patch(
            "spectest.run_certificates.check_certificate",
            return_value=dict(
                status="UNKNOWN" if status == "NEGATIVE_PROOF" else status,
                proof_status="VALID" if status == "NEGATIVE_PROOF" else "UNKNOWN",
                polarity="negative" if status == "NEGATIVE_PROOF" else "positive",
                duration_seconds=1,
                refuted_goal=refuted_goal,
            ),
        ) as checker:
            result = check_run_certificates(
                Path(request["manifest"]), request["manifest_sha256"]
            )
            return result, checker.call_count

    def test_complete_original_group_resolves_split_goals_and_preserves_skipped_annotations(
        self,
    ):
        request = self.prepare()
        result, calls = self.check(request)
        self.assertEqual(calls, 1)
        self.assertEqual(result["results"][0]["status"], "PASS")
        self.assertEqual(result["results"][0]["phases"]["annotations"], "NOT_RUN")
        self.assertEqual(result["summary"]["PASS"], 1)
        self.assertEqual(result["itp_vcs"], [])

    def test_unrecognized_split_goal_does_not_gain_parent_coverage(self):
        self.case["residual_vcs"].append("proof_of_result_split_goal_arbitrary")
        Path(self.case["vc"]["manifest"]).write_text(json.dumps(self.vc))
        with self.assertRaisesRegex(
            JobError, "cover initial satisfiability and residual VCs"
        ):
            self.prepare()

    def test_spatial_split_requires_existing_original_parent(self):
        self.case["residual_vcs"].append("proof_of_missing_split_goal_spatial")
        Path(self.case["vc"]["manifest"]).write_text(json.dumps(self.vc))
        with self.assertRaisesRegex(
            JobError, "cover initial satisfiability and residual VCs"
        ):
            self.prepare()

    def test_original_goal_with_split_suffix_keeps_exact_coverage(self):
        from spectest.run_certificates import _residual_covered

        self.assertTrue(
            _residual_covered(
                "proof_of_named_split_goal_spatial",
                {"proof_of_named_split_goal_spatial"},
            )
        )
        self.assertFalse(_residual_covered("proof_of_named_split_goal_spatial", set()))

    def test_incomplete_execution_never_enters_proof_completion(self):
        self.case["execution_completed"] = False
        request = self.prepare()
        result, calls = self.check(request)
        self.assertFalse(request["proof_required"])
        self.assertEqual(calls, 0)
        self.assertEqual(result["results"][0]["status"], "UNKNOWN")

    def test_missing_initial_satisfiability_cannot_certify_run(self):
        self.case["preconditions"] = []
        with self.assertRaisesRegex(JobError, "initial satisfiability"):
            self.prepare()

    @unittest.skipUnless(os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
                         "set TESPEC_COQ_INTEGRATION=1 for real kernel checks")
    def test_kernel_checked_refutation_dominates_other_unknown_vcs(self):
        goal = Path(self.vc["files"]["goal"])
        goal.write_text(
            "Definition entry : Prop := True.\nDefinition result : Prop := False.\n"
            "Definition unresolved : Prop := True.\nModule Type VC_Correct.\n"
            "Axiom proof_of_entry : entry.\nAxiom proof_of_result : result.\n"
            "Axiom proof_of_unresolved : unresolved.\nEnd VC_Correct.\n"
        )
        self.vc["immutable_sha256"]["goal"] = digest(goal)
        self.vc["residual_goals"].append("proof_of_unresolved")
        Path(self.case["vc"]["manifest"]).write_text(json.dumps(self.vc))
        request = self.prepare(refute_vcs={"x": "proof_of_result"})
        Path(request["editable"][0]).write_text(
            "Require Import Goal. Module Proofs.\n"
            "Lemma proof_of_result : ~ Goal.result.\n"
            "Proof. intro H. exact H. Qed. End Proofs.\n"
        )
        result = check_run_certificates(Path(request["manifest"]), request["manifest_sha256"])
        case = result["results"][0]
        self.assertEqual(case["test_result"], "FAIL", result)
        self.assertIn("proof_of_unresolved", case["residual_vcs"])
        audit = result["proof_completion"]["certificates"][0]["certificate"]
        self.assertEqual(audit["vc_status"], "INVALID", audit)
        self.assertEqual(audit["stages"][-1]["stage"], "kernel_replay", audit)

    @unittest.skipUnless(os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
                         "set TESPEC_COQ_INTEGRATION=1 for real kernel checks")
    def test_agent_judgement_routes_to_checked_negative_proof(self):
        goal = Path(self.vc["files"]["goal"])
        goal.write_text(goal.read_text().replace("result : Prop := True", "result : Prop := False"))
        self.vc["immutable_sha256"]["goal"] = digest(goal)
        Path(self.case["vc"]["manifest"]).write_text(json.dumps(self.vc))
        automatic = self.root / "automatic.json"
        automatic.write_text(json.dumps({
            "schema": "qcp-spectest-report/v1", "function": "f",
            "results": [self.case], "summary": {}, "itp_vcs": [{"case_id": "x"}],
        }))
        agent = self.root / "proof-agent.py"
        agent.write_text(
            "import json,re,sys\nfrom pathlib import Path\n"
            "prompt=sys.stdin.read()\n"
            "if 'Optional routing plan:' in prompt:\n"
            " path=re.search(r'Optional routing plan: (.+?) with JSON',prompt).group(1)\n"
            " Path(path).write_text(json.dumps({'refute_vcs':{'x':'proof_of_result'}}))\n"
            "else:\n"
            " paths=json.loads(re.search(r'Candidates: (\\[.*\\])',prompt).group(1))\n"
            " Path(paths[0]).write_text('Require Import Goal. Module Proofs. '"
            "'Lemma proof_of_result : ~ Goal.result. Proof. intro H. exact H. Qed. End Proofs.')\n"
        )
        script = Path(__file__).resolve().parents[1] / "skills/qcp-spec-test/scripts/proof-controller.py"
        completed = subprocess.run([
            sys.executable, str(script), str(automatic), "--output", str(self.root / "controller"),
            "--agent-command", sys.executable, str(agent),
        ], capture_output=True, text=True, timeout=90)
        self.assertEqual(completed.returncode, 1, completed.stderr)
        self.assertTrue(completed.stdout.strip(), completed.stderr)
        final = json.loads(Path(json.loads(completed.stdout)["report"]).read_text())
        self.assertEqual(final["results"][0]["test_result"], "FAIL", final)
        self.assertEqual(len(final["proof_completion"]["agent"]["attempts"]), 2)
        certificate = final["proof_completion"]["certificates"][0]["certificate"]
        self.assertEqual(certificate["vc_status"], "INVALID", certificate)
        self.assertEqual(certificate["stages"][-1]["stage"], "kernel_replay", certificate)

    def test_selected_original_refutation_fails_without_proving_other_goals(self):
        request = self.prepare(refute_vcs={"x": "proof_of_result"})
        candidate = Path(request["editable"][0]).read_text()
        self.assertIn("proof_of_result : ~ Goal.result.", candidate)
        self.assertNotIn("proof_of_entry :", candidate)
        result, calls = self.check(request, "NEGATIVE_PROOF", "proof_of_result")
        case = result["results"][0]
        self.assertEqual(calls, 1)
        self.assertEqual(case["test_result"], "FAIL")
        self.assertFalse(case["satisfied"])
        self.assertTrue(any(v["status"] == "INVALID" for v in case["vc_results"]))

    def test_unchecked_negative_judgement_remains_unknown(self):
        request = self.prepare(refute_vcs={"x": "proof_of_result"})
        result, _ = self.check(request, "UNKNOWN")
        self.assertEqual(result["results"][0]["status"], "UNKNOWN")

    def test_refuted_vc_is_not_a_reachable_execution_failure(self):
        result, _ = self.check(self.prepare(), "NEGATIVE_PROOF")
        self.assertEqual(result["results"][0]["status"], "UNKNOWN")
        self.assertEqual(result["summary"]["FAIL"], 0)

    def unresolved_entry(self):
        self.case["phases"]["precondition"] = "UNKNOWN"
        self.case["preconditions"][0]["status"] = "UNKNOWN"

    def test_precondition_refutation_checks_negative_statement_and_fails_case(self):
        self.unresolved_entry()
        request = self.prepare(refute={"x"})
        candidate = Path(request["editable"][0]).read_text()
        self.assertIn("proof_of_entry : ~ Goal.entry.", candidate)
        self.assertIn("proof_of_result : Goal.result.", candidate)
        result, calls = self.check(request, "NEGATIVE_PROOF", "proof_of_entry")
        self.assertEqual(calls, 1)
        case = result["results"][0]
        self.assertEqual(case["status"], "FAIL")
        self.assertEqual(case["phases"]["precondition"], "UNSAT")
        self.assertEqual(case["preconditions"][0]["proof"], "kernel")
        self.assertEqual(case["evidence"]["initial_domain"], "EMPTY")
        self.assertFalse(case["satisfied"])
        self.assertEqual(case["phases"]["postcondition"], "UNKNOWN")
        self.assertEqual(result["summary"]["INVALID"], 0)
        self.assertEqual(result["summary"]["PASS"], 0)
        self.assertEqual(result["summary"]["FAIL"], 1)
        self.assertEqual(result["itp_vcs"], [])

    def test_explicit_refutation_without_manifest_is_not_silently_skipped(self):
        self.case["phases"]["precondition"] = "UNKNOWN"
        self.case["preconditions"][0]["status"] = "UNKNOWN"
        del self.case["vc"]["manifest"]
        with self.assertRaisesRegex(JobError, "original VC manifest"):
            self.prepare(refute={"x"})
        self.assertFalse((self.root / "proof").exists())

    def test_refutation_cannot_target_already_satisfied_precondition(self):
        with self.assertRaisesRegex(JobError, "unresolved positive Require"):
            self.prepare(refute={"x"})

    def test_refutation_cannot_target_arbitrary_unknown_case(self):
        with self.assertRaisesRegex(JobError, "unknown case"):
            self.prepare(refute={"missing"})

    def test_refutation_of_one_of_multiple_entries_is_not_a_whole_case_unsat(self):
        self.unresolved_entry()
        self.case["preconditions"].append(dict(goal="entry2", status="UNKNOWN"))
        with self.assertRaisesRegex(JobError, "one unresolved"):
            self.prepare(refute={"x"})

    def test_already_negated_entry_vc_cannot_be_double_negated(self):
        self.unresolved_entry()
        self.case["command"] = ["symexec", "--precondition-proof-negation"]
        with self.assertRaisesRegex(JobError, "positive Require"):
            self.prepare(refute={"x"})

    def test_wrong_goal_refutation_is_not_initial_unsat(self):
        self.unresolved_entry()
        result, _ = self.check(
            self.prepare(refute={"x"}), "NEGATIVE_PROOF", "proof_of_result"
        )
        self.assertEqual(result["results"][0]["status"], "UNKNOWN")
        self.assertEqual(result["summary"]["INVALID"], 0)

    def test_positive_certificate_cannot_complete_a_negative_request(self):
        self.unresolved_entry()
        result, _ = self.check(self.prepare(refute={"x"}), "PASS")
        self.assertEqual(result["results"][0]["status"], "UNKNOWN")

    def test_failed_refutation_remains_unknown(self):
        self.unresolved_entry()
        result, _ = self.check(self.prepare(refute={"x"}), "UNKNOWN")
        self.assertEqual(result["results"][0]["status"], "UNKNOWN")

    def test_declaration_unsat_does_not_claim_execution_or_program_violation(self):
        self.unresolved_entry()
        self.case.update(scope="specification-only", execution_completed=False)
        for phase in ("execution", "safety", "postcondition", "annotations"):
            self.case["phases"][phase] = "NOT_RUN"
        result, _ = self.check(
            self.prepare(refute={"x"}), "NEGATIVE_PROOF", "proof_of_entry"
        )
        case = result["results"][0]
        self.assertEqual(case["status"], "FAIL")
        self.assertFalse(case["execution_completed"])
        self.assertTrue(
            all(
                case["phases"][p] == "NOT_RUN"
                for p in ("execution", "safety", "postcondition", "annotations")
            )
        )

    def test_tampered_frozen_report_rejected_before_proof_check(self):
        request = self.prepare()
        (self.root / "proof/automatic.json").write_text("{}")
        with self.assertRaisesRegex(JobError, "frozen automatic report"):
            self.check(request)

    def test_other_cases_keep_their_automatic_verdicts(self):
        other = copy.deepcopy(self.case)
        other.update(id="y", status="ERROR", reason="qcp_execution_error")
        result, calls = self.check(self.prepare([self.case, other]))
        self.assertEqual(calls, 1)
        self.assertEqual([r["status"] for r in result["results"]], ["PASS", "ERROR"])

    def test_unknown_without_residual_vc_stays_unknown(self):
        self.case["residual_vcs"] = []
        result, calls = self.check(self.prepare())
        self.assertEqual(calls, 0)
        self.assertEqual(result["results"][0]["status"], "UNKNOWN")

    def test_declaration_proof_does_not_claim_execution(self):
        self.case.update(scope="specification-only", execution_completed=False)
        self.case["phases"] = dict(
            precondition="UNKNOWN",
            safety="NOT_RUN",
            postcondition="NOT_RUN",
            annotations="NOT_RUN",
            execution="NOT_RUN",
        )
        result, calls = self.check(self.prepare())
        self.assertEqual(calls, 1)
        case = result["results"][0]
        self.assertEqual(case["status"], "PASS")
        self.assertEqual(case["scope"], "specification-only")
        self.assertFalse(case["execution_completed"])
        self.assertEqual(case["phases"]["execution"], "NOT_RUN")

    def test_changed_vc_manifest_cannot_attach_to_automatic_report(self):
        changed = dict(self.vc, function="different")
        (self.root / "vc.json").write_text(json.dumps(changed))
        with self.assertRaisesRegex(JobError, "does not match automatic"):
            self.prepare()


if __name__ == "__main__":
    unittest.main()
