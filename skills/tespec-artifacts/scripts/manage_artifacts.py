#!/usr/bin/env python3
"""Manage deterministic TeSpec artifact roots."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import sys
import tempfile
from typing import Any, Iterable


SCHEMA = "tespec-artifact-manifest/v1"
MANIFEST_NAME = "artifact-manifest.json"
TASK_ID_RE = re.compile(r"[A-Za-z0-9][A-Za-z0-9._-]*\Z")
TRANSIENT_SUFFIXES = {".aux", ".glob", ".pyc", ".tmp", ".vo", ".vok", ".vos"}
TRANSIENT_NAMES = {".lia.cache", ".nia.cache", ".nra.cache"}
TRANSIENT_DIRS = {"__pycache__", ".pytest_cache", ".mypy_cache"}
LAYOUTS = {
    "e2e": (
        "source/original",
        "spec/versions",
        "tests",
        "mutants/refinement",
        "mutants/heldout",
        "evidence",
        "reports",
    ),
}


class ArtifactError(ValueError):
    pass


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def atomic_write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    descriptor, temporary = tempfile.mkstemp(
        prefix=f".{path.name}.", suffix=".tmp", dir=path.parent
    )
    try:
        os.fchmod(descriptor, 0o644)
        with os.fdopen(descriptor, "w", encoding="utf-8") as stream:
            json.dump(value, stream, ensure_ascii=False, indent=2)
            stream.write("\n")
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temporary, path)
    finally:
        temporary_path = Path(temporary)
        if temporary_path.exists():
            temporary_path.unlink()


def is_transient(path: Path) -> bool:
    return (
        path.name in TRANSIENT_NAMES
        or path.suffix in TRANSIENT_SUFFIXES
        or any(part in TRANSIENT_DIRS for part in path.parts)
    )


def task_files(root: Path, *, include_transient: bool = False) -> Iterable[Path]:
    for path in sorted(root.rglob("*")):
        if path.is_symlink():
            raise ArtifactError(f"artifact roots may not contain symlinks: {path}")
        if not path.is_file() or path.name == MANIFEST_NAME:
            continue
        if include_transient or not is_transient(path.relative_to(root)):
            yield path


def relative_path(root: Path, path: Path) -> str:
    relative = path.relative_to(root).as_posix()
    if relative.startswith("/") or relative.startswith("../"):
        raise ArtifactError(f"path escapes artifact root: {path}")
    return relative


def artifact_role(relative: str) -> str:
    first = relative.split("/", 1)[0]
    if first in {"source", "spec", "tests", "mutants"}:
        return "input"
    if first == "evidence" or relative.endswith(".v"):
        return "evidence"
    if first == "reports" or relative in {
        "negative-examples.json",
        "result.json",
        "survivors.json",
    }:
        return "report"
    return "metadata"


def validate_task_id(task_id: str) -> None:
    if TASK_ID_RE.fullmatch(task_id) is None:
        raise ArtifactError(
            "task id must contain only letters, digits, dot, underscore, and hyphen"
        )


def required_paths(kind: str) -> tuple[str, ...]:
    if kind == "e2e":
        return ("spec/final_spec.c", "tests/binds.json", "manifest.json")
    raise ArtifactError(f"unsupported artifact kind: {kind}")


def require_layout(root: Path, kind: str) -> None:
    missing = [
        relative for relative in required_paths(kind) if not (root / relative).is_file()
    ]
    if missing:
        raise ArtifactError("missing required artifacts: " + ", ".join(missing))
    if kind == "e2e" and not any((root / "source/original").iterdir()):
        raise ArtifactError("source/original must contain the original source bundle")


def load_json(path: Path, label: str) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise ArtifactError(f"cannot read {label} {path}: {error}") from error
    if not isinstance(value, dict):
        raise ArtifactError(f"{label} must be a JSON object")
    return value


def inventory(root: Path) -> list[dict[str, Any]]:
    records = []
    for path in task_files(root):
        relative = relative_path(root, path)
        records.append(
            {
                "path": relative,
                "role": artifact_role(relative),
                "bytes": path.stat().st_size,
                "sha256": sha256(path),
            }
        )
    return records


def inventory_digest(records: list[dict[str, Any]]) -> str:
    canonical = json.dumps(
        records, ensure_ascii=False, sort_keys=True, separators=(",", ":")
    )
    return hashlib.sha256(canonical.encode("utf-8")).hexdigest()


def initialize(root: Path, kind: str, task_id: str) -> None:
    validate_task_id(task_id)
    if root.exists() and any(root.iterdir()):
        raise ArtifactError(f"artifact root is not empty: {root}")
    root.mkdir(parents=True, exist_ok=True)
    for relative in LAYOUTS[kind]:
        (root / relative).mkdir(parents=True, exist_ok=True)
    print(
        json.dumps(
            {
                "status": "initialized",
                "kind": kind,
                "task_id": task_id,
                "root": str(root),
            },
            ensure_ascii=False,
        )
    )


def finalize(root: Path, kind: str, task_id: str) -> None:
    validate_task_id(task_id)
    require_layout(root, kind)
    records = inventory(root)
    manifest = {
        "schema": SCHEMA,
        "kind": kind,
        "task_id": task_id,
        "lifecycle": "finalized",
        "inventory": records,
        "summary": {
            "files": len(records),
            "bytes": sum(item["bytes"] for item in records),
            "sha256": inventory_digest(records),
        },
    }
    atomic_write_json(root / MANIFEST_NAME, manifest)
    print(json.dumps(manifest["summary"], ensure_ascii=False))


def validate_manifest(manifest_path: Path) -> None:
    manifest = load_json(manifest_path, "artifact manifest")
    if manifest.get("schema") != SCHEMA:
        raise ArtifactError(f"artifact manifest schema must be {SCHEMA}")
    kind = manifest.get("kind")
    task_id = manifest.get("task_id")
    if kind not in LAYOUTS or not isinstance(task_id, str):
        raise ArtifactError("artifact manifest has invalid kind or task_id")
    validate_task_id(task_id)
    root = manifest_path.parent
    require_layout(root, kind)
    current = inventory(root)
    recorded = manifest.get("inventory")
    if recorded != current:
        raise ArtifactError("artifact inventory differs from manifest")
    summary = manifest.get("summary")
    expected_summary = {
        "files": len(current),
        "bytes": sum(item["bytes"] for item in current),
        "sha256": inventory_digest(current),
    }
    if summary != expected_summary:
        raise ArtifactError("artifact summary differs from inventory")
    print(json.dumps({"status": "valid", **expected_summary}, ensure_ascii=False))


def clean(root: Path, apply: bool) -> None:
    candidates = [
        path
        for path in task_files(root, include_transient=True)
        if is_transient(path.relative_to(root))
    ]
    total_bytes = sum(path.stat().st_size for path in candidates)
    if apply:
        for path in candidates:
            path.unlink()
        for directory in sorted(
            (
                path
                for path in root.rglob("*")
                if path.is_dir() and path.name in TRANSIENT_DIRS
            ),
            key=lambda item: len(item.parts),
            reverse=True,
        ):
            if not any(directory.iterdir()):
                directory.rmdir()
    print(
        json.dumps(
            {
                "status": "cleaned" if apply else "preview",
                "files": len(candidates),
                "bytes": total_bytes,
            },
            ensure_ascii=False,
        )
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)
    for command in ("init", "finalize"):
        subparser = subparsers.add_parser(command)
        subparser.add_argument("--root", type=Path, required=True)
        subparser.add_argument("--kind", choices=tuple(LAYOUTS), required=True)
        subparser.add_argument("--task-id", required=True)
    clean_parser = subparsers.add_parser("clean")
    clean_parser.add_argument("--root", type=Path, required=True)
    clean_parser.add_argument("--apply", action="store_true")
    validate_parser = subparsers.add_parser("validate")
    validate_parser.add_argument("--manifest", type=Path, required=True)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        if args.command == "init":
            initialize(args.root.expanduser().resolve(), args.kind, args.task_id)
        elif args.command == "finalize":
            finalize(args.root.expanduser().resolve(), args.kind, args.task_id)
        elif args.command == "clean":
            clean(args.root.expanduser().resolve(), args.apply)
        else:
            validate_manifest(args.manifest.expanduser().resolve())
    except (ArtifactError, OSError) as error:
        print(f"artifact error: {error}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
