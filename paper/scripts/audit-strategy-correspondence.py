#!/usr/bin/env python3
"""Check the paired strategy example and the current theory replay receipt."""
import gzip
import hashlib
import json
from pathlib import Path

PAPER = Path(__file__).resolve().parents[1]
BASE = PAPER / "evidence/strategy-correspondence-20261019"

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    experiment = json.loads((BASE / "experiment.json").read_text())
    for rel, expected in experiment["sha256"].items():
        assert sha(BASE / rel) == expected, rel
    assert experiment["run_count"] == 8
    seen = set()
    for run in experiment["runs"]:
        key = (run["run"].split("-")[0], run["execution_strategy"], run["mode"])
        assert key not in seen, key
        seen.add(key)
        expected = "FAIL" if key[:2] == ("loose", "modular") else "PASS"
        report = json.loads((BASE / run["report"]).read_text())
        result = report["results"][0]
        assert run["status"] == result["status"] == expected, key
        assert result["execution_completed"], key
        assert result["evidence"]["certificate"] == "NOT_CHECKED", key
        if key[1] == "modular":
            assert result["result_scope"] == "contract-and-invariant-model"
        if expected == "FAIL":
            states = [e.get("selected_state", "") for e in result["sampling_events"]
                      if e["kind"] == "contract"]
            assert any("== 0" in s for s in states), key
            assert any(v["status"] == "INVALID" for v in result["vc_results"]), key
    assert len(seen) == 8
    replay = json.loads((BASE / "theory/report.json").read_text())
    assert replay["passed"] and len(replay["modules"]) == 12
    assert replay["principal_theorems_closed"] == 102
    assert all(s["exit_code"] == 0 for s in replay["stages"])
    for row in replay["modules"]:
        name = row["module"]
        assert sha(PAPER / "theory" / (name + ".v")) == row["source_sha256"], name
        compile_log = gzip.decompress(
            (BASE / "theory" / ("compile_" + name + ".log.gz")).read_bytes()).decode()
        kernel_log = gzip.decompress(
            (BASE / "theory" / ("kernel_replay_" + name + ".log.gz")).read_bytes()).decode()
        assert compile_log.count("Closed under the global context") == row["expected_closed"], name
        assert "Modules were successfully checked" in kernel_log, name
    print("Strategy evidence verified: 8 paired executions; 12 modules; 102 closed statements.")

if __name__ == "__main__":
    main()
