#!/usr/bin/env python3
"""Run the frozen GPT-5 nano generic-agent baseline on two-input questions."""

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
DEFAULT_RESULTS = ROOT / "benchmark/results/openhands-gpt-5-nano-v2"
COMPAT_DIR = Path(__file__).resolve().parent / "compat"
LABELS = {"correct", "soundness", "complete", "incomparable", "abstain"}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--dataset",
        type=Path,
        required=True,
        help="Materialized two-input dataset containing questions.json.",
    )
    parser.add_argument(
        "--gold",
        type=Path,
        help="Hidden canonical gold file; defaults to DATASET/gold.json.",
    )
    parser.add_argument("--questions", nargs="+", default=["all"])
    parser.add_argument("--model", default="openai/gpt-5-nano")
    parser.add_argument("--attempts", type=int, default=3)
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


def tool_environment_versions() -> dict[str, str | None]:
    """Read versions from the Python environment that owns the OpenHands CLI."""
    executable = shutil.which("openhands")
    tool_python = Path(executable).resolve().with_name("python") if executable else None
    distributions = ("openhands", "openhands-sdk", "litellm")
    if tool_python is None or not tool_python.is_file():
        return {name: package_version(name) for name in distributions}
    program = (
        "import json; from importlib.metadata import PackageNotFoundError, version; "
        f"names={distributions!r}; "
        "print(json.dumps({name: (version(name) if name else None) for name in names}))"
    )
    try:
        completed = subprocess.run(
            [str(tool_python), "-c", program],
            check=True,
            capture_output=True,
            text=True,
            timeout=10,
        )
        payload = json.loads(completed.stdout)
    except (OSError, subprocess.SubprocessError, json.JSONDecodeError):
        return {name: package_version(name) for name in distributions}
    return {
        name: payload.get(name) if isinstance(payload.get(name), str) else None
        for name in distributions
    }


def resolve_inside(root: Path, relative: Any, field: str) -> Path:
    if not isinstance(relative, str) or not relative:
        raise ValueError(f"{field} must be a nonempty relative path")
    candidate = (root / relative).resolve()
    if candidate != root and root not in candidate.parents:
        raise ValueError(f"{field} escapes dataset root: {relative}")
    if not candidate.is_file():
        raise ValueError(f"{field} does not exist: {relative}")
    return candidate


def question_files(dataset: Path, question: dict[str, Any]) -> dict[str, Path]:
    return {
        "task": resolve_inside(
            dataset,
            question.get("task", "TASK.md"),
            "task",
        ),
        "impl": resolve_inside(dataset, question.get("impl"), "impl"),
        "spec": resolve_inside(dataset, question.get("spec"), "spec"),
    }


def artifact_hashes(dataset: Path, question: dict[str, Any]) -> dict[str, str]:
    paths = question_files(dataset, question)
    for index, dependency in enumerate(question.get("dependencies", [])):
        if not isinstance(dependency, dict):
            raise ValueError(f"dependencies[{index}] must be an object")
        paths[f"dependency:{dependency['destination']}"] = resolve_inside(
            dataset,
            dependency.get("source"),
            f"dependencies[{index}].source",
        )
    return {name: sha256_file(path) for name, path in paths.items()}


def select_questions(
    catalog: dict[str, Any], requested: list[str]
) -> list[dict[str, Any]]:
    if catalog.get("schema") != "tespec-four-class-public-index/v1":
        raise ValueError("unsupported public question index schema")
    questions = catalog.get("questions")
    if not isinstance(questions, list):
        raise ValueError("questions must be an array")
    if requested == ["all"]:
        return questions
    by_id = {question["id"]: question for question in questions}
    missing = sorted(set(requested) - set(by_id))
    if missing:
        raise ValueError(f"unknown question IDs: {', '.join(missing)}")
    return [by_id[question_id] for question_id in requested]


def prepare_workspace(
    dataset: Path,
    question: dict[str, Any],
    workspace: Path,
) -> None:
    files = question_files(dataset, question)
    shutil.copy2(files["task"], workspace / "TASK.md")
    shutil.copy2(files["impl"], workspace / "impl.c")
    shutil.copy2(files["spec"], workspace / "spec.qcp")
    for index, dependency in enumerate(question.get("dependencies", [])):
        source = resolve_inside(
            dataset,
            dependency.get("source"),
            f"dependencies[{index}].source",
        )
        destination_value = dependency.get("destination")
        if not isinstance(destination_value, str) or not destination_value:
            raise ValueError(f"dependencies[{index}].destination is invalid")
        destination = (workspace / "dependencies" / destination_value).resolve()
        dependency_root = (workspace / "dependencies").resolve()
        if dependency_root not in destination.parents:
            raise ValueError(
                f"dependency destination escapes workspace: {destination_value}"
            )
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
    return (
        process.returncode,
        stdout,
        stderr,
        time.monotonic() - started,
        timed_out,
    )


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
    assistant_texts: list[str] = []
    fallback_texts: list[str] = []
    for line in stdout.splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            fallback_texts.append(line)
            continue
        fallback_texts.extend(string_values(event))
        llm_message = event.get("llm_message")
        if (
            event.get("source") == "agent"
            and event.get("kind") == "MessageEvent"
            and isinstance(llm_message, dict)
            and llm_message.get("role") == "assistant"
        ):
            assistant_texts.extend(string_values(llm_message.get("content")))

    label_pattern = re.compile(
        r'"label"\s*:\s*'
        r'"(correct|soundness|complete|incomparable|abstain)"'
    )
    selected: str | None = None
    for text in assistant_texts or fallback_texts:
        for match in label_pattern.finditer(text):
            selected = match.group(1)
    return {
        "label": selected or "abstain",
        "parser_status": "parsed" if selected else "no_allowed_label",
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


def extract_input_access(stdout: str) -> dict[str, bool]:
    """Attest that an agent tool action referenced both semantic inputs."""
    inspected = {"impl": False, "spec": False}
    for line in stdout.splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        if event.get("source") != "agent" or event.get("kind") != "ActionEvent":
            continue
        action_text = json.dumps(
            {
                "tool_name": event.get("tool_name"),
                "action": event.get("action"),
                "tool_call": event.get("tool_call"),
            },
            ensure_ascii=False,
            sort_keys=True,
        )
        inspected["impl"] |= "impl.c" in action_text
        inspected["spec"] |= "spec.qcp" in action_text
    return {
        **inspected,
        "complete": inspected["impl"] and inspected["spec"],
    }


def evaluate_attempt(
    dataset: Path,
    question: dict[str, Any],
    gold_label: str,
    attempt: int,
    output_dir: Path,
    model: str,
    timeout: int,
) -> dict[str, Any]:
    question_id = question["id"]
    with tempfile.TemporaryDirectory(
        prefix=f"openhands-{question_id}-{attempt:02d}-"
    ) as temporary:
        workspace = Path(temporary)
        prepare_workspace(dataset, question, workspace)
        returncode, stdout, stderr, elapsed, timed_out = run_openhands(
            workspace,
            model,
            timeout,
        )

    attempt_dir = output_dir / question_id / f"attempt-{attempt:02d}"
    attempt_dir.mkdir(parents=True)
    (attempt_dir / "trace.jsonl").write_text(stdout, encoding="utf-8")
    (attempt_dir / "stderr.log").write_text(stderr, encoding="utf-8")
    prediction = extract_prediction(stdout)
    infrastructure_error = extract_infrastructure_error(stdout)
    input_access = extract_input_access(stdout)
    protocol_error = (
        None
        if input_access["complete"]
        else {
            "code": "semantic_inputs_not_inspected",
            "detail": "agent must inspect both impl.c and spec.qcp before scoring",
        }
    )
    score_eligible = (
        not timed_out
        and returncode == 0
        and infrastructure_error is None
        and protocol_error is None
        and prediction["parser_status"] == "parsed"
    )
    record = {
        "question_id": question_id,
        "attempt": attempt,
        "model": model,
        "condition": "generic-agent-without-tespec-two-input",
        "artifact_sha256": artifact_hashes(dataset, question),
        "returncode": returncode,
        "timed_out": timed_out,
        "wall_seconds": round(elapsed, 3),
        "infrastructure_error": infrastructure_error,
        "protocol_error": protocol_error,
        "input_access": input_access,
        "prediction": prediction,
        "gold_label": gold_label,
        "score_eligible": score_eligible,
        "correct": prediction["label"] == gold_label if score_eligible else None,
    }
    (attempt_dir / "result.json").write_text(
        json.dumps(record, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return record


def main() -> int:
    args = parse_args()
    if not os.environ.get("LLM_API_KEY"):
        raise SystemExit(
            "LLM_API_KEY is required in the process environment and is never stored."
        )
    if not shutil.which("openhands"):
        raise SystemExit("openhands CLI is not installed")
    if args.attempts != 3:
        raise SystemExit("the frozen difficulty policy requires exactly 3 attempts")
    if args.jobs < 1:
        raise SystemExit("--jobs must be at least 1")

    dataset = args.dataset.expanduser().resolve()
    catalog = load_json(dataset / "questions.json")
    gold_path = (args.gold or dataset / "gold.json").expanduser().resolve()
    gold = load_json(gold_path)
    if gold.get("schema") != "tespec-four-class-gold-index/v1":
        raise SystemExit("unsupported gold index schema")
    questions = select_questions(catalog, args.questions)

    stamp = dt.datetime.now(dt.timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    output_dir = (
        args.output_dir or DEFAULT_RESULTS / f"{catalog['benchmark']}-{stamp}"
    ).resolve()
    output_dir.mkdir(parents=True, exist_ok=False)

    started = time.monotonic()
    records: list[dict[str, Any]] = []
    with ThreadPoolExecutor(max_workers=args.jobs) as executor:
        futures = {
            executor.submit(
                evaluate_attempt,
                dataset,
                question,
                gold["questions"][question["id"]]["label"],
                attempt,
                output_dir,
                args.model,
                args.timeout,
            ): (question["id"], attempt)
            for question in questions
            for attempt in range(1, args.attempts + 1)
        }
        for future in as_completed(futures):
            record = future.result()
            records.append(record)
            status = (
                f"correct={record['correct']}"
                if record["score_eligible"]
                else "unresolved"
            )
            print(
                f"{record['question_id']} attempt={record['attempt']}: "
                f"{status} time={record['wall_seconds']:.1f}s"
            )
    records.sort(key=lambda item: (item["question_id"], item["attempt"]))
    versions = tool_environment_versions()

    summary = {
        "schema": "tespec-gpt5-nano-baseline-run/v2",
        "benchmark": catalog["benchmark"],
        "condition": "generic-agent-without-tespec-two-input",
        "model": args.model,
        "reasoning_effort": "high",
        "api_mode": "chat_completions",
        "api_base": os.environ.get("LLM_BASE_URL"),
        "attempts_per_question": args.attempts,
        "question_count": len(questions),
        "concurrency": args.jobs,
        "timeout_seconds_per_attempt": args.timeout,
        "runner_sha256": sha256_file(Path(__file__).resolve()),
        "versions": {
            "openhands_cli": versions["openhands"],
            "openhands_sdk": versions["openhands-sdk"],
            "litellm": versions["litellm"],
        },
        "infrastructure_failures": sum(
            record["timed_out"]
            or record["returncode"] != 0
            or record["infrastructure_error"] is not None
            or record["prediction"]["parser_status"] != "parsed"
            for record in records
        ),
        "protocol_failures": sum(
            record["protocol_error"] is not None for record in records
        ),
        "unresolved_attempts": sum(not record["score_eligible"] for record in records),
        "makespan_seconds": round(time.monotonic() - started, 3),
        "records": records,
    }
    (output_dir / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"results: {output_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
