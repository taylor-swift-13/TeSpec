"""Export a job's parsed program context without executing or deciding its spec."""

import json
from pathlib import Path
import subprocess
import time
import re

from .core import (
    JobError,
    _parse_bind_cases,
    _report_provenance,
    _parse_qcp_config,
    _qcp_command,
    _relocate_strategy_includes,
    _require_object,
    _resolve,
    _run_measured,
    _sha256,
    _source_coq_imports,
    _stage_source_coq_dependencies,
    attach_spec_to_source,
    read_source_text,
    source_with_local_includes,
    specialize_entry_source,
)
from .layout import generate_layout_source


def snapshot_frontend_inputs(roots, excluded=()):
    """Conservatively pin source/header/strategy search trees and absolute imports."""
    roots = sorted({str(Path(root).resolve()) for root in roots})
    excluded = [Path(path).resolve() for path in excluded]
    files = set()
    for root in roots:
        files.update(
            path.resolve()
            for path in Path(root).rglob("*")
            if path.is_file()
            and path.suffix in {".c", ".h", ".strategies"}
            and not any(path.resolve().is_relative_to(skip) for skip in excluded)
        )
    pending = list(files)
    while pending:
        path = pending.pop()
        text = read_source_text(path)
        for value in re.findall(
            r'(?:#\s*include\s*|include\s+strategies\s+)"([^"\n]+)"', text
        ):
            target = Path(value)
            if not target.is_absolute():
                target = path.parent / target
            if target.is_file():
                target = target.resolve()
                if target not in files:
                    files.add(target)
                    pending.append(target)
    return {
        "roots": roots,
        "excluded": [str(path) for path in excluded],
        "files": [
            {"path": str(path), "sha256": _sha256(path)} for path in sorted(files)
        ],
    }


def export_program_preflight(
    job_path: Path, output: Path, *, case_id: str | None = None
) -> dict:
    """Prepare the same entry instance as run_job, then export only its context.

    This receipt does not authorize normalization or assert satisfiability.
    Program-to-certificate association requires a separate kernel check.
    """
    job_path = job_path.expanduser().resolve()
    try:
        job = _require_object(json.loads(job_path.read_text()), "job")
    except (OSError, json.JSONDecodeError) as error:
        raise JobError(f"cannot read job file {job_path}: {error}") from error
    base = job_path.parent
    source_path = _resolve(base, job.get("source"), "source")
    source = read_source_text(source_path)
    function = job.get("function")
    if not isinstance(function, str):
        raise JobError("function must be a string")
    spec_file_path = None
    if job.get("spec_file") is not None:
        spec_file_path = _resolve(base, job["spec_file"], "spec_file")
        source = attach_spec_to_source(
            source,
            read_source_text(spec_file_path),
            function,
        )
    raw_binds = job.get("binds")
    if not isinstance(raw_binds, list) or not raw_binds:
        raise JobError("binds must be a non-empty array")
    cases = _parse_bind_cases(raw_binds, job.get("spec"))
    selected = [case for case in cases if case_id is None or case.case_id == case_id]
    if len(selected) != 1:
        raise JobError("preflight requires exactly one case; select it with --case")
    case = selected[0]
    config = _parse_qcp_config(job, base, source_path.parent)
    signature_source = source_with_local_includes(
        source_path, config.include_dirs, primary_source=source
    )
    provenance = _report_provenance(
        source_path,
        job_path,
        config.binary,
        config.qcip_root,
        signature_source,
        spec_file_path,
    )
    original_inputs = [
        {"path": str(path), "sha256": _sha256(path)}
        for path in (job_path, source_path, spec_file_path)
        if path is not None
    ]
    specialized, entry_spec = specialize_entry_source(
        source,
        function,
        case.values,
        case.spec,
        type_bindings=case.types,
        signature_source=signature_source,
        argument_bindings=case.arguments,
    )
    output = output.expanduser().resolve()
    if output.exists():
        raise JobError(f"preflight output must be fresh: {output}")
    output.mkdir(parents=True)
    frontend = snapshot_frontend_inputs(
        [*config.include_dirs, config.qcip_root], [output]
    )
    generated = output / "input.c"
    generated.write_text(_relocate_strategy_includes(specialized, source_path))
    context = output / "context"
    command = _qcp_command(config, generated, function, entry_spec, context)
    command.append("--spec-test-preflight")
    binary_digest, input_digest = _sha256(config.binary), _sha256(generated)
    started = time.monotonic()
    try:
        completed, rss, cpu = _run_measured(
            command,
            cwd=config.binary.parent.parent,
            timeout=config.timeout_seconds,
            metrics_path=output / ".rss",
        )
    except subprocess.TimeoutExpired as error:
        raise JobError("program preflight timed out") from error
    duration = time.monotonic() - started
    (output / "executor.json").write_text(completed.stdout)
    (output / "stderr.log").write_text(completed.stderr)
    if completed.returncode:
        raise JobError(f"program preflight failed with exit {completed.returncode}")
    if _sha256(config.binary) != binary_digest or _sha256(generated) != input_digest:
        raise JobError("preflight input or binary changed during export")
    if snapshot_frontend_inputs(frontend["roots"], frontend["excluded"]) != frontend:
        raise JobError("frontend inputs changed during preflight")
    try:
        payload = json.loads(completed.stdout)
    except json.JSONDecodeError as error:
        raise JobError("executor did not return preflight JSON") from error
    if not isinstance(payload, dict) or any(
        payload.get(key) != value
        for key, value in {
            "schema": "sac-spec-test-preflight/v1",
            "status": "PARSED",
            "execution": "NOT_RUN",
            "precondition": "NOT_CHECKED",
        }.items()
    ):
        raise JobError("invalid executor preflight status")
    layout = payload.get("target_layout")
    try:
        layout_source = generate_layout_source(layout)
    except (ValueError, TypeError) as error:
        raise JobError(f"invalid preflight layout: {error}") from error
    if layout["architecture_bits"] != config.architecture_bits:
        raise JobError("preflight layout conflicts with requested architecture")
    header_value = payload.get("coq_header")
    if not isinstance(header_value, str):
        raise JobError("preflight did not export a Coq header")
    header = Path(header_value).resolve()
    if not header.is_relative_to(context.resolve()) or not header.is_file():
        raise JobError("preflight header is outside the private context")
    runtime_dependencies = []
    dependencies = _stage_source_coq_dependencies(
        generated,
        source_path,
        config.qcip_root,
        context,
        dependency_source=signature_source,
        runtime_dependencies=runtime_dependencies,
    )
    layout_path = output / "GeneratedLayout.v"
    layout_path.write_text(layout_source)
    if any(_sha256(Path(item["path"])) != item["sha256"] for item in original_inputs):
        raise JobError("original job inputs changed during preflight")
    receipt = {
        "schema": "tespec-program-preflight/v1",
        "status": "PARSED",
        "execution": "NOT_RUN",
        "precondition": "NOT_CHECKED",
        "program_association": "NOT_CHECKED",
        "case": case.case_id,
        "function": function,
        "bindings": case.values,
        "arguments": case.arguments,
        "type_bindings": case.types,
        "input": {"path": str(generated), "sha256": input_digest},
        "binary": {"path": str(config.binary), "sha256": binary_digest},
        "qcip_root": str(config.qcip_root),
        "original_source": str(source_path),
        "original_inputs": original_inputs,
        "provenance": provenance,
        "frontend_snapshot": frontend,
        "target_layout": layout,
        "generated_layout": {"path": str(layout_path), "sha256": _sha256(layout_path)},
        "coq_header": {"path": str(header), "sha256": _sha256(header)},
        "context_files": [
            {"path": str(path), "sha256": _sha256(path)}
            for path in sorted(context.rglob("*.v"))
        ],
        "source_imports": _source_coq_imports(signature_source),
        "coq_dependencies": dependencies,
        "runtime_dependencies": runtime_dependencies,
        "dependency_resolution": "STAGED_SOURCES_ONLY",
        "command": command,
        "resources": {"wall_seconds": duration, "cpu_seconds": cpu, "peak_rss_kb": rss},
    }
    (output / "manifest.json").write_text(json.dumps(receipt, indent=2) + "\n")
    return receipt
