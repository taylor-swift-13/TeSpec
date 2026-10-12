"""Compile requested Rocq runtime modules in a private, identity-preserving copy."""

import json
from pathlib import Path
import re
import shutil
import subprocess
import time

from .certificates import QUALIFIED, digest, tree_digest
from .core import (
    JobError,
    _coq_load_path_args,
    _coq_required_modules,
    _run_measured,
    _runtime_coq_module,
)


def prepare_runtime_modules(
    qcip_root, modules, output, *, switch="qcp-8.20", timeout=120
):
    """Compilation is not a proof verdict; later certificate checks audit uses."""
    qcip_root, output = Path(qcip_root).resolve(), Path(output).resolve()
    modules = list(dict.fromkeys(modules))
    if not modules or any(
        not isinstance(m, str) or not re.fullmatch(QUALIFIED, m) for m in modules
    ):
        raise JobError("runtime preparation requires qualified module names")
    if timeout <= 0 or not (qcip_root / "SeparationLogic/_CoqProject").is_file():
        raise JobError("invalid runtime or timeout")
    if output.exists():
        raise JobError("runtime preparation output must be fresh")
    if output.is_relative_to(qcip_root / "SeparationLogic"):
        raise JobError("private runtime output must be outside the original runtime")
    runtime_digest = tree_digest(qcip_root / "SeparationLogic")
    for module in modules:
        if _runtime_coq_module(module, qcip_root) is None:
            raise JobError("module is not in the pinned runtime: " + module)
    output.mkdir(parents=True)
    target_root = output / "qcip"
    target = target_root / "SeparationLogic"
    shutil.copytree(qcip_root / "SeparationLogic", target)
    if tree_digest(target) != runtime_digest:
        raise JobError("runtime changed during private copy")
    report = {
        "schema": "tespec-runtime-preparation/v1",
        "status": "UNKNOWN",
        "scope": "compilation-only",
        "source_runtime_sha256": runtime_digest,
        "qcip_root": str(target_root),
        "requested_modules": modules,
        "stages": [],
    }
    visiting, completed, rebuilt = set(), set(), set()
    requested = set(modules)
    started = time.monotonic()

    def finish(reason):
        report["reason"] = reason
        report["wall_seconds"] = time.monotonic() - started
        report["runtime_sha256"] = tree_digest(target)
        (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")
        return report

    def compile_module(module):
        if module in completed:
            return True
        if module in visiting:
            raise JobError("cyclic runtime import: " + module)
        source = _runtime_coq_module(module, target_root)
        if source is None:
            # External standard modules remain subject to coqc's normal resolver.
            return True
        compiled = source.with_suffix(".vo")
        visiting.add(module)
        dependencies = _coq_required_modules(source.read_text())
        for dependency in dependencies:
            if not compile_module(dependency):
                return False
        # A requested module is compiled against the current dependency closure.
        # An old .vo alone does not establish compatible imported assumptions.
        # Rebuilding a dependency also invalidates reuse of its dependents.
        if (
            compiled.is_file()
            and module not in requested
            and not any(dependency in rebuilt for dependency in dependencies)
        ):
            visiting.remove(module)
            completed.add(module)
            return True
        label = module.replace(".", "_")
        command = [
            "opam",
            "exec",
            "--switch=" + switch,
            "--",
            "coqc",
            *_coq_load_path_args(target, output),
            str(source),
        ]
        step = {"module": module, "source_sha256": digest(source), "command": command}
        report["stages"].append(step)
        step_started = time.monotonic()
        try:
            result, rss, cpu = _run_measured(
                command,
                cwd=output,
                timeout=timeout,
                metrics_path=output / (label + ".time"),
            )
        except subprocess.TimeoutExpired:
            step.update(status="UNKNOWN", reason="compile_timeout")
            return False
        (output / (label + ".log")).write_text(result.stdout + result.stderr)
        step.update(
            returncode=result.returncode,
            wall_seconds=time.monotonic() - step_started,
            peak_rss_kib=rss,
            cpu_seconds=cpu,
        )
        if result.returncode or not compiled.is_file():
            step["status"] = "ERROR"
            return False
        step.update(status="COMPILED", compiled_sha256=digest(compiled))
        rebuilt.add(module)
        visiting.remove(module)
        completed.add(module)
        return True

    try:
        for module in modules:
            if not compile_module(module):
                return finish("runtime_module_compile_failed")
    except JobError as error:
        report.update(status="ERROR", error=str(error))
        return finish("runtime_import_resolution_failed")
    if tree_digest(qcip_root / "SeparationLogic") != runtime_digest:
        raise JobError("original runtime changed during preparation")
    report["status"] = "COMPILED"
    return finish("private_runtime_modules_compiled")
