#!/usr/bin/env python3
"""Publish only measured, incomplete singleton ITP progress; never run experiments.

The default is read-only. This is deliberately not a complete-group publisher:
it never increases formal coverage or turns an unchecked candidate into PASS.
"""
from __future__ import annotations
import argparse
import copy
import hashlib
import json
from pathlib import Path
import re
import statistics
from collections import Counter

from publish_singleton_completed import (
    ROOT, GROUP, BASE, CANONICAL, Publication, MEASUREMENT_ENVIRONMENT,
    checked_models, collect_checks, require_hash, stage_totals, build_execution,
    csv_bytes, COST_FIELDS, rel, load, digest, need, attempt_measurement,
)

PROGRESS = BASE / "evidence/itp/progress.json"
SEMANTIC_REVIEW = ROOT / "benchmark/results/tespec-unexpected/singleton-external-layout.json"
MARKER_START = "<!-- singleton-current-itp-progress -->"
MARKER_END = "<!-- /singleton-current-itp-progress -->"


def section(text, content, after_paragraph=None):
    block = MARKER_START + "\n" + content.rstrip() + "\n" + MARKER_END
    pattern = re.escape(MARKER_START) + r".*?" + re.escape(MARKER_END)
    if MARKER_START in text:
        need(text.count(MARKER_START) == text.count(MARKER_END) == 1, "Ambiguous progress section")
        if not after_paragraph:
            return re.sub(pattern, lambda _: block, text, flags=re.S)
        text = re.sub(r"(?:\n\n)?" + pattern, "", text, flags=re.S)
    if after_paragraph:
        matches = list(re.finditer(r"(?m)^" + re.escape(after_paragraph) + r"[^\n]*", text))
        need(len(matches) == 1, "Missing/ambiguous current summary paragraph")
        end = matches[0].end()
        return text[:end] + "\n\n" + block + text[end:]
    return text.rstrip() + "\n\n" + block + "\n"


def stage_summary(stages):
    if not stages:
        return {"wall_seconds": None, "peak_process_rss_kib": None, "tokens": None,
                "subprocesses": 0, "resource_metrics_complete": False, "status": "NOT_RUN"}
    return {**stage_totals(stages), "status": "MEASURED_ATTEMPTS"}


def running_checks(itp_root):
    running = []
    for proc in Path('/proc').iterdir():
        if not proc.name.isdecimal():
            continue
        try:
            command = [v.decode(errors='replace') for v in (proc / 'cmdline').read_bytes().split(b'\0') if v]
        except (FileNotFoundError, PermissionError, ProcessLookupError):
            continue
        if '--receipt' not in command or '--certificate-dir' not in command:
            continue
        receipt = Path(command[command.index('--receipt') + 1])
        certificate = Path(command[command.index('--certificate-dir') + 1])
        if receipt.is_relative_to(itp_root / 'checks') and certificate.is_relative_to(itp_root) and not receipt.exists():
            running.append({'pid': int(proc.name), 'status': 'RUNNING',
                'receipt': str(receipt.relative_to(itp_root)), 'command': command,
                'wall_seconds': None, 'peak_process_rss_kib': None,
                'reason': 'No closed receipt yet; costs will be included after the command finishes.'})
    return sorted(running, key=lambda value: value['pid'])


def semantic_review(native_sha256):
    """Read a verdict guard; a kernel-checked exported disjunction is unchanged."""
    if not SEMANTIC_REVIEW.is_file():
        return None
    review = load(SEMANTIC_REVIEW)
    if review.get('status') != 'OPEN':
        return None
    group = review.get('group', review.get('program_group', GROUP))
    need(group == GROUP, 'Semantic review names another group')
    bound = review.get('native_results_sha256')
    if bound is not None and bound != native_sha256:
        return None
    goals = review.get('affected_original_goal_sha256')
    if goals is not None:
        need(isinstance(goals, list) and all(isinstance(v, str) and len(v) == 64 for v in goals),
             'Malformed affected original Goal hashes')
    return {'reference': {'path': rel(SEMANTIC_REVIEW), 'sha256': digest(SEMANTIC_REVIEW)},
            'status': 'OPEN', 'native_results_sha256': bound,
            'affected_original_goal_sha256': goals,
            'reason': review.get('reason', 'Exported parent proof does not certify the original spatial entailment.'),
            'scope': 'Only matching inline ITP context; modular native results remain unchanged.'}


def pending_execution(pub, task, native, itp_root, model_root):
    index = task["execution_index"]
    row = native["runs"][task["native_row_index"]]
    for name, other in (("case", "case"), ("mode", "spatial_smt"), ("strategy", "strategy"),
                        ("input", "input"), ("source_sha256", "source_sha256")):
        need(task[name] == row[other], "Task/native identity changed")
    need(row["raw_status"] == "UNKNOWN" and row["expected"] == "PASS" and
         row["precondition_result"] == "SAT" and row["execution_completed"] is True,
         "Not an eligible legal completed execution")
    need(task["residual_vcs"] == row["residual_vcs"], "Residual inventory changed")
    for key in ("original_goal", "original_report", "original_manifest", "certificate_manifest", "controller_manifest"):
        require_hash(Path(task[key]), task[key + "_sha256"], key)
    require_hash(ROOT / task["source"], task["source_sha256"], "source")
    folders = list((model_root / f"execution-{index:02d}").glob("attempt-*"))
    models = checked_models(model_root / f"execution-{index:02d}") if folders else []
    by_model = {m["source_receipt_sha256"]: m for m in models}
    paths, notes = collect_checks(itp_root / "checks" / f"execution-{index:02d}")
    checks, stages, missing = [], [], []
    for path in paths:
        raw = load(path)
        need(raw["native_row_index"] == task["native_row_index"], "Checker/native execution differs")
        need(raw["native_results_sha256"] == native["_sha256"], "Checker/native snapshot differs")
        need(raw["model_receipt_sha256"] in by_model, "Checker has no metered model receipt")
        model = by_model[raw["model_receipt_sha256"]]
        bind = raw["binding"]
        need(bind["original_goal_sha256"] == task["original_goal_sha256"] and
             bind["original_residual_vcs"] == task["residual_vcs"] and
             bind["source_sha256"] == task["source_sha256"], "Checker binding changed")
        need(bind["precondition_result"] == "SAT" and bind["execution_completed"] is True,
             "Checker lacks valid entry/exit")
        report_path = Path(raw["certificate_report"])
        require_hash(report_path, raw["certificate_report_sha256"], "checker report")
        report = load(report_path)
        need(report == raw["certificate_result"], "Embedded report changed")
        need(report["candidate_sha256"] == model["candidate_sha256"], "Checked candidate changed")
        selected = {k: copy.deepcopy(v) for k, v in raw.items() if k not in
                    {"model_receipt", "native_results", "certificate_report", "certificate_result", "stages", "executed_wrappers"}}
        selected.update(attempt=path.stem, source_receipt_sha256=digest(path), model_attempt=model["attempt"])
        selected["certificate_result"] = {k: copy.deepcopy(v) for k, v in report.items()
                                             if k not in {"stages", "duration_seconds", "certificate_dir"}}
        selected["stages"] = []
        for stage in raw["stages"]:
            attempt_measurement(stage, "Coq attempt", allow_missing_rss=report.get("status") != "PASS")
            require_hash(Path(stage["log"]), stage["log_sha256"], "stage log")
            measured = {k: copy.deepcopy(v) for k, v in stage.items() if k != "log"}
            selected["stages"].append(measured)
            stages.append(measured)
            if (stage.get("resources") or {}).get("max_process_rss_kib") is None:
                missing.append({"execution_index": index, "attempt": path.stem, "stage": stage["stage"],
                    "field": "max_process_rss_kib", "wall_seconds": stage["wall_seconds"],
                    "reason": "Original failed measurement did not retain RSS; reruns cannot replace it."})
        checks.append(selected)
    if models and any(c['status'] == 'KERNEL_CHECKED' and
                      c['model_receipt_sha256'] == models[-1]['source_receipt_sha256'] for c in checks):
        completed, ref = build_execution(pub, task, native, itp_root, model_root)
        return {"execution_index": index, "native_row_index": task["native_row_index"], "status": "PASS",
                "receipt": ref, "models": models, "checks": checks, "missing_measurements": completed["missing_measurements"],
                "metrics": completed["metrics"], "proof_complete": True}
    proof_files = {}
    if models:
        cert = Path(task["certificate_dir"])
        for name in ("Goal.v", "Coverage.v", "Assumptions.v"):
            proof_files[name] = pub.object(cert / name, name)
        require_hash(cert / "Goal.v", task["original_goal_sha256"], "original Goal")
        latest_candidate = model_root / f"execution-{index:02d}" / f"attempt-{models[-1]['attempt']}" / "Candidate.v"
        proof_files["Candidate.v"] = pub.object(latest_candidate, "Candidate.v")
        dep = task["supplemental_dependency"]
        require_hash(Path(dep["source"]), dep["sha256"], "DLL dependency")
        proof_files["DLLSupplement.v"] = pub.object(Path(dep["source"]), "DLLSupplement.v")
        for model in models:
            need(model["locked_goal_and_helper_sha256"]["Goal.v"] == task["original_goal_sha256"], "Model Goal changed")
            need(model["locked_goal_and_helper_sha256"]["DLLSupplement.v"] == dep["sha256"], "Model DLL changed")
    agent = {"wall_seconds": sum(m["wall_seconds"] for m in models) if models else None,
             "peak_process_resident_bytes": max(m["resources"]["max_process_peak_working_set_bytes"] for m in models) if models else None,
             "tokens": sum(u["input_tokens"] + u["output_tokens"] for m in models for u in m["token_usage"]) if models else None,
             "model_calls": len(models), "status": "MEASURED_ATTEMPTS" if models else "NOT_RUN"}
    compile_cost = stage_summary([s for s in stages if not s["stage"].startswith("kernel_replay")])
    kernel_cost = stage_summary([s for s in stages if s["stage"].startswith("kernel_replay")])
    return {"execution_index": index, "native_row_index": task["native_row_index"], "status": "UNKNOWN",
            "attempt_status": "ATTEMPTED_NOT_KERNEL_CHECKED" if models else "NOT_RUN", "proof_complete": False,
            "case": row["case"], "strategy": row["strategy"], "spatial_smt": row["spatial_smt"], "input": row["input"],
            "source_sha256": task["source_sha256"], "original_goal_sha256": task["original_goal_sha256"],
            "original_report_sha256": task["original_report_sha256"], "original_manifest_sha256": task["original_manifest_sha256"],
            "selected_goals": task["residual_vcs"], "proof_files": proof_files,
            "models": models, "checks": checks, "missing_measurements": missing, "controller_notes": notes,
            "metrics": {"agent": agent, "coq_compile_and_assumption_audit": compile_cost, "independent_kernel_check": kernel_cost}}


def prepare(itp_root, model_root, native_path):
    pub = Publication()
    frozen = load(itp_root / "tasks.json")
    require_hash(native_path, frozen["native_result_sha256"], "native results")
    native = load(native_path)
    native["_sha256"] = digest(native_path)
    need(len(frozen["tasks"]) == 14 and len(native["runs"]) == 28, "Unexpected execution count")
    current = load(CANONICAL)
    need(current["schema"] == "tespec-group-native-recheck/v1", "Already canonically published; use completed publisher")
    need(len(current['runs']) == 28, 'Published native snapshot lost executions')
    identity = lambda r: (r['case'], r['strategy'], r['spatial_smt'])
    need(len({identity(r) for r in current['runs']}) == 28, 'Duplicate published native execution')
    need(len({identity(r) for r in native['runs']}) == 28, 'Duplicate frozen native execution')
    need({t['execution_index'] for t in frozen['tasks']} == set(range(14)), 'Missing or duplicate task ordinal')
    need({t['native_row_index'] for t in frozen['tasks']} ==
         {i for i, r in enumerate(native['runs']) if r['raw_status'] == 'UNKNOWN'},
         'Frozen ITP task coverage differs from full original UNKNOWN inventory')
    for saved, measured in zip(current['runs'], native['runs']):
        for key in ('case', 'input', 'strategy', 'spatial_smt', 'expected', 'raw_status', 'source_sha256',
                    'precondition_result', 'execution_completed', 'residual_vcs', 'report_sha256'):
            need(saved[key] == measured[key], 'Published native identity differs from frozen run: ' + key)
    for path, sha in current["input_identity"].items():
        require_hash(ROOT / path, sha, "current input/tool")
    executions = [pending_execution(pub, t, native, itp_root, model_root) for t in frozen["tasks"]]
    review = semantic_review(native['_sha256'])
    for entry, task in zip(executions, frozen['tasks']):
        guarded = bool(review and (review['affected_original_goal_sha256'] is None or
                                  task['original_goal_sha256'] in review['affected_original_goal_sha256']))
        entry['exported_parent_kernel_checked'] = entry['proof_complete']
        entry['original_entailment_completed'] = entry['proof_complete'] and not guarded
        entry['benchmark_final_status'] = 'PASS' if entry['original_entailment_completed'] else 'UNKNOWN'
        if guarded:
            entry['semantic_review'] = review['reference']
            entry['benchmark_itp_status'] = 'SEMANTIC_REVIEW'
    models = [m for e in executions for m in e["models"]]
    need(len({m["source_receipt_sha256"] for m in models}) == len(models), "Model receipt counted twice")
    checks = [c for e in executions for c in e["checks"]]
    need(len({c["source_receipt_sha256"] for c in checks}) == len(checks), "Checker receipt counted twice")
    missing = [m for e in executions for m in e["missing_measurements"]]
    totals = {}
    for stage in ("agent", "coq_compile_and_assumption_audit", "independent_kernel_check"):
        entries = [e["metrics"][stage] for e in executions if e["metrics"][stage]["wall_seconds"] is not None]
        seconds = sum(e["wall_seconds"] for e in entries)
        tokens = sum(e["tokens"] for e in entries)
        peaks = [e.get("peak_process_resident_bytes", None if e.get("peak_process_rss_kib") is None else e["peak_process_rss_kib"] * 1024) for e in entries]
        totals[stage] = {"measured_executions": len(entries), "wall_seconds_total": seconds, "tokens_total": tokens,
            "observed_mean_wall_seconds": statistics.mean(e["wall_seconds"] for e in entries) if entries else None,
            "observed_mean_tokens": statistics.mean(e["tokens"] for e in entries) if entries else None,
            "observed_mean_peak_process_mib": statistics.mean(peaks) / 1048576 if peaks and all(p is not None for p in peaks) else None,
            "full_14_execution_mean": None, "complete": False}
    parent_checked = sum(e['exported_parent_kernel_checked'] for e in executions)
    completed = sum(e['original_entailment_completed'] for e in executions)
    need(completed < 14, "All executions checked; use completed publisher")
    info = {"schema": "tespec-singleton-itp-progress/v1", "group": GROUP,
        "complete": False, "verdict_complete": False, "resource_metrics_complete": False,
        "required_itp_executions": 14, "attempted_executions": sum(bool(e["models"]) for e in executions),
        "kernel_checked_executions": parent_checked,
        "exported_parent_kernel_checked_executions": parent_checked,
        "original_entailment_completed_executions": completed, "pending_executions": 14-completed,
        "semantic_review": review,
        "model": "gpt-6.1-sol", "model_calls": len(models), "check_attempts": len(checks),
        "tokens": sum(u["input_tokens"] + u["output_tokens"] for m in models for u in m["token_usage"]),
        "missing_measurements": missing, "measured_stages": totals,
        "executions": [{k: e[k] for k in ('execution_index', 'native_row_index', 'status', 'proof_complete', 'receipt',
                        'exported_parent_kernel_checked', 'original_entailment_completed', 'benchmark_final_status',
                        'benchmark_itp_status', 'semantic_review') if k in e}
                       if e['proof_complete'] else e for e in executions],
        "native_results_sha256": native["_sha256"], "tasks_sha256": digest(itp_root / "tasks.json"),
        "running_checks": running_checks(itp_root),
        "measurement_environment": MEASUREMENT_ENVIRONMENT,
        "environment_observed_at_publication": {
            "tools": [{"path": str(p), "sha256": digest(p)} for p in
                      (Path('/home/yangfp/.opam/qcp-8.20/bin/coqc'), Path('/home/yangfp/.opam/qcp-8.20/bin/coqchk'))],
            "scope": "Current executable bytes only. Earlier checker receipts did not bind executable or GC environment identity; this observation is not a retroactive binding or a checked-dependency cache seed."},
        "scope": "Snapshot of closed receipts only. No absent receipt is classified as timeout or failure. Ongoing command costs appear only after its receipt closes. Unstarted tasks stay unmeasured; displayed attempt means are not final 14-execution means."}
    progress_ref = pub.json(PROGRESS, info, compact=True)
    current["scope"] = "Current native executions plus separately metered incomplete ITP progress. Original native states, inputs and expectations retained; no new input pairs."
    current["itp"] = {"status": "SEMANTIC_REVIEW" if review else "IN_PROGRESS", "executions": 14, "model": "gpt-6.1-sol",
        "unit": "all residual VCs of one execution", "progress": progress_ref,
        "completed_executions": completed, "model_calls": len(models), "model_tokens": info["tokens"],
        "exported_parent_kernel_checked_executions": parent_checked,
        "original_entailment_completed_executions": completed, "semantic_review": review,
        "agent_seconds": totals["agent"]["wall_seconds_total"],
        "coq_seconds": totals["coq_compile_and_assumption_audit"]["wall_seconds_total"],
        "kernel_seconds": totals["independent_kernel_check"]["wall_seconds_total"],
        "reason": "Open semantic review prevents promotion of matching exported parent proofs to original spatial entailment success. Unfinished tests remain UNKNOWN." if review else
                  "Compiler/assumption success is not a kernel certificate; unfinished tests remain UNKNOWN."}
    for e in executions:
        row = current["runs"][e["native_row_index"]]
        row["itp"] = e.get('benchmark_itp_status', "KERNEL_CHECKED" if e["proof_complete"] else e["attempt_status"])
        row["final_status"] = e['benchmark_final_status']
        row["matches_expected"] = row["final_status"] == row["expected"]
        if e["proof_complete"]:
            row["itp_receipt"] = e["receipt"]
        if 'semantic_review' in e:
            row['itp_semantic_review'] = e['semantic_review']
            row['itp_receipt_scope'] = 'Exported parent only; original spatial entailment remains under semantic review.'
        else:
            row.pop('itp_semantic_review', None)
            row.pop('itp_receipt_scope', None)
    evaluation_ref = pub.json(CANONICAL, current, compact=True)
    latest = {"evidence": evaluation_ref["path"], "sha256": evaluation_ref["sha256"], "case_pairs": 7,
        "executions": 28, "complete": False, "pending_itp_executions": 14-completed, "itp_progress": progress_ref,
        "exported_parent_kernel_checked_executions": parent_checked,
        "original_entailment_completed_executions": completed, "semantic_review": review}
    status_counts = dict(Counter(r["final_status"] for r in current["runs"]))
    summary = {"case_pairs": 7, "executions": 28, "correct_executions": 14+completed,
        "raw_status_counts": {"PASS": 14, "UNKNOWN": 14}, "final_status_counts": status_counts,
        "complete": False, "verdict_complete": False, "resource_metrics_complete": False}
    results = load(BASE / "tespec/results.json")
    results.setdefault("historical_result_summary", {k: results[k] for k in ("summary", "evidence", "cases") if k in results})
    results.update(summary=summary, evidence=evaluation_ref["path"], evidence_sha256=evaluation_ref["sha256"],
        latest_native_recheck=latest, current_itp_progress=progress_ref,
        cases=[{k: r[k] for k in ("case", "variant", "strategy", "spatial_smt", "expected", "raw_status", "final_status", "matches_expected")} for r in current["runs"]])
    pub.json(BASE / "tespec/results.json", results)
    stats = load(BASE / "tespec/statistics.json")
    stats.update(latest_native_recheck=latest, current_itp_progress=progress_ref,
        current_measured_itp_stages=totals, current_tokens=info["tokens"], current_model_calls=len(models),
        current_complete=False, current_missing_measurements=missing)
    pub.json(BASE / "tespec/statistics.json", stats)
    table = load(BASE / "result-cost.json")
    table.update(complete=False, verdict_complete=False, resource_metrics_complete=False, latest_native_recheck=latest,
        current_itp_progress=progress_ref, current_measured_itp_stages=totals, current_missing_measurements=missing)
    for result in table["results"]:
        if result["tool"] == "tespec":
            result.update(result=f"{14+completed}/28 configurations; ITP incomplete", executions=28,
                          expected_execution_matches=14+completed, expected_matches=None)
    table["costs"] = [r for r in table["costs"] if r.get("source") != rel(PROGRESS)]
    for stage, value in totals.items():
        table["costs"].append({"tool": "tespec current ITP", "stage": stage,
            "unit": f"已尝试 {value['measured_executions']} 次执行的暂计均值；不是最终 14 次均值",
            "wall_seconds": value["observed_mean_wall_seconds"], "peak_process_memory_mib": value["observed_mean_peak_process_mib"],
            "tokens": value["observed_mean_tokens"], "estimated": False, "status": "INCOMPLETE_MEASURED_ATTEMPTS", "source": rel(PROGRESS)})
    pub.json(BASE / "result-cost.json", table)
    pub.put(BASE / "result-cost.csv", csv_bytes(table["costs"], COST_FIELDS))
    for filename in ("index.json", "coverage-gap.json"):
        value = load(BASE / filename)
        value.update(complete=False, verdict_complete=False, resource_metrics_complete=False,
            latest_native_recheck=latest, current_itp_progress=progress_ref, current_missing_measurements=missing)
        value["tespec_current_run_status"] = "SEMANTIC_REVIEW" if review else "ITP_IN_PROGRESS_KERNEL_CHECKS_PENDING"
        pub.json(BASE / filename, value)
    detail = (f"当前最终结果（含已完成 ITP）：**{status_counts.get('PASS', 0)} PASS、{status_counts.get('UNKNOWN', 0)} UNKNOWN**；"
              f"导出父 VC 的独立内核检查完成 **{parent_checked}/14**；原始空间蕴含完成 **{completed}/14**。\n\n"
              f"当前 ITP 已实际调用 `gpt-6.1-sol` {len(models)} 次，共 {info['tokens']:,} token；"
              f"已尝试 {info['attempted_executions']}/14 次执行。"
              "编译与假设审计成功不等于内核检查完成；尚未完成的测试仍为 UNKNOWN。\n\n"
              f"已关闭的检查收据 {len(checks)} 份；所有失败尝试计入。"
              f"有 {len(missing)} 个失败阶段未保留峰值 RSS，后续重跑不能补造本次数据。"
              "未关闭的运行不预填超时、时间或内存。完整 14 次执行的最终均值尚未形成。\n\n"
              "[逐执行实际调用与检查证据](evidence/itp/progress.json)。当前全局完整进度仍为 **22/45 组、901 对输入**。")
    if review:
        detail += ("\n\n语义范围复核尚未关闭：匹配旧上下文的父目标证明保留其正式 PASS 收据，"
                   "但父目标含策略化的平凡右分支，尚不能据此认定原始 Dll 后条件已独立核证。"
                   "这些 inline 测试保持 UNKNOWN／SEMANTIC_REVIEW；此处没有反证，也不据此断言执行器 bug。"
                   "[复核记录](../tespec-unexpected/singleton-external-layout.json)。")
    md = (BASE / "result-cost.md").read_text()
    md = md.replace("ITP 未执行的数据保持缺失，不能填 0。", "未启动的 ITP 数据保持缺失；当前实际尝试见上方进度，不填虚构 0。")
    md = md.replace("当前实际尝试见下方进度", "当前实际尝试见上方进度")
    md = md.replace("inline 的 14 次执行仍须分别完成 ITP、编译／假设审计、独立内核检查及实际模型计量，故本组不计完成。",
                    "inline 共 14 次执行，按逐执行 ITP、编译／假设审计、独立内核检查及实际模型计量补齐；目前本组尚未完整。")
    pub.put(BASE / "result-cost.md", section(md, detail, after_paragraph="当前版本 `ac167d0301`"))
    global_path = ROOT / "benchmark/results/group-result-cost-index.json"
    global_index = load(global_path)
    need(sum(bool(e["complete"]) for e in global_index["groups"]) == 22, "Global coverage changed")
    total_pairs = sum(next(r["test_pairs"] for r in load(ROOT / g["json"])["results"] if r["tool"] == "tespec")
                      for g in global_index["groups"] if g["complete"])
    need(total_pairs == 901, "Global input count changed")
    global_index["current_completion_summary"].update(current_instruction="Continue user-authorized group 23 with gpt-6.1-sol.",
        next_group_pending_itp_executions=14-completed, next_group_current_itp_progress=progress_ref)
    pub.json(global_path, global_index)
    ledger_path = ROOT / "benchmark/results/tespec-unexpected/index.json"
    ledger = load(ledger_path)
    ledger.setdefault("current_group_rechecks", {})[GROUP] = {"evidence": evaluation_ref["path"], "sha256": evaluation_ref["sha256"],
        "case_pairs": 7, "executions": 28, "unexpected_executions": 14-completed, "complete": False,
        "raw_status_counts": {"PASS": 14, "UNKNOWN": 14}, "final_status_counts": status_counts,
        "itp": "SEMANTIC_REVIEW" if review else "IN_PROGRESS", "progress": progress_ref,
        "exported_parent_kernel_checked_executions": parent_checked,
        "original_entailment_completed_executions": completed, "semantic_review": review,
        "reason": "Exported parent proofs have an open semantic-scope review; original DLL entailments remain UNKNOWN. Modular native PASS and expected values unchanged." if review else
                  "Inline DLL residuals require full per-execution kernel checking; modular native PASS. No expected value changed."}
    pub.json(ledger_path, ledger)
    docs = ROOT / "docs/benchmark-evaluation-progress.md"
    text = docs.read_text().replace("当前按用户要求仅整理已有 benchmark、结果、成本与证明证据，不继续启动实验。",
                                   "用户已授权继续使用 gpt-6.1-sol 评测第 23 组 singleton；仅整理的暂停已解除。")
    text = text.replace("下一组继续 `Dbl_Linked_List__singleton`：先核对可复用的 CN/QCP/Fulminate 证据，并补测当前 teSpec 的 7 个合法输入、inline/modular 和空间 SMT OFF/ON；其已发布结果仍有 DLL 返回 VC 未消解，尚未计入完整组。",
                        "第 23 组 `Dbl_Linked_List__singleton` 已核对并复用哈希匹配的 CN/QCP/Fulminate 证据；当前 teSpec 的 28 次原生执行已完成，正在逐执行补齐 inline 的 ITP，尚未计入完整组。")
    pub.put(docs, section(text, detail.replace("(evidence/itp/progress.json)", "(../benchmark/results/Dbl_Linked_List__singleton/evidence/itp/progress.json)")
                          .replace('(../tespec-unexpected/singleton-external-layout.json)', '(../benchmark/results/tespec-unexpected/singleton-external-layout.json)'),
                          after_paragraph="本次 singleton 当前原生补测已完成"))
    return pub, info


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--itp-root", required=True, type=Path)
    parser.add_argument("--model-root", required=True, type=Path)
    parser.add_argument("--native-results", required=True, type=Path)
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()
    pub, info = prepare(args.itp_root.resolve(), args.model_root.resolve(), args.native_results.resolve())
    if args.apply:
        before = pub.apply()
        try:
            need(all(p.read_bytes() == b for p, b in pub.files.items()), "Publication write differs")
            need(load(BASE / "index.json")["complete"] is False, "Incomplete publication became complete")
        except BaseException:
            pub.rollback(before)
            raise
    print(json.dumps({"preflight": "PASS", "applied": args.apply, "files_planned": len(pub.files),
        "model_calls": info["model_calls"], "tokens": info["tokens"], "closed_checks": info["check_attempts"],
        "kernel_checked_executions": info["kernel_checked_executions"], "missing_measurements": info["missing_measurements"],
        "exported_parent_kernel_checked_executions": info['exported_parent_kernel_checked_executions'],
        "original_entailment_completed_executions": info['original_entailment_completed_executions'],
        "pending_executions": info['pending_executions'],
        "semantic_review_status": info['semantic_review']['status'] if info['semantic_review'] else None,
        "complete_groups": 22, "complete_group_case_pairs": 901}, ensure_ascii=False))


if __name__ == "__main__":
    main()
