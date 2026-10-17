"""Reject result reuse across different measured toolchain identities."""

from collections.abc import Mapping


class ResultReuseError(ValueError):
    """Matching measurement identities could not be established."""


_FULMINATE_FIELDS = (
    "cn_build",
    "cn_sha256",
    "compiler_wrapper_sha256",
    "driver_sha256",
    "input_files_sha256",
)
_RESUME_FIELDS = (
    *_FULMINATE_FIELDS,
    "executor_sha256",
    "build",
    "evaluation_source_snapshot.source_files_sha256",
    "evaluation_source_snapshot.python_version",
    "evaluation_source_snapshot.z3_solver_installed_version",
)
_MISSING = object()


def _lookup(value, path):
    for part in path.split("."):
        if not isinstance(value, Mapping) or part not in value:
            return _MISSING
        value = value[part]
    return _MISSING if value is None else value


def _check(previous_report, current_toolchain, fields, operation):
    previous = _lookup(previous_report, "toolchain")
    issues = []
    for path in fields:
        old, new = _lookup(previous, path), _lookup(current_toolchain, path)
        if old is _MISSING:
            issues.append("previous report missing toolchain." + path)
        if new is _MISSING:
            issues.append("current toolchain missing " + path)
        if old is not _MISSING and new is not _MISSING and old != new:
            issues.append("changed " + path)
    if issues:
        raise ResultReuseError(
            "Cannot "
            + operation
            + ": "
            + "; ".join(issues)
            + ". Use a new run_id and rerun the measurements; "
            + "do not overwrite the existing measured run."
        )


def assert_resume_compatible(previous_report, current_toolchain):
    """Check the full measured-run identity before loading receipts."""
    _check(
        previous_report, current_toolchain, _RESUME_FIELDS, "resume measured results"
    )


def assert_fulminate_reuse_compatible(previous_report, current_toolchain):
    """Check Fulminate identity before copying its measured stages."""
    _check(
        previous_report, current_toolchain, _FULMINATE_FIELDS, "reuse Fulminate results"
    )


def input_files_identity(root, group):
    """Fingerprint reviewed sources and logical inputs, excluding generated tests."""
    import hashlib
    import json
    from pathlib import Path

    roots = {Path(group), Path(root) / "runtime"}
    for manifest in Path(group).glob("variants/*/manifest.json"):
        for language in json.loads(manifest.read_text()).get("files", {}).values():
            roots.update(Path(root) / path for path in language.get("include_dirs", []))
    extensions = {".c", ".h", ".v", ".json", ".strategies", ".txt", ".csv"}
    files = {}
    for directory in sorted(roots):
        if not directory.exists():
            raise RuntimeError("Missing declared input directory: " + str(directory))
        for path in sorted(directory.rglob("*")):
            if not path.is_file() or path.suffix not in extensions:
                continue
            if (
                directory == Path(group)
                and "tests" in path.relative_to(directory).parts
            ):
                continue
            key = (
                str(path.relative_to(root)) if path.is_relative_to(root) else str(path)
            )
            files[key] = hashlib.sha256(path.read_bytes()).hexdigest()
    return files
