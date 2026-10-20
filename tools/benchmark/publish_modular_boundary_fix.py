#!/usr/bin/env python3
"""Audit and publish modular boundary continuity, exact certificates and costs."""
import csv
import hashlib
import json
import re
import shutil
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / "benchmark/results/spatial-smt-regressions"
PROOFS = ROOT / "benchmark/results/array_load/20261020-boundary-itp"
AUDIT = BASE / "20261020-boundary-fix-audit"
TASKROOT = Path("/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/boundary-itp-20261020")


def load(p):
    return json.loads(p.read_text())


def save(p, d):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(d, ensure_ascii=False, indent=2) + "\n")


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def ref(p):
    return {"path": str(p.relative_to(ROOT)), "sha256": sha(p)}


def check(d):
    p = ROOT / d["path"]
    assert sha(p) == d["sha256"], p
    return p


def mean(xs):
    return sum(xs) / len(xs) if xs else None


def key(x):
    return x["group"], x["variant"], x["case"], x["mode"]


def symbols(t):
    return {n.removeprefix("CNotation.") for n in re.findall(r"^([A-Za-z_][A-Za-z0-9_.]*)\s*:", t, re.M)} - {"Axioms"}


def skeleton(t):
    t = re.sub(r"\(\*.*?\*\)", "", t, flags=re.S)
    t = re.sub(r"Proof\.(.*?)Qed\.", "Proof. Admitted.", t, flags=re.S)
    return re.sub(r"\s+", "", t)


def audit_measure(m):
    assert sha(ROOT / m["stdout"]) == m["stdout_sha256"]
    assert sha(ROOT / m["stderr"]) == m["stderr_sha256"]
    assert load((ROOT / m["stdout"]).parent / "resources.json") == m["resources"]
    assert m["limits"]["address_space_bytes"] == 4294967296


def itp_records():
    records = []
    for binding in load(PROOFS / "tasks.json")["tasks"]:
        i = binding["execution_index"]
        task = TASKROOT / ("execution-%02d" % i)
        folder = PROOFS / task.name
        attempts = sorted(folder.glob("attempt-*/receipt.json"))
        models, compilation, kernels, accepted = [], [], [], []
        canonical = "Require Import ExecutionGoal.\n" + check(binding["original_goal"]).read_text().split("(*----- Function ")[0] + "\n" + (
            "Definition empty_state : naive_C_Rules.model := "
            "{| ConAssertion.s_mem := Mem.empty_mem; ConAssertion.s_STS := Sets.full; ConAssertion.s_token := Sets.empty |}.\n")
        canonical += "".join("Theorem %s : %s.\nProof. Admitted.\n" % tuple(g) for g in binding["checked_theorems"])
        canonical += "".join("Print Assumptions %s.\n" % n for n, _ in binding["checked_theorems"])
        for p in attempts:
            d = load(p)
            assert d["binding"] == binding
            m = d["model"]
            assert m["exit_code"] == 0 and m["requested_model"] == "gpt-6.1-sol" and m["token_usage"]
            assert sha(p.parent / "agent.stdout.jsonl") == m["raw_event_log_sha256"]
            assert sha(p.parent / "prompt.txt") == m["prompt_sha256"]
            assert sha(p.parent / "Candidate.v") == m["candidate_sha256"]
            assert m["locked_goal_and_helper_sha256"]["ExecutionGoal.v"] == binding["original_goal"]["sha256"]
            events = [json.loads(l) for l in (p.parent / "agent.stdout.jsonl").read_text().splitlines() if l.strip()]
            usage = [v["usage"] for v in events if v.get("type") == "turn.completed"]
            assert usage == m["token_usage"]
            assert m["command"][m["command"].index("--model") + 1] == "gpt-6.1-sol"
            models.append(m)
            for v in d["compilation"]:
                audit_measure(v)
                compilation.append(v)
            if d.get("kernel_check"):
                v = d["kernel_check"]
                audit_measure(v)
                assert v["command"][1] == "-silent" and v["command"][-1] == "Candidate"
                assert not any(x in v["command"] for x in ("-norec", "-admit"))
                kernels.append(v)
            if d["status"] == "KERNEL_CHECKED":
                assert d["kernel_check"]["exit_code"] == 0
                text = (p.parent / "proofs/Candidate.v").read_text()
                assert skeleton(text) == skeleton(canonical), "Candidate scope/header/target changed"
                assert not re.search(r"\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b", text)
                assert sha(p.parent / "proofs/Candidate.v") == m["candidate_sha256"]
                assert sha(p.parent / "proofs/ExecutionGoal.v") == binding["original_goal"]["sha256"]
                audit = (ROOT / d["assumption_audit"]["raw"]).read_text()
                assert symbols(audit) == set(d["assumption_audit"]["proof"])
                assert symbols(audit) <= set(d["assumption_audit"]["original"])
                accepted.append((p, d))
        assert len(accepted) == 1
        for r in (binding["report"], binding["source"], binding["binds"]):
            check(r)
        p, final = accepted[0]
        seconds = {"agent_proof_filling": sum(m["wall_seconds"] for m in models),
            "coq_compile_and_assumption_audit": sum(m["wall_seconds"] for m in compilation),
            "independent_kernel_check": sum(m["wall_seconds"] for m in kernels)}
        peaks = {"agent_proof_filling": max(m["resources"]["max_process_peak_working_set_bytes"] for m in models) / 1048576,
            "coq_compile_and_assumption_audit": max(m["resources"]["max_process_rss_kib"] for m in compilation) / 1024,
            "independent_kernel_check": max(m["resources"]["max_process_rss_kib"] for m in kernels) / 1024}
        seconds["itp_total"] = sum(seconds.values())
        peaks["itp_total"] = max(peaks.values())
        tokens = sum(e["input_tokens"] + e["output_tokens"] for m in models for e in m["token_usage"])
        auxiliary = binding["decisive_refuted_original_vc"] is not None
        record = {"binding": binding, "receipt": ref(p), "attempts": len(attempts), "model_calls": len(models),
            "new_measured": True, "seconds": seconds, "peak_process_memory_mib": peaks, "tokens": tokens,
            "proof_status": "KERNEL_CHECKED", "final_status": "UNKNOWN" if auxiliary else "PASS",
            "all_original_residual_vcs_proved": not auxiliary,
            "assumption_audit": final["assumption_audit"],
            "publication_audit": ("The controller labelled an auxiliary pure split refutation FAIL. Full original parent VCs retain spatial alternatives, so that is NOT decisive for the whole execution. Reject promotion and retain UNKNOWN; original receipt is preserved."
                if auxiliary else "All original residual targets and entry SAT proved; no added assumptions beyond original statement parameters.")}
        records.append(record)
        for suffix in ("template.txt", "binding.json"):
            if (task / suffix).exists():
                shutil.copyfile(task / suffix, folder / ("task-" + suffix))
    assert len(records) == 8 and sum(x["model_calls"] for x in records) == 17
    result = {"schema": "tespec-boundary-itp-audited/v1", "executions": records, "attempted_executions": 8,
        "new_complete_executions": 4, "partial_diagnostic_executions": 4,
        "model_calls": sum(x["model_calls"] for x in records), "tokens": sum(x["tokens"] for x in records),
        "mean_seconds": {k: mean([x["seconds"][k] for x in records]) for k in records[0]["seconds"]},
        "mean_peak_process_memory_mib": {k: mean([x["peak_process_memory_mib"][k] for x in records]) for k in records[0]["seconds"]},
        "mean_tokens": mean([x["tokens"] for x in records]),
        "scope": "All attempted executions, including every failed model/compile repair. Four weak-client parent obligations remain unresolved after ITP. Model memory is Windows client PeakWorkingSet, Coq is GNU time single-process RSS; no remote GPU memory."}
    save(PROOFS / "index.json", result)
    if (TASKROOT / "controller-status.json").exists():
        shutil.copyfile(TASKROOT / "controller-status.json", PROOFS / "audit/controller-status.json")
    return result


def main():
    itp = itp_records()
    new = {(x["binding"]["modular_instantiation"], x["binding"]["case"], x["binding"]["mode"]): x for x in itp["executions"]}
    old = {key(x): x for x in load(ROOT / "benchmark/results/modular-itp/20261020/index.json")["executions"]}
    all_rows, groups = [], []
    native_runs = {}
    for sampling in ("on", "off"):
        p = BASE / ("20261020-modular-boundary-" + sampling) / "results.json"
        data = load(p)
        assert data["summary"]["run_complete"] and data["summary"]["unchanged_evidence"]
        native_runs[sampling] = ref(p)
        for row in data["runs"]:
            case = load(check(row["report"]))["results"][0]
            raw = load(Path(case["stdout"]))
            assert raw["spec_test"]["modular_instantiation"] == sampling
            assert not (row["current"]["reason"] in ("contract_instantiation_unknown", "modular_boundary_frame_unknown"))
            assert row["current"]["execution_completed"] or row["expected"] == "ERROR"
            for event in case["sampling_events"]:
                if event["status"] == "SYMBOLIC_FALLBACK":
                    assert event["constraint_state"] == event["selected_state"]
            item = dict(row, modular_instantiation=sampling, execution_mode=case["mode"],
                raw=ref(Path(case["stdout"])), sampling_events=case["sampling_events"],
                abstraction_events=case["abstraction_events"], final_status=row["current"]["status"],
                itp_status="NOT_REQUIRED", result_scope=case["result_scope"])
            cert = old.get(key(row))
            if cert:
                b = cert["binding"]
                assert b["source"] == row["source"] and b["binds"] == row["binds"]
                assert [(x["kind"], x["sha256"]) for x in b["vc_artifacts"]] == [(x["kind"], x["sha256"]) for x in row["vc_artifacts"]]
                assert b["expected"] == row["expected"] and row["current"]["residual_vcs"] == load(check(b["report"]))["results"][0]["residual_vcs"]
                check(cert["receipt"])
                item.update(final_status=cert["final_status"], itp_status="REUSED_EXACT_ORIGINAL_TARGET_KERNEL_CERTIFICATE",
                    historical_itp=cert, historical_itp_metrics_are_new_measurements=False)
            current_proof = new.get((sampling, row["case"], row["mode"])) if row["group"] == "array_load" else None
            if current_proof:
                assert current_proof["binding"]["report"] == row["report"]
                item.update(final_status=current_proof["final_status"], itp_status=("ALL_RESIDUALS_KERNEL_PROVED" if current_proof["all_original_residual_vcs_proved"] else "PARTIAL_AUXILIARY_REFUTATION_PARENT_UNRESOLVED"), current_itp=current_proof)
            item["matched"] = (item["final_status"] == row["expected"] and row["measurement"]["exit_code"] in (0, 1)
                and (row["expected"] != "ERROR" or row["comparison"]["ok"]))
            if not item["matched"]:
                item["classification"] = "MODULAR_WEAK_CALLEE_CONTRACT_PARENT_VC_UNRESOLVED_AFTER_ITP"
                item["cause"] = "The callee contract leaves the return value and output list unconstrained. Original client assertions require 0/1/2 and the original contents. Native execution now completes; auxiliary pure goals are refutable, but full parent VC alternatives have not been decided. This is not a counterexample to the actual inlined read body."
            all_rows.append(item)
    assert len(all_rows) == 3600
    assert sum(x["itp_status"] == "REUSED_EXACT_ORIGINAL_TARGET_KERNEL_CERTIFICATE" for x in all_rows) == 116
    for group in sorted({x["group"] for x in all_rows}):
        rows = [x for x in all_rows if x["group"] == group]
        folder = ROOT / "benchmark/results" / group / "modular-boundary/20261020"
        configs, costs = {}, []
        for sampling in ("on", "off"):
            for mode in ("off", "on"):
                chosen = [x for x in rows if x["modular_instantiation"] == sampling and x["mode"] == mode]
                label = "sampling-" + sampling + "/spatial-" + mode
                configs[label] = {"executions": len(chosen), "native_counts": dict(Counter(x["current"]["status"] for x in chosen)),
                    "final_counts": dict(Counter(x["final_status"] for x in chosen)), "matches": sum(x["matched"] for x in chosen),
                    "unresolved_after_itp": sum(x["final_status"] == "UNKNOWN" for x in chosen)}
                for stage in ("native_cli", "symbolic_executor", "spatial_smt"):
                    v = [x["stage_measurements"][stage] for x in chosen]
                    if stage == "spatial_smt":
                        v = [m for ms in v for m in ms]
                        peaks = [m["sampled_peak_process_rss_kib"] / 1024 for m in v if m.get("sampled_peak_process_rss_kib") is not None]
                    elif stage == "native_cli":
                        peaks = [m["resources"]["max_process_rss_kib"] / 1024 for m in v]
                    else:
                        peaks = [m["peak_rss_kib"] / 1024 for m in v]
                    costs.append({"configuration": label, "stage": stage, "executions": len(v),
                        "mean_seconds": mean([m["wall_seconds"] for m in v]), "mean_per_execution_peak_memory_mib": mean(peaks),
                        "mean_tokens": 0, "measurement": "CURRENT" if v else "NOT_REQUIRED"})
                proofs = [x["current_itp"] for x in chosen if x.get("current_itp")]
                for stage in ("agent_proof_filling", "coq_compile_and_assumption_audit", "independent_kernel_check", "itp_total"):
                    costs.append({"configuration": label, "stage": stage, "executions": len(proofs),
                        "mean_seconds": mean([p["seconds"][stage] for p in proofs]),
                        "mean_per_execution_peak_memory_mib": mean([p["peak_process_memory_mib"][stage] for p in proofs]),
                        "mean_tokens": mean([p["tokens"] if stage in ("agent_proof_filling", "itp_total") else 0 for p in proofs]),
                        "measurement": "CURRENT_ALL_ATTEMPTS" if proofs else "NOT_RUN_OR_REUSED"})
        result = {"schema": "tespec-modular-boundary-group/v1", "group": group, "case_pairs": len(rows) // 4,
            "native_run_complete": True, "verdicts_complete": all(x["final_status"] != "UNKNOWN" for x in rows),
            "all_expected_matched": all(x["matched"] for x in rows), "configurations": configs, "costs": costs, "cases": rows,
            "base_four_tool_table": "benchmark/results/" + group + "/result-cost.json",
            "scope": "Boundary fix supplement. Original CN/QCP/Fulminate and inline evidence unchanged. Exact-target historical proof costs stay explicitly historical; current ITP costs include all failed attempts. UNKNOWN after partial auxiliary refutation is not successful detection."}
        save(folder / "result-cost.json", result)
        with (folder / "result-cost.csv").open("w", newline="") as f:
            w = csv.DictWriter(f, fieldnames=list(costs[0])); w.writeheader(); w.writerows(costs)
        lines = ["# " + group + "：modular 边界修复结果与成本", "", result["scope"], "",
            "| 配置 | 原生 PASS / FAIL / UNKNOWN / ERROR | 最终 PASS / FAIL / UNKNOWN / ERROR | 预期匹配 |",
            "| --- | --- | --- | ---: |"]
        for label, c in configs.items():
            fmtcounts = lambda counts: " / ".join(str(counts.get(k, 0)) for k in ("PASS", "FAIL", "UNKNOWN", "ERROR"))
            lines.append("| %s | %s | %s | %d/%d |" % (label, fmtcounts(c["native_counts"]), fmtcounts(c["final_counts"]), c["matches"], c["executions"]))
        lines += ["", "| 配置 | 阶段 | 次数 | 平均秒 | 单次峰值内存平均 MiB | 平均 token | 测量范围 |", "| --- | --- | ---: | ---: | ---: | ---: | --- |"]
        fmt = lambda v: "—" if v is None else "%.6f" % v
        for c in costs:
            lines.append("| %s | %s | %d | %s | %s | %s | %s |" % (c["configuration"], c["stage"], c["executions"], fmt(c["mean_seconds"]), fmt(c["mean_per_execution_peak_memory_mib"]), fmt(c["mean_tokens"]), c["measurement"]))
        lines += ["", "CLI、执行器和空间SMT为嵌套阶段；ITP总计与分项重叠，不能重复相加。模型内存为Windows客户端PeakWorkingSet，Coq为GNU time单进程RSS。历史证明成本见原modular表，未冒充本轮新调用。", "", "[逐次证据](result-cost.json)；[原四工具表](../../result-cost.md)；[历史modular证明成本](../../modular/20261020/result-cost.md)。"]
        (folder / "result-cost.md").write_text("\n".join(lines) + "\n")
        groups.append({"group": group, "case_pairs": len(rows) // 4, "configurations": configs,
            "verdicts_complete": result["verdicts_complete"], "all_expected_matched": result["all_expected_matched"], "result": ref(folder / "result-cost.json")})
    unresolved = [x for x in all_rows if not x["matched"]]
    assert len(unresolved) == 4 and all(x["case"] == "original_client_translation12_only_entry" for x in unresolved)
    save(ROOT / "benchmark/results/tespec-unexpected/recheck-20261020-modular-boundary-fix.json", {
        "schema": "tespec-modular-boundary-unexpected/v1", "executions": 3600, "unmatched": 4,
        "results": unresolved, "resolved_native_unknowns": [x for x in all_rows if x["current"]["status"] == "UNKNOWN" and x["matched"]],
        "scope": "Expected input classifications unchanged; weak-client whole execution remains UNKNOWN after auxiliary-only ITP evidence."})
    diagnostics = []
    for batch in sorted(BASE.glob("20261020-boundary-*")):
        if batch.name == "20261020-boundary-fix-audit":
            continue
        for path in sorted(batch.glob("array_load/case-*/*/receipt.json")):
            d = load(path)
            diagnostics.append({"case": d["case"], "mode": d["mode"], "status": d["current"]["status"], "receipt": ref(path),
                "seconds": d["measurement"]["wall_seconds"], "peak_process_rss_kib": d["measurement"]["resources"]["max_process_rss_kib"]})
    repair_means = []
    for mode in ("off", "on"):
        selected = [x for x in diagnostics if x["mode"] == mode]
        ids = sorted({x["case"] for x in selected})
        repair_means.append({"spatial_smt": mode, "logical_clients": len(ids), "actual_invocations": len(selected),
            "mean_accumulated_seconds_per_client": mean([sum(x["seconds"] for x in selected if x["case"] == name) for name in ids]),
            "mean_max_process_rss_mib_per_client": mean([max(x["peak_process_rss_kib"] for x in selected if x["case"] == name) / 1024 for name in ids])})
    save(AUDIT / "development-native-diagnostics.json", {"attempts": diagnostics, "means": repair_means,
        "scope": "All intermediate executor repair diagnostics, including failed attempts, sampling off. Not additional independent benchmark inputs or controlled timing samples."})
    summary = {"schema": "tespec-modular-boundary-fix-summary/v1", "groups": groups, "native_runs": native_runs,
        "configurations": {label: {"counts": dict(Counter(x["final_status"] for x in all_rows if "sampling-" + x["modular_instantiation"] + "/spatial-" + x["mode"] == label)),
            "matched": sum(x["matched"] for x in all_rows if "sampling-" + x["modular_instantiation"] + "/spatial-" + x["mode"] == label)} for label in groups[0]["configurations"]},
        "no_execution_block_from_sampling_or_boundary_frame": True,
        "new_itp": ref(PROOFS / "index.json"), "historical_exact_target_certificates_reused": 116,
        "remaining_unknown": 4, "current_model_calls": itp["model_calls"], "current_tokens": itp["tokens"],
        "development_native_invocations": len(diagnostics), "scope": "21 groups, 900 source/input pairs, four modular configurations. No original expectations or primary four-tool completion flags altered."}
    save(AUDIT / "summary.json", summary)
    print(json.dumps({"remaining_unknown": 4, "model_calls": itp["model_calls"], "tokens": itp["tokens"], "native_diagnostic_invocations": len(diagnostics)}))


if __name__ == "__main__":
    main()
