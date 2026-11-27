#!/usr/bin/env python3
"""Audit the current matrix, all three group views and the mismatch index."""
from collections import Counter
import csv

from organize_tespec_routes import ROOT, RESULTS, BINARY, digest, fingerprint, inputs, read, reference, save
from publish_current_tables import COLUMNS


def require(condition, message):
    if not condition:
        raise ValueError(message)


def main():
    index_path = RESULTS / "group-result-cost-index.json"
    index = read(index_path)
    totals = Counter()
    auto_verdicts = Counter()
    residual_verdicts = Counter()
    mismatch = {}
    for entry in index["groups"]:
        group = entry["program_group"]
        base = RESULTS / group
        path = base / "tespec/current-executions.json"
        current = read(path)
        table = read(base / "result-cost.json")["current_evaluation"]
        receipt = entry.get("current_group_audit")
        if receipt:
            receipt_path = ROOT / receipt["path"]
            require(reference(receipt_path) == receipt, group + ": stale group audit")
            audited = read(receipt_path)
            for tool in ("cn", "qcp", "fulminate", "tespec"):
                artifact = audited[tool]
                require(reference(ROOT / artifact["path"]) == artifact, group + ": stale " + tool + " audit evidence")
        tasks, _, _ = inputs(group)
        proof = read(base / "tespec/current-itp.json")["executions"]
        require(table["executions"] == reference(path), group + ": wrong current execution reference")
        require(current["profile"]["binary_sha256"] == fingerprint(BINARY), group + ": wrong binary")
        require(current["profile"]["plan_sha256"] == fingerprint(ROOT/"benchmark/programs"/group/"evaluation-plan.json"), group + ": wrong plan")
        with (base / "result-cost.csv").open(newline="") as stream:
            csv_rows = csv.DictReader(stream)
            require(tuple(csv_rows.fieldnames) == COLUMNS, group + ": wrong CSV header")
            expected = [{k: "" if r[k] is None else str(r[k]) for k in COLUMNS} for r in table["stages"]]
            require(list(csv_rows) == expected, group + ": CSV differs from JSON")
        require("逐执行记录" in (base / "result-cost.md").read_text(), group + ": missing Markdown links")
        seen = set()
        anomalies = []
        for i, r in enumerate(current["executions"]):
            key = r["variant"], r["case"], r["strategy"]
            require(key not in seen, group + ": duplicate execution")
            seen.add(key)
            (_, src, bind, exp), _, fault = tasks[key]
            require((r["source_sha256"], r["input_sha256"], r["expected"], r["expected_fault_code"]) ==
                    (src["sha256"], digest(bind), exp, fault), group + ": execution identity")
            if "original_source_sha256" in src:
                require(r.get("qcp_input_fixture_path") == src["path"] and r.get("original_source_sha256") == src["original_source_sha256"]
                        and r.get("executed_source_sha256"), group + ": fixture")
            require(r["native"]["tokens"] == 0 and r["native"]["wall_seconds"] is not None and r["native"]["max_process_rss_kib"] is not None, group + ": native cost")
            totals["executions"] += 1
            totals["branch_records"] += int(r.get("branch_evaluation") is not None)
            totals["auto_matches"] += int(r["expected_match"])
            auto_verdicts[r["effective_status"]] += 1
            h = r["native_report_sha256"]
            item = proof.get(h)
            eligible = r["auto_status"] != "NOT_RUN"
            if eligible:
                require(r["auto"] and r["auto"]["tokens"] == 0 and r["auto"]["model_calls"] == 0, group + ": Auto cost")
                totals["eligible"] += 1
                residual_verdicts[("AWAITING_MODEL" if item.get("needs_model") else item["final_status"]) if item else "PENDING"] += 1
            else:
                require(item is None, group + ": ITP without residual task")
            if item:
                require((item["case"], item["strategy"], item["variant"], item["goal_sha256"]) ==
                        (r["case"],r["strategy"],r["variant"],r["goal_sha256"]), group + ": proof mismatch")
                for m in item["model_attempts"]:
                    require((m["requested_model"],m["requested_reasoning_effort"]) == ("gpt-6.1-sol","medium"), "ITP model")
                totals["itp_model_calls"] += len(item["model_attempts"])
            itp_final = r["native_status"]
            if eligible:
                itp_final = item["final_status"] if item and not item.get("needs_model") else "PENDING"
            if not r["expected_match"] or (itp_final != "PENDING" and itp_final != exp):
                anomalies.append({"execution_row": i, "case": key[1], "variant": key[0], "strategy": key[2],
                                  "expected": exp, "native": r["native_status"], "auto": r["effective_status"], "itp": itp_final,
                                  "reason": r.get("reason")})
        require(seen == tasks.keys(), group + ": missing planned execution")
        if anomalies:
            mismatch[group] = {"evidence": reference(path), "executions": anomalies}
        entry["current_evaluation"] = {"json": str((base/"result-cost.json").relative_to(ROOT)),
                                       "pointer": "/current_evaluation", "executions": len(seen)}
    index["current_route_measurement"] = {"schema": "tespec-current-coverage/v1", "groups":len(index["groups"]),
             **dict(totals), "auto_outcomes": dict(auto_verdicts), "itp_residual_outcomes": dict(residual_verdicts),
             "unexpected": "benchmark/results/tespec-unexpected/current-routes.json"}
    save(RESULTS / "tespec-unexpected/current-routes.json", {"schema":"tespec-current-unexpected/v1",
         "reproduction":"python3 tools/benchmark/measure_current_executions.py --reproduce --group GROUP --case CASE --variant VARIANT --strategy STRATEGY --scratch SCRATCH --workers 4",
         "identity":"execution_row indexes current-executions.json; matching ITP evidence keyed by native_report_sha256",
         "groups":mismatch})
    import json
    index_path.write_text(json.dumps(index, ensure_ascii=False, indent=2)+"\n")
    print(index["current_route_measurement"])


if __name__ == "__main__":
    main()
