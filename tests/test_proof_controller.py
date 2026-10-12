"""The external runner measures processes without trusting self-reported verdicts."""

import importlib.util
import json
from pathlib import Path
import sys
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location(
    "proof_controller",
    Path(__file__).resolve().parents[1]
    / "skills/qcp-spec-test/scripts/proof-controller.py",
)
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class ProofControllerTests(unittest.TestCase):
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
