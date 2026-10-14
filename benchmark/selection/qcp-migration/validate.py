#!/usr/bin/env python3
"""Check migration provenance and replay evidence without executing the tools."""

import argparse
from collections import Counter
import json
from pathlib import Path

import prepare


def validate(directory):
    manifest = prepare.prepare()
    report = json.loads((directory / "report.json").read_text())
    assert report["manifest_sha256"] == prepare.sha(
        (prepare.HERE / "manifest.json").read_bytes()
    )
    assert report["runner_sha256"] == prepare.sha(
        (prepare.HERE / "run.py").read_bytes()
    )
    expected = report["artifacts"]
    actual = {
        str(p.relative_to(directory))
        for p in directory.rglob("*")
        if p.is_file() and p != directory / "report.json"
    }
    assert actual == set(expected), "Evidence inventory differs from the report"
    for name, digest in expected.items():
        path = directory / name
        assert path.resolve().is_relative_to(directory.resolve())
        assert prepare.sha(path.read_bytes()) == digest, name
    cases = {row["id"]: row for row in manifest["cases"]}
    assert len(report["native"]) == len(cases)
    for native in report["native"]:
        assert native["source_sha256"] == cases[native["case"]]["source_sha256"]
        assert native["log_sha256"] == expected[f"native/{native['case']}/executor.log"]
    seen = set()
    for row in report["tespec"]:
        key = row["case"], row["function"], row["mode"], row["id"]
        assert key not in seen, key
        seen.add(key)
        details = json.loads((directory / row["detail"]).read_text())
        result = next(r for r in details["results"] if r["id"] == row["id"])
        assert result["status"] == row["status"]
        assert result.get("reason") == row["reason"]
        assert result["generated_source_sha256"] == prepare.sha(
            result["embedded_artifacts"]["generated_source"].encode()
        )
        # Archived stdout allows investigation after temporary run directories disappear.
        assert "stdout" in result["embedded_artifacts"]
    required = {
        (c["id"], t["function"], mode, b["id"])
        for c in manifest["cases"]
        for t in c["targets"]
        for b in t["binds"]
        for mode in ["entry-exit", "all-boundaries"]
    }
    assert seen == required, "Missing replay inputs or modes"
    counts = Counter(r["status"] for r in report["tespec"])
    assert dict(counts) == report["summary"]["tespec"]
    assert "ERROR" not in counts, "Replay contains unresolved setup errors"
    for row in report["negative_controls"]:
        assert not (
            row["status"] == "COMPLETED"
            and row["functions"].get(row["function"], {}).get("status")
            == "AUTOMATICALLY_DISCHARGED"
        )
        assert row["error_kind"] == "postcondition_rejected" or (
            row["status"] == "COMPLETED"
            and row["functions"][row["function"]]["manual"] > 0
        )
    native = {row["case"]: row for row in report["native"]}
    assert native["single-free"]["status"] == "COMPLETED"
    assert native["single-free"]["functions"]["main"]["manual"] == 0
    assert native["double-free"]["error_kind"] == "call_precondition_not_established"
    print(json.dumps(report["summary"], indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "directory", type=Path, nargs="?", default=prepare.HERE / "evidence/20261014"
    )
    validate(parser.parse_args().directory)
