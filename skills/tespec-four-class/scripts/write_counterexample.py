#!/usr/bin/env python3
"""Write a direction-safe TeSpec four-class counterexample."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import sys
import tempfile


POLARITIES = {
    "sound": {
        "axis_dir": "soundness",
        "direction": "spec_satisfied_impl_rejected",
        "implementation_satisfied": False,
        "specification_satisfied": True,
    },
    "complete": {
        "axis_dir": "completeness",
        "direction": "impl_satisfied_spec_rejected",
        "implementation_satisfied": True,
        "specification_satisfied": False,
    },
}


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def relative_file(root: Path, raw: str, label: str) -> str:
    path = Path(raw)
    if path.is_absolute() or ".." in path.parts:
        raise ValueError(f"{label} must be relative to the task root")
    resolved = (root / path).resolve()
    if root != resolved and root not in resolved.parents:
        raise ValueError(f"{label} escapes the task root")
    if not resolved.is_file():
        raise ValueError(f"{label} does not exist: {raw}")
    return path.as_posix()


def output_path(root: Path, raw: str | None, axis_dir: str) -> Path:
    relative = (
        Path(raw)
        if raw is not None
        else Path("evidence") / axis_dir / "counterexample.json"
    )
    if relative.is_absolute() or ".." in relative.parts:
        raise ValueError("output must be relative to the task root")
    output = (root / relative).resolve()
    allowed = (root / "evidence" / axis_dir).resolve()
    if allowed not in output.parents:
        raise ValueError(f"output must be under evidence/{axis_dir}/")
    return output


def atomic_write(path: Path, value: dict[str, object]) -> None:
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


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--property", choices=sorted(POLARITIES), required=True)
    parser.add_argument("--case-file", required=True)
    parser.add_argument("--implementation-check", required=True)
    parser.add_argument("--specification-check", required=True)
    parser.add_argument("--rationale", required=True)
    parser.add_argument("--output")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    root = args.root.expanduser().resolve()
    polarity = POLARITIES[args.property]
    try:
        if not args.rationale.strip():
            raise ValueError("rationale must not be empty")
        impl = root / "input" / "impl.c"
        spec = root / "input" / "spec.qcp"
        if not impl.is_file() or not spec.is_file():
            raise ValueError("task root must contain input/impl.c and input/spec.qcp")
        case_file = relative_file(root, args.case_file, "case file")
        implementation_check = relative_file(
            root, args.implementation_check, "implementation check"
        )
        specification_check = relative_file(
            root, args.specification_check, "specification check"
        )
        output = output_path(root, args.output, str(polarity["axis_dir"]))
        payload = {
            "schema": "tespec-four-class-counterexample/v2",
            "property": args.property,
            "witness_direction": polarity["direction"],
            "inputs_sha256": {
                "impl": sha256(impl),
                "spec": sha256(spec),
            },
            "case_file": case_file,
            "checks": {
                "implementation": {
                    "satisfied": polarity["implementation_satisfied"],
                    "evidence": implementation_check,
                },
                "specification": {
                    "satisfied": polarity["specification_satisfied"],
                    "evidence": specification_check,
                },
            },
            "rationale": args.rationale.strip(),
        }
        atomic_write(output, payload)
    except (OSError, ValueError) as error:
        print(f"four-class counterexample error: {error}", file=sys.stderr)
        return 2
    print(json.dumps(payload, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
