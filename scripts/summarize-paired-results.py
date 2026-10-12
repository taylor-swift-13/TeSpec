#!/usr/bin/env python3
"""Audit paired probe reports and preserve phase-specific results, not expectations."""

import argparse
import gzip
import hashlib
import json
from pathlib import Path


def digest(data):
    return hashlib.sha256(data).hexdigest()


def classify(tool, code, log):
    if code == "TIMEOUT":
        return "TIMEOUT"
    if tool == "cn_verify":
        if code == 0:
            return "VERIFIED"
        if code == 1 and "Unprovable constraint" in log:
            return "UNPROVED"
    elif tool == "fulminate":
        if code == 0:
            return "RUNTIME_PASS"
        if code == 2 and "Failed at" in log:
            return "RUNTIME_VIOLATION"
    return "TOOL_ERROR"


def summarize(inputs, output):
    if output.exists():
        raise ValueError("output must not exist")
    rows, evidence = [], {}
    seen = set()
    for index, path in enumerate(inputs):
        data = path.read_bytes()
        report = json.loads(data)
        subject = report.get("case", "single_cell")
        mode = report.get("tespec_mode", "expand")
        prefix = f"evidence/{index:03d}"
        evidence[f"{prefix}/report.json"] = data
        for run in report["runs"]:
            tool, variant = run["tool"], run["variant"]
            key = (subject, mode, variant, tool)
            if key in seen:
                raise ValueError("duplicate selected observation: " + str(key))
            seen.add(key)
            log_path = Path(run["log"])
            archived_dir = path.parent / variant
            archived_log = archived_dir / f"{tool}.log.gz"
            raw_log = (
                gzip.decompress(archived_log.read_bytes())
                if archived_log.is_file()
                else log_path.read_bytes()
            )
            if digest(raw_log) != run["log_sha256"]:
                raise ValueError("changed log: " + str(log_path))
            evidence[f"{prefix}/{variant}/{tool}.log.gz"] = gzip.compress(
                raw_log, mtime=0
            )
            suffix = "qcp" if tool == "tespec" else "cn"
            source = archived_dir / f"cell.{suffix}.c"
            if not archived_log.is_file():
                source = log_path.parent / f"cell.{suffix}.c"
            source_bytes = source.read_bytes()
            if digest(source_bytes) != run["source_sha256"]:
                raise ValueError("changed source: " + str(source))
            evidence[f"{prefix}/{variant}/cell.{suffix}.c"] = source_bytes
            row = {
                "subject": subject,
                "category": report.get("category", "single_cell"),
                "mode": mode,
                "variant": variant,
                "tool": tool,
                "returncode": run["returncode"],
                "evidence": f"{prefix}/{variant}/{tool}.log.gz",
                "source_sha256": run["source_sha256"],
            }
            if tool == "tespec":
                phase_path = (
                    archived_dir / "tespec-report.json"
                    if archived_log.is_file()
                    else log_path.parent / "tespec/report.json"
                )
                phase_bytes = phase_path.read_bytes()
                result = json.loads(phase_bytes)
                if len(result["results"]) != 1:
                    raise ValueError("expected one logical instance per probe")
                case = result["results"][0]
                row.update(
                    status=case["status"],
                    phases=case["phases"],
                    reason=case["reason"],
                    execution_completed=case.get("execution_completed"),
                    binary_sha256=result.get("provenance", {}).get("binary_sha256"),
                )
                if case["status"] == "PASS" and "UNKNOWN" in case["phases"].values():
                    raise ValueError("inconsistent PASS with unresolved phase")
                evidence[f"{prefix}/{variant}/tespec-report.json"] = phase_bytes
            else:
                row["status"] = classify(tool, run["returncode"], raw_log.decode())
            rows.append(row)
    output.mkdir(parents=True)
    for name, data in evidence.items():
        destination = output / name
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_bytes(data)
    result = {
        "schema": "tespec-paired-observation-summary/v1",
        "scope": "selected final development probes; not isolated performance trials",
        "subjects": sorted({r["subject"] for r in rows}),
        "observations": rows,
        "files": {name: digest(data) for name, data in evidence.items()},
    }
    (output / "results.json").write_text(json.dumps(result, indent=2) + "\n")
    lines = [
        "# Paired development observations",
        "",
        "CN verifies the full contract domain; Fulminate runs a concrete fixture;",
        "TeSpec checks a symbolic instance. Repeated baselines across modes are",
        "not independent subjects. UNPROVED and UNKNOWN do not establish violations.",
        "Proof-completed replays and QCP universal checks are reported separately.",
        "",
        "| Subject | Mode | Variant | CN | Fulminate | TeSpec | Require / execution / post / annotations |",
        "|---|---|---|---|---|---|---|",
    ]
    for subject, mode, variant in sorted(
        {(r["subject"], r["mode"], r["variant"]) for r in rows}
    ):
        group = {
            r["tool"]: r
            for r in rows
            if (r["subject"], r["mode"], r["variant"]) == (subject, mode, variant)
        }
        phases = group.get("tespec", {}).get("phases", {})
        detail = " / ".join(
            phases.get(k, "MISSING")
            for k in ["precondition", "execution", "postcondition", "annotations"]
        )
        statuses = [
            group.get(t, {}).get("status", "MISSING")
            for t in ["cn_verify", "fulminate", "tespec"]
        ]
        lines.append(
            "| " + " | ".join([subject, mode, variant, *statuses, detail]) + " |"
        )
    (output / "README.md").write_text("\n".join(lines) + "\n")
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, action="append", required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    result = summarize(args.input, args.output)
    print(
        json.dumps(
            {
                "subjects": len(result["subjects"]),
                "observations": len(result["observations"]),
            }
        )
    )


if __name__ == "__main__":
    main()
