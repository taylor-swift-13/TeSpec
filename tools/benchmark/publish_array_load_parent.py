#!/usr/bin/env python3
"""Publish current array_load regression and honest full-parent ITP diagnosis."""
from collections import Counter
import csv
import json
from meter_read_itp_coq import ROOT, save, sha

OUT = ROOT / "benchmark/results/array_load/20261021-parent-analysis"
ITP = ROOT / "benchmark/results/array_load/20261021-parent-itp"


def load(path):
    return json.loads(path.read_text())


def ref(path):
    return {"path": str(path.relative_to(ROOT)), "sha256": sha(path)}


def checked(refdata):
    path = ROOT / refdata["path"]
    assert sha(path) == refdata["sha256"]
    return path


def attach_certificate(row, strategy):
    if strategy == "inline":
        evidence = next(x for x in row["itp_comparison_oracle"]["evidence"] if x["source_mode"] == row["mode"])
        path = checked(evidence["receipt"])
        proof = load(path)
        binding = proof["binding"]
        assert binding["qcp_source_sha256"] == row["source"]["sha256"]
        assert binding["binds_sha256"] == row["binds"]["sha256"]
        goalsha = binding["goal_sha256"]
        targets = binding["residual_vcs"]
    else:
        index = 4 if row["mode"] == "off" else 5
        path = ROOT / f"benchmark/results/array_load/20261020-boundary-itp/execution-{index:02d}/attempt-2/receipt.json"
        proof = load(path)
        binding = proof["binding"]
        assert binding["source"] == row["source"] and binding["binds"] == row["binds"]
        goalsha = binding["original_goal"]["sha256"]
        targets = binding["all_original_residual_vcs"]
    assert proof["status"] == "KERNEL_CHECKED" and proof["kernel_check"]["exit_code"] == 0
    assert proof["final_status"] == "PASS"
    goal = next(x for x in row["vc_artifacts"] if x["kind"] == "goal")
    assert goal["sha256"] == goalsha
    assert [x.removeprefix("proof_of_") for x in row["current"]["residual_vcs"]] == targets
    return ref(path)


def main():
    attempts = [load(x) for x in sorted(ITP.glob("attempt-*/receipt.json"))]
    assert attempts and attempts[-1]["status"] == "DIAGNOSTICS_KERNEL_CHECKED"
    latest = sorted(ITP.glob("attempt-*/receipt.json"))[-1]
    stage_rows = []
    models = [x["model"] for x in attempts]
    stage_rows.append({"stage": "agent_proof_and_repairs", "seconds": sum(x["wall_seconds"] for x in models),
        "peak_process_mib": max(x["resources"]["max_process_peak_working_set_bytes"] for x in models) / 1024**2,
        "tokens": sum(u.get("input_tokens", 0) + u.get("output_tokens", 0) for x in models for u in x["token_usage"]), "calls": len(models)})
    for key, title in [("compilation", "coq_compile_and_assumption_audit"), ("kernel_check", "independent_kernel_check")]:
        stages = [m for a in attempts for m in (a.get(key, []) if key == "compilation" else [a[key]] if key in a else [])]
        stage_rows.append({"stage": title, "seconds": sum(m["wall_seconds"] for m in stages),
            "peak_process_mib": max(m["resources"]["max_process_rss_kib"] for m in stages) / 1024,
            "tokens": 0, "calls": len(stages)})
    proof_cost = {"unit": "One complete-execution diagnostic task, including all attempts; not a full successful execution certificate.",
        "stages": stage_rows, "total_seconds": sum(x["seconds"] for x in stage_rows),
        "peak_process_mib": max(x["peak_process_mib"] for x in stage_rows), "tokens": stage_rows[0]["tokens"],
        "model_calls": len(models), "receipt": ref(latest), "attempts": [ref(x) for x in sorted(ITP.glob("attempt-*/receipt.json"))]}
    rows, decisions, unexpected = [], [], []
    for strategy in ["inline", "modular"]:
        batch = ROOT / f"benchmark/results/spatial-smt-regressions/20261021-array-load-{strategy}"
        data = load(batch / "results.json")
        assert data["summary"]["run_complete"] and not data["summary"]["changed_evidence"]
        assert len(data["runs"]) == 134
        for mode in ["off", "on"]:
            selected = [r for r in data["runs"] if r["mode"] == mode]
            final = Counter()
            for r in selected:
                for obj in [r["source"], r["binds"], r["report"], *r["vc_artifacts"]]:
                    checked(obj)
                status = r["current"]["status"]
                certificate = None
                if status == "UNKNOWN" and (strategy == "inline" or "translation7_only_entry" in r["case"]):
                    certificate = attach_certificate(r, strategy)
                    status = "PASS"
                final[status] += 1
                decision = {"strategy": strategy, "mode": mode, "variant": r["variant"], "case": r["case"],
                    "expected": r["expected"], "raw_status": r["current"]["status"], "final_status": status,
                    "certificate": certificate, "report": r["report"], "vc_artifacts": r["vc_artifacts"]}
                decisions.append(decision)
                if status != r["expected"]:
                    assert r["case"] == "original_client_translation12_only_entry" and strategy == "modular"
                    goal = next(x for x in r["vc_artifacts"] if x["kind"] == "goal")
                    assert goal["sha256"] == attempts[-1]["original_goal_sha256"]
                    unexpected.append({**decision, "source": r["source"], "binds": r["binds"],
                        "command": r["measurement"]["command"], "logs": {k: r["measurement"][k] for k in ["stdout", "stderr"]},
                        "itp_receipt": ref(latest), "itp_conclusion": "Diagnostic lemmas kernel checked; exact full parent not proved or refuted.",
                        "reason": "Weak callee contract loses returned value and array contents. Full spatial refutation additionally lacks a concrete valid/disjoint local-address countermodel; auxiliary refutation cannot decide whole test."})
            rows.append({"strategy": strategy, "spatial_smt": mode, "executions": len(selected),
                "raw_statuses": dict(Counter(r["current"]["status"] for r in selected)), "final_statuses": dict(final),
                "expected_matches": sum(x["final_status"] == x["expected"] for x in decisions if x["strategy"] == strategy and x["mode"] == mode),
                "mean_cli_seconds": sum(r["measurement"]["wall_seconds"] for r in selected) / len(selected),
                "mean_peak_process_mib": sum(r["measurement"]["resources"]["max_process_rss_kib"] for r in selected) / len(selected) / 1024,
                "tokens": 0, "model_calls": 0,
                "per_execution_stages": [{"case": r["case"], "variant": r["variant"], "measurement": r["stage_measurements"]} for r in selected]})
    summary = {"schema": "tespec-array-load-parent-analysis/v1", "group": "array_load", "case_pairs": 67,
        "native_executions": 268, "evaluation_complete": False, "rows": rows, "decisions": decisions,
        "whole_execution_itp_diagnostic": proof_cost, "remaining": unexpected,
        "historical_four_tool_results": ref(ROOT / "benchmark/results/array_load/result-cost.json"),
        "cost_scope": "Fresh native per-stage measurements and one new diagnostic ITP task. Matched historical full proofs reused without charging old costs again. Native CLI and executor stages are nested."}
    save(OUT / "result-cost.json", summary)
    columns = ["strategy", "spatial_smt", "executions", "raw_statuses", "final_statuses", "expected_matches", "mean_cli_seconds", "mean_peak_process_mib", "tokens"]
    with (OUT / "result-cost.csv").open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=columns, extrasaction="ignore", lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)
    lines = ["# array_load — 2026-10-21", "", "67 input pairs, 268 fresh native runs. Expectations unchanged. Modular remains incomplete.", "",
        "| Strategy | Spatial SMT | Raw | Final with exact certificates | Match | Mean CLI s | Mean peak MiB |", "|---|---|---|---|---:|---:|---:|"]
    lines += [f"| {r['strategy']} | {r['spatial_smt']} | {r['raw_statuses']} | {r['final_statuses']} | {r['expected_matches']}/67 | {r['mean_cli_seconds']:.6f} | {r['mean_peak_process_mib']:.3f} |" for r in rows]
    lines += ["", "One whole-execution ITP diagnostic task, all repairs included:", "", "| Stage | Seconds | Peak process MiB | Tokens |", "|---|---:|---:|---:|"]
    lines += [f"| {r['stage']} | {r['seconds']:.6f} | {r['peak_process_mib']:.3f} | {r['tokens']} |" for r in stage_rows]
    lines += ["", f"ITP total {proof_cost['total_seconds']:.6f}s; peak {proof_cost['peak_process_mib']:.3f} MiB; {proof_cost['tokens']} tokens, {proof_cost['model_calls']} actual gpt-6.1-sol calls. Diagnostic proofs are kernel checked; no unconditional original parent proof/refutation exists in this result.", "",
        "CN, QCP, Fulminate and earlier ITP costs: [historical four-tool table](../result-cost.md). Native substage costs and exact source/input/VC/certificate identities remain in JSON. No repeated model cost is attributed to certificate reuse."]
    (OUT / "result-cost.md").write_text("\n".join(lines) + "\n")
    save(ROOT / "benchmark/results/tespec-unexpected/recheck-20261021-array-load.json", {"group": "array_load", "mismatches": unexpected, "whole_execution_itp_diagnostic": proof_cost})
    print(json.dumps({"rows": [{k: v for k, v in r.items() if k != "per_execution_stages"} for r in rows], "itp": proof_cost}, ensure_ascii=False))


if __name__ == "__main__":
    main()
