#!/usr/bin/env python3
"""Validate and summarize the Codex CLI Nano TeSpec ablation."""

from __future__ import annotations

import argparse
from collections import defaultdict
import hashlib
import json
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[3]
EXPERIMENT = Path(__file__).resolve().parent
EXPECTED_LABELS = {
    "q01": "correct",
    "q02": "complete",
    "q03": "soundness",
    "q04": "incomparable",
}


def load(path: Path) -> dict[str, Any]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise ValueError(f"{path} must contain a JSON object")
    return value


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def accuracy(records: list[dict[str, Any]]) -> float | None:
    return (
        sum(record["correct"] for record in records) / len(records) if records else None
    )


def action_count(record: dict[str, Any]) -> int:
    return sum(stage["action_count"] for stage in record["codex_action_audit"].values())


def project(record: dict[str, Any]) -> dict[str, Any]:
    return {
        "question_id": record["question_id"],
        "attempt": record["attempt"],
        "prediction": record["prediction"]["label"],
        "gold_label": record["gold_label"],
        "correct": record["correct"],
        "parser_status": record["prediction"]["parser_status"],
        "codex_returncodes": {
            name: stage["returncode"] for name, stage in record["codex_stages"].items()
        },
        "action_count": action_count(record),
        "binds_valid": record["binds"]["valid"],
        "report_summary": record["tespec_report"]["summary"],
        "strict_tool_adherent": record["strict_tool_adherent"],
        "tool_forbidden_adherent": record["tool_forbidden_adherent"],
    }


def validate_summary(
    summary: dict[str, Any],
    condition: str,
    manifest: dict[str, Any],
) -> None:
    if summary.get("condition") != condition:
        raise ValueError(f"expected {condition}, got {summary.get('condition')}")
    if summary.get("model") != "gpt-5-nano":
        raise ValueError("unexpected model")
    records = summary.get("records")
    if not isinstance(records, list) or len(records) != 12:
        raise ValueError(f"{condition} must contain 12 attempts")
    seen = defaultdict(list)
    for record in records:
        question_id = record["question_id"]
        if record["gold_label"] != EXPECTED_LABELS.get(question_id):
            raise ValueError(f"unexpected label for {question_id}")
        hashes = manifest["questions"][question_id]
        if record["artifact_sha256"]["impl"] != hashes["impl_sha256"]:
            raise ValueError(f"implementation hash mismatch for {question_id}")
        if record["artifact_sha256"]["spec"] != hashes["spec_sha256"]:
            raise ValueError(f"spec hash mismatch for {question_id}")
        seen[question_id].append(record["attempt"])
    if {question_id: sorted(attempts) for question_id, attempts in seen.items()} != {
        question_id: [1, 2, 3] for question_id in EXPECTED_LABELS
    }:
        raise ValueError(f"unbalanced attempts in {condition}")


def per_question(
    enabled: list[dict[str, Any]],
    forbidden: list[dict[str, Any]],
) -> dict[str, Any]:
    result = {}
    for question_id, label in EXPECTED_LABELS.items():
        tool_records = [
            record for record in enabled if record["question_id"] == question_id
        ]
        no_tool_records = [
            record for record in forbidden if record["question_id"] == question_id
        ]
        tool_accuracy = accuracy(tool_records)
        no_tool_accuracy = accuracy(no_tool_records)
        result[question_id] = {
            "gold_label": label,
            "tool_predictions": [
                record["prediction"]["label"] for record in tool_records
            ],
            "no_tool_predictions": [
                record["prediction"]["label"] for record in no_tool_records
            ],
            "tool_accuracy": tool_accuracy,
            "no_tool_accuracy": no_tool_accuracy,
            "tool_minus_no_tool_accuracy": tool_accuracy - no_tool_accuracy,
        }
    return result


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--tool-enabled-summary", type=Path, required=True)
    parser.add_argument("--tool-forbidden-summary", type=Path, required=True)
    parser.add_argument(
        "--dataset-manifest",
        type=Path,
        default=EXPERIMENT / "dataset-manifest.json",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=EXPERIMENT / "report.json",
    )
    args = parser.parse_args()
    enabled_path = args.tool_enabled_summary.resolve()
    forbidden_path = args.tool_forbidden_summary.resolve()
    manifest_path = args.dataset_manifest.resolve()
    enabled = load(enabled_path)
    forbidden = load(forbidden_path)
    manifest = load(manifest_path)
    validate_summary(enabled, "tool-enabled", manifest)
    validate_summary(forbidden, "tool-forbidden", manifest)
    enabled_records = enabled["records"]
    forbidden_records = forbidden["records"]
    strict_tool = [
        record for record in enabled_records if record["strict_tool_adherent"]
    ]
    zero_action_outputs = [
        record
        for record in forbidden_records
        if action_count(record) == 0
        and record["prediction"]["parser_status"] == "parsed"
    ]
    clean_forbidden = [
        record for record in forbidden_records if record["tool_forbidden_adherent"]
    ]
    if len(strict_tool) != 12:
        raise ValueError("all tool-enabled attempts must pass strict audit")
    if len(zero_action_outputs) != 12:
        raise ValueError("all tool-forbidden attempts must be zero-action outputs")

    tool_accuracy = accuracy(enabled_records)
    no_tool_accuracy = accuracy(forbidden_records)
    report = {
        "schema": "tespec-codex-nano-binds-ablation/v1",
        "experiment_id": "codex-nano-binds-ablation-20260731",
        "model": "gpt-5-nano",
        "runner": "codex-cli 0.145.0",
        "provider": "yunwu-responses",
        "api_base": "https://yunwu.ai/v1",
        "valid": True,
        "effectiveness_conclusion_valid": True,
        "sample_size_warning": (
            "This is a 24-allocation diagnostic ablation, not a "
            "statistically powered effectiveness study."
        ),
        "dataset_manifest_sha256": sha256(manifest_path),
        "raw_summary": {
            "tool_enabled": str(enabled_path.relative_to(ROOT)),
            "tool_forbidden": str(forbidden_path.relative_to(ROOT)),
        },
        "raw_summary_sha256": {
            "tool_enabled": sha256(enabled_path),
            "tool_forbidden": sha256(forbidden_path),
        },
        "tool_enabled": {
            "allocated_attempts": len(enabled_records),
            "allocated_accuracy": tool_accuracy,
            "strict_adherent_attempts": len(strict_tool),
            "strict_adherence_rate": len(strict_tool) / len(enabled_records),
            "strict_adherent_accuracy": accuracy(strict_tool),
            "all_binds_valid": all(
                record["binds"]["valid"] for record in enabled_records
            ),
            "all_reports_valid": all(
                record["tespec_report"]["valid"] for record in enabled_records
            ),
            "attempts": [project(record) for record in enabled_records],
        },
        "tool_forbidden": {
            "allocated_attempts": len(forbidden_records),
            "allocated_accuracy": no_tool_accuracy,
            "zero_action_output_attempts": len(zero_action_outputs),
            "zero_action_output_accuracy": accuracy(zero_action_outputs),
            "clean_process_attempts": len(clean_forbidden),
            "clean_process_accuracy": accuracy(clean_forbidden),
            "post_output_transport_failures": [
                {
                    "question_id": record["question_id"],
                    "attempt": record["attempt"],
                    "prediction": record["prediction"]["label"],
                }
                for record in zero_action_outputs
                if not record["tool_forbidden_adherent"]
            ],
            "attempts": [project(record) for record in forbidden_records],
        },
        "per_question": per_question(enabled_records, forbidden_records),
        "comparison": {
            "tool_minus_no_tool_allocated_accuracy": (tool_accuracy - no_tool_accuracy),
            "tool_correct": sum(record["correct"] for record in enabled_records),
            "no_tool_correct": sum(record["correct"] for record in forbidden_records),
            "conclusion": (
                "No tool improvement was observed. TeSpec protocol adherence "
                "rose to 12/12, but label accuracy was 8/12 with the report "
                "versus 9/12 without tools. The only per-question difference "
                "was one q03 run where Nano treated a Completeness "
                "counterexample as evidence against Soundness."
            ),
        },
        "excluded_pilots": [
            {
                "name": "direct-agent-tool-loop",
                "reason": (
                    "The gateway returned HTTP 429 when Codex continued a "
                    "Responses conversation after the first shell result."
                ),
            },
            {
                "name": "q03-two-stage-pilot",
                "reason": (
                    "Used only to validate the final stateless protocol before "
                    "the balanced 24-allocation run."
                ),
            },
        ],
    }
    args.output.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(args.output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
