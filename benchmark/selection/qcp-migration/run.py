#!/usr/bin/env python3
"""Replay the same migrated sources through native QCP and teSpec."""

from __future__ import annotations

import argparse
from collections import Counter
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

import prepare

ROOT, HERE = prepare.ROOT, prepare.HERE
sys.path.insert(0, str(ROOT))
from spectest.core import run_job  # noqa: E402


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, ensure_ascii=False) + "\n")


def git(repo, *args):
    return subprocess.check_output(["git", "-C", str(repo), *args], text=True).strip()


def native(binary, source, output, timeout):
    output.mkdir(parents=True)
    command = [
        str(binary),
        "--input-file=" + str(source),
        "--Json-output",
        "--no-strategy-gen",
        "--gen-and-backup",
        "--coq-output-dir=" + str(output / "vc"),
        "--no-logic-path",
        "--disable-solver-info",
        "--no-exec-info",
        "-I" + str(prepare.QCP),
    ]
    try:
        result = subprocess.run(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            timeout=timeout,
            cwd=binary.parents[2],
        )
        code, log = result.returncode, result.stdout
    except subprocess.TimeoutExpired as exc:
        code = "TIMEOUT"
        log = exc.stdout or ""
        if isinstance(log, bytes):
            log = log.decode(errors="replace")
    (output / "executor.log").write_text(log)
    try:
        raw = json.loads(log)
    except json.JSONDecodeError:
        raw = {}
    functions = {}
    for row in raw.get("WitnessList") or []:
        if not row.get("Witness"):
            continue
        counts = row["Witness"]["total_witness_count"]
        status = "RESIDUAL" if counts["manual"] else "AUTOMATICALLY_DISCHARGED"
        if counts["auto_solved"] == 0 and counts["manual"] == 0:
            status = "EMPTY_WITNESSES"
        functions[row["functionName"]] = dict(status=status, **counts)
    status = (
        "COMPLETED" if code == 0 and raw.get("result") == "success" else "TOOL_ERROR"
    )
    if code == "TIMEOUT":
        status = "TIMEOUT"
    message = (raw.get("errormessage") or {}).get("Main Error Message", "")
    error_kind = None
    if (
        "postcondition contradicts the current path condition" in message
        or "every return post branch" in message
    ):
        error_kind = "postcondition_rejected"
    elif "Cannot derive the precondition of function" in message:
        error_kind = "call_precondition_not_established"
    return dict(
        status=status,
        returncode=code,
        command=command,
        source_sha256=digest(source),
        log_sha256=digest(output / "executor.log"),
        error=raw.get("errormessage"),
        error_kind=error_kind,
        functions=functions,
        certificate="NOT_CHECKED",
        unit_manual_obligations=sum(r["manual"] for r in functions.values()),
    )


def wrong_post(source, function):
    pattern = r"\b" + re.escape(function) + r"\s*\([^;{}]*\)\s*/\*@(?P<spec>.*?)\*/"
    matches = list(re.finditer(pattern, source, re.S))
    if len(matches) != 1:
        raise ValueError(f"Cannot identify target contract: {function}")
    match = matches[0]
    spec = match["spec"]
    pre, post = spec.split("Ensure", 1)
    replacement = pre + "Ensure (" + post.strip() + ") && 0 == 1 "
    return source[: match.start("spec")] + replacement + source[match.end("spec") :]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--qcp-repo", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--timeout", type=float, default=30)
    args = parser.parse_args()
    manifest = prepare.prepare()
    repo, output = args.qcp_repo.resolve(), args.output.resolve()
    binary = repo / "build/release/symexec"
    if not binary.is_file():
        parser.error("Missing native QCP binary")
    if output.exists() and any(output.iterdir()):
        parser.error("Output must be empty")
    if git(repo, "status", "--porcelain") or git(
        repo / "smt_solver", "status", "--porcelain"
    ):
        parser.error("Native QCP and its solver source checkout must be clean")
    output.mkdir(parents=True, exist_ok=True)
    report = dict(
        schema="fulminate-qcp-validation/v1",
        scope="native QCP universal obligations and teSpec bound-input execution; not a timing comparison",
        certificate="NOT_CHECKED; automatic witnesses are not independently kernel checked",
        started_at=datetime.now(timezone.utc).isoformat(),
        manifest_sha256=digest(HERE / "manifest.json"),
        runner_sha256=digest(Path(__file__)),
        qcp_revision=git(repo, "rev-parse", "HEAD"),
        smt_revision=git(repo / "smt_solver", "rev-parse", "HEAD"),
        qcp_binary_sha256=digest(binary),
        tespec_build=json.loads((ROOT / "bin/tespec-symexec.build.json").read_text()),
        tespec_binary_sha256=digest(ROOT / "bin/tespec-symexec"),
        native=[],
        negative_controls=[],
        tespec=[],
    )
    for case in manifest["cases"]:
        source = HERE / case["source"]
        result = native(binary, source, output / "native" / case["id"], args.timeout)
        report["native"].append(
            dict(
                case=case["id"],
                targets=[t["function"] for t in case["targets"]],
                **result,
            )
        )
        for target in case["targets"]:
            name = target["function"]
            if result["status"] == "COMPLETED":
                directory = output / "negative" / (case["id"] + "-" + name)
                directory.mkdir(parents=True)
                mutated = directory / "wrong_post.c"
                mutated.write_text(wrong_post(source.read_text(), name))
                for dependency in (HERE / "cases").glob("*.strategies"):
                    shutil.copyfile(dependency, directory / dependency.name)
                for dependency in (HERE / "cases").glob("*.h"):
                    shutil.copyfile(dependency, directory / dependency.name)
                negative = native(binary, mutated, directory / "run", args.timeout)
                report["negative_controls"].append(
                    dict(case=case["id"], function=name, **negative)
                )
            for mode in ["entry-exit", "all-boundaries"]:
                with tempfile.TemporaryDirectory(prefix="fulminate-qcp-") as temporary:
                    job = Path(temporary) / "job.json"
                    save(
                        job,
                        dict(
                            source=str(source),
                            function=name,
                            binds=target["binds"],
                            qcp=dict(
                                binary=str(ROOT / "bin/tespec-symexec"),
                                qcip_root=str(ROOT / "runtime/qcip"),
                                include_dirs=["QCP_examples/QCP_demos_human"],
                                execution_mode=mode,
                                timeout=args.timeout,
                            ),
                        ),
                    )
                    results = run_job(job, Path(temporary) / "run")
                    results["job_content"] = json.loads(job.read_text())
                    for row in results["results"]:
                        artifacts = {}
                        for key in ["stdout", "stderr", "generated_source"]:
                            path = Path(row[key]) if row.get(key) else None
                            if path and path.is_file():
                                artifacts[key] = path.read_text()
                        artifacts["vc_files"] = {
                            name: Path(path).read_text()
                            for name, path in (row.get("vc") or {})
                            .get("files", {})
                            .items()
                            if path and Path(path).is_file()
                        }
                        row["embedded_artifacts"] = artifacts
                        # Keep actual executor JSON as well as the controller decision.
                        record = {
                            k: row.get(k)
                            for k in [
                                "id",
                                "status",
                                "reason",
                                "error",
                                "execution_completed",
                                "phases",
                                "command",
                            ]
                        }
                        report["tespec"].append(
                            dict(case=case["id"], function=name, mode=mode, **record)
                        )
                        report["tespec"][-1]["detail"] = (
                            "tespec/" + case["id"] + "-" + name + "-" + mode + ".json"
                        )
                    save(
                        output
                        / "tespec"
                        / (case["id"] + "-" + name + "-" + mode + ".json"),
                        results,
                    )
        save(output / "report.json", report)
        print(case["id"], result["status"], flush=True)
    report["summary"] = dict(
        upstream_files=len(manifest["cases"]),
        target_functions=sum(len(c["targets"]) for c in manifest["cases"]),
        native_targets=dict(
            Counter(
                row["functions"].get(name, {}).get("status", "MISSING_TARGET")
                if row["status"] == "COMPLETED"
                else row["status"]
                for row in report["native"]
                for name in row["targets"]
            )
        ),
        tespec=dict(Counter(row["status"] for row in report["tespec"])),
        tespec_reasons=dict(
            Counter(row["reason"] or row["status"] for row in report["tespec"])
        ),
        negative_controls=len(report["negative_controls"]),
    )
    # A false postcondition may leave a VC; it must never be certified automatic.
    for row in report["negative_controls"]:
        if row["status"] == "COMPLETED" and (
            row["functions"].get(row["function"], {}).get("status")
            == "AUTOMATICALLY_DISCHARGED"
        ):
            raise RuntimeError(
                f"Invalid postcondition was accepted: {row['case']}/{row['function']}"
            )
    report["summary"]["false_postcondition_accepted"] = 0
    report["summary"]["negative_control_outcomes"] = dict(
        Counter(
            row["error_kind"]
            or (
                row["functions"]
                .get(row["function"], {})
                .get("status", "MISSING_TARGET")
                if row["status"] == "COMPLETED"
                else row["status"]
            )
            for row in report["negative_controls"]
        )
    )
    report["artifacts"] = {
        str(path.relative_to(output)): digest(path)
        for path in sorted(output.rglob("*"))
        if path.is_file() and path != output / "report.json"
    }
    save(output / "report.json", report)
    print(json.dumps(report["summary"], indent=2))


if __name__ == "__main__":
    main()
