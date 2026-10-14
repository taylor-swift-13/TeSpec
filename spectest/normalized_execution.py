"""Controller for checked definition normalization and ordinary spec execution."""

import json
from pathlib import Path
import time
import subprocess

from .certificates import check_certificate, digest, tree_digest
from .kernel_replay import KernelReplayCache
from .core import (
    JobError,
    _executor_result,
    _executor_target_layout,
    _run_measured,
    _write_vc_manifest,
    source_with_local_includes,
)
from .normalization_association import (
    NormalizationCompatibilityError,
    prepare_normalization_association,
)
from .normalization_certificates import seal_predicate_normalization
from .preflight import export_program_preflight, snapshot_frontend_inputs


def validate_execution_context(program, activation):
    """Revalidate the concrete controller inputs; stale reports grant nothing."""
    snapshot = program["frontend_snapshot"]
    if snapshot_frontend_inputs(snapshot["roots"], snapshot["excluded"]) != snapshot:
        raise JobError("frontend inputs changed after preflight")
    for key in ("binary", "input", "coq_header", "generated_layout"):
        record = program[key]
        if digest(Path(record["path"])) != record["sha256"]:
            raise JobError("program context changed: " + key)
    for record in program.get("original_inputs", []):
        if digest(Path(record["path"])) != record["sha256"]:
            raise JobError("original job inputs changed after preflight")
    for record in program["context_files"]:
        if digest(Path(record["path"])) != record["sha256"]:
            raise JobError("program Coq context changed")
    for dependency in program["coq_dependencies"]:
        for key in ("source", "staged"):
            if digest(Path(dependency[key])) != dependency["sha256"]:
                raise JobError("program dependency changed")
    if digest(Path(activation["manifest"])) != activation["manifest_sha256"]:
        raise JobError("normalization manifest changed")
    if digest(Path(activation["rules"])) != activation["rules_sha256"]:
        raise JobError("sealed normalization rules changed")
    bundle_path = Path(activation["manifest"])
    bundle = json.loads(bundle_path.read_text())
    for name, expected in bundle["immutable_sha256"].items():
        if digest(bundle_path.parent / name) != expected:
            raise JobError("normalization immutable input changed")
    for dependency in bundle["dependencies"]:
        if digest(bundle_path.parent / dependency["file"]) != dependency["sha256"]:
            raise JobError("normalization dependency changed")
    if tree_digest(Path(bundle["runtime"])) != activation["runtime_sha256"]:
        raise JobError("normalization runtime changed")


def _run_normalized_case(
    job_path,
    normalization_path,
    normalization_digest,
    output,
    *,
    case_id=None,
    switch="qcp-8.20",
    proof_timeout=300,
    execution_timeout=30,
    reuse_kernel_dependencies=True,
):
    """Run one selected job instance after both independent proof gates.

    Residual execution VCs use the existing optional ITP workflow. This function
    proves normalization gates, and never treats them as execution proofs.
    """
    output = Path(output).resolve()
    if output.exists():
        raise JobError("normalized execution output must be fresh")
    if execution_timeout <= 0:
        raise JobError("execution timeout must be positive")
    output.mkdir(parents=True)
    started = time.monotonic()
    report = {
        "schema": "tespec-normalized-execution/v1",
        "status": "UNKNOWN",
        "execution": "NOT_RUN",
        "results": [],
        "itp_vcs": [],
        "stages": {},
    }

    def finish(reason):
        report["reason"] = reason
        report["wall_seconds"] = time.monotonic() - started
        (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")
        return report

    finish("checking_normalization_equations")

    kernel_cache = KernelReplayCache() if reuse_kernel_dependencies else None

    activation = seal_predicate_normalization(
        normalization_path,
        normalization_digest,
        output / "equations",
        switch=switch,
        timeout=proof_timeout,
        kernel_cache=kernel_cache,
    )
    report["stages"]["equations"] = activation
    if activation["status"] != "PASS":
        return finish("normalization_equations_not_proved")
    finish("parsing_program_context")
    program = export_program_preflight(
        Path(job_path), output / "preflight", case_id=case_id
    )
    # Keeping outputs outside input search trees makes snapshots independent of
    # the new controller artifacts and of future include-resolution changes.
    if any(
        output.is_relative_to(Path(root))
        for root in program["frontend_snapshot"]["roots"]
    ):
        raise JobError("controller output must be outside frontend search trees")
    report["stages"]["preflight"] = program
    report["provenance"] = program["provenance"]
    finish("checking_program_association")
    preflight_path = output / "preflight/manifest.json"
    association = prepare_normalization_association(
        preflight_path,
        digest(preflight_path),
        normalization_path,
        normalization_digest,
        output / "association",
    )
    association_report = check_certificate(
        Path(association["manifest"]),
        association["manifest_sha256"],
        switch=switch,
        timeout=proof_timeout,
        kernel_cache=kernel_cache,
    )
    report["stages"]["association"] = {
        "request": association,
        "proof": association_report,
    }
    if association_report["status"] != "PASS":
        return finish("program_association_not_proved")
    association_manifest = json.loads(Path(association["manifest"]).read_text())
    if (
        association_manifest.get("association", {}).get("binding_scope")
        != "all-referenced-symbols"
    ):
        return finish("program_association_incomplete_symbol_coverage")
    if (
        association_manifest.get("association", {}).get("semantic_binding_scope")
        != "formula-notation-interpretations"
    ):
        return finish("program_association_incomplete_semantic_coverage")
    if (
        association_manifest.get("association", {}).get("definition_binding_scope")
        != "qualified-selected-predicate"
    ):
        return finish("program_association_missing_definition_identity")
    finish("validating_execution_context")
    validate_execution_context(program, activation)
    execute_dir = output / "execution"
    execute_dir.mkdir()
    source = execute_dir / "input.c"
    source.write_text(
        Path(program["input"]["path"]).read_text()
        + '\n/*@ include strategies "'
        + activation["rules"]
        + '" */\n'
    )
    source_digest = digest(source)
    vc_dir = execute_dir / "vc"
    command = [
        arg.replace(
            "--input-file=" + program["input"]["path"], "--input-file=" + str(source)
        )
        if arg.startswith("--input-file=")
        else str(vc_dir)
        if arg == str(output / "preflight/context")
        else arg
        for arg in program["command"]
        if arg != "--spec-test-preflight"
    ]
    command.extend(activation["executor_args"])
    report["execution"] = "STARTED"
    finish("executing_program")
    run_started = time.monotonic()
    completed, rss, cpu = _run_measured(
        command,
        cwd=Path(program["binary"]["path"]).parent.parent,
        timeout=execution_timeout,
        metrics_path=execute_dir / ".rss",
    )
    elapsed = time.monotonic() - run_started
    (execute_dir / "executor.json").write_text(completed.stdout)
    (execute_dir / "stderr.log").write_text(completed.stderr)
    validate_execution_context(program, activation)
    if digest(source) != source_digest:
        raise JobError("normalized execution input changed")
    layout = _executor_target_layout(completed.stdout)
    if layout != program["target_layout"]:
        raise JobError("executed layout differs from preflight")
    header = Path(program["coq_header"]["path"]).read_text()
    goal_path = vc_dir / "input_goal.v"
    materialized_goal = goal_path.is_file()
    if materialized_goal and not goal_path.read_text().startswith(header):
        raise JobError("executed Coq context differs from preflight")
    if not materialized_goal:
        provisional = _executor_result(
            completed.stdout,
            completed.returncode,
            {"status": "not_generated", "residual_goals": []},
        )
        if provisional["status"] not in {"ERROR", "UNKNOWN", "INVALID"}:
            raise JobError("executor verdict requires a generated Coq context")
    include_dirs = [Path(arg[2:]) for arg in command if arg.startswith("-I")]
    dependencies_source = source_with_local_includes(
        Path(program["original_source"]),
        include_dirs,
        primary_source=source.read_text(),
    )
    vc = _write_vc_manifest(
        vc_dir,
        source,
        Path(program["original_source"]),
        Path(program["qcip_root"]),
        program["function"],
        program["case"],
        dependencies_source,
        executor_output=completed.stdout,
    )
    before = {dep["module"]: dep["sha256"] for dep in program["coq_dependencies"]}
    after = {dep["module"]: dep["sha256"] for dep in vc["coq_dependencies"]}
    if before != after:
        raise JobError("executed dependency closure differs from preflight")
    if program.get("runtime_dependencies", []) != vc.get("runtime_dependencies", []):
        raise JobError("executed runtime modules differ from preflight")
    result = {
        **_executor_result(completed.stdout, completed.returncode, vc),
        "id": program["case"],
        "bindings": program["bindings"],
        "arguments": program["arguments"],
        "type_bindings": program["type_bindings"],
        "vc": vc,
        "command": command,
        "resources": {"wall_seconds": elapsed, "cpu_seconds": cpu, "peak_rss_kib": rss},
    }
    execution = {"PASS": "RUN", "NOT_RUN": "NOT_RUN"}.get(
        result.get("phases", {}).get("execution"), "INCOMPLETE"
    )
    report.update(status=result["status"], execution=execution, results=[result])
    result["residual_vcs"] = vc["residual_goals"]
    if vc["residual_goals"]:
        report["itp_vcs"] = [
            {
                "case_id": program["case"],
                "function": program["function"],
                "manifest": vc["manifest"],
                "goals": vc["residual_goals"],
            }
        ]
    automatic = {
        "schema": "qcp-spectest-report/v1",
        "job": str(Path(job_path).resolve()),
        "source": program["original_source"],
        "function": program["function"],
        "qcp_binary": program["binary"]["path"],
        "provenance": program["provenance"],
        "results": [result],
        "itp_vcs": report["itp_vcs"],
        "normalization": {
            "equations_manifest_sha256": activation["manifest_sha256"],
            "association_manifest_sha256": association["manifest_sha256"],
            "status": "CHECKED",
        },
        "summary": {
            "total": 1,
            **{
                status: int(result["status"] == status)
                for status in ("PASS", "FAIL", "UNKNOWN", "ERROR", "INVALID")
            },
            "duration_seconds": elapsed,
            "peak_rss_kb": rss,
        },
    }
    automatic_path = execute_dir / "report.json"
    automatic_path.write_text(json.dumps(automatic, indent=2) + "\n")
    report["automatic_report"] = str(automatic_path)
    return finish(
        "checked_normalization_execution"
        if materialized_goal
        else "execution_ended_without_vc_group"
    )


def run_normalized_case(
    job_path,
    normalization_path,
    normalization_digest,
    output,
    *,
    case_id=None,
    switch="qcp-8.20",
    proof_timeout=300,
    execution_timeout=30,
    reuse_kernel_dependencies=True,
):
    """Persist unsuccessful gates and execution timeouts as explicit outcomes."""
    output = Path(output).resolve()
    if not isinstance(reuse_kernel_dependencies, bool):
        raise JobError("reuse_kernel_dependencies must be a boolean")
    if output.exists():
        raise JobError("normalized execution output must be fresh")
    started = time.monotonic()
    try:
        return _run_normalized_case(
            job_path,
            normalization_path,
            normalization_digest,
            output,
            case_id=case_id,
            switch=switch,
            proof_timeout=proof_timeout,
            execution_timeout=execution_timeout,
            reuse_kernel_dependencies=reuse_kernel_dependencies,
        )
    except (JobError, OSError, subprocess.TimeoutExpired) as error:
        path = output / "report.json"
        report = (
            json.loads(path.read_text())
            if path.is_file()
            else {
                "schema": "tespec-normalized-execution/v1",
                "execution": "NOT_RUN",
                "results": [],
                "itp_vcs": [],
                "stages": {},
            }
        )
        timeout = isinstance(error, subprocess.TimeoutExpired)
        unproved_layout = isinstance(error, NormalizationCompatibilityError)
        report.update(
            status="UNKNOWN" if timeout or unproved_layout else "ERROR",
            reason=(
                "normalization_layout_unproved"
                if unproved_layout
                else "execution_timeout"
                if timeout
                else "controller_validation_failed"
            ),
            error=str(error),
            wall_seconds=time.monotonic() - started,
        )
        if report["execution"] == "STARTED":
            report["execution"] = "INCOMPLETE"
        output.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(report, indent=2) + "\n")
        return report
