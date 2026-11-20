"""The external runner measures processes without trusting self-reported verdicts."""

import json
from pathlib import Path
import sys
import tempfile
import unittest

from spectest.certificates import digest

from spectest import proof_controller as MODULE


class ProofControllerTests(unittest.TestCase):
    def test_cache_identity_binds_source_input_goal_polarity_and_runtime(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            generated = root / "input.c"
            generated.write_text("int f(void) { return 7; }")
            manifest = root / "vc.json"
            manifest.write_text(json.dumps({"source": str(generated)}))
            bundle = dict(function="f", target_layout={"bits": 32}, goals=["entry"],
                          scope="selected", refuted_goal=None, immutable_sha256={"Goal.v": "g"},
                          dependencies=[], runtime_sha256="r", allowed_assumptions=[],
                          original_manifest=str(manifest), original_manifest_sha256=digest(manifest),
                          original_goal_sha256="g")
            provenance = {"source_sha256": "s", "binary_sha256": "b", "included_source_sha256": "inc"}
            report = {"provenance": provenance}
            case = {"generated_source_sha256": digest(generated), "arguments":{"x":7},
                    "bindings":{}, "type_bindings":{}}
            original = MODULE.proof_key(bundle, report, case)
            self.assertIsNotNone(original)
            self.assertNotEqual(original, MODULE.proof_key(bundle, report, dict(case, arguments={"x":8})))
            for field, value in (("goals", ["return"]), ("runtime_sha256", "new"),
                                 ("refuted_goal", "entry"), ("dependencies", ["different"]),
                                 ("target_layout", {"bits": 64})):
                self.assertNotEqual(original, MODULE.proof_key(dict(bundle, **{field:value}), report, case))
            self.assertIsNone(MODULE.proof_key(bundle, {}, case))
            generated.write_text("int f(void) { return 8; }")
            self.assertIsNone(MODULE.proof_key(bundle, report, case))

    def test_rejected_replay_is_metered_and_agent_uses_fresh_template(self):
        from types import SimpleNamespace
        from unittest.mock import patch
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "m.json").write_text('{"refuted_goal":null}')
            proof = root / "Candidate.v"
            proof.write_text("original template")
            cache = root / "cache"
            cache.mkdir()
            (cache / "key.v").write_text("exact cached candidate")
            attempts, plans = [], []
            automatic = {"results":[{"id":"one"}]}
            entry = {"case_index":0, "manifest":str(root / "m.json")}
            args = SimpleNamespace(agent_command=["agent"], agent_timeout=3)
            outputs = root / "attempts"
            def agent(command, prompt, folder, timeout):
                self.assertEqual(proof.read_text(), "original template")
                self.assertIn(str(proof), prompt)
                proof.write_text("agent candidate")
                return {"status":"COMPLETED", "wall_seconds":1, "token_usage":[{"output_tokens":2}]}
            with patch.object(MODULE, "proof_key", return_value="key"), \
                 patch.object(MODULE, "published_candidates", return_value=[]), \
                 patch.object(MODULE, "run_agent", side_effect=agent) as invoked:
                stream = MODULE.proof_attempts(["agent"], outputs, cache, automatic, attempts, plans, args)(entry)
                first = next(stream)
                invoked.assert_not_called()
                self.assertEqual(proof.read_text(), "exact cached candidate")
                log = root / "compile.log"
                log.write_text("failed")
                first({"status":"UNKNOWN","stages":[{"log":str(log),"wall_seconds":2,
                        "resources":{"max_process_rss_kib":12}}],"duration_seconds":2})
                second = next(stream)
                second({"status":"PASS","proof_status":"VALID","stages":[],"duration_seconds":3,
                        "candidate_sha256":digest(proof)})
            self.assertEqual((cache / "key.v").read_text(), "agent candidate")
            self.assertEqual([a["source"] for a in attempts], ["cache","agent"])
            self.assertEqual(Path(attempts[0]["check"]["stages"][0]["log"]).read_text(), "failed")
            self.assertEqual(MODULE.agent_summary(attempts)["token_usage"], [{"output_tokens":2}])
            self.assertEqual(MODULE.agent_summary(attempts[:1])["tokens"], 0)


    def test_multi_attempt_telemetry_counts_cached_input_once_and_peak_across_runs(self):
        runs = [
            {"agent": {"status": "COMPLETED", "wall_seconds": 2, "resources": {"max_process_rss_kib": 6},
                       "token_usage": [{"input_tokens": 10, "cached_input_tokens": 8, "output_tokens": 4}]}},
            {"agent": {"status": "COMPLETED", "wall_seconds": 4, "resources": {"max_process_rss_kib": 3},
                       "token_usage": [{"input_tokens": 8, "cached_input_tokens": 4, "output_tokens": 2}]}},
        ]
        summary = MODULE.agent_summary(runs)
        self.assertEqual(summary["tokens"], 24)
        self.assertEqual(summary["wall_seconds"], 6)
        self.assertEqual(summary["resources"]["max_process_rss_kib"], 6)
        self.assertEqual(len(summary["token_usage"]), 2)
        runs[1]["agent"]["token_usage"] = None
        runs[1]["agent"]["resources"] = None
        incomplete = MODULE.agent_summary(runs)
        self.assertIsNone(incomplete["tokens"])
        self.assertIsNone(incomplete["resources"]["max_process_rss_kib"])
        self.assertEqual(incomplete["attempts"][0]["agent"]["token_usage"], summary["token_usage"][:1])


    def test_published_candidate_matches_inputs_dependencies_and_goal(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            subject = root / "benchmark/programs/demo/variants/sample/qcp.c"
            subject.parent.mkdir(parents=True)
            subject.write_text("int f(int n);")
            proof_dir = root / "benchmark/results/demo/evidence/proofs"
            proof_dir.mkdir(parents=True)
            def record(name, data):
                p = root / name
                p.write_text(data)
                return {"path": name, "sha256": digest(p)}
            dep = {"module": "Node", "sha256": "a"}
            layout = {"architecture_bits": 32}
            context = dict(coq_dependencies=[dep], runtime_dependencies=[], target_layout=layout)
            original = root / "original.json"
            original.write_text(json.dumps(context))
            goal = record("ExecutionGoal.v", "Definition ok := True.")
            rec = dict(schema="tespec-current-proof/v1", kind="test", status="PASS",
                       coverage_style="direct-original-targets", targets=["proof_of_ok"],
                       source={"sha256": digest(subject), "path": str(subject.relative_to(root))},
                       goal=goal, target_theorems={"proof_of_ok":"resolved_ok"},
                       input=[{"args": {"n":7}, "values":{}}],
                       logical_context=record("context.json", json.dumps(context)),
                       candidate=record("archive.v",
                          "Require Import ExecutionGoal. Lemma resolved_ok : ExecutionGoal.ok. exact I. Qed."),
                       dependencies=[dep])
            (proof_dir / "entry.json").write_text(json.dumps(rec))
            bundle = dict(goals=[{"proof": "proof_of_ok","statement":"ok"}], refuted_goal=None,
                          target_layout=layout, original_goal_sha256=goal["sha256"],
                          dependencies=[dep], original_manifest=str(original))
            report = {"source":str(subject), "provenance":{"source_sha256":digest(subject)}}
            case = {"arguments":{"n":7}, "bindings":{}}
            def lookup(bound=bundle, inp=case):
                return list(MODULE.published_candidates(root, report, inp, bound))
            [(origin, candidate)] = lookup()
            self.assertEqual(origin, str(proof_dir / "entry.json"))
            self.assertIn("Definition proof_of_ok : Goal.ok := resolved_ok.", candidate)
            self.assertEqual(lookup(inp=dict(case, arguments={"n":8})), [])
            self.assertEqual(lookup(dict(bundle, original_goal_sha256="other")), [])
            self.assertEqual(lookup(dict(bundle, refuted_goal="proof_of_ok")), [])
            original.write_text(json.dumps(dict(context, coq_dependencies=[])))
            self.assertEqual(lookup(), [])


    def test_usage_comes_from_turn_events_not_nested_tool_text(self):
        events = "\n".join(
            [
                "not JSON",
                "[]",
                json.dumps({"type": "tool.output", "usage": {"output_tokens": 999}}),
                json.dumps(
                    {
                        "type": "turn.completed",
                        "usage": {"input_tokens": 8, "output_tokens": 4},
                    }
                ),
            ]
        )
        self.assertEqual(
            MODULE.token_usage(events), [{"input_tokens": 8, "output_tokens": 4}]
        )
        self.assertIsNone(MODULE.token_usage('{"status":"PASS","token_usage":123}'))

    def test_routing_plan_preserves_checked_positive_results(self):
        with tempfile.TemporaryDirectory() as temp:
            plan = Path(temp) / "plan.json"
            plan.write_text(json.dumps({"refute_vcs": {"good": "proof_of_x", "bad": "proof_of_y"}}))
            report = {"results": [{"id": "good", "status": "PASS"},
                                  {"id": "bad", "status": "UNKNOWN"}]}
            self.assertEqual(MODULE.read_refutation_plan(plan, report),
                             ({"bad": "proof_of_y"}, set()))
            self.assertEqual(report["results"][1]["status"], "UNKNOWN")
            plan.write_text(json.dumps({"refute_vcs": {"absent": "proof_of_x"}}))
            with self.assertRaises(ValueError):
                MODULE.read_refutation_plan(plan, report)
            plan.write_text(json.dumps({"status": "FAIL"}))
            with self.assertRaises(ValueError):
                MODULE.read_refutation_plan(plan, report)

    def test_external_process_resources_and_unknown_usage(self):
        with tempfile.TemporaryDirectory() as temp:
            out = Path(temp)
            result = MODULE.run_agent(
                [sys.executable, "-c", "import sys; print(sys.stdin.read())"],
                "proof task",
                out,
                10,
            )
            self.assertEqual(result["exit_code"], 0)
            self.assertIsNone(result["token_usage"])
            self.assertGreater(result["resources"]["max_process_rss_kib"], 0)
            self.assertEqual(
                (out / "agent.stdout.jsonl").read_text().strip(), "proof task"
            )

    def test_timed_out_process_is_incomplete(self):
        with tempfile.TemporaryDirectory() as temp:
            result = MODULE.run_agent(
                [sys.executable, "-c", "import time; time.sleep(10)"],
                "proof task",
                Path(temp),
                0.1,
            )
            self.assertEqual(result["exit_code"], "TIMEOUT")
            self.assertEqual(result["status"], "INCOMPLETE")


if __name__ == "__main__":
    unittest.main()
