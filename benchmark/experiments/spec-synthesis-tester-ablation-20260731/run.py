#!/usr/bin/env python3
"""Run syntax-assisted bidirectional Code/QCP synthesis with hidden tests."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import sys
import tempfile
import time
from typing import Any


ROOT = Path(__file__).resolve().parents[3]
EXPERIMENT = Path(__file__).resolve().parent
CASE = ROOT / "e2e/iplib_ModeConvert_AMMFun"
PUBLIC_IMPL = EXPERIMENT / "input/impl.c"
PUBLIC_SPEC = EXPERIMENT / "input/spec.qcp"
PUBLIC_INTERFACE = EXPERIMENT / "input/interface.h"
DEMOS = (
    (
        "add_one",
        EXPERIMENT / "demo/add_one.c",
        EXPERIMENT / "demo/add_one.qcp",
        EXPERIMENT / "demo/add_one.annotated.c",
    ),
    (
        "increment_cell",
        EXPERIMENT / "demo/increment_cell.c",
        EXPERIMENT / "demo/increment_cell.qcp",
        EXPERIMENT / "demo/increment_cell.annotated.c",
    ),
    (
        "struct_override",
        EXPERIMENT / "demo/struct_override.c",
        EXPERIMENT / "demo/struct_override.qcp",
        EXPERIMENT / "demo/struct_override.annotated.c",
    ),
)
HIDDEN_STATES = EXPERIMENT / "hidden/states.json"
MUTANT_DIRS = (CASE / "mutants/refinement", CASE / "mutants/heldout")
MATRIX_RUNNER = ROOT / "skills/tespec-e2e/scripts/run_mutation_matrix.py"
SYNTAX_CHECKER = EXPERIMENT / "syntax_checker.py"
SPLIT = EXPERIMENT / "split.json"
SPEC_SCHEMA = EXPERIMENT / "output-schema.json"
CODE_SCHEMA = EXPERIMENT / "code-output-schema.json"
QCP_BINARY = ROOT / "bin/qcp-symexec"
DEFAULT_RESULTS_ROOT = (
    Path(
        os.environ.get(
            "TESPEC_ARTIFACT_ROOT",
            str(ROOT.parent / f"{ROOT.name}-artifacts"),
        )
    ).expanduser()
    / "benchmark-results"
)
MODEL = "gpt-5-nano"
PROVIDER_CONFIG = (
    'model_providers.yunwu={name="Yunwu",'
    'base_url="https://yunwu.ai/v1",'
    'env_key="YUNWU_API_KEY",wire_api="responses",request_max_retries=10}'
)
ANNOTATION = re.compile(r"/\*@(?P<body>.*?)\*/", re.DOTALL)

for import_root in (ROOT, EXPERIMENT):
    if str(import_root) not in sys.path:
        sys.path.insert(0, str(import_root))

from spectest.core import JobError, attach_spec_to_source  # noqa: E402
from state_adapter import StateBindingError, bind_states_for_spec  # noqa: E402


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--direction",
        choices=("code-to-spec", "spec-to-code", "both"),
        default="both",
    )
    parser.add_argument(
        "--condition",
        choices=("no-tool", "qcp-tool", "tespec-tool", "all"),
        default="all",
    )
    parser.add_argument("--attempts", type=int, default=1)
    parser.add_argument("--rounds", type=int, default=2)
    parser.add_argument("--timeout", type=int, default=300)
    parser.add_argument("--output-dir", type=Path)
    parser.add_argument(
        "--oracle-audit",
        action="store_true",
        help="audit both gold artifacts on the hidden test machine",
    )
    return parser.parse_args()


def write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(value, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def strip_spec(source: str) -> str:
    stripped, count = ANNOTATION.subn("", source)
    if count != 1:
        raise ValueError(f"expected exactly one QCP annotation, found {count}")
    return stripped


def load_protocol() -> tuple[dict[str, Any], list[dict[str, Any]]]:
    split = json.loads(SPLIT.read_text(encoding="utf-8"))
    payload = json.loads(HIDDEN_STATES.read_text(encoding="utf-8"))
    if payload.get("schema") != "tespec-c-state-suite/v1":
        raise ValueError("hidden states use an unsupported schema")
    if payload.get("function") != "ModeConvert_AMMFun":
        raise ValueError("hidden states target the wrong function")
    states = payload.get("cases")
    if not isinstance(states, list):
        raise ValueError("hidden state suite must contain a cases array")
    state_ids = {item["id"] for item in states}
    listed = [case for group in split["groups"] for case in group["cases"]]
    if len(split["groups"]) != 6:
        raise ValueError("the task must have exactly six semantic groups")
    if (
        len(states) != 30
        or len(state_ids) != 30
        or len(listed) != 30
        or len(set(listed)) != 30
        or set(listed) != state_ids
        or any(len(group["cases"]) != 5 for group in split["groups"])
    ):
        raise ValueError("six groups must partition all 30 hidden cases as 6 x 5")
    mutant_names = {
        path.name for directory in MUTANT_DIRS for path in directory.glob("*.c")
    }
    if len(mutant_names) != 12:
        raise ValueError("hidden mutation suite must contain exactly 12 mutants")
    for group in split["groups"]:
        if not set(group["mutants"]) <= mutant_names:
            raise ValueError(f"unknown group mutant in {group['id']}")
    bind_states_for_spec(PUBLIC_SPEC.read_text(encoding="utf-8"), states)
    return split, states


def prepare_mutants(target_dir: Path) -> None:
    target_dir.mkdir(parents=True)
    for source_dir in MUTANT_DIRS:
        for source in sorted(source_dir.glob("*.c")):
            target = target_dir / source.name
            if target.exists():
                raise ValueError(f"duplicate mutant name: {source.name}")
            target.write_text(
                strip_spec(source.read_text(encoding="utf-8")),
                encoding="utf-8",
            )


def evaluate_spec(
    candidate: str,
    output_dir: Path,
    states: list[dict[str, Any]],
) -> dict[str, Any]:
    output_dir.mkdir(parents=True)
    reference = output_dir / "reference.c"
    spec = output_dir / "candidate.qcp"
    binds_path = output_dir / "candidate-binds.json"
    mutants = output_dir / "hidden-mutants"
    matrix_dir = output_dir / "matrix"
    reference.write_text(PUBLIC_IMPL.read_text(encoding="utf-8"), encoding="utf-8")
    spec.write_text(candidate.strip() + "\n", encoding="utf-8")
    try:
        binds = bind_states_for_spec(candidate, states)
    except StateBindingError as error:
        return {
            "returncode": None,
            "matrix": None,
            "matrix_dir": matrix_dir,
            "interface_error": str(error),
        }
    write_json(binds_path, {"binds": binds})
    prepare_mutants(mutants)
    completed = subprocess.run(
        [
            os.sys.executable,
            str(MATRIX_RUNNER),
            "--reference",
            str(reference),
            "--function",
            "ModeConvert_AMMFun",
            "--spec-file",
            str(spec),
            "--binds",
            str(binds_path),
            "--mutants",
            str(mutants),
            "--output-dir",
            str(matrix_dir),
            "--artifact-root",
            str(output_dir),
            "--spec-version",
            "frozen-candidate",
            "--phase",
            "heldout",
            "--expected-binds",
            "30",
            "--minimum-mutants",
            "12",
        ],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=False,
    )
    (output_dir / "runner.stdout.txt").write_text(completed.stdout, encoding="utf-8")
    (output_dir / "runner.stderr.txt").write_text(completed.stderr, encoding="utf-8")
    matrix_path = matrix_dir / "matrix.json"
    return {
        "returncode": completed.returncode,
        "matrix": (
            json.loads(matrix_path.read_text(encoding="utf-8"))
            if matrix_path.is_file()
            else None
        ),
        "matrix_dir": matrix_dir,
    }


def candidate_translation_unit(code: str) -> str:
    return (
        PUBLIC_INTERFACE.read_text(encoding="utf-8").rstrip()
        + "\n\n"
        + code.strip()
        + "\n"
    )


def evaluate_code(
    candidate: str,
    output_dir: Path,
    states: list[dict[str, Any]],
) -> dict[str, Any]:
    output_dir.mkdir(parents=True)
    source = output_dir / "candidate.c"
    spec = output_dir / "target.qcp"
    job = output_dir / "job.json"
    report_dir = output_dir / "report"
    source.write_text(candidate_translation_unit(candidate), encoding="utf-8")
    spec.write_text(PUBLIC_SPEC.read_text(encoding="utf-8"), encoding="utf-8")
    binds = bind_states_for_spec(PUBLIC_SPEC.read_text(encoding="utf-8"), states)
    write_json(
        job,
        {
            "source": str(source),
            "spec_file": str(spec),
            "function": "ModeConvert_AMMFun",
            "binds": binds,
            "output_dir": str(report_dir),
        },
    )
    completed = subprocess.run(
        [
            os.sys.executable,
            "-m",
            "spectest",
            str(job),
            "--output-dir",
            str(report_dir),
        ],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=False,
    )
    (output_dir / "runner.stdout.txt").write_text(completed.stdout, encoding="utf-8")
    (output_dir / "runner.stderr.txt").write_text(completed.stderr, encoding="utf-8")
    report_path = report_dir / "report.json"
    return {
        "returncode": completed.returncode,
        "report": (
            json.loads(report_path.read_text(encoding="utf-8"))
            if report_path.is_file()
            else None
        ),
    }


def score_spec(evaluation: dict[str, Any], split: dict[str, Any]) -> dict[str, Any]:
    if evaluation.get("interface_error"):
        return {
            "correct": False,
            "score": 0.0,
            "groups": [],
            "error": False,
            "invalid_spec_interface": evaluation["interface_error"],
        }
    matrix = evaluation["matrix"]
    if not isinstance(matrix, dict) or "reference" not in matrix:
        return {"correct": False, "score": 0.0, "groups": [], "error": True}
    matrix_dir = evaluation["matrix_dir"]
    reference = json.loads(
        (matrix_dir / "reference/report.json").read_text(encoding="utf-8")
    )
    reference_status = {item["id"]: item["status"] for item in reference["results"]}
    mutant_status = {}
    for item in matrix["mutants"]:
        report = json.loads(
            (
                matrix_dir / "mutants" / Path(item["mutant"]).stem / "report.json"
            ).read_text(encoding="utf-8")
        )
        mutant_status[item["mutant"]] = {
            case["id"]: case["status"] for case in report["results"]
        }
    groups = []
    for group in split["groups"]:
        positive = sum(reference_status.get(case) == "PASS" for case in group["cases"])
        killed = sum(
            any(
                mutant_status.get(mutant, {}).get(case) == "FAIL"
                for case in group["cases"]
            )
            for mutant in group["mutants"]
        )
        total = len(group["cases"]) + len(group["mutants"])
        groups.append(
            {
                "id": group["id"],
                "hidden_tests_passed": positive,
                "hidden_tests_total": len(group["cases"]),
                "targeted_mutants_killed": killed,
                "targeted_mutants_total": len(group["mutants"]),
                "score": (positive + killed) / total,
            }
        )
    mutation = matrix["mutation_summary"]
    positive_rate = matrix["reference"]["counts"]["PASS"] / 30
    mutation_rate = mutation["killed"] / 12
    return {
        "correct": positive_rate == 1 and mutation_rate == 1,
        "score": (positive_rate + mutation_rate) / 2,
        "reference_counts": matrix["reference"]["counts"],
        "mutation_summary": mutation,
        "groups": groups,
        "error": False,
    }


def score_code(evaluation: dict[str, Any], split: dict[str, Any]) -> dict[str, Any]:
    report = evaluation["report"]
    if not isinstance(report, dict):
        return {"correct": False, "score": 0.0, "groups": [], "error": True}
    status = {item["id"]: item["status"] for item in report["results"]}
    groups = []
    for group in split["groups"]:
        passed = sum(status.get(case) == "PASS" for case in group["cases"])
        groups.append(
            {
                "id": group["id"],
                "hidden_tests_passed": passed,
                "hidden_tests_total": len(group["cases"]),
                "score": passed / len(group["cases"]),
            }
        )
    return {
        "correct": report["summary"]["PASS"] == 30,
        "score": report["summary"]["PASS"] / 30,
        "reference_counts": report["summary"],
        "groups": groups,
        "error": False,
    }


def fenced(name: str, content: str, language: str) -> str:
    return f"### `{name}`\n\n```{language}\n{content.rstrip()}\n```"


def demo_prompt() -> str:
    sections = []
    for name, implementation, specification, annotated in DEMOS:
        sections.extend(
            [
                fenced(
                    f"demo/{name}.c",
                    implementation.read_text(encoding="utf-8"),
                    "c",
                ),
                fenced(
                    f"demo/{name}.qcp",
                    specification.read_text(encoding="utf-8"),
                    "text",
                ),
                fenced(
                    f"demo/{name}.annotated.c",
                    annotated.read_text(encoding="utf-8"),
                    "c",
                ),
            ]
        )
    return "\n\n".join(sections)


def condition_prompt(condition: str) -> str:
    if condition == "qcp-tool":
        return (
            "After each submission, the harness deterministically inserts the "
            "candidate annotation and runs the original `qcp-symexec` binary. "
            "The next stateless call receives its raw return code, stdout, and "
            "stderr. This tool has no hidden C states or mutations."
        )
    if condition == "tespec-tool":
        return (
            "After each submission, the harness runs TeSpec's public checker. "
            "The next stateless call receives its normalized attachment, "
            "binding-analysis, parser, or C-interface diagnostic. This tool "
            "has no hidden C states or mutations."
        )
    return (
        "This is the no-tool condition. No execution or parser report is "
        "returned between stateless calls; review the candidate yourself."
    )


def task_prompt(direction: str, condition: str) -> str:
    if direction == "code-to-spec":
        return "\n\n".join(
            [
                (
                    "Generate a precise QCP separation-logic specification for "
                    "`ModeConvert_AMMFun`. Return JSON with one raw QCP body in "
                    "`spec`; do not return C or a `/*@ ... */` wrapper."
                ),
                (
                    "The final answer is judged once by hidden semantic tests "
                    "and hidden incorrect-program mutations. No test inputs or "
                    "mutation feedback are available. A vacuous postcondition "
                    "is incorrect."
                ),
                condition_prompt(condition),
                (
                    "Do not call Codex tools yourself; the harness invokes only "
                    "the tool selected for this ablation condition."
                ),
                (
                    "Follow the demonstrated QCP grammar exactly. Bind logical "
                    "pre-state values with `With`; describe memory with "
                    "`data_at` or `store`; use `p@pre` for pre-state program "
                    "pointers; and express cases with `&&`, `!`, and `=>`. "
                    "QCP does not use C ternaries, `old(...)`, or "
                    "`If ... Then ... Else`."
                ),
                (
                    "Hidden tests are concrete C states, so binder spelling is "
                    "arbitrary. To make state binding structural, every `With` "
                    "input variable must occur exactly once as the direct value "
                    "of one `Require store(field_address, variable)` term; each "
                    "field and variable must be unique."
                ),
                "Unrelated QCP examples:",
                demo_prompt(),
                "Target input:",
                fenced("input/impl.c", PUBLIC_IMPL.read_text(encoding="utf-8"), "c"),
            ]
        )
    return "\n\n".join(
        [
            (
                "Generate the C definition of `void ModeConvert_AMMFun(void *p)` "
                "that implements the QCP specification. Return JSON with only "
                "the function definition in `code`; the supplied interface is "
                "prepended by the judge."
            ),
            (
                "The final answer is judged once by hidden semantic tests. No "
                "test inputs or results are available."
            ),
            condition_prompt(condition),
            (
                "Do not call Codex tools yourself; the harness invokes only "
                "the tool selected for this ablation condition."
            ),
            (
                "The examples are complete implementations of their specs. "
                "Generate only the requested function definition using names "
                "from the supplied interface. Do not add includes or use "
                "undeclared macros such as `NULL`."
            ),
            "Unrelated Code/QCP examples:",
            demo_prompt(),
            "Target inputs:",
            fenced(
                "input/interface.h",
                PUBLIC_INTERFACE.read_text(encoding="utf-8"),
                "c",
            ),
            fenced("input/spec.qcp", PUBLIC_SPEC.read_text(encoding="utf-8"), "text"),
        ]
    )


def revision_prompt(
    direction: str,
    condition: str,
    candidate: str,
    tool_report: dict[str, Any] | None,
) -> str:
    field = "spec" if direction == "code-to-spec" else "code"
    parts = [
        task_prompt(direction, condition),
        (
            f"Return a complete replacement `{field}`. Recheck syntax and all "
            "semantics yourself."
        ),
        fenced(f"current.{field}", candidate, "text" if field == "spec" else "c"),
    ]
    if tool_report is not None:
        parts.extend(
            [
                (
                    "The selected public tool returned the following. It "
                    "contains no hidden test case or mutation:"
                ),
                fenced(
                    f"{condition}-report.json",
                    json.dumps(tool_report, ensure_ascii=False, indent=2),
                    "json",
                ),
            ]
        )
    else:
        parts.append("No tool report is available; perform the review yourself.")
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


def parse_candidate(stdout: str, direction: str) -> str | None:
    field = "spec" if direction == "code-to-spec" else "code"
    selected = None
    for line in stdout.splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        item = event.get("item")
        if (
            event.get("type") == "item.completed"
            and isinstance(item, dict)
            and item.get("type") == "agent_message"
        ):
            try:
                payload = json.loads(item.get("text", ""))
            except json.JSONDecodeError:
                continue
            if isinstance(payload, dict) and isinstance(payload.get(field), str):
                selected = payload[field]
    return selected


def action_audit(stdout: str) -> dict[str, Any]:
    action_types = []
    for line in stdout.splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        item = event.get("item")
        if event.get("type") != "item.completed" or not isinstance(item, dict):
            continue
        if item.get("type") in {
            "command_execution",
            "file_change",
            "mcp_tool_call",
            "web_search",
        }:
            action_types.append(item["type"])
    return {
        "action_count": len(action_types),
        "action_types": action_types,
    }


def check_syntax(
    direction: str,
    candidate: str,
    output_dir: Path,
) -> dict[str, Any]:
    suffix = ".qcp" if direction == "code-to-spec" else ".c"
    submission = output_dir / f"submission{suffix}"
    submission.write_text(candidate.strip() + "\n", encoding="utf-8")
    completed = subprocess.run(
        [
            os.sys.executable,
            str(SYNTAX_CHECKER),
            direction,
            "--submission",
            str(submission),
        ],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=False,
    )
    (output_dir / "syntax-check.stderr.txt").write_text(
        completed.stderr, encoding="utf-8"
    )
    try:
        report = json.loads(completed.stdout)
    except json.JSONDecodeError:
        report = {
            "schema": "tespec-syntax-check/v1",
            "syntax_valid": False,
            "stage": "checker",
            "diagnostic": completed.stderr[-1200:],
        }
    write_json(output_dir / "syntax-check.json", report)
    return report


def check_with_original_qcp(
    direction: str,
    candidate: str,
    output_dir: Path,
) -> dict[str, Any]:
    try:
        if direction == "code-to-spec":
            source = attach_spec_to_source(
                PUBLIC_IMPL.read_text(encoding="utf-8"),
                candidate,
                "ModeConvert_AMMFun",
            )
        else:
            implementation = (
                PUBLIC_INTERFACE.read_text(encoding="utf-8")
                + "\n"
                + candidate.strip()
                + "\n"
            )
            source = attach_spec_to_source(
                implementation,
                PUBLIC_SPEC.read_text(encoding="utf-8"),
                "ModeConvert_AMMFun",
            )
    except (JobError, OSError, UnicodeError) as error:
        report = {
            "schema": "qcp-original-tool-report/v1",
            "accepted": False,
            "stage": "attach",
            "returncode": None,
            "stdout": "",
            "stderr": str(error),
        }
        write_json(output_dir / "qcp-tool-report.json", report)
        return report

    source_path = output_dir / "qcp-tool-input.annotated.c"
    source_path.write_text(source, encoding="utf-8")
    try:
        completed = subprocess.run(
            [
                str(QCP_BINARY),
                "--no-coq-gen",
                "--function",
                "ModeConvert_AMMFun",
                str(source_path),
            ],
            cwd=ROOT,
            capture_output=True,
            text=True,
            timeout=60,
            check=False,
        )
    except subprocess.TimeoutExpired as error:
        report = {
            "schema": "qcp-original-tool-report/v1",
            "accepted": False,
            "stage": "symbolic-execution",
            "returncode": None,
            "stdout": (error.stdout or "")[-6000:],
            "stderr": ((error.stderr or "") + "\nQCP timed out after 60 seconds")[
                -6000:
            ],
        }
        write_json(output_dir / "qcp-tool-report.json", report)
        return report
    (output_dir / "qcp-tool.stdout.txt").write_text(completed.stdout, encoding="utf-8")
    (output_dir / "qcp-tool.stderr.txt").write_text(completed.stderr, encoding="utf-8")
    report = {
        "schema": "qcp-original-tool-report/v1",
        "accepted": completed.returncode == 0,
        "stage": "symbolic-execution",
        "returncode": completed.returncode,
        "stdout": completed.stdout[-6000:],
        "stderr": completed.stderr[-6000:],
    }
    write_json(output_dir / "qcp-tool-report.json", report)
    return report


def run_attempt(
    direction: str,
    condition: str,
    attempt: int,
    rounds: int,
    timeout: int,
    output_dir: Path,
    split: dict[str, Any],
    states: list[dict[str, Any]],
) -> dict[str, Any]:
    attempt_dir = output_dir / direction / condition / f"attempt-{attempt:03d}"
    attempt_dir.mkdir(parents=True)
    candidate = None
    tool_report = None
    calls = []
    schema = SPEC_SCHEMA if direction == "code-to-spec" else CODE_SCHEMA
    with tempfile.TemporaryDirectory(prefix="tespec-bidirectional-model-") as temp:
        workspace = Path(temp)
        for round_number in range(1, rounds + 1):
            prompt = (
                task_prompt(direction, condition)
                if round_number == 1
                else revision_prompt(
                    direction,
                    condition,
                    candidate or "",
                    tool_report,
                )
            )
            call = run_codex(workspace, prompt, schema, timeout)
            audit = action_audit(call["stdout"])
            round_dir = attempt_dir / f"round-{round_number:02d}"
            round_dir.mkdir()
            (round_dir / "trace.jsonl").write_text(call["stdout"], encoding="utf-8")
            (round_dir / "stderr.txt").write_text(call["stderr"], encoding="utf-8")
            parsed = parse_candidate(call["stdout"], direction)
            if parsed is not None:
                candidate = parsed
            tool_ran = condition != "no-tool" and candidate is not None
            if tool_ran and condition == "qcp-tool":
                tool_report = check_with_original_qcp(
                    direction,
                    candidate,
                    round_dir,
                )
            elif tool_ran:
                tool_report = check_syntax(direction, candidate, round_dir)
            calls.append(
                {
                    "round": round_number,
                    "returncode": call["returncode"],
                    "timed_out": call["timed_out"],
                    "wall_seconds": call["wall_seconds"],
                    "candidate_parsed": parsed is not None,
                    "model_action_audit": audit,
                    "tool": condition if condition != "no-tool" else None,
                    "tool_ran": tool_ran,
                    "tool_accepted": (
                        tool_report.get(
                            "syntax_valid",
                            tool_report.get("accepted"),
                        )
                        if tool_ran and tool_report is not None
                        else None
                    ),
                }
            )
    if candidate is None:
        hidden = {"correct": False, "score": 0.0, "error": "no candidate"}
    else:
        suffix = ".qcp" if direction == "code-to-spec" else ".c"
        frozen = attempt_dir / f"frozen-submission{suffix}"
        frozen.write_text(candidate.strip() + "\n", encoding="utf-8")
        evaluation_dir = attempt_dir / "hidden-test-machine"
        if direction == "code-to-spec":
            hidden = score_spec(
                evaluate_spec(candidate, evaluation_dir, states),
                split,
            )
        else:
            hidden = score_code(
                evaluate_code(candidate, evaluation_dir, states),
                split,
            )
    result = {
        "direction": direction,
        "condition": condition,
        "attempt": attempt,
        "calls": calls,
        "hidden": hidden,
    }
    if any(call["model_action_audit"]["action_count"] != 0 for call in calls):
        result["protocol_valid"] = False
        result["hidden"]["correct"] = False
        result["hidden"]["protocol_violation"] = "model used an undeclared tool"
    else:
        result["protocol_valid"] = True
    write_json(attempt_dir / "result.json", result)
    return result


def gold_function() -> str:
    source = PUBLIC_IMPL.read_text(encoding="utf-8")
    start = source.index("void ModeConvert_AMMFun")
    return source[start:]


def oracle_audit(
    output_dir: Path,
    split: dict[str, Any],
    states: list[dict[str, Any]],
) -> dict[str, Any]:
    spec = PUBLIC_SPEC.read_text(encoding="utf-8")
    code = gold_function()
    report = {
        "schema": "tespec-bidirectional-oracle-audit/v1",
        "code_to_spec": score_spec(
            evaluate_spec(spec, output_dir / "code-to-spec", states),
            split,
        ),
        "spec_to_code": score_code(
            evaluate_code(code, output_dir / "spec-to-code", states),
            split,
        ),
        "inputs": {
            "implementation_sha256": sha256(PUBLIC_IMPL),
            "specification_sha256": sha256(PUBLIC_SPEC),
        },
    }
    write_json(output_dir / "report.json", report)
    return report


def summarize(results: list[dict[str, Any]]) -> dict[str, Any]:
    cells = {}
    for direction in ("code-to-spec", "spec-to-code"):
        for condition in ("no-tool", "qcp-tool", "tespec-tool"):
            selected = [
                item
                for item in results
                if item["direction"] == direction and item["condition"] == condition
            ]
            if selected:
                cells[f"{direction}/{condition}"] = {
                    "attempts": len(selected),
                    "correct": sum(item["hidden"]["correct"] for item in selected),
                    "mean_score": sum(item["hidden"]["score"] for item in selected)
                    / len(selected),
                }
    return {
        "schema": "tespec-bidirectional-synthesis-ablation/v1",
        "model": MODEL,
        "cells": cells,
        "results": results,
    }


def main() -> int:
    args = parse_args()
    if args.attempts < 1 or args.rounds < 1:
        raise SystemExit("attempts and rounds must be positive")
    split, states = load_protocol()
    output_dir = (
        args.output_dir.expanduser().resolve()
        if args.output_dir is not None
        else DEFAULT_RESULTS_ROOT
        / "bidirectional-synthesis"
        / time.strftime("%Y%m%d-%H%M%S")
    )
    if output_dir.exists():
        raise SystemExit(f"output directory already exists: {output_dir}")
    output_dir.mkdir(parents=True)
    if args.oracle_audit:
        report = oracle_audit(output_dir, split, states)
        print(json.dumps(report, ensure_ascii=False, indent=2))
        return (
            0
            if all(
                report[direction]["correct"]
                for direction in ("code_to_spec", "spec_to_code")
            )
            else 1
        )
    if "YUNWU_API_KEY" not in os.environ:
        raise SystemExit("YUNWU_API_KEY is required for live model runs")
    directions = (
        ("code-to-spec", "spec-to-code")
        if args.direction == "both"
        else (args.direction,)
    )
    conditions = (
        ("no-tool", "qcp-tool", "tespec-tool")
        if args.condition == "all"
        else (args.condition,)
    )
    results = [
        run_attempt(
            direction,
            condition,
            attempt,
            args.rounds,
            args.timeout,
            output_dir,
            split,
            states,
        )
        for direction in directions
        for condition in conditions
        for attempt in range(1, args.attempts + 1)
    ]
    report = summarize(results)
    write_json(output_dir / "report.json", report)
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
