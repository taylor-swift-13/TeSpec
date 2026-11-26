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
            peak = r["peak_process_memory_mib"]
            usage = stats.get("token_usage") or {}
            if not isinstance(usage, dict) or r["tokens"] != usage.get("total_tokens"):
                usage = {}
            total = r["tokens"]
            rows.append(line(tool=tool, stage=r["stage"], basis="archived_cost", result=outcome,
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
    return rows


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
            status = "NOT_REQUIRED" if not required else "MEASURED" if len(data) == required else "PARTIAL" if data else "PENDING"
            zero = not required
            def tokens(key):
                if zero:
                    return 0
                return aggregate([{**r, key: 0 if r.get("tokens") == 0 else r.get(key)} for r in data], key)
            rows.append(line(tool="tespec", strategy=strategy, stage=stage, basis="current_execution",
                             result=status, unit="measured subset total; largest single-process peak",
                             measured=len(data), required=required, wall_seconds=0 if zero else aggregate(data, "wall_seconds"),
                             max_process_rss_kib=aggregate([m for m in data if m.get("invoked", True)], "max_process_rss_kib", max),
                             input_tokens=tokens("input_tokens"), output_tokens=tokens("output_tokens"), tokens=tokens("tokens"),
                             evidence=source if data else None, **counts))
        outcomes = Counter()
        decided = 0
        for r in items:
            if r["auto_status"] == "NOT_RUN":
                final = r["native_status"]
                match = r["expected_match"]
            else:
                proof = proofs.get(r["native_report_sha256"], {})
                final = proof.get("final_status", "PENDING")
                match = final == r["expected"] and final in ("PASS", "FAIL") or proof.get("expected_crash_match") is True
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
        text = v.get("verdict") or json.dumps(v.get("summary", {}), ensure_ascii=False, sort_keys=True)
        if "entry_snapshot_replay" in v:
            target = [r for r in v["entry_snapshot_replay"]["runs"].values() if r["source_sha256"] == v.get("source_sha256")]
            if len(target) == 1 and target[0]["native"]["exit"] == 0:
                text = f"主程序生成 {target[0]['vc_correct_targets']} 个原始目标；独立检查覆盖已记录的证明子集"
        md.append(f"| {tool} | {display(text)} |")
    md += ["", "| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |", "|---|---:|---:|---:|---:|---:|"]
    for s in summaries:
        md.append("| "+" | ".join(str(s[k]) for k in ("strategy","executions","auto_matches","itp_matches","residual_executions","itp_receipts"))+" |")
    md += ["", "| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |",
           "|---|---|---|---|---:|---:|---:|---:|"]
    for r in rows:
        scope = r["unit"] if r["required"] is None else f"{r['measured']}/{r['required']} {r['basis']}"
        branch = None if r["branch_records"] is None else f"{r['branch_records']}/{r['required']}"
        md.append("| "+" | ".join(display(v) for v in [r["tool"],r["strategy"],r["stage"],scope,r["wall_seconds"],r["max_process_rss_kib"],r["tokens"],branch])+" |")
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
