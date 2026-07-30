from __future__ import annotations

import json
from pathlib import Path
import runpy
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
GATE = ROOT / "scripts/gate-gpt5-nano-difficulty.py"
RUNNER = ROOT / "benchmark/baselines/openhands_gpt5nano" / "run_two_input.py"


def record(
    question_id: str,
    attempt: int,
    gold: str,
    prediction: str,
    *,
    eligible: bool = True,
) -> dict[str, object]:
    return {
        "question_id": question_id,
        "attempt": attempt,
        "gold_label": gold,
        "artifact_sha256": {
            "impl": f"{question_id}-impl",
            "spec": f"{question_id}-spec",
            "task": "task",
        },
        "score_eligible": eligible,
        "protocol_error": None,
        "correct": prediction == gold if eligible else None,
        "prediction": {
            "label": prediction,
            "parser_status": "parsed" if eligible else "no_allowed_label",
        },
    }


def summary(records: list[dict[str, object]]) -> dict[str, object]:
    return {
        "schema": "tespec-gpt5-nano-baseline-run/v2",
        "model": "openai/gpt-5-nano",
        "condition": "generic-agent-without-tespec-two-input",
        "reasoning_effort": "high",
        "api_mode": "chat_completions",
        "attempts_per_question": 3,
        "timeout_seconds_per_attempt": 600,
        "runner_sha256": "a" * 64,
        "question_count": len({str(record["question_id"]) for record in records}),
        "records": records,
    }


class Gpt5NanoDifficultyGateTests(unittest.TestCase):
    def run_gate(
        self,
        payload: dict[str, object],
    ) -> tuple[subprocess.CompletedProcess[str], dict[str, object]]:
        with tempfile.TemporaryDirectory(prefix="tespec-nano-gate-") as temp:
            root = Path(temp)
            source = root / "summary.json"
            output = root / "gate.json"
            source.write_text(json.dumps(payload), encoding="utf-8")
            completed = subprocess.run(
                [
                    sys.executable,
                    str(GATE),
                    "--summary",
                    str(source),
                    "--output",
                    str(output),
                ],
                cwd=ROOT,
                capture_output=True,
                text=True,
                check=False,
            )
            report = json.loads(output.read_text(encoding="utf-8"))
            return completed, report

    def test_gate_replaces_questions_nano_solves_two_of_three(self) -> None:
        records = [
            record("hard", 1, "correct", "soundness"),
            record("hard", 2, "correct", "complete"),
            record("hard", 3, "correct", "correct"),
            record("easy", 1, "complete", "complete"),
            record("easy", 2, "complete", "complete"),
            record("easy", 3, "complete", "soundness"),
        ]
        completed, report = self.run_gate(summary(records))
        self.assertEqual(completed.returncode, 1)
        self.assertFalse(report["passed"])
        self.assertEqual(
            [item["question_id"] for item in report["retained"]],
            ["hard"],
        )
        self.assertEqual(
            [item["question_id"] for item in report["replacement_queue"]],
            ["easy"],
        )

    def test_infrastructure_failure_is_unresolved_not_hard(self) -> None:
        records = [
            record("unknown", 1, "incomparable", "soundness"),
            record("unknown", 2, "incomparable", "complete"),
            record(
                "unknown",
                3,
                "incomparable",
                "abstain",
                eligible=False,
            ),
        ]
        completed, report = self.run_gate(summary(records))
        self.assertEqual(completed.returncode, 1)
        self.assertEqual(report["retained"], [])
        self.assertEqual(report["replacement_queue"], [])
        self.assertEqual(
            report["unresolved"],
            [{"question_id": "unknown", "reason": "infrastructure_failure"}],
        )

    def test_gate_passes_when_nano_solves_at_most_one_attempt(self) -> None:
        records = [
            record("hard", 1, "soundness", "soundness"),
            record("hard", 2, "soundness", "complete"),
            record("hard", 3, "soundness", "incomparable"),
        ]
        completed, report = self.run_gate(summary(records))
        self.assertEqual(completed.returncode, 0)
        self.assertTrue(report["passed"])
        self.assertEqual(report["outcome_counts"], {"retained": 1})

    def test_uninspected_inputs_are_unresolved_not_hard(self) -> None:
        records = [
            record("unread", attempt, "incomparable", "abstain")
            for attempt in range(1, 4)
        ]
        for item in records:
            item["score_eligible"] = False
            item["correct"] = None
            item["protocol_error"] = {
                "code": "semantic_inputs_not_inspected",
            }
        completed, report = self.run_gate(summary(records))
        self.assertEqual(completed.returncode, 1)
        self.assertEqual(report["retained"], [])
        self.assertEqual(
            report["unresolved"],
            [
                {
                    "question_id": "unread",
                    "reason": "semantic_inputs_not_inspected",
                }
            ],
        )

    def test_two_input_runner_exposes_frozen_attempt_policy(self) -> None:
        completed = subprocess.run(
            [sys.executable, str(RUNNER), "--help"],
            cwd=ROOT,
            capture_output=True,
            text=True,
            check=False,
        )
        self.assertEqual(completed.returncode, 0)
        self.assertIn("--dataset", completed.stdout)
        self.assertIn("--attempts", completed.stdout)

    def test_runner_requires_agent_tool_access_to_both_inputs(self) -> None:
        extract_input_access = runpy.run_path(str(RUNNER))["extract_input_access"]
        prompt_only = json.dumps(
            {
                "source": "user",
                "kind": "MessageEvent",
                "llm_message": {"content": "read impl.c and spec.qcp"},
            }
        )
        self.assertEqual(
            extract_input_access(prompt_only),
            {"impl": False, "spec": False, "complete": False},
        )
        action = json.dumps(
            {
                "source": "agent",
                "kind": "ActionEvent",
                "tool_name": "terminal",
                "tool_call": {
                    "name": "terminal",
                    "arguments": {"command": "sed -n '1,240p' impl.c spec.qcp"},
                },
            }
        )
        self.assertEqual(
            extract_input_access(action),
            {"impl": True, "spec": True, "complete": True},
        )


if __name__ == "__main__":
    unittest.main()
