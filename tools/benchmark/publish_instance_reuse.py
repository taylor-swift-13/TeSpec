#!/usr/bin/env python3
"""Publish per-group native costs and separately measured proof-repair attempts."""
from collections import Counter, defaultdict
import csv
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "benchmark/results/instance-reuse-20261020"
BASE = ROOT / "benchmark/results/spatial-smt-regressions"


def load(path):
    return json.loads(path.read_text())


def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def mean(values):
    return sum(values) / len(values) if values else None


def verify_refs(value):
    if isinstance(value, dict):
        if "path" in value and "sha256" in value:
            assert hashlib.sha256((ROOT / value["path"]).read_bytes()).hexdigest() == value["sha256"]
        for child in value.values():
            verify_refs(child)
    elif isinstance(value, list):
        for child in value:
            verify_refs(child)


def finalize(rows, group, strategy):
    if strategy == "inline":
        return None
    sampling = strategy.split("-")[1]
    previous = load(ROOT / "benchmark/results" / group / "modular-boundary/20261020/result-cost.json")
    old = {(x["variant"], x["case"], x["mode"]): x for x in previous["cases"]
           if x["modular_instantiation"] == sampling}
    decisions = []
    for row in rows:
        status = row["current"]["status"]
        basis = "native"
        evidence = None
        if status == "UNKNOWN":
            prior = old[row["variant"], row["case"], row["mode"]]
            same_vcs = {x["kind"]: x["sha256"] for x in row["vc_artifacts"]} == {
                x["kind"]: x["sha256"] for x in prior["vc_artifacts"]}
            if sampling == "on" and row["case"] == "original_client_translation7_only_entry":
                proof_path = OUT / "proof-recheck/repaired-2" / row["mode"] / "receipt.json"
                proof = load(proof_path)
                assert proof["status"] == "KERNEL_CHECKED"
                assert proof["source"] == row["source"] and proof["binds"] == row["binds"]
                assert proof["original_goal"] in row["vc_artifacts"]
                verify_refs(proof)
                status, basis = "PASS", "fresh_complete_original_vc_kernel_check"
                evidence = str(proof_path.relative_to(ROOT))
            elif same_vcs and prior["final_status"] in ("PASS", "FAIL"):
                assert prior["source"] == row["source"] and prior["binds"] == row["binds"]
                proof = prior.get("current_itp") or prior.get("historical_itp")
                assert proof and proof.get("final_status") == prior["final_status"]
                verify_refs(proof)
                status, basis = prior["final_status"], "exact_vc_existing_certificate_reference"
                evidence = proof["receipt"]
        decisions.append({"variant": row["variant"], "case": row["case"], "mode": row["mode"],
                          "status": status, "basis": basis, "evidence": evidence})
    return decisions


def main():
    audit = load(OUT / "audit.json")
    assert audit["passed"]
    tables = defaultdict(list)
    unexpected = []
    for strategy in ("inline", "modular-on", "modular-off"):
        batch = BASE / ("20261020-instance-reuse-" + strategy)
        data = load(batch / "results.json")
        for group in data["summary"]["coverage"]["selected_groups"]:
            for mode in ("off", "on"):
                rows = [x for x in data["runs"] if x["group"] == group and x["mode"] == mode]
                executor = [x["stage_measurements"]["symbolic_executor"] for x in rows
                            if x["stage_measurements"]["symbolic_executor"]]
                final = finalize(rows, group, strategy)
                tables[group].append({"strategy": strategy, "spatial_smt": mode,
                    "executions": len(rows),
                    "native_statuses": dict(Counter(x["current"]["status"] for x in rows)),
                    "final_statuses": dict(Counter(x["status"] for x in final)) if final else None,
                    "decisions": final,
                    "cli_mean_seconds": mean([x["measurement"]["wall_seconds"] for x in rows]),
                    "cli_mean_peak_rss_mib": mean([x["measurement"]["resources"]["max_process_rss_kib"] / 1024 for x in rows]),
                    "executor_mean_seconds": mean([x["wall_seconds"] for x in executor]),
                    "executor_mean_peak_rss_mib": mean([x["peak_rss_kib"] / 1024 for x in executor]),
                    "tokens": 0, "model_calls": 0,
                    "evidence": str((batch / "results.json").relative_to(ROOT))})
        if strategy.startswith("modular"):
            for row in data["runs"]:
                if row["case"] == "original_client_translation12_only_entry":
                    unexpected.append({"group": row["group"], "variant": row["variant"],
                        "case": row["case"], "strategy": strategy, "mode": row["mode"],
                        "expected": row["expected"], "current": row["current"],
                        "final_status": "UNKNOWN", "source": row["source"], "binds": row["binds"],
                        "vc_artifacts": row["vc_artifacts"], "report": row["report"],
                        "reproduction_command": row["measurement"]["command"],
                        "reason": "Weak callee contract does not determine the contents/return required by the client; whole residual remains unresolved. No boundary resource or sampling execution block.",
                        "itp_scope": "Prior auxiliary refutation is diagnostic only; changed new parent VC is not claimed refuted or proved."})
    for group, rows in tables.items():
        folder = OUT / "groups" / group
        save(folder / "result-cost.json", {"group": group, "rows": rows,
             "scope": "Fresh native costs and audited certificate decisions. Historical CN/QCP/Fulminate and reused ITP costs remain in prior group result tables.",
             "averaging": "Per-execution peak then mean; nested CLI/executor times are not additive."})
        columns = ["strategy", "spatial_smt", "executions", "native_statuses", "final_statuses", "cli_mean_seconds",
                   "cli_mean_peak_rss_mib", "executor_mean_seconds", "executor_mean_peak_rss_mib", "tokens"]
        with (folder / "result-cost.csv").open("w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=columns, extrasaction="ignore")
            writer.writeheader()
            writer.writerows(rows)
        text = ["# " + group + " — instance normalization regression", "",
                "Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.", "",
                "| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |", "|---|---|---:|---|---|---:|---:|"]
        text += ["| %s | %s | %d | %s | %s | %.6f | %.3f |" % (x["strategy"], x["spatial_smt"], x["executions"],
                  x["native_statuses"], x["final_statuses"], x["cli_mean_seconds"], x["cli_mean_peak_rss_mib"]) for x in rows]
        (folder / "result-cost.md").write_text("\n".join(text) + "\n")
    proof_rows = []
    for mode in ("off", "on"):
        phases, model_seconds, model_peaks, tokens = [], [], [], 0
        root = OUT / "proof-recheck"
        for folder in (root / mode, root / "repaired" / mode, root / "repaired-2" / mode):
            path = folder / "receipt.json"
            if not path.exists():
                continue
            d = load(path)
            phases += d["compilation"]
            if d.get("kernel_check"):
                phases.append(d["kernel_check"])
            if d.get("model"):
                m = d["model"]
                model_seconds.append(m["wall_seconds"])
                model_peaks.append(m["resources"]["max_process_peak_working_set_bytes"] / 1024**2)
                tokens += sum(u.get("input_tokens", 0) + u.get("output_tokens", 0) for u in m["token_usage"])
        final = load(root / "repaired-2" / mode / "receipt.json")
        assert final["status"] == "KERNEL_CHECKED"
        compile_phases = [p for p in phases if Path(p["command"][0]).name == "coqc"]
        kernel_phases = [p for p in phases if Path(p["command"][0]).name == "coqchk"]
        proof_rows.append({"case": "original_client_translation7_only_entry", "mode": mode,
            "status": "PASS", "all_original_residuals_proved": final["original_targets"],
            "model_calls": len(model_seconds), "tokens": tokens,
            "model_seconds": sum(model_seconds), "model_peak_mib": max(model_peaks),
            "compile_seconds": sum(p["wall_seconds"] for p in compile_phases),
            "compile_peak_mib": max(p["resources"]["max_process_rss_kib"] / 1024 for p in compile_phases),
            "kernel_seconds": sum(p["wall_seconds"] for p in kernel_phases),
            "kernel_peak_mib": max(p["resources"]["max_process_rss_kib"] / 1024 for p in kernel_phases),
            "failed_unchanged_proof_and_model_repairs_included": True})
    save(OUT / "result-cost.json", {"groups": sorted(tables), "native_executions": 5400,
         "native_regression_passed": True, "per_group_tables": "groups/*/result-cost.json",
         "proof_rechecks": proof_rows,
         "proof_mean": {key: mean([x[key] for x in proof_rows]) for key in (
             "tokens", "model_seconds", "model_peak_mib", "compile_seconds", "compile_peak_mib", "kernel_seconds", "kernel_peak_mib")},
         "new_complete_groups_claimed": 0,
         "remaining_unknown": "array_load/original_client_translation12_only_entry"})
    save(ROOT / "benchmark/results/tespec-unexpected/recheck-20261020-instance-reuse.json",
         {"cases": unexpected, "scope": "Same known modular limitation; no newly introduced execution failure."})
    print(json.dumps({"groups": len(tables), "proof_rechecks": proof_rows}))


if __name__ == "__main__":
    main()
