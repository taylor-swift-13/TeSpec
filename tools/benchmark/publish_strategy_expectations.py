#!/usr/bin/env python3
"""Publish strategy-specific benchmark oracles and exact-proof reuse audits."""
from collections import Counter
import csv
import json
from meter_read_itp_coq import ROOT, save, sha

OUT = ROOT / "benchmark/results/strategy-expectations-20261021"
BASE = ROOT / "benchmark/results/spatial-smt-regressions"
PROOF = ROOT / "benchmark/results/array_load/20261021-local-counterexample"


def load(path):
    return json.loads(path.read_text())


def ref(path):
    return {"path": str(path.relative_to(ROOT)), "sha256": sha(path)}


def verify(reference):
    assert sha(ROOT / reference["path"]) == reference["sha256"]


def fingerprints(row):
    return {r["kind"]: r["sha256"] for r in row["vc_artifacts"]}


def proof_cost():
    files = sorted(PROOF.glob("attempt-*/receipt.json"))
    receipts = [load(f) for f in files]
    latest = next((f for f in reversed(files) if load(f)["status"] == "KERNEL_CHECKED"), None)
    assert latest is not None
    models = {r["model"]["raw_event_log_sha256"]: r["model"] for r in receipts}
    stages = [{"stage": "agent_proofs_and_repairs", "seconds": sum(m["wall_seconds"] for m in models.values()),
               "peak_process_mib": max(m["resources"]["max_process_peak_working_set_bytes"] for m in models.values()) / 1024**2,
               "tokens": sum(u["input_tokens"] + u["output_tokens"] for m in models.values() for u in m["token_usage"]),
               "calls": len(models)}]
    for key, title in [("compilation", "coq_compile_and_assumption_audit"), ("kernel_check", "independent_kernel_check")]:
        runs = [m for r in receipts for m in (r.get(key, []) if key == "compilation" else [r[key]] if key in r else [])]
        stages.append({"stage": title, "seconds": sum(m["wall_seconds"] for m in runs),
                       "peak_process_mib": max(m["resources"]["max_process_rss_kib"] for m in runs) / 1024,
                       "tokens": 0, "calls": len(runs)})
    return {"unit": "One complete-execution counterexample task, all model repairs and validation retries included.",
            "model_calls": len(models), "tokens": stages[0]["tokens"], "stages": stages,
            "seconds": sum(s["seconds"] for s in stages), "peak_process_mib": max(s["peak_process_mib"] for s in stages),
            "receipt": ref(latest), "attempts": [ref(f) for f in files],
            "previous_diagnostic_costs": "benchmark/results/array_load/20261021-parent-analysis/result-cost.json"}


def main():
    cost = proof_cost()
    proof = load(ROOT / cost["receipt"]["path"])
    runs = {s: load(BASE / f"20261021-strategy-expectations-{s}/results.json") for s in ["inline", "modular"]}
    previous = load(BASE / "20261020-clean-modular-20/results.json")
    old = {(r["group"], r["variant"], r["case"], r["mode"]): r for r in previous["runs"]}
    grouped = {}
    global_counts = {}
    closure_references = []
    for strategy, data in runs.items():
        assert data["summary"]["run_complete"] and not data["summary"]["changed_evidence"]
        assert len(data["runs"]) == 1800
        for row in data["runs"]:
            for r in [row["source"], row["binds"], row["report"], *row["vc_artifacts"]]:
                verify(r)
            result = row["current"]["status"]
            evidence = None
            if result == "UNKNOWN":
                if strategy == "inline":
                    assert fingerprints(row) == fingerprints(row["baseline"])
                    oracle = row["itp_comparison_oracle"]
                    records = oracle.get("evidence", [oracle])
                    for record in records:
                        verify(record["receipt"])
                    result = oracle["conclusion"]
                    evidence = {"kind": "exact_original_vc_certificate_reuse", "receipts": [r["receipt"] for r in records]}
                elif row["group"] == "array_load":
                    if row["case"] == "original_client_translation12_only_entry":
                        goal = next(r for r in row["vc_artifacts"] if r["kind"] == "goal")
                        assert goal["sha256"] == proof["binding"]["original_goal"]["sha256"]
                        assert row["source"] == proof["binding"]["source"] and row["binds"] == proof["binding"]["binds"]
                        result = "FAIL"
                        evidence = {"kind": "full_parent_universal_local_environment_counterexample", "receipt": cost["receipt"],
                                    "raw_parent_unconditionally_refuted": False, "specialization_link_kernel_checked": True}
                        closure_references.append({"mode": row["mode"], "goal": goal, "proof": cost["receipt"]})
                    else:
                        assert row["case"] == "original_client_translation7_only_entry"
                        i = 4 if row["mode"] == "off" else 5
                        f = ROOT / f"benchmark/results/array_load/20261020-boundary-itp/execution-{i:02d}/attempt-2/receipt.json"
                        receipt = load(f)
                        goal = next(r for r in row["vc_artifacts"] if r["kind"] == "goal")
                        assert receipt["status"] == "KERNEL_CHECKED" and receipt["binding"]["original_goal"]["sha256"] == goal["sha256"]
                        assert receipt["binding"]["source"] == row["source"] and receipt["binding"]["binds"] == row["binds"]
                        result = "PASS"
                        evidence = {"kind": "exact_original_vc_certificate_reuse", "receipt": ref(f)}
                else:
                    before = old[row["group"], row["variant"], row["case"], row["mode"]]
                    assert fingerprints(row) == fingerprints(before)
                    assert row["source"] == before["source"] and row["binds"] == before["binds"]
                    table = load(ROOT / f"benchmark/results/modular-20-groups-20261020/groups/{row['group']}/result-cost.json")
                    prior_row = next(r for r in table["rows"] if r["strategy"] == "modular" and r["spatial_smt"] == row["mode"])
                    decision = next(r for r in prior_row["decisions"] if r["variant"] == row["variant"] and r["case"] == row["case"])
                    result = decision["status"]
                    evidence = decision["evidence"]
                    verify(evidence)
            assert result == row["expected"], (strategy, row["group"], row["case"], result, row["expected"])
            d = {"variant": row["variant"], "case": row["case"], "strategy": strategy, "mode": row["mode"],
                 "expected": row["expected"], "raw_status": row["current"]["status"], "final_status": result,
                 "evidence": evidence, "report": row["report"], "vc_artifacts": row["vc_artifacts"]}
            grouped.setdefault(row["group"], []).append((d, row))
            global_counts.setdefault(strategy + "/" + row["mode"], Counter()).update([result])
    for group, items in grouped.items():
        rows = []
        for strategy in ["inline", "modular"]:
            for mode in ["off", "on"]:
                selected = [(d, r) for d, r in items if d["strategy"] == strategy and d["mode"] == mode]
                rows.append({"strategy": strategy, "spatial_smt": mode, "executions": len(selected),
                    "raw": dict(Counter(d["raw_status"] for d, r in selected)),
                    "final": dict(Counter(d["final_status"] for d, r in selected)), "expected_matches": len(selected),
                    "mean_cli_seconds": sum(r["measurement"]["wall_seconds"] for d, r in selected) / len(selected),
                    "mean_peak_process_mib": sum(r["measurement"]["resources"]["max_process_rss_kib"] for d, r in selected) / len(selected) / 1024,
                    "tokens": 0, "model_calls": 0,
                    "per_execution_stages": [{"case": d["case"], "variant": d["variant"], "measurements": r["stage_measurements"]} for d, r in selected]})
        folder = OUT / "groups" / group
        save(folder / "result-cost.json", {"group": group, "complete": True, "rows": rows,
            "decisions": [d for d, r in items], "new_itp": cost if group == "array_load" else None,
            "historical_four_tool_table": ref(ROOT / f"benchmark/results/{group}/result-cost.json")})
        columns = ["strategy", "spatial_smt", "executions", "raw", "final", "expected_matches", "mean_cli_seconds", "mean_peak_process_mib", "tokens"]
        with (folder / "result-cost.csv").open("w", newline="") as stream:
            writer = csv.DictWriter(stream, fieldnames=columns, extrasaction="ignore", lineterminator="\n")
            writer.writeheader()
            writer.writerows(rows)
        text = ["# " + group, "", "| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |", "|---|---|---:|---|---|---:|---:|---:|"]
        text += [f"| {r['strategy']} | {r['spatial_smt']} | {r['executions']} | {r['raw']} | {r['final']} | {r['expected_matches']} | {r['mean_cli_seconds']:.6f} | {r['mean_peak_process_mib']:.3f} |" for r in rows]
        text += ["", "CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../" + group + "/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive."]
        if group == "array_load":
            text += ["", "translation12: inline expected PASS, modular expected FAIL (explicit user change). OFF uses a kernel-checked full-parent counterexample under a legal local environment, linked to the unchanged original definition. ON finds a finite spatial countermodel automatically. No claim of a bug in the actual read body.", "",
                     f"New ITP: {cost['model_calls']} model calls; {cost['tokens']} tokens; {cost['seconds']:.6f} seconds; {cost['peak_process_mib']:.3f} MiB maximum process peak. All repairs/validation retries included, historical diagnostics linked separately."]
        (folder / "result-cost.md").write_text("\n".join(text) + "\n")
    summary = {"schema": "tespec-strategy-expectations/v1", "groups": sorted(grouped), "complete_groups": len(grouped),
        "case_pairs": 900, "native_executions": 3600, "all_expected_matched": True,
        "final_by_strategy_and_spatial_smt": {k: dict(v) for k, v in global_counts.items()},
        "new_counterexample_itp": cost, "closure_certificate_bindings": closure_references,
        "expectation_change": {"case": "array_load/original_client_translation12_only_entry", "inline": "PASS", "modular": "FAIL", "source": "Explicit user instruction; original source and inputs unchanged."}}
    save(OUT / "summary.json", summary)
    lines = ["# Strategy-specific expectations — 21 complete groups", "", "900 input pairs, 3600 native executions, all final results match their strategy-specific expectations.", "", "| Group | Results and costs |", "|---|---|"]
    lines += [f"| {g} | [table](groups/{g}/result-cost.md) |" for g in sorted(grouped)]
    (OUT / "index.md").write_text("\n".join(lines) + "\n")
    save(ROOT / "benchmark/results/tespec-unexpected/resolved-20261021-translation12.json", {
        "status": "RESOLVED", "expectation_change": summary["expectation_change"], "group": "array_load",
        "evidence": ref(OUT / "groups/array_load/result-cost.json"), "scope": "Modular contract adequacy; inline actual-body expectation remains PASS.",
        "original_parent_unconditionally_refuted": False, "universal_legal_local_environment_refuted": True})
    print(json.dumps({k: v for k, v in summary.items() if k not in ["closure_certificate_bindings", "new_counterexample_itp"]}))


if __name__ == "__main__":
    main()
