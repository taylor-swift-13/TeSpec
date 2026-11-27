#!/usr/bin/env python3
"""Publish identical current result/cost views without discarding archived evidence."""
import argparse
from collections import Counter
import csv
import io
import json
from pathlib import Path

from organize_tespec_routes import RESULTS, ROOT, read, reference, fingerprint

BRANCHES = ("pure_queries", "evaluated_true", "evaluated_false", "smt_fallback")
COLUMNS = ("tool", "strategy", "stage", "basis", "result", "measured", "required", "unit",
           "wall_seconds", "max_process_rss_kib", "input_tokens", "output_tokens", "tokens",
           "branch_records", *BRANCHES, "evidence")


def aggregate(records, key, op=sum):
    values = [r.get(key) for r in records]
    return op(values) if values and all(isinstance(v, (float, int)) for v in values) else None


def line(**values):
    return {key: values.get(key) for key in COLUMNS}


def historic(base, table):
    rows = []
    for tool in ("cn", "qcp", "fulminate"):
        result_path = base / tool / "results.json"
        result = read(result_path)
        summary = result.get("summary", {})
        outcome = result.get("verdict") or json.dumps(summary, ensure_ascii=False, sort_keys=True)
        stats_path = base / tool / "statistics.json"
        stats = read(stats_path)
        for r in (c for c in table["costs"] if c["tool"] == tool):
            statuses = summary.get("native_status_counts", {})
            if (tool == "fulminate" and r["stage"] == "单独运行测试" and statuses
                    and set(statuses) == {"NOT_BUILT"} and r["wall_seconds"] is None):
                rows.append(line(tool=tool, stage=r["stage"], basis="tool_receipt", result="NOT_BUILT",
                                 measured=0, required=summary["case_pairs"], unit="no executable produced",
                                 input_tokens=0, output_tokens=0, tokens=0, evidence=str(result_path.relative_to(ROOT))))
                continue
            peak = r["peak_process_memory_mib"]
            usage = stats.get("token_usage") or {}
            if not isinstance(usage, dict) or r["tokens"] != usage.get("total_tokens"):
                usage = {}
            total = r["tokens"]
            rows.append(line(tool=tool, stage=r["stage"], basis="archived_cost", result=r["status"],
                             unit=r["unit"], wall_seconds=r["wall_seconds"],
                             max_process_rss_kib=None if peak is None else peak * 1024,
                             input_tokens=usage.get("input_tokens", 0 if total == 0 else None),
                             output_tokens=usage.get("output_tokens", 0 if total == 0 else None),
                             tokens=total, evidence=r.get("source") or str(stats_path.relative_to(ROOT))))
        if tool == "cn" and stats.get("current_verification"):
            m = stats["current_verification"]
            rows.append(line(tool=tool, stage="主程序验证（当前兼容头文件）", basis="tool_receipt", result=outcome,
                             unit="one verification", measured=1, required=1, wall_seconds=m["wall_seconds"],
                             max_process_rss_kib=m["max_process_rss_kib"], input_tokens=0, output_tokens=0,
                             tokens=m["tokens"], evidence=str(stats_path.relative_to(ROOT))))
        if tool == "qcp" and isinstance(result.get("certificate"), dict) and not stats.get("cost_ledger"):
            ref = result["certificate"]
            if fingerprint(ROOT / ref["path"]) != ref["sha256"]:
                raise ValueError("Changed QCP certificate")
            proof = read(ROOT / ref["path"])
            m = proof["metrics"]
            rows.append(line(tool=tool, stage="完整原始目标证明（含历史尝试）", basis="proof_receipt", result=outcome,
                             unit="charged proof attempts; missing fields unknown", wall_seconds=m["wall_seconds"],
                             max_process_rss_kib=m["max_process_rss_kib"], tokens=m["tokens"], evidence=ref["path"]))
        generation_path = base / tool / "proof/generation-replay.json"
        if tool == "qcp" and generation_path.is_file():
            gen = read(generation_path)
            attempts = [*gen.get("previous_attempts", []), gen]
            rows.append(line(tool=tool, stage="当前 QCP 原始目标生成（含全部尝试）", basis="local_replay",
                             result="EXACT_GOAL_MATCH" if gen["exact_goal_match"] else "DIFFERENT_GOAL",
                             unit="native generation; compare against archived certificate", measured=len(attempts),
                             wall_seconds=aggregate(attempts, "wall_seconds"), max_process_rss_kib=aggregate(attempts, "max_process_rss_kib", max),
                             input_tokens=0, output_tokens=0, tokens=0, evidence=str(generation_path.relative_to(ROOT))))
        replay_path = base / tool / "proof/local-replay.json"
        if tool == "qcp" and replay_path.is_file():
            replay = read(replay_path)
            if replay.get("certificate") != result.get("certificate"):
                raise ValueError("QCP replay and certificate differ")
            for stage in ("coq", "kernel"):
                ms = [m for m in replay["stages"] if m["stage"] == stage]
                if ms:
                    rows.append(line(tool=tool, stage=stage, basis="local_replay", result=replay["status"],
                                     unit="local replay", measured=len(ms), wall_seconds=aggregate(ms,"wall_seconds"),
                                     max_process_rss_kib=aggregate(ms,"max_process_rss_kib",max), input_tokens=0,
                                     output_tokens=0, tokens=0, evidence=str(replay_path.relative_to(ROOT))))
        if isinstance(stats.get("cost_ledger"), dict):
            ref = stats["cost_ledger"]
            if fingerprint(ROOT / ref["path"]) != ref["sha256"]:
                raise ValueError("Changed cost ledger")
            grouped = {}
            for measurement in read(ROOT / ref["path"])["measurements"]:
                if measurement["tool"] == tool:
                    grouped.setdefault(measurement["stage"], []).append(measurement)
            if grouped:
                rows = [r for r in rows if r["tool"] != tool]
            for stage, ms in grouped.items():
                token = aggregate(ms, "tokens")
                rows.append(line(tool=tool, stage=stage, basis="tool_receipt", result=outcome,
                                 unit="stage total", measured=len(ms), required=len(ms),
                                 wall_seconds=aggregate(ms, "wall_seconds"), max_process_rss_kib=aggregate(ms, "max_process_rss_kib", max),
                                 input_tokens=0 if token == 0 else None, output_tokens=0 if token == 0 else None,
                                 tokens=token, evidence=ref["path"]))
        if tool == "fulminate" and isinstance(stats.get("stages"), dict):
            rows = [r for r in rows if r["tool"] != tool]
            for stage, m in stats["stages"].items():
                rows.append(line(tool=tool, stage=stage, basis="tool_receipt", result=outcome,
                                 unit="stage total", measured=m["n"], required=m["n"],
                                 wall_seconds=m["wall_seconds_total"], max_process_rss_kib=m["max_process_rss_kib"],
                                 input_tokens=0, output_tokens=0, tokens=m["tokens"], evidence=str(stats_path.relative_to(ROOT))))
        standalone = base / "qcp/standalone/receipt.json"
        if tool == "qcp" and standalone.is_file():
            profile = read(standalone)
            for m in [*profile["stages"], *([profile["prior_attempt_cost"]] if profile.get("prior_attempt_cost") else [])]:
                rows.append(line(tool=tool, stage=m["stage"], basis="standalone_qcp", result=profile["status"],
                                 unit="measured invocations", measured=m["invocations"], required=m["invocations"],
                                 wall_seconds=m["wall_seconds"], max_process_rss_kib=m["max_process_rss_kib"],
                                 input_tokens=0, output_tokens=0, tokens=m["total_tokens"], evidence=str(standalone.relative_to(ROOT))))
        if tool == "qcp" and result.get("standalone_generation_exact_goal_match"):
            rp = result["standalone_generation"]
            if reference(ROOT/rp["path"]) != rp:
                raise ValueError("different standalone QCP generator receipt")
            gen=read(ROOT/rp["path"])
            rows.append(line(tool="qcp",basis="standalone_qcp",stage="standalone_generation",result="EXACT_GOAL_MATCH",
                             unit="one verification",measured=1,required=1,wall_seconds=gen["wall_seconds"],max_process_rss_kib=gen["max_process_rss_kib"],
                             tokens=0,input_tokens=0,output_tokens=0,evidence=rp["path"]))
        if tool == "fulminate" and "locked_original_build_cost" in stats:
            original = stats["locked_original_build_cost"]
            entries = [("locked_original_build", original["attempts"], original["wall_seconds"], original["max_process_rss_kib"]),
                       ("compatibility_instrument_compile_first_run", stats["pipeline_attempts"], stats["instrument_compile_initial_execution_wall_seconds_total"], stats["pipeline_peak_process_rss_kib"]),
                       ("compatibility_execution", stats["test_attempts"], stats["test_execution_wall_seconds_total"], stats["test_peak_process_rss_kib"])]
            for stage, attempt in stats.get("earlier_compatibility_attempt_costs",{}).items():
                if attempt["attempts"]:
                    entries.append(("prior_compatibility_"+stage, attempt["attempts"], attempt["wall_seconds"], attempt["max_process_rss_kib"]))
            for stage,count,wall,rss in entries:
                rows.append(line(tool=tool,stage=stage,basis="fulminate_compatibility",result="MEASURED",
                                 unit="measured invocations",measured=count,required=count,wall_seconds=wall,
                                 max_process_rss_kib=rss,tokens=0,input_tokens=0,output_tokens=0,evidence=str(stats_path.relative_to(ROOT))))
    return rows


def measure_status(data, required):
    """Separate an invoiced attempt from a complete time/RSS/token observation."""
    complete = sum(
        m.get("wall_seconds") is not None and m.get("tokens") is not None
        and (not m.get("invoked", True) or m.get("max_process_rss_kib") is not None)
        for m in data
    )
    if not required:
        return "NOT_REQUIRED", complete
    if not data:
        return "PENDING", complete
    if complete < len(data):
        return "PARTIAL_METRICS", complete
    return ("MEASURED" if complete == required else "PARTIAL"), complete


def timeout_diagnostics(cases, strategy, path):
    diagnostics = [r["additional_timeout_diagnostic"] for r in cases if r.get("additional_timeout_diagnostic")]
    rows = []
    for budget in sorted({d["budget_seconds"] for d in diagnostics}):
        attempts = [d for d in diagnostics if d["budget_seconds"] == budget]
        for stage, field in (("layout_prepare", "layout_cost"), ("native", "native_cost"), ("auto", "auto_cost")):
            costs = [d[field] for d in attempts if d[field]]
            required = len(costs) if stage == "auto" else len(attempts)
            status, measured = measure_status(costs, required)
            branches = [d["branch_evaluation"] for d in attempts if d["branch_evaluation"] is not None]
            output = {k: sum(b[k] for b in branches) if branches else None for k in BRANCHES}
            rows.append(line(tool="tespec", strategy=strategy, stage=stage, basis=f"timeout_diagnostic_{budget}s",
                             unit="additional attempts only", result=status, measured=measured, required=required,
                             wall_seconds=aggregate(costs, "wall_seconds") if required else 0,
                             max_process_rss_kib=aggregate(costs, "max_process_rss_kib", max),
                             input_tokens=0, output_tokens=0, tokens=aggregate(costs, "tokens") if required else 0,
                             evidence=str(path.relative_to(ROOT)),
                             **({"branch_records": len(branches), **output} if stage == "native" else {})))
    return rows


def resource_replay_stages(receipt):
    """Each separately metered retry is charged once, including unsuccessful compilation."""
    seen = set()
    for run in receipt.get("resource_protection_replays", []):
        key = (run["original_attempt_sha256"], tuple(step["log_sha256"] for step in run["stages"]))
        if key not in seen:
            seen.add(key)
            yield from run["stages"]


def latest_route_stages(base, strategy, required):
    auto_path = base / "tespec/latest-auto.json"
    itp_path = base / "tespec/latest-itp.json"
    auto = read(auto_path)["executions"] if auto_path.is_file() else {}
    itp = read(itp_path)["executions"] if itp_path.is_file() else {}
    rows = []
    for stage in ("auto", "itp_model", "itp_coq", "itp_kernel", "itp_binding", "shared_check"):
        proof_stage = stage != "auto"
        source = itp_path if proof_stage else auto_path
        group = itp if proof_stage else auto
        data = [r[stage] for r in group.values() if r["strategy"] == strategy
                and not r.get("needs_model") and r.get(stage) is not None]
        if stage in ("itp_binding","shared_check") and not data:
            continue
        denominator = len(data) if stage in ("itp_binding","shared_check") else required
        status, measured = measure_status(data, denominator)
        def cost(key):
            if not required:
                return 0
            if key in ("input_tokens", "output_tokens"):
                return aggregate([{**r, key:0 if r.get("tokens") == 0 else r.get(key)} for r in data], key)
            return aggregate(data, key)
        rows.append(line(tool="tespec", strategy=strategy, stage=stage, basis="shared_original_check" if stage == "shared_check" else "latest_same_input_and_vc",
                         result=status, measured=measured, required=denominator, unit="single-input residual execution",
                         wall_seconds=cost("wall_seconds"), tokens=cost("tokens"),
                         input_tokens=cost("input_tokens"), output_tokens=cost("output_tokens"),
                         max_process_rss_kib=aggregate([r for r in data if r.get("invoked", True)], "max_process_rss_kib", max),
                         evidence=str(source.relative_to(ROOT)) if source.is_file() else None))
    checker_replays = {}
    for r in itp.values():
        if r["strategy"] == strategy:
            for step in resource_replay_stages(r):
                checker_replays.setdefault(step["stage"], []).append(step)
    for stage, checks in checker_replays.items():
        rows.append(line(tool="tespec",strategy=strategy,stage=stage,basis="current_resource_recheck_subset",result="MEASURED",
                         measured=len(checks),required=len(checks),unit="included in measured ITP checker phase",
                         wall_seconds=aggregate(checks,"wall_seconds"),max_process_rss_kib=aggregate(checks,"max_process_rss_kib",max),
                         tokens=0,input_tokens=0,output_tokens=0,evidence=str(itp_path.relative_to(ROOT))))
    extra_runs = {}
    for r in auto.values():
        if r["strategy"] != strategy:
            continue
        for profile, attempt in r.get("additional_profile_runs", {}).items():
            extra_runs.setdefault("same_input_profile_recheck_" + profile[:8], []).append(attempt["auto"])
        for run in r.get("unattributed_profile_diagnostics", []):
            extra_runs.setdefault("source_transition_diagnostic", []).append(run["auto"])
        for name in ("same_budget_diagnostic","additional_budget_diagnostic"):
            if name in r:
                extra_runs.setdefault(name, []).append(r[name]["auto"])
    for label, runs in extra_runs.items():
        rows.append(line(tool="tespec",strategy=strategy,stage="auto",basis=label,result="MEASURED",
                         measured=len(runs),required=len(runs),unit="supplemental per-input replay",
                         wall_seconds=aggregate(runs,"wall_seconds"),max_process_rss_kib=aggregate(runs,"max_process_rss_kib",max),
                         tokens=0,input_tokens=0,output_tokens=0,evidence=str(auto_path.relative_to(ROOT))))
    return rows


def tool_results(base, summaries, paired):
    results = []
    for tool in ("cn", "qcp", "fulminate"):
        path = base / tool / "results.json"
        source = read(path)
        summary = source.get("summary", {})
        if tool == "fulminate":
            cases = source.get("cases", source.get("runs", []))
            matches = sum(r.get("matches_expected", r.get("correct", r.get("actual", r.get("status")) == r["expected"]))
                          for r in cases)
            count = summary.get("case_pairs", summary.get("input_pairs", len(cases)))
            if not cases or len(cases) != count or matches != summary.get("correct", summary.get("expected_matches", matches)):
                raise ValueError(f"inconsistent finite test summary in {path}")
            item = {"result": f"{matches}/{count}", "test_pairs": count, "expected_matches": matches}
        else:
            item = {"result": source["verdict"], "test_pairs": None, "expected_matches": None}
        results.append({"tool": tool, **item, "result_source": str(path.relative_to(ROOT)),
                        "statistics_source": str((path.parent / "statistics.json").relative_to(ROOT))})
    for summary in summaries:
        strategy = summary["strategy"]
        if paired is not None:
            auto = paired["auto_" + strategy]
            results.append({"tool": "tespec", "route": "auto", "strategy": strategy,
                            "result": f"{auto['matches']}/{auto['executions']}", "executions": auto["executions"],
                            "expected_matches": auto["matches"], "result_source": "benchmark/results/paired-tool-comparison.json"})
        latest = paired.get("latest_" + strategy) if paired else None
        if latest is not None:
            outcome = {s[4:]:v for s,v in latest.items() if s in ("itp_PASS","itp_FAIL","itp_UNKNOWN","itp_CRASH","itp_ERROR")}
            results.append({"tool":"tespec", "route":"itp", "strategy":strategy,
                            "executions":summary["executions"], "residual_executions":latest["residual"],
                            "expected_matches":latest["total_itp_matches"], "receipts":latest["attempted"],
                            "native_only_executions":latest["native_only_executions"], "native_only_matches":latest["native_matches"],
                            "awaiting":latest.get("awaiting",0), "residual_statuses":outcome,
                            "result_source":"benchmark/results/paired-tool-comparison.json"})
            continue
        results.append({"tool": "tespec", "route": "itp", "strategy": strategy,
                        "result": summary["itp_statuses"], "executions": summary["executions"],
                        "expected_matches": summary["itp_matches"], "residual_executions": summary["residual_executions"],
                        "receipts": summary["itp_receipts"], "result_source": str((base / "tespec/current-itp.json").relative_to(ROOT))})
    return results


def display(value):
    if value is None:
        return "—"
    if isinstance(value, float):
        return f"{value:.4f}"
    return str(value).replace("|", "\\|").replace("\n", " ")


def publish(group):
    base = RESULTS / group
    table_file = base / "result-cost.json"
    table = read(table_file)
    path = base / "tespec/current-executions.json"
    current = read(path)
    receipt_file = base / "tespec/current-itp.json"
    proofs = read(receipt_file)["executions"] if receipt_file.is_file() else {}
    rows = historic(base, table)
    summaries = []
    for strategy in ("inline", "modular"):
        items = [r for r in current["executions"] if r["strategy"] == strategy]
        needed = [r for r in items if r["auto_status"] != "NOT_RUN"]
        recorded = [proofs[r["native_report_sha256"]] for r in needed if r["native_report_sha256"] in proofs]
        stage_file = str(path.relative_to(ROOT))
        attempted = [r for r in recorded if not r.get("needs_model")]
        for stage, required, data, source in [
            ("native", len(items), [r["native"] for r in items if r.get("native")], stage_file),
            ("auto", len(needed), [r["auto"] for r in needed if r.get("auto")], stage_file),
            *[(name, len(needed), [r[name] for r in attempted if r.get(name)], str(receipt_file.relative_to(ROOT)))
              for name in ("itp_model", "itp_coq", "itp_kernel")],
        ]:
            branch = [r["branch_evaluation"] for r in items if r.get("branch_evaluation") is not None]
            counts = ({k: sum(c[k] for c in branch) if branch else None for k in BRANCHES}
                      | {"branch_records": len(branch)}) if stage == "native" else {}
            status, measured = measure_status(data, required)
            zero = not required
            def tokens(key):
                if zero:
                    return 0
                return aggregate([{**r, key: 0 if r.get("tokens") == 0 else r.get(key)} for r in data], key)
            rows.append(line(tool="tespec", strategy=strategy, stage=stage, basis="current_execution",
                             result=status, unit="measured subset total; largest single-process peak",
                             measured=measured, required=required, wall_seconds=0 if zero else aggregate(data, "wall_seconds"),
                             max_process_rss_kib=aggregate([m for m in data if m.get("invoked", True)], "max_process_rss_kib", max),
                             input_tokens=tokens("input_tokens"), output_tokens=tokens("output_tokens"), tokens=tokens("tokens"),
                             evidence=source if data else None, **counts))
        remeasured = [m for r in recorded for run in r.get("resource_replays", []) for m in run["stages"]]
        if remeasured:
            by_stage = sorted({m["stage"] for m in remeasured})
            for name in by_stage:
                ms = [m for m in remeasured if m["stage"] == name]
                rows.append(line(tool="tespec",strategy=strategy,stage=name,basis="historical_stage_remeasurement",
                                 result="MEASURED", measured=len(ms),required=len(ms),unit="additional timed checker invocation",
                                 wall_seconds=aggregate(ms,"wall_seconds"),max_process_rss_kib=aggregate(ms,"max_process_rss_kib",max),
                                 tokens=0,input_tokens=0,output_tokens=0,evidence=str(receipt_file.relative_to(ROOT))))
        outcomes = Counter()
        decided = 0
        for r in items:
            if r["auto_status"] == "NOT_RUN":
                final = r["native_status"]
                match = r["expected_match"]
            else:
                proof = proofs.get(r["native_report_sha256"], {})
                final = "PENDING" if not proof or proof.get("needs_model") else proof["final_status"]
                match = (final in ("PASS", "FAIL") and final == r["expected"]
                         or final == "CRASH" and proof.get("expected_crash_match") is True)
            outcomes[final] += 1
            decided += int(match)
        summaries.append(dict(strategy=strategy, executions=len(items), auto_statuses=dict(Counter(r["effective_status"] for r in items)),
                              auto_matches=sum(r["expected_match"] for r in items), itp_statuses=dict(outcomes),
                              itp_matches=decided, residual_executions=len(needed), itp_receipts=len(attempted), replay_awaiting_model=len(recorded)-len(attempted)))
    current_view = {"schema": "benchmark-current-evaluation/v1", "executions": reference(path),
                    "itp_evidence": reference(receipt_file) if receipt_file.is_file() else None,
                    "historical_routes": reference(base / "tespec/routes.json"),
                    "primary_results": {t: reference(base/t/"results.json") for t in ("cn","qcp","fulminate")},
                    "strategies": summaries, "stages": rows}
    layout_path = base / "tespec/auto-layout.json"
    if layout_path.exists():
        layout_profile = read(layout_path)
        if layout_profile["original_profile"] != reference(path):
            raise ValueError("Layout Auto results have a different baseline")
        current_view["default_auto"] = reference(layout_path)
        for strategy in ("inline", "modular"):
            batches = [b for b in layout_profile["batches"] if b["strategy"] == strategy]
            executions = [r for b in batches for r in b["rows"]]
            for stage, data in (
                ("layout_prepare", [b["layout"]["cost"] for b in batches]),
                ("layout_check", [r["layout_check_cost"] for r in executions]),
                ("native", [r["native_cost"] for r in executions]),
                ("auto", [r["auto_cost"] for r in executions if r["auto_cost"]]),
                ("prior_native_attempt", [r["previous_native_attempt"] for r in executions if r.get("previous_native_attempt")]),
            ):
                if not data:
                    continue
                branches = [r["branch_counts"] for r in executions if r["branch_counts"] is not None]
                counts = ({"branch_records":len(branches), **{k:sum(v[k] for v in branches) for k in BRANCHES}}
                          if stage == "native" else {})
                rows.append(line(tool="tespec",strategy=strategy,stage=stage,basis="default_auto_layout",
                                 result="MEASURED",measured=len(data),required=len(data),
                                 unit="shared preparation per batch" if stage=="layout_prepare" else "executions",
                                 wall_seconds=aggregate(data,"wall_seconds"),max_process_rss_kib=aggregate(data,"max_process_rss_kib",max),
                                 tokens=0,input_tokens=0,output_tokens=0,evidence=str(layout_path.relative_to(ROOT)),**counts))
    guard_path = base / "tespec/auto-guards.json"
    if guard_path.is_file():
        guards = read(guard_path)
        if guards["baseline"] != reference(layout_path):
            raise ValueError("Guard results have a different layout baseline")
        current_view["guarded_auto"] = reference(guard_path)
        for strategy in ("inline", "modular"):
            cases = [r for r in guards["executions"] if r["strategy"] == strategy]
            for key, stage in (("layout_cost","guard_prepare"), ("native_cost","native_including_guard_check"),
                               ("recheck","final_guard_check_subset"), ("auto_cost","auto")):
                measurements = [r[key] for r in cases if r[key] is not None]
                initial = [r["initial_attempt"] for r in cases if r.get("initial_attempt")]
                measurements.extend(r[key] for r in initial if r[key] is not None)
                if not measurements:
                    continue
                branches = [r["branch_counts"] for r in cases + initial if r["branch_counts"] is not None]
                counts = ({"branch_records": len(branches), **{k: sum(v[k] for v in branches) for k in BRANCHES}}
                          if key == "native_cost" else {})
                rows.append(line(tool="tespec", strategy=strategy, stage=stage, basis="auto_checked_guards",
                                 result="MEASURED", measured=len(measurements), required=len(measurements),
                                 unit="subset of native" if key == "recheck" else "executions",
                                 wall_seconds=aggregate(measurements,"wall_seconds"),
                                 max_process_rss_kib=aggregate(measurements,"max_process_rss_kib",max),
                                 tokens=0, input_tokens=0, output_tokens=0, evidence=str(guard_path.relative_to(ROOT)), **counts))
    roots_path = base / "tespec/auto-original-roots.json"
    if roots_path.is_file():
        roots = read(roots_path)
        if roots["previous"] != reference(guard_path):
            raise ValueError("Original VC replay has a different guard baseline")
        current_view["auto_original_roots"] = reference(roots_path)
        for strategy in ("inline", "modular"):
            cases = [r for r in roots["executions"] if r["strategy"] == strategy]
            data = [r["auto_cost"] for r in cases] + [r["initial_auto_cost"] for r in cases if "initial_auto_cost" in r]
            if data:
                rows.append(line(tool="tespec", strategy=strategy, stage="auto", basis="auto_original_roots",
                                 result="MEASURED", measured=len(data), required=len(data), unit="Auto attempts on frozen native executions",
                                 wall_seconds=aggregate(data,"wall_seconds"), max_process_rss_kib=aggregate(data,"max_process_rss_kib",max),
                                 tokens=0,input_tokens=0,output_tokens=0,evidence=str(roots_path.relative_to(ROOT))))
    rest_path = base / "tespec/auto-remaining.json"
    if rest_path.exists():
        rest = read(rest_path)
        if rest["baseline"] != reference(path):
            raise ValueError("Auto remainder has a different native baseline")
        current_view["auto_remaining"] = reference(rest_path)
        for strategy in ("inline","modular"):
            cases = [r for r in rest["executions"] if r["strategy"] == strategy]
            rows.extend(timeout_diagnostics(cases, strategy, rest_path))
            for key in ("layout_prepare","native","auto"):
                ms = [r[key] for r in cases if r[key] is not None]
                if not ms:
                    continue
                branch = [r["branch_evaluation"] for r in cases if r["branch_evaluation"] is not None]
                counts = ({"branch_records":len(branch), **{k:sum(c[k] for c in branch) for k in BRANCHES}} if key=="native" else {})
                rows.append(line(tool="tespec",strategy=strategy,stage=key,basis="fresh_auto_remaining",result="MEASURED",
                                 unit="per execution",measured=len(ms),required=len(ms),wall_seconds=aggregate(ms,"wall_seconds"),
                                 max_process_rss_kib=aggregate(ms,"max_process_rss_kib",max),tokens=0,input_tokens=0,output_tokens=0,
                                 evidence=str(rest_path.relative_to(ROOT)),**counts))
    replay_path = base / "tespec/auto-on-itp-roots.json"
    if replay_path.exists():
        replay = read(replay_path)
        if replay["baseline"] != reference(path):
            raise ValueError("Auto and ITP do not share native goals")
        current_view["auto_on_itp_roots"] = reference(replay_path)
        for strategy in ("inline","modular"):
            costs = [r["auto"] for r in replay["executions"].values() if r["strategy"]==strategy]
            if costs:
                rows.append(line(tool="tespec",strategy=strategy,stage="auto",basis="auto_on_itp_roots",result="MEASURED",
                                 unit="postprocessing on identical input and VC", measured=len(costs),required=len(costs),
                                 wall_seconds=aggregate(costs,"wall_seconds"),max_process_rss_kib=aggregate(costs,"max_process_rss_kib",max),
                                 input_tokens=0,output_tokens=0,tokens=0,evidence=str(replay_path.relative_to(ROOT))))
    comparison = RESULTS / "paired-tool-comparison.json"
    paired = read(comparison)["groups"][group] if comparison.is_file() else None
    if paired is not None:
        current_view["paired_comparison"] = {"path":str(comparison.relative_to(ROOT)), "group":group}
    results = tool_results(base, summaries, paired)
    attempted = all(s["itp_receipts"] == s["residual_executions"] for s in summaries)
    complete_costs = all(r["result"] in ("MEASURED", "NOT_REQUIRED") for r in rows if r["basis"] == "current_execution")
    has_latest = paired is not None and "latest_inline" in paired
    if has_latest:
        native_file = RESULTS / "latest-native-costs.json"
        native_costs = read(native_file)["groups"][group] if native_file.is_file() else None
        for strategy in ("inline", "modular"):
            if native_costs:
                nr = native_costs[strategy]
                for field in ("layout_prepare","batch_auto"):
                    ms = nr[field]
                    rows.append(line(tool="tespec",strategy=strategy,stage=field,basis="latest_native_matrix",
                                     result=ms["status"],measured=ms["measured_batches"],required=ms["invoked_batches"],
                                     unit="original batches with stage invocation", wall_seconds=ms["wall_seconds"],
                                     max_process_rss_kib=ms["max_process_rss_kib"], tokens=ms["tokens"],
                                     input_tokens=0,output_tokens=0,evidence=str(native_file.relative_to(ROOT))))
                rows.append(line(tool="tespec", strategy=strategy, stage="native", basis="latest_native_matrix",
                                 result="MEASURED", measured=nr["executions"], required=nr["executions"],
                                 unit=f"{nr['native_batches']} measured batches", wall_seconds=nr["wall_seconds"],
                                 max_process_rss_kib=nr["max_process_rss_kib"], tokens=nr["tokens"], input_tokens=0, output_tokens=0,
                                 branch_records=nr["branch_records"], evidence=str(native_file.relative_to(ROOT)),
                                 **{k:nr[k] for k in BRANCHES}))
            counts = paired["latest_" + strategy]
            rows.extend(latest_route_stages(base, strategy, counts["residual"]))
        attempted = all(paired["latest_" + s]["residual"] == paired["latest_" + s]["attempted"] for s in ("inline","modular"))
        complete_costs = all(r["result"] in ("MEASURED","NOT_REQUIRED") for r in rows if r["basis"] == "latest_same_input_and_vc")
        current_view["stages"] = rows
    # Original evidence validators consume the v1 fields, including detailed measurement IDs.
    table["field_scopes"] = {
        "historical": ["results", "costs", "complete"],
        "current": ["latest_results", "latest_costs", "latest_complete", "current_evaluation"],
        "current_completion": "All finite outcomes published and all required current dual-route stage costs measured. Result agreement and historical construction costs are separate.",
    }
    table["latest_results"] = results
    table["latest_costs"] = {"$ref": "#/current_evaluation/stages"}
    table["latest_complete"] = paired is not None and attempted and complete_costs
    table["current_evaluation"] = current_view
    table_file.write_text(json.dumps(table, ensure_ascii=False, indent=2)+"\n")
    stream = io.StringIO()
    writer = csv.DictWriter(stream, fieldnames=COLUMNS, lineterminator="\n")
    writer.writeheader()
    writer.writerows(rows)
    (base / "result-cost.csv").write_text(stream.getvalue())
    md = [f"# {group} 评测结果与成本", "", "| 工具 | 结果或覆盖 |", "|---|---|"]
    for tool in ("cn", "qcp", "fulminate"):
        v = read(base/tool/"results.json")
        text = v.get("verdict")
        if text is None:
            counts = v.get("summary", {})
            total = counts.get("case_pairs", counts.get("input_pairs"))
            correct = counts.get("correct", counts.get("expected_matches"))
            statuses = counts.get("native_status_counts", counts.get("status_counts", {}))
            text = f"{correct}/{total} 符合预期" if correct is not None and total is not None else json.dumps(counts, ensure_ascii=False)
            if statuses:
                text += " · " + "、".join(f"{s} {n}" for s,n in statuses.items())
        if "entry_snapshot_replay" in v:
            target = [r for r in v["entry_snapshot_replay"]["runs"].values() if r["source_sha256"] == v.get("source_sha256")]
            if len(target) == 1 and target[0]["native"]["exit"] == 0:
                text = f"主程序生成 {target[0]['vc_correct_targets']} 个原始目标；独立检查覆盖已记录的证明子集"
        md.append(f"| {tool} | {display(text)} |")
    if layout_path.exists():
        counts = layout_profile["summary"]
        md.extend(["", f"默认 Auto 布局绑定后，{counts['matches']}/{counts['executions']} 次符合预期。"
                   f"原字段地址未绑定的 {counts['target']} 次中，{counts['target_entry_sat']} 次入口 SAT，"
                   f"{counts['target_expected_matches']} 次整次符合预期。[逐执行结果与成本](tespec/auto-layout.json)",
                   "", "下表的双路线对照保留原 VC；默认 Auto 的成本在阶段表中标记为 default_auto_layout。"])
    if guard_path.is_file():
        md.extend(["", "本次 Auto 投影复核覆盖此前仍为 UNKNOWN 的输入，"
                   + "、".join(f"{k} {v}" for k,v in guards["statuses"].items())
                   + "。[逐输入 VC、分支和成本](tespec/auto-guards.json)。最终环境复核耗时已包含在 native 阶段。"])
    if roots_path.is_file():
        outcomes = Counter(r["status"] for r in roots["executions"])
        md += ["", "同名局部变量专项复用原生 VC，再次执行 Auto 得到 "
               + "、".join(f"{k} {v}" for k,v in outcomes.items())
               + "。[逐输入结果、原始目标与新增成本](tespec/auto-original-roots.json)"]
    if rest_path.exists():
        md.extend(["", f"最新 Auto 补测的 {len(rest['executions'])} 次中，{rest['matches']} 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)"])
    if paired is not None:
        inline, modular = paired["auto_inline"], paired["auto_modular"]
        md.extend(["", f"全量 Auto 符合预期：inline {inline['matches']}/{inline['executions']}，modular {modular['matches']}/{modular['executions']}。"
                   "[同一输入的跨工具比较](../paired-tool-comparison.md)。"])
    if has_latest:
        md += ["", "| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |",
               "|---|---:|---:|---:|---:|---:|"]
        for strategy in ("inline", "modular"):
            counts = paired["latest_" + strategy]
            md.append(f"| {strategy} | {counts['native_only_executions']} | {counts['residual']} | {counts['attempted']} | {counts.get('awaiting', 0)} | {counts['total_itp_matches']} |")
    md += ["", "以下为旧冻结双路线批次。", "", "| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |", "|---|---:|---:|---:|---:|---:|"]
    for s in summaries:
        md.append("| "+" | ".join(str(s[k]) for k in ("strategy","executions","auto_matches","itp_matches","residual_executions","itp_receipts"))+" |")
    md += ["", "| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |",
           "|---|---|---|---|---|---:|---:|---:|---:|"]
    for r in rows:
        scope = (f"{r['unit']} · {r['result']}" if r["required"] is None else
                 f"{r['measured']}/{r['required']} · {r['result']}" if r["tool"] == "tespec" or r["result"] == "NOT_BUILT" else
                 f"{r['measured']}/{r['required']} · {r['unit']}")
        branch = None if r["branch_records"] is None else f"{r['branch_records']}/{r['required']}"
        md.append("| "+" | ".join(display(v) for v in [r["tool"],r["strategy"],r["stage"],r["basis"],scope,r["wall_seconds"],r["max_process_rss_kib"],r["tokens"],branch])+" |")
    md += ["", "¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。", "",
           "[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)"]
    (base / "result-cost.md").write_text("\n".join(md)+"\n")
    return current_view


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--group", action="append")
    args = parser.parse_args()
    for group in args.group or sorted(p.name for p in (ROOT / "benchmark/programs").iterdir() if p.is_dir()):
        publish(group)


if __name__ == "__main__":
    main()
