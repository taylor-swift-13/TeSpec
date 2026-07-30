#!/usr/bin/env python3
"""Run the generic OpenHands baseline without exposing TeSpec or hidden gold."""

from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import datetime as dt
import hashlib
from importlib.metadata import PackageNotFoundError, version
import json
import os
from pathlib import Path
import re
import shutil
import signal
import subprocess
import tempfile
import time
from typing import Any


ROOT = Path(__file__).resolve().parents[3]
DEFAULT_PILOT = ROOT / "benchmark" / "pilot" / "xizi-array"
DEFAULT_RESULTS = ROOT / "benchmark" / "results" / "openhands-gpt-5-nano"
COMPAT_DIR = Path(__file__).resolve().parent / "compat"
LABELS = {"perfect", "sound", "complete", "incomparable", "abstain"}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--pilot", type=Path, default=DEFAULT_PILOT)
    parser.add_argument(
        "--questions",
        nargs="+",
        default=["all"],
        help="Question IDs, or 'all'.",
    )
    parser.add_argument("--model", default="openai/gpt-5-nano")
    parser.add_argument("--timeout", type=int, default=600)
    parser.add_argument("--jobs", type=int, default=1)
    parser.add_argument("--output-dir", type=Path)
    return parser.parse_args()


def load_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def package_version(distribution: str) -> str | None:
    try:
        return version(distribution)
    except PackageNotFoundError:
        return None


def question_path(
    pilot: Path, question: dict[str, Any], key: str, default: str
) -> Path:
    return pilot / str(question.get(key, default))


def artifact_hashes(pilot: Path, question: dict[str, Any]) -> dict[str, str]:
    paths = {
        "task": question_path(pilot, question, "task", "TASK.template.md"),
        "reference": question_path(pilot, question, "reference", "reference.c"),
        "domain": question_path(pilot, question, "domain", "domain.qcp"),
        "candidate": question_path(pilot, question, "candidate", "candidate.qcp"),
        "mutant": question_path(pilot, question, "mutant", "mutant.c"),
    }
    for dependency in question.get("dependencies", []):
        if isinstance(dependency, dict):
            source = str(dependency["source"])
            destination = str(dependency["destination"])
        else:
            source = destination = str(dependency)
        paths[f"dependency:{destination}"] = pilot / source
    return {name: sha256_file(path) for name, path in paths.items()}


def select_questions(catalog: dict[str, Any], requested: list[str]) -> list[dict[str, Any]]:
    questions = catalog["questions"]
    if requested == ["all"]:
        return questions
    by_id = {q["id"]: q for q in questions}
    missing = sorted(set(requested) - set(by_id))
    if missing:
        raise SystemExit(f"unknown question IDs: {', '.join(missing)}")
    return [by_id[qid] for qid in requested]


def prepare_workspace(pilot: Path, question: dict[str, Any], workspace: Path) -> None:
    public_files = {
        "reference.c": question_path(pilot, question, "reference", "reference.c"),
        "domain.qcp": question_path(pilot, question, "domain", "domain.qcp"),
        "candidate.qcp": question_path(
            pilot, question, "candidate", "candidate.qcp"
        ),
        "mutant.c": question_path(pilot, question, "mutant", "mutant.c"),
        "TASK.md": question_path(pilot, question, "task", "TASK.template.md"),
    }
    for destination, source in public_files.items():
        shutil.copy2(source, workspace / destination)
    for dependency in question.get("dependencies", []):
        if isinstance(dependency, dict):
            source = pilot / str(dependency["source"])
            destination = workspace / str(dependency["destination"])
        else:
            source = pilot / str(dependency)
            destination = workspace / str(dependency)
        if workspace not in destination.resolve().parents:
            raise ValueError(f"dependency destination escapes workspace: {destination}")
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, destination)


def terminate_process_group(process: subprocess.Popen[str]) -> None:
    try:
        os.killpg(process.pid, signal.SIGTERM)
        process.wait(timeout=10)
    except (ProcessLookupError, subprocess.TimeoutExpired):
        try:
            os.killpg(process.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
        process.wait()


def run_openhands(
    workspace: Path,
    model: str,
    timeout: int,
) -> tuple[int | None, str, str, float, bool]:
    env = os.environ.copy()
    env["LLM_MODEL"] = model
    env["OPENHANDS_SUPPRESS_BANNER"] = "1"
    env["OPENHANDS_FORCE_CHAT_COMPLETIONS"] = "1"
    existing_pythonpath = env.get("PYTHONPATH")
    env["PYTHONPATH"] = (
        f"{COMPAT_DIR}{os.pathsep}{existing_pythonpath}"
        if existing_pythonpath
        else str(COMPAT_DIR)
    )
    command = [
        "openhands",
        "--headless",
        "--json",
        "--always-approve",
        "--override-with-envs",
        "--file",
        "TASK.md",
    ]
    started = time.monotonic()
    process = subprocess.Popen(
        command,
        cwd=workspace,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        start_new_session=True,
    )
    timed_out = False
    try:
        stdout, stderr = process.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        timed_out = True
        terminate_process_group(process)
        stdout, stderr = process.communicate()
    elapsed = time.monotonic() - started
    return process.returncode, stdout, stderr, elapsed, timed_out


def string_values(value: Any):
    if isinstance(value, str):
        yield value
    elif isinstance(value, list):
        for item in value:
            yield from string_values(item)
    elif isinstance(value, dict):
        for item in value.values():
            yield from string_values(item)


def extract_prediction(stdout: str) -> dict[str, Any]:
    """Extract the last allowed label, preferring strings in later JSONL events."""
    assistant_texts: list[str] = []
    candidate_texts: list[str] = []
    for line in stdout.splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            candidate_texts.append(line)
            continue
        candidate_texts.extend(string_values(event))
        llm_message = event.get("llm_message")
        if (
            event.get("source") == "agent"
            and event.get("kind") == "MessageEvent"
            and isinstance(llm_message, dict)
            and llm_message.get("role") == "assistant"
        ):
            assistant_texts.extend(string_values(llm_message.get("content")))

    label_pattern = re.compile(
        r'"label"\s*:\s*"(perfect|sound|complete|incomparable|abstain)"'
    )
    selected_label: str | None = None
    selected_text: str | None = None
    for text in assistant_texts or candidate_texts:
        for match in label_pattern.finditer(text):
            selected_label = match.group(1)
            selected_text = text

    parsed_object: dict[str, Any] | None = None
    if selected_text:
        decoder = json.JSONDecoder()
        for index, character in enumerate(selected_text):
            if character != "{":
                continue
            try:
                value, _ = decoder.raw_decode(selected_text[index:])
            except json.JSONDecodeError:
                continue
            if isinstance(value, dict) and value.get("label") in LABELS:
                parsed_object = value

    return {
        "label": selected_label or "abstain",
        "submission": parsed_object,
        "parser_status": "parsed" if selected_label else "no_allowed_label",
    }


def extract_infrastructure_error(stdout: str) -> dict[str, str] | None:
    error: dict[str, str] | None = None
    for line in stdout.splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        if event.get("kind") == "ConversationErrorEvent":
            error = {
                "code": str(event.get("code", "ConversationError")),
                "detail": str(event.get("detail", "")).splitlines()[0][:500],
            }
    return error


def evaluate_question(
    pilot: Path,
    question: dict[str, Any],
    gold_label: str,
    output_dir: Path,
    model: str,
    timeout: int,
) -> dict[str, Any]:
    qid = question["id"]
    with tempfile.TemporaryDirectory(prefix=f"openhands-{qid}-") as temporary:
        workspace = Path(temporary)
        prepare_workspace(pilot, question, workspace)
        returncode, stdout, stderr, elapsed, timed_out = run_openhands(
            workspace, model, timeout
        )

    question_dir = output_dir / qid
    question_dir.mkdir()
    (question_dir / "trace.jsonl").write_text(stdout, encoding="utf-8")
    (question_dir / "stderr.log").write_text(stderr, encoding="utf-8")

    prediction = extract_prediction(stdout)
    infrastructure_error = extract_infrastructure_error(stdout)
    score_eligible = (
        not timed_out
        and returncode == 0
        and infrastructure_error is None
        and prediction["parser_status"] == "parsed"
    )
    record = {
        "question_id": qid,
        "model": model,
        "condition": "generic-agent-without-tespec",
        "artifact_sha256": artifact_hashes(pilot, question),
        "returncode": returncode,
        "timed_out": timed_out,
        "wall_seconds": round(elapsed, 3),
        "infrastructure_error": infrastructure_error,
        "prediction": prediction,
        "gold_label": gold_label,
        "score_eligible": score_eligible,
        "correct": prediction["label"] == gold_label if score_eligible else None,
    }
    (question_dir / "result.json").write_text(
        json.dumps(record, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return record


def print_record(record: dict[str, Any]) -> None:
    qid = record["question_id"]
    if record["score_eligible"]:
        print(
            f"{qid}: predicted={record['prediction']['label']} "
            f"gold={record['gold_label']} correct={record['correct']} "
            f"time={record['wall_seconds']:.1f}s"
        )
    else:
        infrastructure_error = record["infrastructure_error"]
        reason = (
            infrastructure_error["code"]
            if infrastructure_error
            else "timeout"
            if record["timed_out"]
            else record["prediction"]["parser_status"]
        )
        print(
            f"{qid}: infrastructure_failure={reason} "
            f"time={record['wall_seconds']:.1f}s"
        )


def main() -> int:
    args = parse_args()
    if not os.environ.get("LLM_API_KEY"):
        raise SystemExit(
            "LLM_API_KEY is required in the process environment; it is never written to disk."
        )
    if not shutil.which("openhands"):
        raise SystemExit("openhands CLI is not installed")

    pilot = args.pilot.resolve()
    catalog = load_json(pilot / "questions.json")
    gold = load_json(pilot / "gold.json")["questions"]
    questions = select_questions(catalog, args.questions)

    run_stamp = dt.datetime.now(dt.timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    output_dir = (args.output_dir or DEFAULT_RESULTS / run_stamp).resolve()
    output_dir.mkdir(parents=True, exist_ok=False)

    run_started = time.monotonic()
    records: list[dict[str, Any]] = []
    if args.jobs < 1:
        raise SystemExit("--jobs must be at least 1")
    with ThreadPoolExecutor(max_workers=args.jobs) as executor:
        futures = {
            executor.submit(
                evaluate_question,
                pilot,
                question,
                gold[question["id"]]["label"],
                output_dir,
                args.model,
                args.timeout,
            ): question["id"]
            for question in questions
        }
        for future in as_completed(futures):
            record = future.result()
            records.append(record)
            print_record(record)
    records.sort(key=lambda record: record["question_id"])

    scored_records = [record for record in records if record["score_eligible"]]
    correct = sum(record["correct"] is True for record in scored_records)
    summary = {
        "benchmark": catalog["benchmark"],
        "condition": "generic-agent-without-tespec",
        "model": args.model,
        "reasoning_effort": "high",
        "api_mode": "chat_completions",
        "api_base": os.environ.get("LLM_BASE_URL"),
        "concurrency": args.jobs,
        "timeout_seconds_per_question": args.timeout,
        "versions": {
            "openhands_cli": package_version("openhands"),
            "openhands_sdk": package_version("openhands-sdk"),
            "litellm": package_version("litellm"),
        },
        "attempted": len(records),
        "scored": len(scored_records),
        "infrastructure_failures": len(records) - len(scored_records),
        "correct": correct,
        "accuracy": correct / len(scored_records) if scored_records else None,
        "summed_question_wall_seconds": round(
            sum(r["wall_seconds"] for r in records), 3
        ),
        "makespan_seconds": round(time.monotonic() - run_started, 3),
        "records": records,
    }
    (output_dir / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    accuracy = (
        f"{summary['accuracy']:.3f}"
        if summary["accuracy"] is not None
        else "not-scored"
    )
    print(
        f"summary: correct={correct}/{len(scored_records)} "
        f"infrastructure_failures={summary['infrastructure_failures']} "
        f"accuracy={accuracy}"
    )
    print(f"results: {output_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
