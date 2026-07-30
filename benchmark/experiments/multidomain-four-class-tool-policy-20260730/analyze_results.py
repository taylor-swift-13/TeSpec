#!/usr/bin/env python3
"""Audit tool-policy traces and write the durable aggregate report."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import statistics
from typing import Any


COMPILER = re.compile(r"(?<![A-Za-z0-9_])(cc|gcc|clang)(?=\s)")
READ_COMMAND = re.compile(r"(^|[\s;&|])(cat|sed|nl|head|tail|grep)(?=\s)")
ROOT = Path(__file__).resolve().parents[3]


def load(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def events(path: Path) -> list[dict[str, Any]]:
    result = []
    for line in path.read_text(encoding="utf-8").splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        if isinstance(event, dict):
            result.append(event)
    return result


def observation(event: dict[str, Any]) -> dict[str, Any]:
    value = event.get("observation")
    return value if isinstance(value, dict) else event


def action_count(trace: list[dict[str, Any]]) -> int:
    return sum(
        event.get("source") == "agent" and event.get("kind") == "ActionEvent"
        for event in trace
    )


def successful_read(trace: list[dict[str, Any]], filename: str) -> bool:
    for event in trace:
        if event.get("kind") != "ObservationEvent":
            continue
        item = observation(event)
        if item.get("is_error") is True:
            continue
        if event.get("tool_name") == "file_editor":
            path = str(item.get("path", ""))
            if path.endswith(f"/{filename}") and item.get("prev_exist") is True:
                return True
        if event.get("tool_name") != "terminal":
            continue
        if item.get("exit_code") != 0:
            continue
        command = str(item.get("command", ""))
        if filename in command and READ_COMMAND.search(command):
            return True
    return False


def successful_probe(trace: list[dict[str, Any]]) -> bool:
    compiled = False
    executed = False
    for event in trace:
        if event.get("kind") != "ObservationEvent":
            continue
        item = observation(event)
        if event.get("tool_name") != "terminal" or item.get("exit_code") != 0:
            continue
        command = str(item.get("command", ""))
        if COMPILER.search(command):
            compiled = True
            if "&&" in command:
                executed = True
        elif re.search(r"(^|[\s;&|./])(harness|test_[A-Za-z0-9_-]+)", command):
            executed = True
    return compiled and executed


def condition_report(
    condition: str,
    summary_path: Path,
) -> dict[str, Any]:
    summary = load(summary_path)
    root = summary_path.parent
    attempts = []
    for record in summary["records"]:
        trace_path = (
            root
            / record["question_id"]
            / f"attempt-{record['attempt']:02d}"
            / "trace.jsonl"
        )
        trace = events(trace_path)
        actions = action_count(trace)
        read_impl = successful_read(trace, "impl.c")
        read_spec = successful_read(trace, "spec.qcp")
        probe = successful_probe(trace)
        parsed = record["prediction"]["parser_status"] == "parsed"
        infrastructure_ok = (
            not record["timed_out"]
            and record["returncode"] == 0
            and record["infrastructure_error"] is None
            and parsed
        )
        correct = (
            record["prediction"]["label"] == record["gold_label"]
            if infrastructure_ok
            else None
        )
        if condition == "tool-forbidden":
            adherent = infrastructure_ok and actions == 0
        else:
            adherent = (
                infrastructure_ok and read_impl and read_spec and probe
            )
        attempts.append(
            {
                "question_id": record["question_id"],
                "attempt": record["attempt"],
                "gold_label": record["gold_label"],
                "prediction": record["prediction"]["label"],
                "correct": correct,
                "wall_seconds": record["wall_seconds"],
                "action_count": actions,
                "read_impl_observed": read_impl,
                "read_spec_observed": read_spec,
                "successful_executable_probe": probe,
                "condition_adherent": adherent,
                "runner_score_eligible": record["score_eligible"],
            }
        )
    walls = [item["wall_seconds"] for item in attempts]
    allocated_correct = sum(item["correct"] is True for item in attempts)
    adherent = [item for item in attempts if item["condition_adherent"]]
    by_question = {}
    executed_artifacts = {}
    for question_id in sorted({item["question_id"] for item in attempts}):
        selected = [
            item for item in attempts if item["question_id"] == question_id
        ]
        raw_record = next(
            record
            for record in summary["records"]
            if record["question_id"] == question_id
        )
        executed_artifacts[question_id] = raw_record["artifact_sha256"]
        by_question[question_id] = {
            "gold_label": selected[0]["gold_label"],
            "predictions": [item["prediction"] for item in selected],
            "correct_attempts": sum(item["correct"] is True for item in selected),
            "attempts": len(selected),
        }
    return {
        "id": condition,
        "raw_summary": str(summary_path.relative_to(ROOT)),
        "raw_summary_sha256": sha256(summary_path),
        "allocated_correct_attempts": allocated_correct,
        "allocated_attempts": len(attempts),
        "allocated_accuracy": allocated_correct / len(attempts),
        "condition_adherent_attempts": len(adherent),
        "condition_adherent_correct_attempts": sum(
            item["correct"] is True for item in adherent
        ),
        "runner_score_eligible_attempts": sum(
            item["runner_score_eligible"] for item in attempts
        ),
        "successful_executable_probe_attempts": sum(
            item["successful_executable_probe"] for item in attempts
        ),
        "zero_tool_action_attempts": sum(
            item["action_count"] == 0 for item in attempts
        ),
        "mean_wall_seconds": round(statistics.mean(walls), 3),
        "median_wall_seconds": round(statistics.median(walls), 3),
        "makespan_seconds": summary["makespan_seconds"],
        "executed_artifact_sha256_by_question": executed_artifacts,
        "by_question": by_question,
        "attempt_records": attempts,
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--tool-enabled-summary", type=Path, required=True)
    parser.add_argument("--tool-forbidden-summary", type=Path, required=True)
    parser.add_argument("--dataset-manifest", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    enabled = condition_report(
        "tool-enabled",
        args.tool_enabled_summary.resolve(),
    )
    forbidden = condition_report(
        "tool-forbidden",
        args.tool_forbidden_summary.resolve(),
    )
    dataset_manifest = load(args.dataset_manifest.resolve())
    output = {
        "schema": "tespec-nano-tool-policy-ablation/v1",
        "experiment_id": "multidomain-four-class-tool-policy-20260730",
        "valid": False,
        "invalidation": {
            "code": "tespec_not_invoked",
            "reason": (
                "The nominal tool-enabled condition used ad-hoc compiler "
                "harnesses and never invoked qcp-spectest with implementation, "
                "QCP specification, and concrete binds. Its accuracy delta "
                "does not measure the TeSpec tool skill."
            ),
        },
        "design": {
            "model": "openai/gpt-5-nano",
            "api_base": "https://yunwu.ai/v1",
            "attempts_per_question": 3,
            "questions": ["h01", "h02", "h03", "h04"],
            "labels": {
                "h01": "correct",
                "h02": "complete",
                "h03": "soundness",
                "h04": "incomparable",
            },
            "semantic_inputs_identical_across_conditions": True,
            "inputs_inlined_in_both_conditions": True,
            "only_intended_variable": (
                "the generic skill permits/requires tools versus forbids tools"
            ),
            "dataset_manifest": dataset_manifest,
            "dataset_manifest_sha256": sha256(
                args.dataset_manifest.resolve()
            ),
            "canonicalization_note": (
                "At execution time the dataset builder stripped skill trailing "
                "whitespace before inlining, so every TASK.md byte matched the "
                "executed prompt. The condition snapshots and builder were "
                "later removed. Per-condition artifact hashes retain the exact "
                "packaged dependency identity used by OpenHands."
            ),
        },
        "gold_review": {
            "method": "direct-current-contract-semantic-review",
            "note": (
                "The legacy pilot's h02/h03 axis names are reversed relative "
                "to the current contract. This experiment re-reviewed the "
                "actual impl/spec pairs: h02 is Complete-only and h03 is "
                "Sound-only."
            ),
        },
        "conditions": [forbidden, enabled],
        "comparison": {
            "conclusion_valid": False,
            "tool_forbidden_allocated_accuracy": forbidden[
                "allocated_accuracy"
            ],
            "tool_enabled_allocated_accuracy": enabled["allocated_accuracy"],
            "absolute_accuracy_delta_tool_minus_forbidden": (
                enabled["allocated_accuracy"] - forbidden["allocated_accuracy"]
            ),
            "tool_forbidden_adherence": (
                forbidden["condition_adherent_attempts"]
                / forbidden["allocated_attempts"]
            ),
            "tool_enabled_strict_adherence": (
                enabled["condition_adherent_attempts"]
                / enabled["allocated_attempts"]
            ),
            "interpretation": (
                "No conclusion about TeSpec tool effectiveness is valid. The "
                "treatment did not run the spec-testing tool."
            ),
        },
        "excluded_preexperiments": [
            {
                "path": (
                    "benchmark/results/openhands-gpt-5-nano-v2/"
                    "multidomain-no-skill-20260730"
                ),
                "reason": (
                    "Wrong comparison condition and 11/12 attempts did not "
                    "inspect both semantic inputs."
                ),
            },
            {
                "path": (
                    "benchmark/results/openhands-gpt-5-nano-v2/"
                    "multidomain-no-skill-j3-20260730"
                ),
                "reason": (
                    "Wrong comparison condition; all 12 attempts immediately "
                    "abstained without inspecting inputs."
                ),
            },
        ],
        "limitations": [
            "Four questions and three stochastic attempts per question are a capability probe, not a population estimate.",
            "The OpenHands runtime exposes tool schemas in both conditions; the forbidden skill achieved zero calls in all attempts.",
            "The frozen baseline runner marks inline no-tool attempts unresolved because its default protocol requires file-tool actions; this report rescored them only after verifying zero calls and exact input inlining.",
            "A general C probe can observe implementation behavior but cannot by itself enumerate spec-only behaviors, so Sound counterexamples still require relational reasoning.",
        ],
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(output, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(args.output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
