#!/usr/bin/env python3
import argparse
import json
import subprocess
import sys
from datetime import datetime
from pathlib import Path


def sanitize_path_component(text: str) -> str:
    return "".join(ch if ch.isalnum() or ch in "._-" else "_" for ch in text).strip("._-") or "default"


def list_model_inputs(spec_root: Path, model: str) -> list[int]:
    input_dir = spec_root / model / "input"
    if not input_dir.exists():
        raise FileNotFoundError(f"Missing input directory: {input_dir}")
    return sorted(int(path.stem) for path in input_dir.glob("*.v") if path.stem.isdigit())


def parse_range(range_expr: str) -> tuple[int, int]:
    if ":" not in range_expr:
        raise ValueError("Range must use the form a:b")
    start_text, end_text = range_expr.split(":", 1)
    if not start_text or not end_text:
        raise ValueError("Range must use the form a:b")
    start = int(start_text)
    end = int(end_text)
    if start < 0 or end < start:
        raise ValueError("Range must satisfy 0 <= a <= b")
    return start, end


def select_indices(all_indices: list[int], range_expr: str | None, explicit_indices: list[int] | None) -> list[int]:
    if range_expr and explicit_indices:
        raise ValueError("Use either --range or --idx, not both")
    if explicit_indices:
        wanted = []
        seen = set()
        available = set(all_indices)
        for idx in explicit_indices:
            if idx not in available:
                raise FileNotFoundError(f"Missing input file for index: {idx}")
            if idx not in seen:
                seen.add(idx)
                wanted.append(idx)
        return wanted
    if range_expr:
        start, end = parse_range(range_expr)
        return [idx for idx in all_indices if start <= idx < end]
    return all_indices


def build_idx_args(indices: list[int]) -> list[str]:
    if not indices:
        return []
    return ["--idx", *[str(idx) for idx in indices]]


def run_command(cmd: list[str], workdir: Path) -> None:
    print("+", " ".join(cmd))
    subprocess.run(cmd, cwd=workdir, check=True)


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--spec-root", default="spec")
    parser.add_argument("--model", required=True)
    parser.add_argument("--api-model", default="gemini-3-pro-preview")
    parser.add_argument("--judge-models", nargs="+", default=["gemini-3-pro-preview", "claude-opus-4-5-20251101", "gpt-5"])
    parser.add_argument("--judge-repeats", type=int, default=3)
    parser.add_argument("--max-iterations", type=int, default=2)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--range")
    parser.add_argument("--idx", nargs="+", type=int)
    parser.add_argument("--base-url", default="https://yunwu.ai/v1")
    parser.add_argument("--run-name")
    parser.add_argument("--skip-positive-tests", action="store_true")
    parser.add_argument("--skip-negative-tests", action="store_true")
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parent
    spec_root = Path(args.spec_root)
    all_indices = list_model_inputs(spec_root, args.model)
    indices = select_indices(all_indices, args.range, args.idx)
    if not indices:
        raise ValueError("No input files selected")

    run_name = args.run_name
    if run_name is None:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        run_name = f"{sanitize_path_component(args.model)}_{timestamp}"

    idx_args = build_idx_args(indices)

    translate_cmd = [
        sys.executable,
        str(repo_root / "translate_coq_input.py"),
        "--spec-root",
        str(spec_root),
        "--model",
        args.model,
        "--api-model",
        args.api_model,
        "--base-url",
        args.base_url,
        "--judge-repeats",
        str(args.judge_repeats),
        "--max-iterations",
        str(args.max_iterations),
        "--workers",
        str(args.workers),
        "--judge-models",
        *args.judge_models,
        *idx_args,
    ]
    run_command(translate_cmd, repo_root)

    compose_cmd = [
        sys.executable,
        str(repo_root / "compose_coq_output.py"),
        "--spec-root",
        str(spec_root),
        "--model",
        args.model,
        "--run-name",
        run_name,
        *idx_args,
    ]
    run_command(compose_cmd, repo_root)

    output_dir = repo_root / spec_root / args.model / "output" / run_name

    positive_summary = None
    if not args.skip_positive_tests:
        test_cmd = [
            sys.executable,
            str(repo_root / "run_tests.py"),
            "--output-dir",
            str(output_dir),
            *idx_args,
        ]
        run_command(test_cmd, repo_root)
        positive_summary = load_json(repo_root / "test_reports" / run_name / "_summary.json")

    negative_summary = None
    if not args.skip_negative_tests:
        negative_cmd = [
            sys.executable,
            str(repo_root / "run_negative_tests.py"),
            "--output-dir",
            str(output_dir),
            *idx_args,
        ]
        run_command(negative_cmd, repo_root)
        negative_summary = load_json(repo_root / "negative_report" / run_name / "_summary.json")

    summary = {
        "model": args.model,
        "api_model": args.api_model,
        "judge_models": args.judge_models,
        "judge_repeats": args.judge_repeats,
        "max_iterations": args.max_iterations,
        "selected_indices": indices,
        "run_name": run_name,
        "output_dir": str(output_dir),
        "positive_summary": positive_summary,
        "negative_summary": negative_summary,
    }
    summary_path = output_dir / "_pipeline_summary.json"
    summary_path.write_text(json.dumps(summary, ensure_ascii=True, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote {summary_path}")


if __name__ == "__main__":
    main()
