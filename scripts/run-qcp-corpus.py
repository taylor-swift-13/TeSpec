#!/usr/bin/env python3
"""Reproducible QCP corpus smoke evaluation; generated binds are not an oracle."""

from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys
import time

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from spectest.core import (  # noqa: E402
    analyze_catalog,
    read_source_text,
    run_job,
    source_with_local_includes,
)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--examples", type=Path, required=True)
    parser.add_argument("--binary", type=Path, required=True)
    parser.add_argument("--runtime", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--limit", type=int, default=0)
    parser.add_argument("--timeout", type=float, default=5)
    parser.add_argument("--filter", default="")
    args = parser.parse_args()
    root, output = args.examples.resolve(), args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    inventory, results = [], []
    include_roots = tuple(
        [root] + [path for path in sorted(root.iterdir()) if path.is_dir()]
    )
    started = time.monotonic()
    for source in sorted(root.rglob("*.c")):
        relative = str(source.relative_to(root))
        if args.filter not in relative:
            continue
        record = {
            "source": relative,
            "sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
        }
        try:
            text = read_source_text(source)
            signatures = source_with_local_includes(source, include_roots)
            catalog = analyze_catalog(text, signature_source=signatures)
            record["functions"] = catalog["functions"]
        except Exception as error:
            record["error"] = str(error)
        inventory.append(record)
    (output / "inventory.json").write_text(json.dumps(inventory, indent=2) + "\n")
    count = 0
    binary_digest = hashlib.sha256(args.binary.read_bytes()).hexdigest()

    def checkpoint():
        summary = dict(Counter(item["status"] for item in results))
        final = {
            "schema": "qcp-corpus-evaluation/v1",
            "examples": str(root),
            "binary_sha256": binary_digest,
            "source_count": len(inventory),
            "specs_selected": count,
            "reason_counts": dict(Counter(item.get("reason", "") for item in results)),
            "binding_policy": "synthetic sizes 0,1,2; symbolic pointers; not a validity oracle",
            "duration_seconds": round(time.monotonic() - started, 3),
            "summary": summary,
            "results": results,
        }
        (output / "report.json").write_text(json.dumps(final, indent=2) + "\n")

    for entry in inventory:
        for function in entry.get("functions", []):
            for spec in function["specs"]:
                if args.limit and count >= args.limit:
                    continue
                count += 1
                identity = f"{entry['source']}:{function['function']}:{spec['spec']}"
                if (
                    not spec["supported"]
                    or spec["type_bindings"]
                    or "<well-typed QCP term>" in json.dumps(spec["binds_template"])
                ):
                    results.append(
                        {
                            "identity": identity,
                            "status": "NEEDS_BINDINGS",
                            "reason": spec.get("unsupported_reason")
                            or "explicit_typed_binding_required",
                        }
                    )
                    continue
                for mode in ("entry-exit", "all-boundaries"):
                    binds = []
                    for size in (0, 1, 2):
                        case = json.loads(json.dumps(spec["binds_template"][0]))
                        case["id"] = f"size_{size}"
                        for name, value in case.get("args", {}).items():
                            if isinstance(value, int):
                                case["args"][name] = size
                        for name, value in case.get("values", {}).items():
                            if isinstance(value, int):
                                case["values"][name] = size
                            elif isinstance(value, list):
                                case["values"][name] = [value[0] if value else 1] * size
                        binds.append(case)
                    directory = output / "artifacts" / f"{count:05d}" / mode
                    directory.mkdir(parents=True, exist_ok=True)
                    job = {
                        "source": str(root / entry["source"]),
                        "function": function["function"],
                        "binds": binds,
                        "spec": spec["spec"],
                        "qcp": {
                            "binary": str(args.binary.resolve()),
                            "qcip_root": str(args.runtime.resolve()),
                            "execution_mode": mode,
                            "timeout_seconds": args.timeout,
                            "loop_unroll_limit": 16,
                            "include_dirs": [str(path) for path in include_roots],
                        },
                    }
                    job_path = directory / "job.json"
                    job_path.write_text(json.dumps(job, indent=2) + "\n")
                    report = None
                    try:
                        report = run_job(job_path, directory)
                        for case in report["results"]:
                            results.append(
                                {
                                    "identity": identity,
                                    "mode": mode,
                                    "scope": case.get("scope"),
                                    "case": case["id"],
                                    "status": case["status"],
                                    "reason": case.get("reason"),
                                    "preconditions": case.get("preconditions", []),
                                    "duration_seconds": case.get("duration_seconds"),
                                    "peak_rss_kb": case.get("peak_rss_kb"),
                                    "report": str(directory / "report.json"),
                                }
                            )
                    except Exception as error:
                        results.append(
                            {
                                "identity": identity,
                                "mode": mode,
                                "status": "ERROR",
                                "reason": str(error),
                            }
                        )
                    checkpoint()
                    print(
                        identity,
                        mode,
                        report["summary"] if report else "error",
                        flush=True,
                    )
    checkpoint()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
