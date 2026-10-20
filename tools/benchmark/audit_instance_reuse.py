#!/usr/bin/env python3
"""Compare shared-instance regression runs with their immediately preceding builds."""
from collections import Counter
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / "benchmark/results/spatial-smt-regressions"
OUT = ROOT / "benchmark/results/instance-reuse-20261020"


def load(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def identity(row):
    return tuple(row[k] for k in ("group", "variant", "case", "mode"))


def files(row):
    return {x["kind"]: x["sha256"] for x in row["vc_artifacts"]}


def verified(row):
    for item in (row["source"], row["binds"], row["report"], *row["vc_artifacts"]):
        assert digest(ROOT / item["path"]) == item["sha256"], item
    assert row["measurement"]["exit_code"] in (0, 1), row["measurement"]


def compare(name, before_name, after_name, exact):
    before = load(BASE / before_name / "results.json")
    after = load(BASE / after_name / "results.json")
    old = {identity(x): x for x in before["runs"]}
    new = {identity(x): x for x in after["runs"]}
    assert old.keys() == new.keys()
    differences, regressions = [], []
    identical_vcs = 0
    for key, row in new.items():
        previous = old[key]
        verified(row)
        verified(previous)
        assert row["source"] == previous["source"] and row["binds"] == previous["binds"]
        same_vcs = files(row) == files(previous)
        identical_vcs += same_vcs
        fields = ("status", "reason", "precondition_result", "execution_completed",
                  "executor_error", "residual_vcs", "phases")
        changed = [k for k in fields if row["current"].get(k) != previous["current"].get(k)]
        if changed or not same_vcs:
            differences.append({"identity": key, "fields": changed, "same_vcs": same_vcs,
                "before": previous["current"], "after": row["current"],
                "before_vcs": previous["vc_artifacts"], "after_vcs": row["vc_artifacts"]})
        a, b = previous["current"], row["current"]
        if ((exact and (changed or not same_vcs))
                or (a["status"] in ("PASS", "FAIL", "ERROR") and b["status"] != a["status"])
                or (a["execution_completed"] and not b["execution_completed"])
                or (row["expected"] == "FAIL" and b["status"] == "PASS")):
            regressions.append(key)
    result = {"name": name, "executions": len(new), "same_original_vc_files": identical_vcs,
        "before": before_name, "after": after_name, "exact_comparison": exact,
        "native_statuses": dict(Counter(x["current"]["status"] for x in new.values())),
        "regressions": regressions, "differences": differences,
        "input_and_evidence_hashes_verified": True,
        "source_baseline_changes": after["summary"]["changed_evidence"],
        "stage_costs": after["summary"]["modes"]}
    assert not result["source_baseline_changes"]
    return result


def main():
    runs = [compare("inline", "20261020-inline-after-boundary-fix",
                    "20261020-instance-reuse-inline", True),
            compare("modular-on", "20261020-modular-boundary-on",
                    "20261020-instance-reuse-modular-on", False),
            compare("modular-off", "20261020-modular-boundary-off",
                    "20261020-instance-reuse-modular-off", True)]
    result = {"schema": "tespec-instance-reuse-audit/v1", "runs": runs,
              "passed": all(not x["regressions"] for x in runs),
              "tokens": 0, "model_calls": 0,
              "scope": "Native regression and original VC identity audit. No new ITP certification."}
    OUT.mkdir(exist_ok=True)
    (OUT / "audit.json").write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({"passed": result["passed"], "runs": [
        {k: x[k] for k in ("name", "executions", "same_original_vc_files", "native_statuses", "regressions")}
        for x in runs]}, ensure_ascii=False))
    return 0 if result["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
