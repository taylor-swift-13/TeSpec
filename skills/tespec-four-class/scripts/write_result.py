#!/usr/bin/env python3
"""Write a canonical TeSpec four-class result."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import sys
import tempfile


LABELS = {
    (True, True): "correct",
    (True, False): "soundness",
    (False, True): "complete",
    (False, False): "incomparable",
}

COUNTEREXAMPLE_POLARITIES = {
    "sound": {
        "direction": "spec_satisfied_impl_rejected",
        "implementation_satisfied": False,
        "specification_satisfied": True,
    },
    "complete": {
        "direction": "impl_satisfied_spec_rejected",
        "implementation_satisfied": True,
        "specification_satisfied": False,
    },
}


def boolean(value: str) -> bool:
    normalized = value.lower()
    if normalized == "true":
        return True
    if normalized == "false":
        return False
    raise argparse.ArgumentTypeError("expected true or false")


def evidence_path(root: Path, raw: str, label: str) -> str:
    path = Path(raw)
    if path.is_absolute() or ".." in path.parts:
        raise ValueError(f"{label} must be relative to the task root")
    if not (root / path).is_file():
        raise ValueError(f"{label} does not exist: {raw}")
    return path.as_posix()


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def payload_file(root: Path, raw: object, label: str) -> None:
    if not isinstance(raw, str):
        raise ValueError(f"{label} must be a relative file path")
    evidence_path(root, raw, label)


def validate_counterexample(root: Path, raw: str, property_name: str) -> None:
    path = root / raw
    try:
        payload = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as error:
        raise ValueError(f"{property_name} counterexample is invalid JSON") from error
    if not isinstance(payload, dict):
        raise ValueError(f"{property_name} counterexample must be an object")
    expected = COUNTEREXAMPLE_POLARITIES[property_name]
    if payload.get("schema") != "tespec-four-class-counterexample/v2":
        raise ValueError(
            f"{property_name} counterexample must use "
            "tespec-four-class-counterexample/v2"
        )
    if payload.get("property") != property_name:
        raise ValueError(f"{property_name} counterexample property is reversed")
    if payload.get("witness_direction") != expected["direction"]:
        raise ValueError(f"{property_name} counterexample direction is reversed")
    inputs = payload.get("inputs_sha256")
    if not isinstance(inputs, dict):
        raise ValueError(f"{property_name} counterexample lacks input hashes")
    current_hashes = {
        "impl": sha256(root / "input" / "impl.c"),
        "spec": sha256(root / "input" / "spec.qcp"),
    }
    if inputs != current_hashes:
        raise ValueError(f"{property_name} counterexample input hashes are stale")
    checks = payload.get("checks")
    if not isinstance(checks, dict):
        raise ValueError(f"{property_name} counterexample lacks checks")
    for subject, satisfied_key in (
        ("implementation", "implementation_satisfied"),
        ("specification", "specification_satisfied"),
    ):
        check = checks.get(subject)
        if not isinstance(check, dict):
            raise ValueError(f"{property_name} counterexample lacks {subject} check")
        if check.get("satisfied") is not expected[satisfied_key]:
            raise ValueError(
                f"{property_name} counterexample has reversed {subject} polarity"
            )
        payload_file(
            root,
            check.get("evidence"),
            f"{property_name} {subject} check evidence",
        )
    payload_file(root, payload.get("case_file"), f"{property_name} case file")
    rationale = payload.get("rationale")
    if not isinstance(rationale, str) or not rationale.strip():
        raise ValueError(f"{property_name} counterexample lacks rationale")


def atomic_write(path: Path, value: dict[str, object]) -> None:
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
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--sound", type=boolean, required=True)
    parser.add_argument("--complete", type=boolean, required=True)
    parser.add_argument("--soundness-evidence", required=True)
    parser.add_argument("--completeness-evidence", required=True)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    root = args.root.expanduser().resolve()
    try:
        soundness = evidence_path(root, args.soundness_evidence, "soundness evidence")
        completeness = evidence_path(
            root, args.completeness_evidence, "completeness evidence"
        )
        if not args.sound:
            validate_counterexample(root, soundness, "sound")
        if not args.complete:
            validate_counterexample(root, completeness, "complete")
        result = {
            "schema": "tespec-four-class-result/v1",
            "label": LABELS[(args.sound, args.complete)],
            "properties": {
                "sound": args.sound,
                "complete": args.complete,
            },
            "evidence": {
                (
                    "soundness_certificate"
                    if args.sound
                    else "soundness_counterexample"
                ): soundness,
                (
                    "completeness_certificate"
                    if args.complete
                    else "completeness_counterexample"
                ): completeness,
            },
        }
        atomic_write(root / "result.json", result)
    except (OSError, ValueError) as error:
        print(f"four-class result error: {error}", file=sys.stderr)
        return 2
    print(json.dumps(result, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
