#!/usr/bin/env python3
import json
import re
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parent
INPUT_ROOT = ROOT / "input"
OUTPUT_ROOT = ROOT / "output"
TEST_REPORT_ROOT = ROOT / "test_reports"
NEGATIVE_REPORT_ROOT = ROOT / "negative_report"

GPT_DEEPSEEK_KEY = "sk-afVplv2oRlR8SnMlC3K0ndGKOIsaBN5O3zxrD1B7zWzgNWGA"
CLAUDE_KEY = "sk-531Gm6lDz4TntanpSd8Pp8BYzUNGqQ90XukBrw4Xxo1eI4SQ"
GEMINI_KEY = "sk-uTP4bW0qlJ927dODSZ81Ww5QsspvYE2pGRXynvPjf66lXjkS"

RUN_SUFFIX_RE = re.compile(r"_(\d{8}_\d{6})$")


def model_name_from_run(run_name: str) -> str:
    match = RUN_SUFFIX_RE.search(run_name)
    if not match:
        raise ValueError(f"Run directory does not end with timestamp: {run_name}")
    return run_name[: match.start()]


def key_for_model(model_name: str) -> str:
    if model_name.startswith("claude"):
        return CLAUDE_KEY
    if model_name.startswith("gemini"):
        return GEMINI_KEY
    if model_name.startswith("gpt-") or model_name.startswith("deepseek"):
        return GPT_DEEPSEEK_KEY
    raise ValueError(f"Unknown model family for {model_name}")


def human_eval_index(path: Path) -> int:
    match = re.fullmatch(r"HumanEval_(\d+)\.(?:py|json)", path.name)
    if not match:
        raise ValueError(f"Unexpected HumanEval filename: {path}")
    return int(match.group(1))


def find_quote_indices(output_dir: Path) -> set[int]:
    indices = set()
    for path in output_dir.glob("HumanEval_*.py"):
        text = path.read_text(encoding="utf-8")
        if '""""' in text:
            indices.add(human_eval_index(path))
    return indices


def find_entry_point_indices(report_dir: Path) -> set[int]:
    if not report_dir.exists():
        return set()
    indices = set()
    for path in report_dir.glob("HumanEval_*.json"):
        report = json.loads(path.read_text(encoding="utf-8"))
        if report.get("failure_type") == "missing_entry_point":
            indices.add(human_eval_index(path))
    return indices


def helper_dependency_indices() -> set[int]:
    return {10, 32, 38, 50, 64}


def unlink_if_exists(path: Path):
    if path.exists():
        path.unlink()


def run_command(args: list[str], check: bool = True):
    print("+", " ".join(args))
    subprocess.run(args, cwd=ROOT, check=check)


def affected_runs():
    runs = []
    for output_dir in sorted(OUTPUT_ROOT.iterdir()):
        if not output_dir.is_dir() or output_dir.name == "fix_docstring_check":
            continue
        run_name = output_dir.name
        quote_indices = find_quote_indices(output_dir)
        entry_indices = find_entry_point_indices(TEST_REPORT_ROOT / run_name)
        helper_indices = helper_dependency_indices()
        indices = sorted(quote_indices | entry_indices | helper_indices)
        if not indices:
            continue
        runs.append(
            {
                "run_name": run_name,
                "model_name": model_name_from_run(run_name),
                "indices": indices,
                "quote_indices": sorted(quote_indices),
                "entry_indices": sorted(entry_indices),
                "helper_indices": sorted(helper_indices),
            }
        )
    return runs


def repair_run(run: dict):
    run_name = run["run_name"]
    model_name = run["model_name"]
    indices = run["indices"]
    key = key_for_model(model_name)

    print(f"== Repairing {run_name}")
    print(f"   model: {model_name}")
    print(f"   quote indices: {run['quote_indices']}")
    print(f"   entry indices: {run['entry_indices']}")
    print(f"   helper indices: {run['helper_indices']}")

    input_dir = INPUT_ROOT / run_name
    output_dir = OUTPUT_ROOT / run_name
    test_report_dir = TEST_REPORT_ROOT / run_name
    negative_report_dir = NEGATIVE_REPORT_ROOT / run_name

    for idx in indices:
        unlink_if_exists(input_dir / f"HumanEval_{idx}.py")
        unlink_if_exists(output_dir / f"HumanEval_{idx}.py")
        unlink_if_exists(test_report_dir / f"HumanEval_{idx}.json")
        unlink_if_exists(negative_report_dir / f"HumanEval_{idx}.json")

    idx_args = [str(idx) for idx in indices]
    run_command(
        [
            sys.executable,
            "generate_specs.py",
            "--run-name",
            run_name,
            "--api-model",
            model_name,
            "--api-key",
            key,
            "--idx",
            *idx_args,
        ]
    )
    run_command(
        [
            sys.executable,
            "run_tests.py",
            "--output-dir",
            str(output_dir),
            "--idx",
            *idx_args,
        ],
        check=False,
    )
    run_command(
        [
            sys.executable,
            "run_negative_tests.py",
            "--output-dir",
            str(output_dir),
            "--idx",
            *idx_args,
        ],
        check=False,
    )


def main():
    runs = affected_runs()
    if not runs:
        print("No affected runs found.")
        return

    print("Runs to repair:")
    for run in runs:
        print(
            f"- {run['run_name']}: idx={run['indices']} "
            f"(quotes={run['quote_indices']}, entry={run['entry_indices']}, helper={run['helper_indices']})"
        )

    for run in runs:
        repair_run(run)


if __name__ == "__main__":
    main()
