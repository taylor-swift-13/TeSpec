#!/usr/bin/env python3
"""Publish the modular sampling ablation as native evidence, not fresh ITP."""
import csv
import hashlib
import json
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BATCH = ROOT / "benchmark/results/spatial-smt-regressions/20261020-modular-symbolic"
OLD = ROOT / "benchmark/results/spatial-smt-regressions/20261020-complete-groups-modular/results.json"
ITP = ROOT / "benchmark/results/modular-itp/20261020/index.json"
INLINE = ROOT / "benchmark/results/vc-storage-regressions/20261020-modular-symbolic-inline-exact/summary.json"


def load(p):
    return json.loads(p.read_text())


def save(p, d):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(d, ensure_ascii=False, indent=2) + "\n")


def ref(p):
    return {"path": str(p.relative_to(ROOT)), "sha256": hashlib.sha256(p.read_bytes()).hexdigest()}


def check(d):
    p = ROOT / d["path"]
    assert ref(p) == d, p
    return p


def key(x):
    return x["group"], x["variant"], x["case"], x["mode"]


def artifacts(x):
    return {v["kind"]: v["sha256"] for v in x["vc_artifacts"]}


def mean(xs):
    return sum(xs) / len(xs) if xs else None


def main():
    current = load(BATCH / "results.json")
    old = {key(x): x for x in load(OLD)["runs"]}
    certificates = {key(x): x for x in load(ITP)["executions"]}
    assert current["summary"]["run_complete"] and current["summary"]["unchanged_evidence"]
    assert current["summary"]["coverage"]["modular_instantiation"] == "off"
    assert load(INLINE)["passed"]
    rows, certificate_matches = [], []
    for x in current["runs"]:
        y = old[key(x)]
        assert x["source"] == y["source"] and x["binds"] == y["binds"] and x["expected"] == y["expected"]
        for f in [x["source"], x["binds"], x["report"], *x["vc_artifacts"]]:
            check({k: f[k] for k in ("path", "sha256")})
        case = load(check(x["report"]))["results"][0]
        raw = load(Path(case["stdout"]))
        spec = raw["spec_test"]
        assert spec["execution_semantics"] == "modular-symbolic/v1"
        assert spec["modular_instantiation"] == "off" and spec["sampling_events"] == []
        match = (x["current"]["status"] == x["expected"] and
                 x["measurement"]["exit_code"] in (0, 1) and
                 (x["expected"] != "ERROR" or x["comparison"]["ok"]))
        item = dict(x, sampling_events=[], abstraction_events=spec["abstraction_events"],
                    raw=ref(Path(case["stdout"])), result_scope=spec["result_scope"],
                    native_expected_match=match, previous_native_status=y["current"]["status"],
                    execution_strategy="modular", modular_instantiation="off",
                    execution_mode=case["mode"], new_itp_invocations=0,
                    itp_conclusion="NOT_RUN_IN_THIS_NATIVE_ABLATION")
        cert = certificates.get(key(x))
        if cert:
            assert cert["status"] == "KERNEL_CHECKED"
            b = cert["binding"]
            assert b["source"] == x["source"] and b["binds"] == x["binds"]
            assert artifacts(x) == artifacts(y) == artifacts(b)
            assert x["current"]["residual_vcs"] == y["current"]["residual_vcs"]
            check(cert["receipt"])
            item["historical_exact_goal_certificate"] = {
                "receipt": cert["receipt"], "conclusion": cert["final_status"],
                "original_coq_artifacts_byte_equal": True,
                "new_model_or_kernel_measurement": False,
                "scope": "Historical checked target comparison; native UNKNOWN is preserved. No new full-cost certification claimed."}
            certificate_matches.append({k: item[k] for k in ("group", "variant", "case", "mode", "historical_exact_goal_certificate")})
        if x["group"] == "array_load" and x["current"]["status"] == "UNKNOWN":
            item["diagnostic"] = (
                "Boundary frame entailment unresolved; one case reaches exit with the limit still set, two stop at a later read call."
                if x["current"]["reason"] == "modular_boundary_frame_unknown" else
                "Exit VC keeps array root a and entry root a_pre distinct with no connecting equality. Diagnostic reading only; no new ITP verdict.")
        rows.append(item)
    assert len(rows) == 1800 and len(certificate_matches) == 58
    assert Counter((x["previous_native_status"], x["current"]["status"]) for x in rows) == Counter({
        ("PASS", "PASS"): 982, ("FAIL", "FAIL"): 700, ("ERROR", "ERROR"): 46,
        ("UNKNOWN", "UNKNOWN"): 68, ("UNKNOWN", "PASS"): 4})
    groups = []
    for group in current["summary"]["coverage"]["selected_groups"]:
        selected = [x for x in rows if x["group"] == group]
        folder = ROOT / "benchmark/results" / group / "modular-symbolic/20261020"
        costs, modes = [], {}
        for mode in ("off", "on"):
            cases = [x for x in selected if x["mode"] == mode]
            modes[mode] = {"native_statuses": dict(Counter(x["current"]["status"] for x in cases)),
                "executions": len(cases), "native_expected_matches": sum(x["native_expected_match"] for x in cases),
                "historical_exact_goal_certificates": sum("historical_exact_goal_certificate" in x for x in cases)}
            for stage in ("native_cli", "symbolic_executor", "spatial_smt"):
                values = [x["stage_measurements"][stage] for x in cases]
                if stage == "spatial_smt":
                    values = [v for vs in values for v in vs]
                    peaks = [v["sampled_peak_process_rss_kib"] / 1024 for v in values if v.get("sampled_peak_process_rss_kib") is not None]
                elif stage == "native_cli":
                    peaks = [v["resources"]["max_process_rss_kib"] / 1024 for v in values]
                else:
                    peaks = [v["peak_rss_kib"] / 1024 for v in values]
                costs.append({"mode": mode, "stage": stage, "executions": len(values),
                    "mean_seconds": mean([v["wall_seconds"] for v in values]),
                    "mean_per_execution_peak_process_rss_mib": mean(peaks), "mean_tokens": 0,
                    "status": "MEASURED" if values else "NOT_REQUIRED"})
            for stage in ("agent_proof_filling", "coq_compile_and_assumption_audit", "independent_kernel_check"):
                costs.append({"mode": mode, "stage": stage, "executions": 0,
                    "mean_seconds": None, "mean_per_execution_peak_process_rss_mib": None, "mean_tokens": None,
                    "status": "NOT_RUN_NATIVE_ABLATION"})
        result = {"schema": "tespec-modular-symbolic-ablation/v1", "group": group,
            "native_run_complete": True, "full_evaluation_claimed": False,
            "case_pairs": len(selected) // 2, "execution_strategy": "modular", "modular_instantiation": "off",
            "modes": modes, "costs": costs, "cases": selected,
            "scope": "Native ablation only. Historical exact-goal proofs are disclosed, not new ITP calls or costs. Original four-tool group measurements remain unchanged.",
            "cost_policy": "Nested stages are not additive. Display per-execution means of time and maximum process RSS. Concurrent load is not controlled performance evidence."}
        save(folder / "result-cost.json", result)
        with (folder / "result-cost.csv").open("w", newline="") as f:
            w = csv.DictWriter(f, fieldnames=list(costs[0])); w.writeheader(); w.writerows(costs)
        lines = ["# " + group + "：modular 关闭实例化实验", "", result["scope"], "",
            "| 空间 SMT | PASS / FAIL / UNKNOWN / ERROR | 原生预期匹配 | 同目标历史证书 |",
            "| --- | --- | ---: | ---: |"]
        for mode, v in modes.items():
            lines.append("| %s | %s | %d/%d | %d |" % (mode, " / ".join(str(v["native_statuses"].get(k, 0)) for k in ("PASS", "FAIL", "UNKNOWN", "ERROR")), v["native_expected_matches"], v["executions"], v["historical_exact_goal_certificates"]))
        lines += ["", "| 空间 SMT | 阶段 | 平均秒 | 单次峰值 RSS 平均 MiB | 平均 token | 状态 |", "| --- | --- | ---: | ---: | ---: | --- |"]
        fmt = lambda v: "—" if v is None else "%.6f" % v
        for c in costs:
            lines.append("| %s | %s | %s | %s | %s | %s |" % (c["mode"], c["stage"], fmt(c["mean_seconds"]), fmt(c["mean_per_execution_peak_process_rss_mib"]), fmt(c["mean_tokens"]), c["status"]))
        lines += ["", "阶段嵌套，不能相加。未执行新 ITP 的成本不填零；历史证明成本仍保留在旧批次。", "", "[逐例原始证据](result-cost.json)；[原四工具表](../../result-cost.md)。"]
        (folder / "result-cost.md").write_text("\n".join(lines) + "\n")
        groups.append({"group": group, "case_pairs": len(selected) // 2, "modes": modes, "result": ref(folder / "result-cost.json")})
    unmatched = [x for x in rows if not x["native_expected_match"]]
    assert len(unmatched) == 68
    ledger = ROOT / "benchmark/results/tespec-unexpected/recheck-20261020-modular-symbolic.json"
    save(ledger, {"schema": "tespec-unexpected-native-ablation/v1", "executions": 1800,
        "native_unmatched": 68, "historical_exact_goal_proof_matches": 58,
        "new_array_unknowns": 10, "new_itp_invocations": 0, "results": unmatched,
        "scope": "Original expectations unchanged; no full evaluation claim or retrospective new proof cost."})
    summary = {"schema": "tespec-modular-symbolic-ablation-summary/v1", "native_run": ref(BATCH / "results.json"),
        "sampling_baseline": ref(OLD), "inline_exact_regression": ref(INLINE),
        "groups": groups, "executions": 1800, "prior_unknown_to_pass": 4,
        "prior_decided_status_regressions": 0, "native_unknown": 68,
        "historical_exact_goal_proof_matches": certificate_matches,
        "array_load_remaining_unknown": [x for x in unmatched if x["group"] == "array_load"],
        "unexpected_ledger": ref(ledger), "new_itp_invocations": 0,
        "full_evaluation_claimed": False}
    save(BATCH / "ablation-summary.json", summary)
    print(json.dumps({"executions": len(rows), "unknown": len(unmatched), "historical_goal_matches": len(certificate_matches)}))


if __name__ == "__main__":
    main()
