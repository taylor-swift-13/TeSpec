#!/usr/bin/env python3
"""Write a canonical TeSpec four-class result."""

from __future__ import annotations

import argparse
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
