#!/usr/bin/env python3
"""Run a Codex CLI GPT-5 Nano TeSpec/no-tool ablation."""

from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import shutil
import signal
import subprocess
import tempfile
import time
from typing import Any


ROOT = Path(__file__).resolve().parents[3]
EXPERIMENT = Path(__file__).resolve().parent
FIXTURES = (
    ROOT / "benchmark/experiments/switch-four-class-binds-ablation-20260730/fixtures"
)
LABEL_SCHEMA = EXPERIMENT / "output-schema.json"
BINDS_SCHEMA = EXPERIMENT / "binds-output-schema.json"
LABELS = {
    "q01": "correct",
    "q02": "complete",
    "q03": "soundness",
    "q04": "incomparable",
}
MODEL = "gpt-5-nano"
PROVIDER_CONFIG = (
    'model_providers.yunwu={name="Yunwu",'
    'base_url="https://yunwu.ai/v1",'
    'env_key="YUNWU_API_KEY",wire_api="responses",request_max_retries=10}'
)
CASE_VALUES = (-1, 0, 1, 2, 9, 10)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--condition",
        choices=("tool-enabled", "tool-forbidden"),
        required=True,
    )
    parser.add_argument("--questions", nargs="+", default=["all"])
    parser.add_argument("--attempts", type=int, default=3)
    parser.add_argument("--jobs", type=int, default=1)
    parser.add_argument("--timeout", type=int, default=300)
    parser.add_argument("--output-dir", type=Path)
    return parser.parse_args()


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def fenced(name: str, text: str, language: str) -> str:
    return f"### `{name}`\n\n```{language}\n{text.rstrip()}\n```"


def shared_contract() -> str:
    return """
Classify the relation between the C implementation and QCP specification.

- Sound: every behavior admitted by the spec is an implementation behavior,
  `R_S subset R_I`.
- Complete: every implementation behavior is admitted by the spec,
  `R_I subset R_S`.
- `correct`: both properties.
- `soundness`: Sound only.
- `complete`: Complete only.
- `incomparable`: neither.

Analyze both directions independently. An implementation test that passes only
supports Complete. A failing implementation test refutes Complete. Soundness
requires checking whether the spec admits an output the implementation cannot
produce.
""".strip()


def binds_prompt(impl: str, spec: str, template: str) -> str:
    return "\n\n".join(
        [
            (
                "You are the binds-writing stage of a four-class TeSpec skill. "
                "Do not call tools. Return only the required JSON object."
            ),
            (
                "Create exactly six concrete test cases for target function "
                "`classify_switch`, using n = -1, 0, 1, 2, 9, 10 in that "
                "order. In every case bind QCP value `N` to the same integer "
                "as C argument `n`. Preserve the template's field structure."
            ),
            fenced("impl.c", impl, "c"),
            fenced("spec.qcp", spec, "text"),
            fenced("analyze-derived binds template", template, "json"),
        ]
    )


def classification_prompt(
    impl: str,
    spec: str,
    binds: str | None = None,
    report: str | None = None,
) -> str:
    parts = [
        shared_contract(),
        (
            "The only original semantic inputs are the exact `impl.c` and "
            "`spec.qcp` below. Do not call any tool. Return only the JSON "
            "object required by the output schema."
        ),
        fenced("impl.c", impl, "c"),
        fenced("spec.qcp", spec, "text"),
    ]
    if binds is not None and report is not None:
        parts.extend(
            [
                (
                    "The following binds and TeSpec report are derived "
                    "artifacts produced from those two inputs. Use the report "
                    "as evidence for Complete, then still analyze Soundness "
                    "semantically."
                ),
                fenced("binds.json", binds, "json"),
                fenced("tespec-output/report.json", report, "json"),
            ]
        )
    else:
        parts.insert(
            1,
            (
                "This is the tool-forbidden condition. Reason only from the "
                "two original inputs."
            ),
        )
    return "\n\n".join(parts)


def terminate(process: subprocess.Popen[str]) -> None:
    try:
        os.killpg(process.pid, signal.SIGTERM)
        process.wait(timeout=10)
    except (ProcessLookupError, subprocess.TimeoutExpired):
        try:
            os.killpg(process.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
        process.wait()


def run_codex(
    workspace: Path,
    prompt: str,
    schema: Path,
    timeout: int,
) -> dict[str, Any]:
    command = [
        "codex",
        "exec",
        "--ephemeral",
        "--ignore-user-config",
        "--ignore-rules",
        "--skip-git-repo-check",
        "--json",
        "--sandbox",
        "read-only",
        "-C",
        str(workspace),
        "-m",
        MODEL,
        "-c",
        'model_provider="yunwu"',
        "-c",
        PROVIDER_CONFIG,
        "-c",
        'approval_policy="never"',
        "--output-schema",
        str(schema),
        prompt,
    ]
    started = time.monotonic()
    process = subprocess.Popen(
        command,
        cwd=workspace,
        env=os.environ.copy(),
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
        terminate(process)
        stdout, stderr = process.communicate()
    return {
        "returncode": process.returncode,
        "stdout": stdout,
        "stderr": stderr,
        "wall_seconds": round(time.monotonic() - started, 3),
        "timed_out": timed_out,
    }


def load_events(stdout: str) -> list[dict[str, Any]]:
    result = []
    for line in stdout.splitlines():
        try:
            item = json.loads(line)
        except json.JSONDecodeError:
            continue
        if isinstance(item, dict):
            result.append(item)
    return result


def agent_json(events: list[dict[str, Any]]) -> dict[str, Any] | None:
    selected = None
    for event in events:
        item = event.get("item")
        if (
            event.get("type") == "item.completed"
            and isinstance(item, dict)
            and item.get("type") == "agent_message"
            and isinstance(item.get("text"), str)
        ):
            try:
                value = json.loads(item["text"])
            except json.JSONDecodeError:
                continue
            if isinstance(value, dict):
                selected = value
    return selected


def prediction(events: list[dict[str, Any]]) -> tuple[str, str]:
    value = agent_json(events)
    label = value.get("label") if value else None
    if label in {*LABELS.values(), "abstain"}:
        return label, "parsed"
    return "abstain", "no_allowed_label"


def action_audit(events: list[dict[str, Any]]) -> dict[str, Any]:
    commands = []
    action_types = []
    for event in events:
        if event.get("type") != "item.completed":
            continue
        item = event.get("item")
        if not isinstance(item, dict):
            continue
        item_type = item.get("type")
        if item_type in {
            "command_execution",
            "file_change",
            "mcp_tool_call",
            "web_search",
        }:
            action_types.append(item_type)
        if item_type == "command_execution" and isinstance(item.get("command"), str):
            commands.append(item["command"])
    return {
        "action_count": len(action_types),
        "action_types": action_types,
        "commands": commands,
    }


def parse_binds(events: list[dict[str, Any]]) -> list[dict[str, Any]] | None:
    value = agent_json(events)
    binds = value.get("binds") if value else None
    return binds if isinstance(binds, list) else None


def validate_binds(value: Any) -> dict[str, Any]:
    result = {"exists": isinstance(value, list), "valid": False, "cases": 0}
    if not isinstance(value, list):
        return result
    result["cases"] = len(value)
    observed = []
    structurally_valid = True
    for index, item in enumerate(value, start=1):
        if not (
            isinstance(item, dict)
            and item.get("id") == f"case_{index:03d}"
            and isinstance(item.get("args"), dict)
            and isinstance(item.get("values"), dict)
            and isinstance(item["args"].get("n"), int)
            and item["args"].get("n") == item["values"].get("N")
        ):
            structurally_valid = False
            break
        observed.append(item["args"]["n"])
    result["valid"] = structurally_valid and observed == list(CASE_VALUES)
    return result


def validate_report(path: Path) -> dict[str, Any]:
    result = {"exists": path.is_file(), "valid": False, "summary": None}
    if not path.is_file():
        return result
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return result
    summary = value.get("summary")
    result["summary"] = summary
    result["valid"] = (
        isinstance(summary, dict)
        and summary.get("total", 0) == len(CASE_VALUES)
        and summary.get("UNKNOWN") == 0
        and summary.get("ERROR") == 0
    )
    return result


def run_tespec(
    workspace: Path,
    operation: str,
    timeout: int,
) -> dict[str, Any]:
    if operation == "analyze":
        args = [
            "python3",
            "-m",
            "spectest",
            "analyze",
            "impl.c",
            "--spec-file",
            "spec.qcp",
            "--function",
            "classify_switch",
            "--write-binds",
            "binds.json",
        ]
    else:
        args = [
            "python3",
            "-m",
            "spectest",
            "run",
            "impl.c",
            "--spec-file",
            "spec.qcp",
            "--function",
            "classify_switch",
            "--binds",
            "binds.json",
            "--output-dir",
            "tespec-output",
        ]
    env = os.environ.copy()
    env["PYTHONPATH"] = str(ROOT)
    started = time.monotonic()
    try:
        completed = subprocess.run(
            args,
            cwd=workspace,
            env=env,
            text=True,
            capture_output=True,
            timeout=timeout,
            check=False,
        )
        return {
            "returncode": completed.returncode,
            "stdout": completed.stdout,
            "stderr": completed.stderr,
            "wall_seconds": round(time.monotonic() - started, 3),
            "timed_out": False,
        }
    except subprocess.TimeoutExpired as error:
        return {
            "returncode": None,
            "stdout": error.stdout or "",
            "stderr": error.stderr or "",
            "wall_seconds": round(time.monotonic() - started, 3),
            "timed_out": True,
        }


def write_stage(attempt_root: Path, name: str, stage: dict[str, Any]) -> None:
    (attempt_root / f"{name}-trace.jsonl").write_text(stage["stdout"], encoding="utf-8")
    (attempt_root / f"{name}-stderr.log").write_text(stage["stderr"], encoding="utf-8")


def run_attempt(
    condition: str,
    question_id: str,
    attempt: int,
    output_root: Path,
    timeout: int,
) -> dict[str, Any]:
    attempt_root = output_root / question_id / f"attempt-{attempt:02d}"
    attempt_root.mkdir(parents=True)
    with tempfile.TemporaryDirectory(
        prefix=f"codex-nano-{condition}-{question_id}-{attempt:02d}-"
    ) as temporary:
        workspace = Path(temporary)
        shutil.copy2(FIXTURES / "impl.c", workspace / "impl.c")
        shutil.copy2(FIXTURES / f"{question_id}.qcp", workspace / "spec.qcp")
        impl = (workspace / "impl.c").read_text(encoding="utf-8")
        spec = (workspace / "spec.qcp").read_text(encoding="utf-8")
        original_hashes = {
            "impl": sha256(workspace / "impl.c"),
            "spec": sha256(workspace / "spec.qcp"),
        }
        stages: dict[str, dict[str, Any]] = {}
        external: dict[str, dict[str, Any]] = {}
        binds_value = None
        report = {"exists": False, "valid": False, "summary": None}

        if condition == "tool-enabled":
            external["analyze"] = run_tespec(workspace, "analyze", timeout)
            template_path = workspace / "binds.json"
            if external["analyze"]["returncode"] == 0 and template_path.is_file():
                stages["binds"] = run_codex(
                    workspace,
                    binds_prompt(
                        impl,
                        spec,
                        template_path.read_text(encoding="utf-8"),
                    ),
                    BINDS_SCHEMA,
                    timeout,
                )
                binds_events = load_events(stages["binds"]["stdout"])
                binds_value = parse_binds(binds_events)
            binds_check = validate_binds(binds_value)
            if binds_check["valid"]:
                (workspace / "binds.json").write_text(
                    json.dumps(binds_value, ensure_ascii=False, indent=2) + "\n",
                    encoding="utf-8",
                )
                external["run"] = run_tespec(workspace, "run", timeout)
                report = validate_report(workspace / "tespec-output/report.json")
            if report["valid"]:
                stages["classification"] = run_codex(
                    workspace,
                    classification_prompt(
                        impl,
                        spec,
                        (workspace / "binds.json").read_text(encoding="utf-8"),
                        (workspace / "tespec-output/report.json").read_text(
                            encoding="utf-8"
                        ),
                    ),
                    LABEL_SCHEMA,
                    timeout,
                )
        else:
            binds_check = validate_binds(None)
            stages["classification"] = run_codex(
                workspace,
                classification_prompt(impl, spec),
                LABEL_SCHEMA,
                timeout,
            )

        classification = stages.get("classification")
        classify_events = (
            load_events(classification["stdout"]) if classification else []
        )
        label, parser_status = prediction(classify_events)
        stage_audits = {
            name: action_audit(load_events(stage["stdout"]))
            for name, stage in stages.items()
        }
        action_count = sum(audit["action_count"] for audit in stage_audits.values())
        unchanged = {
            "impl": sha256(workspace / "impl.c") == original_hashes["impl"],
            "spec": sha256(workspace / "spec.qcp") == original_hashes["spec"],
        }
        if (workspace / "binds.json").is_file():
            shutil.copy2(workspace / "binds.json", attempt_root / "binds.json")
        if (workspace / "tespec-output/report.json").is_file():
            shutil.copy2(
                workspace / "tespec-output/report.json",
                attempt_root / "tespec-report.json",
            )

    for name, stage in stages.items():
        write_stage(attempt_root, name, stage)
    for name, stage in external.items():
        (attempt_root / f"tespec-{name}.stdout.log").write_text(
            stage["stdout"], encoding="utf-8"
        )
        (attempt_root / f"tespec-{name}.stderr.log").write_text(
            stage["stderr"], encoding="utf-8"
        )

    codex_ok = all(
        stage["returncode"] == 0 and not stage["timed_out"] for stage in stages.values()
    )
    strict_tool = (
        condition == "tool-enabled"
        and set(stages) == {"binds", "classification"}
        and codex_ok
        and action_count == 0
        and external.get("analyze", {}).get("returncode") == 0
        and "run" in external
        and binds_check["valid"]
        and report["valid"]
        and all(unchanged.values())
        and parser_status == "parsed"
    )
    forbidden_adherent = (
        condition == "tool-forbidden"
        and set(stages) == {"classification"}
        and codex_ok
        and action_count == 0
        and parser_status == "parsed"
    )
    gold = LABELS[question_id]
    record = {
        "question_id": question_id,
        "attempt": attempt,
        "condition": condition,
        "model": MODEL,
        "gold_label": gold,
        "prediction": {"label": label, "parser_status": parser_status},
        "correct": label == gold if parser_status == "parsed" else False,
        "artifact_sha256": original_hashes,
        "codex_stages": {
            name: {
                key: stage[key]
                for key in (
                    "returncode",
                    "wall_seconds",
                    "timed_out",
                )
            }
            for name, stage in stages.items()
        },
        "codex_action_audit": stage_audits,
        "external_tespec": {
            name: {
                key: stage[key]
                for key in (
                    "returncode",
                    "wall_seconds",
                    "timed_out",
                )
            }
            for name, stage in external.items()
        },
        "binds": binds_check,
        "tespec_report": report,
        "inputs_unchanged": unchanged,
        "strict_tool_adherent": strict_tool,
        "tool_forbidden_adherent": forbidden_adherent,
    }
    (attempt_root / "result.json").write_text(
        json.dumps(record, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return record


def main() -> int:
    args = parse_args()
    if not os.environ.get("YUNWU_API_KEY"):
        raise SystemExit("YUNWU_API_KEY is required and is never persisted")
    if not shutil.which("codex"):
        raise SystemExit("codex CLI is not installed")
    question_ids = list(LABELS) if args.questions == ["all"] else args.questions
    unknown = sorted(set(question_ids) - set(LABELS))
    if unknown:
        raise SystemExit(f"unknown questions: {', '.join(unknown)}")
    if args.attempts < 1 or args.jobs < 1:
        raise SystemExit("attempts and jobs must be positive")
    stamp = dt.datetime.now(dt.timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    output_root = (
        args.output_dir
        or ROOT / "benchmark/results/codex-gpt-5-nano" / f"{args.condition}-{stamp}"
    ).resolve()
    output_root.mkdir(parents=True, exist_ok=False)
    started = time.monotonic()
    records = []
    with ThreadPoolExecutor(max_workers=args.jobs) as executor:
        futures = {
            executor.submit(
                run_attempt,
                args.condition,
                question_id,
                attempt,
                output_root,
                args.timeout,
            ): (question_id, attempt)
            for question_id in question_ids
            for attempt in range(1, args.attempts + 1)
        }
        for future in as_completed(futures):
            record = future.result()
            records.append(record)
            print(
                f"{record['question_id']} attempt={record['attempt']} "
                f"label={record['prediction']['label']} "
                f"correct={record['correct']} "
                f"strict={record['strict_tool_adherent']} "
                f"forbidden_ok={record['tool_forbidden_adherent']}",
                flush=True,
            )
    records.sort(key=lambda item: (item["question_id"], item["attempt"]))
    strict = [item for item in records if item["strict_tool_adherent"]]
    forbidden = [item for item in records if item["tool_forbidden_adherent"]]

    def accuracy(items: list[dict[str, Any]]) -> float | None:
        return sum(item["correct"] for item in items) / len(items) if items else None

    summary = {
        "schema": "tespec-codex-nano-condition-run/v2",
        "condition": args.condition,
        "model": MODEL,
        "provider": "yunwu-responses",
        "api_base": "https://yunwu.ai/v1",
        "codex_version": subprocess.run(
            ["codex", "--version"],
            check=True,
            text=True,
            capture_output=True,
        ).stdout.strip(),
        "attempts_per_question": args.attempts,
        "question_count": len(question_ids),
        "timeout_seconds": args.timeout,
        "concurrency": args.jobs,
        "allocated_attempts": len(records),
        "allocated_accuracy": accuracy(records),
        "strict_tool_adherent_attempts": len(strict),
        "strict_tool_adherent_accuracy": accuracy(strict),
        "tool_forbidden_adherent_attempts": len(forbidden),
        "tool_forbidden_adherent_accuracy": accuracy(forbidden),
        "makespan_seconds": round(time.monotonic() - started, 3),
        "records": records,
    }
    (output_root / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(output_root)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
