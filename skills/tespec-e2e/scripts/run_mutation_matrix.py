#!/usr/bin/env python3
"""Run one frozen QCP spec and one binds set over reference plus C mutants."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import sys
from typing import Any


def project_root() -> Path:
    container_root = Path("/opt/tespec")
    if (container_root / "spectest").is_dir():
        return container_root
    return Path(__file__).resolve().parents[3]


ROOT = project_root()
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from spectest.core import (  # noqa: E402
    JobError,
    _find_function_spec,
    bundled_qcip_root,
    bundled_qcp_binary,
    run_job,
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--reference", type=Path, required=True)
    parser.add_argument("--function", required=True)
    parser.add_argument("--spec")
    parser.add_argument("--binds", type=Path, required=True)
    parser.add_argument("--mutants", type=Path, required=True)
    parser.add_argument("--output-dir", type=Path, required=True)
    parser.add_argument(
        "--artifact-root",
        type=Path,
        required=True,
        help="task root used to record portable relative paths",
    )
    parser.add_argument("--spec-version", required=True)
    parser.add_argument(
        "--phase", choices=("refinement", "heldout"), default="refinement"
    )
    parser.add_argument("--expected-binds", type=int, default=30)
    parser.add_argument("--minimum-mutants", type=int, default=8)
    parser.add_argument("-I", "--include-dir", action="append", type=Path, default=[])
    parser.add_argument("--loop-unroll-limit", type=int, default=64)
    parser.add_argument("--call-depth-limit", type=int, default=64)
    parser.add_argument("--timeout", type=float, default=30)
    return parser.parse_args()


def load_binds(path: Path) -> list[dict[str, Any]]:
    payload = json.loads(path.read_text(encoding="utf-8"))
    binds = payload.get("binds") if isinstance(payload, dict) else payload
    if not isinstance(binds, list):
        raise JobError("binds must be an array or an object containing a binds array")
    if not all(isinstance(item, dict) for item in binds):
        raise JobError("every bind must be a JSON object")
    ids = [item.get("id") for item in binds]
    if not all(isinstance(item, str) and item for item in ids):
        raise JobError("every bind must have a non-empty string id")
    if len(set(ids)) != len(ids):
        raise JobError("bind ids must be unique")
    return binds


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def artifact_path(root: Path, path: Path) -> str:
    try:
        return path.resolve().relative_to(root).as_posix()
    except ValueError as error:
        raise JobError(f"path is outside artifact root {root}: {path}") from error


def write_json(path: Path, value: Any) -> None:
    path.write_text(
        json.dumps(value, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def run_source(
    source: Path,
    function: str,
    spec: str | None,
    binds: list[dict[str, Any]],
    output_dir: Path,
    args: argparse.Namespace,
) -> dict[str, Any]:
    output_dir.mkdir(parents=True, exist_ok=False)
    job: dict[str, Any] = {
        "source": str(source),
        "function": function,
        "binds": binds,
        "output_dir": str(output_dir),
        "qcp": {
            "qcip_root": str(bundled_qcip_root()),
            "binary": str(bundled_qcp_binary()),
            "include_dirs": [str(item) for item in args.include_dir],
            "loop_unroll_limit": args.loop_unroll_limit,
            "call_depth_limit": args.call_depth_limit,
            "timeout_seconds": args.timeout,
        },
    }
    if spec is not None:
        job["spec"] = spec
    job_path = output_dir / "job.json"
    write_json(job_path, job)
    return run_job(job_path, output_dir)


def status_counts(report: dict[str, Any]) -> dict[str, int]:
    return {
        name: int(report["summary"][name])
        for name in ("PASS", "FAIL", "UNKNOWN", "ERROR")
    }


def main() -> int:
    args = parse_args()
    if args.expected_binds < 1 or args.minimum_mutants < 1:
        raise SystemExit("expected binds and minimum mutants must be positive")

    reference = args.reference.expanduser().resolve()
    binds_path = args.binds.expanduser().resolve()
    mutants_dir = args.mutants.expanduser().resolve()
    output_dir = args.output_dir.expanduser().resolve()
    artifact_root = args.artifact_root.expanduser().resolve()
    args.include_dir = [item.expanduser().resolve() for item in args.include_dir]
    for path in (reference, binds_path, mutants_dir, output_dir):
        artifact_path(artifact_root, path)
    binds = load_binds(binds_path)
    if len(binds) != args.expected_binds:
        raise SystemExit(
            f"expected exactly {args.expected_binds} binds, found {len(binds)}"
        )
    mutants = sorted(mutants_dir.glob("*.c"))
    if len(mutants) < args.minimum_mutants:
        raise SystemExit(
            f"expected at least {args.minimum_mutants} .c mutants, found {len(mutants)}"
        )
    if output_dir.exists():
        raise SystemExit(f"output directory already exists: {output_dir}")
    output_dir.mkdir(parents=True)

    reference_text = reference.read_text(encoding="utf-8")
    reference_spec = _find_function_spec(reference_text, args.function, args.spec).body
    invalid_spec_mutants: list[str] = []
    for mutant in mutants:
        mutant_spec = _find_function_spec(
            mutant.read_text(encoding="utf-8"), args.function, args.spec
        ).body
        if mutant_spec != reference_spec:
            invalid_spec_mutants.append(mutant.name)
    if invalid_spec_mutants:
        write_json(
            output_dir / "matrix.json",
            {
                "status": "ERROR",
                "reason": "mutant_changed_frozen_spec",
                "mutants": invalid_spec_mutants,
            },
        )
        return 2

    reference_report = run_source(
        reference,
        args.function,
        args.spec,
        binds,
        output_dir / "reference",
        args,
    )
    reference_counts = status_counts(reference_report)
    reference_by_id = {item["id"]: item for item in reference_report["results"]}

    negative_examples: list[dict[str, Any]] = []
    mutant_records: list[dict[str, Any]] = []
    if reference_counts["PASS"] == len(binds):
        for mutant in mutants:
            report = run_source(
                mutant,
                args.function,
                args.spec,
                binds,
                output_dir / "mutants" / mutant.stem,
                args,
            )
            counts = status_counts(report)
            if counts["ERROR"]:
                classification = "invalid"
            elif counts["FAIL"]:
                classification = "killed"
            elif counts["UNKNOWN"]:
                classification = "unresolved"
            else:
                classification = "survived"
            for result in report["results"]:
                if (
                    reference_by_id[result["id"]]["status"] == "PASS"
                    and result["status"] == "FAIL"
                ):
                    negative_examples.append(
                        {
                            "mutant": mutant.name,
                            "bind_id": result["id"],
                            "reason": result.get("reason"),
                            "mutant_source_sha256": sha256(mutant),
                            "report": artifact_path(
                                artifact_root,
                                output_dir / "mutants" / mutant.stem / "report.json",
                            ),
                        }
                    )
            mutant_records.append(
                {
                    "mutant": mutant.name,
                    "source_sha256": sha256(mutant),
                    "classification": classification,
                    "counts": counts,
                    "report": artifact_path(
                        artifact_root,
                        output_dir / "mutants" / mutant.stem / "report.json",
                    ),
                }
            )

    class_counts = {
        name: sum(item["classification"] == name for item in mutant_records)
        for name in ("killed", "survived", "unresolved", "invalid")
    }
    denominator = class_counts["killed"] + class_counts["survived"]
    matrix = {
        "schema": "tespec-mutation-matrix/v2",
        "status": (
            "PASS"
            if reference_counts["PASS"] == len(binds) and class_counts["invalid"] == 0
            else "ERROR"
        ),
        "phase": args.phase,
        "spec_version": args.spec_version,
        "function": args.function,
        "spec": args.spec,
        "artifact_root": ".",
        "reference": {
            "source": artifact_path(artifact_root, reference),
            "source_sha256": sha256(reference),
            "spec_sha256": hashlib.sha256(reference_spec.encode("utf-8")).hexdigest(),
            "counts": reference_counts,
            "report": artifact_path(
                artifact_root, output_dir / "reference" / "report.json"
            ),
        },
        "binds": {
            "path": artifact_path(artifact_root, binds_path),
            "sha256": sha256(binds_path),
            "count": len(binds),
        },
        "mutants": mutant_records,
        "mutation_summary": {
            "total": len(mutant_records),
            **class_counts,
            "mutation_score": (
                class_counts["killed"] / denominator if denominator else None
            ),
            "confirmed_negative_examples": len(negative_examples),
        },
    }
    write_json(output_dir / "negative-examples.json", negative_examples)
    write_json(
        output_dir / "survivors.json",
        [
            item
            for item in mutant_records
            if item["classification"] in {"survived", "unresolved"}
        ],
    )
    write_json(output_dir / "matrix.json", matrix)
    print(json.dumps(matrix, ensure_ascii=False, indent=2))
    return 0 if matrix["status"] == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
