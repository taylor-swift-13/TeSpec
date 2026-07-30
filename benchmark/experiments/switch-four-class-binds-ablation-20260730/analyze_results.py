#!/usr/bin/env python3
"""Audit raw traces and summarize the Nano binds-only ablation."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
from typing import Any


ROOT = Path(__file__).resolve().parents[3]


def load(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def strings(value: Any):
    if isinstance(value, str):
        yield value
    elif isinstance(value, list):
        for item in value:
            yield from strings(item)
    elif isinstance(value, dict):
        for item in value.values():
            yield from strings(item)


def events(path: Path) -> list[dict[str, Any]]:
    result = []
    for line in path.read_text(encoding="utf-8").splitlines():
        try:
            item = json.loads(line)
        except json.JSONDecodeError:
            continue
        if isinstance(item, dict):
            result.append(item)
    return result


def audit_attempt(result_root: Path, record: dict[str, Any]) -> dict[str, Any]:
    trace = (
        result_root
        / record["question_id"]
        / f"attempt-{record['attempt']:02d}"
        / "trace.jsonl"
    )
    trace_events = events(trace)
    actions = [item for item in trace_events if item.get("kind") == "ActionEvent"]
    observations = [
        item for item in trace_events if item.get("kind") == "ObservationEvent"
    ]
    commands = []
    input_reads = {"impl": False, "spec": False}
    binds_authored = False
    forbidden_writes: list[str] = []
    for item in actions:
        action = item.get("action")
        if not isinstance(action, dict):
            continue
        command = action.get("command")
        path = action.get("path")
        kind = action.get("kind")
        if isinstance(command, str) and kind == "TerminalAction":
            commands.append(command)
            input_reads["impl"] |= "impl.c" in command
            input_reads["spec"] |= "spec.qcp" in command
            if "binds.json" in command and re.search(
                r"(?:open\s*\(|>\s*[^&]|write_text|json\.dump)", command
            ):
                binds_authored = True
            if re.search(r"\b(?:gcc|cc|clang)\b|harness", command):
                forbidden_writes.append(command)
            if re.search(r"\b(?:cp|mv)\s+.*(?:impl\.c|spec\.qcp)", command):
                forbidden_writes.append(command)
        if kind == "FileEditorAction" and isinstance(path, str):
            input_reads["impl"] |= path.endswith("/impl.c") and command == "view"
            input_reads["spec"] |= path.endswith("/spec.qcp") and command == "view"
            if command not in (None, "view"):
                if path.endswith("/binds.json"):
                    binds_authored = True
                else:
                    forbidden_writes.append(f"{command}:{path}")

    analyze_success = False
    run_complete = False
    for item in observations:
        observation = item.get("observation")
        if not isinstance(observation, dict):
            continue
        command = observation.get("command")
        output = "\n".join(strings(observation.get("content")))
        if isinstance(command, str) and "spectest analyze" in command:
            analyze_success |= observation.get("exit_code") == 0
        if isinstance(command, str) and "spectest run" in command:
            has_six = re.search(r'"total"\s*:\s*6', output) is not None
            no_unknown = re.search(r'"UNKNOWN"\s*:\s*0', output) is not None
            no_error = re.search(r'"ERROR"\s*:\s*0', output) is not None
            run_complete |= has_six and no_unknown and no_error

    parsed = record["prediction"]["parser_status"] == "parsed"
    correct = (
        record["prediction"]["label"] == record["gold_label"] if parsed else False
    )
    strict = (
        not record["timed_out"]
        and input_reads["impl"]
        and input_reads["spec"]
        and analyze_success
        and binds_authored
        and run_complete
        and not forbidden_writes
    )
    return {
        "question_id": record["question_id"],
        "attempt": record["attempt"],
        "prediction": record["prediction"]["label"],
        "gold_label": record["gold_label"],
        "correct": correct,
        "timed_out": record["timed_out"],
        "action_count": len(actions),
        "input_reads": input_reads,
        "analyze_success": analyze_success,
        "binds_authored": binds_authored,
        "run_complete_six_binds": run_complete,
        "forbidden_writes": forbidden_writes,
        "strict_tool_adherent": strict,
        "trace_sha256": sha256(trace),
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--tool-enabled-summary", type=Path, required=True)
    parser.add_argument("--tool-forbidden-summary", type=Path, required=True)
    parser.add_argument("--dataset-manifest", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    enabled_path = args.tool_enabled_summary.resolve()
    forbidden_path = args.tool_forbidden_summary.resolve()
    enabled = load(enabled_path)
    forbidden = load(forbidden_path)
    enabled_root = enabled_path.parent
    forbidden_root = forbidden_path.parent
    enabled_attempts = [
        audit_attempt(enabled_root, item) for item in enabled["records"]
    ]
    forbidden_attempts = [
        audit_attempt(forbidden_root, item) for item in forbidden["records"]
    ]
    strict = [item for item in enabled_attempts if item["strict_tool_adherent"]]
    forbidden_adherent = [
        item for item in forbidden_attempts if item["action_count"] == 0
    ]

    def accuracy(items: list[dict[str, Any]]) -> float | None:
        return (
            sum(item["correct"] for item in items) / len(items) if items else None
        )

    report = {
        "schema": "tespec-nano-binds-only-ablation/v1",
        "experiment_id": "switch-four-class-binds-ablation-20260730",
        "model": "openai/gpt-5-nano",
        "api_base": "https://yunwu.ai/v1",
        "valid": False,
        "effectiveness_conclusion_valid": False,
        "invalidation": {
            "code": "insufficient_strict_tool_adherence",
            "reason": (
                "Only two of twelve tool allocations completed the audited "
                "binds-only TeSpec protocol, so the strict subset cannot "
                "support a causal tool-effect estimate."
            ),
        },
        "dataset_manifest_sha256": sha256(args.dataset_manifest.resolve()),
        "raw_summary_sha256": {
            "tool_enabled": sha256(enabled_path),
            "tool_forbidden": sha256(forbidden_path),
        },
        "raw_summary": {
            "tool_enabled": str(enabled_path.relative_to(ROOT)),
            "tool_forbidden": str(forbidden_path.relative_to(ROOT)),
        },
        "tool_enabled": {
            "allocated_attempts": len(enabled_attempts),
            "allocated_accuracy": accuracy(enabled_attempts),
            "strict_adherent_attempts": len(strict),
            "strict_adherence_rate": len(strict) / len(enabled_attempts),
            "strict_adherent_accuracy": accuracy(strict),
            "attempts": enabled_attempts,
        },
        "tool_forbidden": {
            "allocated_attempts": len(forbidden_attempts),
            "zero_action_attempts": len(forbidden_adherent),
            "zero_action_accuracy": accuracy(forbidden_adherent),
            "attempts": forbidden_attempts,
        },
        "comparison": {
            "tool_minus_no_tool_allocated_accuracy": (
                accuracy(enabled_attempts) - accuracy(forbidden_adherent)
            ),
            "conclusion": (
                "No tool improvement was demonstrated. The no-tool condition "
                "scored higher, while only two of twelve tool allocations "
                "completed the required binds-only TeSpec protocol. The "
                "strict tool subset is too small and selection-biased for a "
                "causal accuracy estimate."
            )
        },
        "invalid_preexperiments": [
            {
                "result": "switch-binds-tool-enabled-20260730",
                "reason": "the prompt inlined inputs and no attempt invoked TeSpec",
            },
            {
                "result": "switch-binds-tool-enabled-v2-20260730",
                "reason": "no attempt completed spectest run",
            },
            {
                "result": "switch-binds-tool-enabled-v3-20260730",
                "reason": (
                    "persistent terminal cwd caused cross-workspace repository "
                    "root contamination"
                ),
            },
        ],
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(args.output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
