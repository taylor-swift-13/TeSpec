#!/usr/bin/env python3
"""Classify materialized questions as retain, replace, or unresolved."""

from __future__ import annotations

import argparse
from collections import Counter, defaultdict
import json
from pathlib import Path
from typing import Any

EXPECTED_MODEL = "openai/gpt-5-nano"
EXPECTED_CONDITION = "generic-agent-without-tespec-two-input"
ATTEMPTS = 3
MAX_CORRECT_TO_RETAIN = 1
LABELS = {"correct", "soundness", "complete", "incomparable"}


def load_records(summary: dict[str, Any], errors: list[str]) -> list[dict[str, Any]]:
    if summary.get("schema") != "tespec-gpt5-nano-baseline-run/v2":
        errors.append("unsupported summary schema")
    if summary.get("model") != EXPECTED_MODEL:
        errors.append("baseline model is not frozen gpt-5-nano")
    if summary.get("condition") != EXPECTED_CONDITION:
        errors.append("baseline condition is not the frozen two-input condition")
    if summary.get("reasoning_effort") != "high":
        errors.append("reasoning effort must be high")
    if summary.get("api_mode") != "chat_completions":
        errors.append("API mode must be chat_completions")
    if summary.get("attempts_per_question") != ATTEMPTS:
        errors.append("exactly three attempts per question are required")
    if summary.get("timeout_seconds_per_attempt") != 600:
        errors.append("attempt timeout must be frozen at 600 seconds")
    runner_sha256 = summary.get("runner_sha256")
    if (
        not isinstance(runner_sha256, str)
        or len(runner_sha256) != 64
        or any(character not in "0123456789abcdef" for character in runner_sha256)
    ):
        errors.append("runner SHA-256 is missing or invalid")
    records = summary.get("records")
    if not isinstance(records, list):
        errors.append("records must be an array")
        return []
    return records


def gate(summary: dict[str, Any]) -> dict[str, Any]:
    errors: list[str] = []
    records = load_records(summary, errors)
    grouped: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for record in records:
        grouped[str(record.get("question_id"))].append(record)

    retained: list[dict[str, Any]] = []
    replacement_queue: list[dict[str, Any]] = []
    unresolved: list[dict[str, Any]] = []
    class_outcomes: Counter[str] = Counter()

    for question_id, attempts in sorted(grouped.items()):
        attempts.sort(key=lambda item: item.get("attempt", 0))
        attempt_numbers = [item.get("attempt") for item in attempts]
        labels = {item.get("gold_label") for item in attempts}
        hashes = {
            json.dumps(item.get("artifact_sha256"), sort_keys=True) for item in attempts
        }
        eligible = [item for item in attempts if item.get("score_eligible") is True]
        issue = None
        if attempt_numbers != [1, 2, 3]:
            issue = "missing_or_duplicate_attempt"
        elif len(labels) != 1:
            issue = "inconsistent_gold_label"
        elif not labels <= LABELS:
            issue = "noncanonical_gold_label"
        elif len(hashes) != 1:
            issue = "artifact_changed_between_attempts"
        elif any("protocol_error" not in item for item in attempts):
            issue = "missing_protocol_attestation"
        elif any(item.get("protocol_error") is not None for item in attempts):
            issue = "semantic_inputs_not_inspected"
        elif len(eligible) != ATTEMPTS:
            issue = "infrastructure_failure"
        if issue:
            unresolved.append({"question_id": question_id, "reason": issue})
            class_outcomes["unresolved"] += 1
            continue

        correct = sum(item.get("correct") is True for item in eligible)
        outcome = {
            "question_id": question_id,
            "gold_label": next(iter(labels)),
            "correct_attempts": correct,
            "attempts": ATTEMPTS,
            "correct_rate": correct / ATTEMPTS,
            "predictions": [item["prediction"]["label"] for item in eligible],
            "artifact_sha256": attempts[0]["artifact_sha256"],
        }
        if correct <= MAX_CORRECT_TO_RETAIN:
            retained.append(outcome)
            class_outcomes["retained"] += 1
        else:
            replacement_queue.append(outcome)
            class_outcomes["replace"] += 1

    if not grouped:
        errors.append("summary contains no question attempts")
    if summary.get("question_count") != len(grouped):
        errors.append("summary question_count does not match records")
    passed = not errors and not replacement_queue and not unresolved
    return {
        "schema": "tespec-gpt5-nano-difficulty-gate/v1",
        "policy": {
            "model": EXPECTED_MODEL,
            "condition": EXPECTED_CONDITION,
            "reasoning_effort": "high",
            "attempts_per_question": ATTEMPTS,
            "retain_if_correct_attempts_at_most": MAX_CORRECT_TO_RETAIN,
            "replace_if_correct_attempts_at_least": MAX_CORRECT_TO_RETAIN + 1,
            "infrastructure_failures_are_unresolved": True,
            "uninspected_inputs_are_unresolved": True,
        },
        "passed": passed,
        "errors": errors,
        "question_count": len(grouped),
        "outcome_counts": dict(class_outcomes),
        "retained": retained,
        "replacement_queue": replacement_queue,
        "unresolved": unresolved,
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--summary", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    summary = json.loads(args.summary.read_text(encoding="utf-8"))
    report = gate(summary)
    target = args.output.resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(
        json.dumps(
            {
                "passed": report["passed"],
                "question_count": report["question_count"],
                "outcome_counts": report["outcome_counts"],
                "output": str(target),
            },
            ensure_ascii=False,
            indent=2,
        )
    )
    return 0 if report["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
