#!/usr/bin/env python3
"""Audit the verified-specification theorem and hash-matching reused replay."""
import gzip
import hashlib
import json
from pathlib import Path

PAPER = Path(__file__).resolve().parents[1]
BASE = PAPER / "evidence/verified-specification-testing-20261020"

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    report = json.loads((BASE / "report.json").read_text())
    assert report["passed"]
    assert sha(PAPER / report["source"]) == report["source_sha256"]
    for rel, expected in report["sha256"].items():
        assert sha(BASE / rel) == expected, rel
    commands = json.loads((BASE / "commands.json").read_text())
    for stage in ("final_compile", "final_kernel_replay"):
        row = report[stage]
        assert row["exit_code"] == commands[row["command_index"]]["returncode"] == 0
    compiled = gzip.decompress((BASE / report["final_compile"]["stdout"]).read_bytes()).decode()
    kernel = gzip.decompress((BASE / report["final_kernel_replay"]["stderr"]).read_bytes()).decode()
    assert compiled.count("Closed under the global context") == report["principal_theorems_closed"] == 20
    assert "Modules were successfully checked" in kernel
    assert "8.20.1" in report["coq_version"]
    prior = report["reused_receipt"]
    assert sha(PAPER / prior["path"]) == prior["sha256"]
    replay = json.loads((PAPER / prior["path"]).read_text())
    assert replay["passed"] and len(replay["modules"]) == prior["modules"] == 12
    assert replay["principal_theorems_closed"] == prior["principal_theorems_closed"] == 102
    for row in replay["modules"]:
        assert sha(PAPER / "theory" / (row["module"] + ".v")) == row["source_sha256"]
    assert report["combined_coverage"]["principal_theorems_closed"] == 122
    print("Verified-specification evidence: 20 new closed statements; independent kernel check; 12 unchanged modules reused; 13 modules / 122 total.")

if __name__ == "__main__":
    main()
