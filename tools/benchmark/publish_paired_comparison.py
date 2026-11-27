"""Summarise paired observed outcomes, retaining different oracles and build failures."""

import argparse
from collections import Counter, defaultdict
from pathlib import Path

from organize_tespec_routes import RESULTS, ROOT, read, reference, save, inputs, digest
from regress_auto_guards import batches


def coordinates(row):
    return row["variant"], row["case"], row["strategy"]


def paired_route_costs(rows, replay, receipts):
    """Compare only identical native executions with both terminal attempt receipts."""
    measured = []
    costs = defaultdict(list)
    counts = Counter()
    outcomes = Counter()
    for row in rows:
        counts["residual"] += 1
        fresh = replay[row["native_report_sha256"]]
        if (
            coordinates(fresh) != coordinates(row)
            or fresh["goal_sha256"] != row["goal_sha256"]
            or fresh["input_sha256"] != row["input_sha256"]
        ):
            raise ValueError("Auto backend did not replay the same frozen execution")
        counts["auto_matches"] += int(fresh["expected_match"])
        counts["auto_" + fresh["effective_status"]] += 1
        r = receipts.get(row["native_report_sha256"])
        if not r or r.get("needs_model"):
            counts["awaiting"] += 1
            continue
        if r["goal_sha256"] != row["goal_sha256"] or coordinates(r) != coordinates(row):
            raise ValueError("ITP result does not identify the same original VC")
        counts["attempted"] += 1
        itp_match = (
            r["final_status"] in {"FAIL", "PASS"}
            and r["final_status"] == row["expected"]
        ) or r.get("expected_crash_match") is True
        overlap = {
            (True, True): "both_match",
            (True, False): "auto_only",
            (False, True): "itp_only",
            (False, False): "neither_match",
        }
        counts[overlap[bool(fresh["expected_match"]), bool(itp_match)]] += 1
        counts["parent_vc_refuted"] += int(
            any(
                check.get("proof_status") == "VALID"
                and check.get("vc_status") == "INVALID"
                for check in r.get("checks", [])
            )
        )
        for attempt in r.get("model_attempts", []):
            if (attempt["requested_model"], attempt["requested_reasoning_effort"]) != (
                "gpt-6.1-sol",
                "medium",
            ):
                raise ValueError(
                    "Incompatible model configuration in measured ITP attempt"
                )
            counts["metered_cli_calls"] += 1
        counts["recorded_model_tokens"] += (r.get("itp_model") or {}).get("tokens") or 0
        if r["final_status"] not in ("UNKNOWN", "ERROR"):
            counts["itp_decided"] += 1
        outcomes[r["final_status"]] += 1
        phases = [r[k] for k in ("itp_model", "itp_coq", "itp_kernel")]
        if r.get("itp_binding") is not None:
            phases.append(r["itp_binding"])
        shared = r.get("shared_check")
        if shared:
            counts["checked_by_reuse"] += 1
            if shared.get("original_vc_judgement") == "VC_REFUTED" and not any(
                c.get("vc_status") == "INVALID" and c.get("proof_status") == "VALID"
                for c in r.get("checks", [])
            ):
                counts["parent_vc_refuted"] += 1
        if r.get("cumulative_costs_complete") is False:
            counts["incomplete_cumulative_costs"] += 1
            continue
        if fresh.get("auto") is None or any(
            m is None
            or m.get("wall_seconds") is None
            or m.get("tokens") is None
            or (m.get("invoked") and m.get("max_process_rss_kib") is None)
            for m in phases
        ):
            continue
        auto = fresh["auto"]
        if any(
            auto.get(k) is None
            for k in ("wall_seconds", "tokens", "max_process_rss_kib")
        ):
            continue
        counts["cost_subset_auto_matches"] += int(fresh["expected_match"])
        counts["cost_subset_itp_matches"] += int(itp_match)
        measured.append(row["native_report_sha256"])
        if shared:
            counts["cost_subset_shared_checks"] += 1
            costs["shared_check_seconds"].append(shared["wall_seconds"])
            costs["shared_check_rss"].append(shared["max_process_rss_kib"])
        costs["auto_seconds"].append(auto["wall_seconds"])
        costs["itp_seconds"].append(sum(x["wall_seconds"] for x in phases))
        costs["auto_tokens"].append(auto["tokens"])
        costs["itp_tokens"].append(sum(x["tokens"] for x in phases))
        costs["auto_rss"].append(auto["max_process_rss_kib"])
        costs["itp_rss"].extend(
            x["max_process_rss_kib"]
            for x in phases
            if x.get("max_process_rss_kib") is not None
        )
    counts["paired_cost_records"] = len(measured)
    return counts, costs, outcomes


def markdown(result):
    totals = result["unique_auto"]
    statuses = result["outcomes"]
    lines = [
        "# 四工具配对评测",
        "",
        f"45 个程序组，{result['input_pairs']:,} 个 CN 变体与输入配对。teSpec 合并映射到同一 QCP 变体与输入的重复记录，inline 和 modular 合计 {totals['executions']:,} 次独立执行，{totals['matches']:,} 次符合预期。",
        "",
        "## teSpec Auto 与 Fulminate",
        "",
        "| 同一配对的结果 | inline | modular |",
        "|---|---:|---:|",
    ]
    for key, label in (
        ("both_match", "两者符合预期"),
        ("tespec_only", "仅 teSpec 符合预期"),
        ("fulminate_only", "仅 Fulminate 符合预期"),
        ("neither_match", "两者均未符合预期"),
        ("body_only", "目标未声明 CN 前置或后置条件"),
        ("different_contract", "计划明确标注规约不同"),
        ("different_expected", "两工具预期标签不同"),
        ("unavailable_fulminate", "缺可执行文件"),
    ):
        lines.append(
            f"| {label} | {result['paired']['inline'].get(key, 0)} | {result['paired']['modular'].get(key, 0)} |"
        )
    lines += [
        "",
        "匹配按各用例预先声明的预期判定，CRASH 还须匹配故障种类。后三类规约或标签差异按表中顺序单列，每个配对每种策略只计一次。未标注规约差异的配对仍可能有翻译差别。",
        "",
        "两个 zero 输入从未初始化的 int 单元开始，构造的实现没有写入。后置条件要求已初始化的单元。teSpec Auto 在两个执行策略下都返回 FAIL，Fulminate 在两个输入上均返回 PASS。[zero 的结果和成本](zero/result-cost.md)",
        "",
        "5 个旧 CN 组共有 342 个输入。锁定工具链对未适配源码的构建均拒绝。有限输入的兼容规约插桩后 342 个全部运行并符合预期。上表使用实际运行结果。所有组中 CN 目标未声明规约的输入仍保留驱动执行记录。[Fulminate 全覆盖与范围审计](fulminate-coverage.json)",
        "",
        "## 主程序验证与有限测试",
        "",
        "CN 在 45 个主程序上均有实测记录。28 组验证通过（含 3 组兼容头文件），8 组有信任限定，9 组被拒绝。QCP 的 35 组取得内核接受的验证证据，3 组取得原始必要义务的内核反证，7 组被独立生成器拒绝。组表保留策略配置与运行库假设。",
        "",
        "在被 QCP 生成器拒绝的 7 组中，5 组在与 QCP 验证完全相同的源文件上有 teSpec 有限输入命中预期。例如 bad_free 的原始 main 在两个策略下均被判为预期 FAIL。这些观察只覆盖所测入口和输入。[bad_free 组证据](runtime-extras__bad_free/result-cost.md)",
        "",
        f"全量 Auto 的实际输出为 PASS {statuses.get('PASS', 0):,}、FAIL {statuses.get('FAIL', 0):,}、CRASH {statuses.get('CRASH', 0):,}、UNKNOWN {statuses.get('UNKNOWN', 0):,}、ERROR {statuses.get('ERROR', 0):,}。60 次 ERROR 均来自 runway 的原生分支上限。",
        "",
        "唯一一次预期 FAIL 而实际 PASS 发生在 leaky 的 modular 调用。leaky_get 的后置条件给调用方留下空堆，函数体实际只读内存。modular 按该后置条件继续执行，原生阶段便判 main 为 PASS，没有调用 Auto。同一输入的 inline Auto 与 Fulminate 均为 FAIL，QCP 也正式反证了 leaky_get 的返回义务。既定用例以整个实现的泄漏为预期，统计保留这次不符。[leaky 的实执记录](runtime-extras__leaky/tespec/auto-remaining.json)",
        "",
        "## 旧冻结批次的独立复核",
        "",
    ]
    if "native_costs" in result:
        m = result["native_costs"]["totals"]
        prep, post = m["layout_prepare"], m["batch_auto"]
        lines[-2:-2] = [
            f"主矩阵的 {m['executions']:,} 次执行中，布局准备累计 {prep['wall_seconds']:,.2f} 秒，原生执行累计 {m['wall_seconds']:,.2f} 秒，{post['invoked_batches']} 个批次的 Auto 后处理累计 {post['wall_seconds']:,.2f} 秒。三阶段均未调用模型。布局准备是本批次耗时最多的阶段。",
            "",
            f"原生执行共 {m['native_batches']} 个批次，累计 {m['wall_seconds']:,.2f} 秒，单进程峰值 {m['max_process_rss_kib']:,} KiB。{m['branch_records']:,} 次执行返回了分支计数，另有 {m['branch_missing']} 次原生超时。已记录的 {m['pure_queries']:,} 次条件查询中，直接判真或判假 {m['evaluated_true'] + m['evaluated_false']:,} 次，回退 SMT {m['smt_fallback']:,} 次。[分支与成本收据](latest-native-costs.json)",
            "",
        ]
    if "latest_routes" in result:
        info = result["latest_routes"]
        counts = Counter(info["counts"])
        cc = info["paired_postprocessing_costs"]
        lines[-2:-2] = [
            "## 当前矩阵的两条路线",
            "",
            f"当前 {totals['executions']:,} 次执行中，{counts['native_only_executions']:,} 次没有残余义务可交给后处理，两条路线共用其原生输出。其余 {counts['residual']} 次均以单个输入的全部原始义务为一项任务。ITP 已实测 {counts['attempted']} 项，尚待 {counts['awaiting']} 项。",
            "",
            f"Auto 在逐输入复核中判定 PASS {counts['auto_PASS']}、FAIL {counts['auto_FAIL']}、UNKNOWN {counts['auto_UNKNOWN']}。其中 {len(info['auto_batch_vs_single'])} 次与批次 Auto 不同，逐例保存了两次判定和相同预算下的诊断复测。成本表使用首次逐输入判定。",
            "",
            f"另一次独立计量覆盖 {counts['additional_profile_runs']} 次，得到 PASS {counts['additional_profile_PASS']}、FAIL {counts['additional_profile_FAIL']}、UNKNOWN {counts['additional_profile_UNKNOWN']}。8 秒诊断覆盖了首次逐输入判定为 UNKNOWN 的 {counts['primary_unknown_retried']} 次，其中 {counts['primary_unknown_retried_PASS']} 次得到 PASS，{counts['primary_unknown_retried_UNKNOWN']} 次仍为 UNKNOWN。两类复测均单列成本。",
            "",
            f"当前后处理已有双方回执的执行中，双方均命中 {counts['both_match']} 次，仅 Auto 命中 {counts['auto_only']} 次，仅 ITP 命中 {counts['itp_only']} 次，双方均未命中 {counts['neither_match']} 次。ITP 有 {counts['parent_vc_refuted']} 项正式反证原始 VC。执行 FAIL 还需有绑定当前输入的可达性证据。",
            "",
            f"下表只计入阶段成本完整的 {counts['paired_cost_records']} 次配对。模型生成限定 gpt-6.1-sol（medium），包含失败与修复。RSS 为最高单进程峰值，时间按各次执行累加。",
            "",
            "| 后处理 | 合计秒 | 峰值 KiB | 实际 token |",
            "|---|---:|---:|---:|",
            *[
                f"| {tool.upper()} | {cc.get(tool + '_seconds', 0):,.2f} | {cc.get(tool + '_rss', 0):,.0f} | {cc.get(tool + '_tokens', 0):,} |"
                for tool in ("auto", "itp")
                if counts["paired_cost_records"]
            ],
            "",
            f"其中 {counts['cost_subset_shared_checks']} 份复用了同一输入和目标已通过的核验。其原始核验合计 {cc.get('shared_check_seconds', 0):,.2f} 秒，最高单进程 RSS 为 {cc.get('shared_check_rss', 0):,.0f} KiB。本表计入本轮绑定、模型、编译与内核活动，共享的既有核验另列。旧反证候选的历史 CLI 没有记录推理强度，未纳入本轮 medium 模型计量。",
            "",
        ]
    n = result["same_native_residuals"]
    c = result["paired_postprocessing_costs"]
    lines.append(
        f"双路线基线产生 {n['residual']} 个需要后处理的执行。ITP 已有 {n['attempted']} 项判定回执，{n.get('awaiting', 0)} 项未取得完整回执。历史目标改变时优先评测当前目标。"
    )
    lines += [
        "",
        f"以下成本仅覆盖两路线都有可计量后处理的 {n['paired_cost_records']} 次相同执行。模型生成、修复、Coq 编译与独立内核检查计入 ITP。只有 ITP 的证明生成调用 gpt-6.1-sol（medium）。共用原生阶段单列。RSS 为各操作系统记录的最大单进程峰值。Auto 与 ITP 判定结果和未决执行在结构化文件中单列。",
        "",
        "| 后处理 | 合计秒 | 峰值 KiB | 实际 token |",
        "|---|---:|---:|---:|",
    ]
    for tool in ("auto", "itp"):
        lines.append(
            f"| {tool.upper()} | {c[tool + '_seconds']:,.2f} | {c[tool + '_rss']:,.0f} | {c[tool + '_tokens']:,} |"
        )
    outcomes = result["same_native_itp_outcomes"]
    lines.extend(
        [
            "",
            f"在全部 {n['residual']} 份共同原始报告上，Auto 有 {n['auto_matches']} 次命中预期，{n.get('auto_UNKNOWN', 0)} 次 UNKNOWN。在上表这 {n['paired_cost_records']} 个同输入、同目标且阶段成本完整的执行中，Auto 命中 {n.get('cost_subset_auto_matches', 0)} 次，ITP 命中 {n.get('cost_subset_itp_matches', 0)} 次。",
            "",
            f"本轮 ITP 已计量 {n.get('metered_cli_calls', 0):,} 次模型调用、{n.get('recorded_model_tokens', 0):,} 个 token，包含失败与修复。旧证明在当前目标上本地重放的成本单列。",
            "",
            "ITP 已取得回执的执行结果为 "
            + "、".join(f"{key} {outcomes[key]}" for key in sorted(outcomes))
            + "。结果按完整执行判定。父 VC 的内核反证另行记录，升级为执行 FAIL 还需证明反例状态从该输入可达。",
            "",
            f"目前有 {n.get('parent_vc_refuted', 0)} 次执行取得父 VC 的正式反证。在已有双方回执的 {n['attempted']} 次执行中，仅 Auto 命中 {n.get('auto_only', 0)} 次，仅 ITP 命中 {n.get('itp_only', 0)} 次，双方均命中 {n.get('both_match', 0)} 次。",
            "",
            "[逐组、逐分歧输入、证据哈希和成本口径](paired-tool-comparison.json) · [总索引](group-result-cost-index.json)",
        ]
    )
    return "\n".join(lines) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--publish", action="store_true")
    args = parser.parse_args()
    index_path = RESULTS / "group-result-cost-index.json"
    index = read(index_path)
    subset = index["auto_original_roots_measurement"]
    if subset["unexpected"]:
        raise ValueError(
            "per-case regression exceptions require explicit matching evidence"
        )
    covered = {
        (g, *k)
        for _, g, _, items in batches(Path("."))
        for (k, detail), r, prev in items
    }
    if len(covered) != subset["executions"]:
        raise ValueError("original-root profile changed")
    finite_coverage = read(RESULTS / "fulminate-coverage.json")
    all_statuses = Counter()
    native_auto = Counter()
    totals = defaultdict(Counter)
    groups = {}
    same_counts, same_outcomes = Counter(), Counter()
    same_costs = defaultdict(list)
    original_profiles = defaultdict(Counter)
    discordant = defaultdict(list)
    refs = {}
    auto_refs = {}
    itp_refs = {}
    profiles = set()
    actual_remainder = 0
    unexpected = {}
    latest_unexpected = {}
    discrepancies = []
    reasons = Counter()
    primary_verdicts = {"cn": Counter(), "qcp": Counter()}
    latest_path = RESULTS / "latest-proof-route-inventory.json"
    latest = read(latest_path) if latest_path.is_file() else None
    latest_counts, latest_outcomes = Counter(), Counter()
    latest_costs = defaultdict(list)
    for e in index["groups"]:
        group = e["program_group"]
        base = RESULTS / group
        current_path = base / "tespec/current-executions.json"
        remaining_path = base / "tespec/auto-remaining.json"
        fulminate_path = base / "fulminate/results.json"
        for tool, verdicts in primary_verdicts.items():
            verdicts[read(base / tool / "results.json")["verdict"]] += 1
        remaining = {}
        if remaining_path.exists():
            overlay = read(remaining_path)
            if overlay["baseline"] != reference(current_path):
                raise ValueError(f"{group}: stale Auto baseline")
            remaining = {coordinates(r): r for r in overlay["executions"]}
            exception_rows = [
                i
                for i, record in enumerate(overlay["executions"])
                if not record["expected_match"]
            ]
            if exception_rows:
                unexpected[group] = {
                    "evidence": reference(remaining_path),
                    "execution_rows": exception_rows,
                }
                reasons.update(
                    overlay["executions"][i]["reason"] for i in exception_rows
                )
        observed = {}
        gstats = defaultdict(Counter)
        current = read(current_path)
        auto_refs[group] = {"native_and_baseline": reference(current_path)}
        if remaining_path.exists():
            auto_refs[group]["remainder"] = reference(remaining_path)
        itp_refs[group] = reference(base / "tespec/current-itp.json")
        frozen_path = base / "tespec/auto-on-itp-roots.json"
        replay = read(frozen_path)
        if replay["baseline"] != reference(current_path):
            raise ValueError("Auto replay is bound to different original goals")
        auto_refs[group]["on_itp_roots"] = reference(frozen_path)
        profiles.add(replay["provenance"]["implementation_sha256"])
        old_receipts = read(base / "tespec/current-itp.json")["executions"]
        count, costs, outcomes = paired_route_costs(
            (row for row in current["executions"] if row["auto_status"] != "NOT_RUN"),
            replay["executions"],
            old_receipts,
        )
        gstats["itp_attempts"] = count
        same_counts.update(count)
        same_outcomes.update(outcomes)
        for k, v in costs.items():
            same_costs[k].extend(v)
        for row in current["executions"]:
            k = coordinates(row)
            if k in remaining:
                if (group, *k) in covered or any(
                    remaining[k][item] != row[item]
                    for item in (
                        "source_sha256",
                        "input_sha256",
                        "expected",
                        "expected_fault_code",
                    )
                ):
                    raise ValueError(f"{group}: different baseline identities")
                actual_remainder += 1
                r = remaining.pop(k)
                status, match = r["effective_status"], r["expected_match"]
            elif (group, *k) in covered:
                status, match = row["expected"], True
            else:
                raise ValueError(f"{group}: absent Auto result {k}")
            observed[k] = row["expected"], match
            all_statuses[status] += 1
            native_auto["executions"] += 1
            native_auto["matches"] += int(match)
            gstats["auto_unique"][status] += 1
            gstats["auto_" + k[2]]["executions"] += 1
            gstats["auto_" + k[2]]["matches"] += int(match)
        if latest:
            inventory = latest["groups"][group]
            auto = {}
            if "auto" in inventory:
                auto_path = ROOT / inventory["auto"]["path"]
                if reference(auto_path) != inventory["auto"]:
                    raise ValueError("Stale latest Auto cost record")
                auto = read(auto_path)["executions"]
            itp_path = base / "tespec/latest-itp.json"
            receipts = read(itp_path)["executions"] if itp_path.exists() else {}
            if receipts.keys() - auto.keys():
                raise ValueError("ITP receipt does not belong to current eligible set")
            for strategy in ("inline", "modular"):
                rows = [v for v in auto.values() if v["strategy"] == strategy]
                if len(rows) != inventory["residuals"].get(strategy, 0):
                    raise ValueError("Missing per-execution Auto evidence")
                count, costs, outs = paired_route_costs(rows, auto, receipts)
                outcome = gstats["latest_" + strategy]
                outcome.update(count)
                for field in (
                    "residual",
                    "attempted",
                    "awaiting",
                    "paired_cost_records",
                ):
                    outcome.setdefault(field, 0)
                for k, v in outs.items():
                    outcome["itp_" + k] = v
                auto_stats = gstats["auto_" + strategy]
                eligible_batch_matches = 0
                for item in rows:
                    expected, match = observed[coordinates(item)]
                    if item["expected"] != expected:
                        raise ValueError("Different oracle on paired routes")
                    eligible_batch_matches += int(match)
                    diagnostic = item.get("additional_budget_diagnostic", {})
                    if diagnostic:
                        if item["effective_status"] == "UNKNOWN":
                            latest_counts["primary_unknown_retried"] += 1
                            latest_counts[
                                "primary_unknown_retried_"
                                + diagnostic["effective_status"]
                            ] += 1
                        latest_counts["budget_diagnostic_runs"] += 1
                        latest_counts[
                            "budget_diagnostic_" + diagnostic["effective_status"]
                        ] += 1
                    for rerun in item.get("additional_profile_runs", {}).values():
                        latest_counts["additional_profile_runs"] += 1
                        latest_counts["additional_profile_" + rerun["status"]] += 1
                    if item["effective_status"] != item["batch_auto_status"]:
                        retry = item.get("same_budget_diagnostic")
                        discrepancies.append(
                            {
                                "group": group,
                                "case": item["case"],
                                "variant": item["variant"],
                                "strategy": strategy,
                                "native_report_sha256": item["native_report_sha256"],
                                "batch": item["batch_auto_status"],
                                "one_input": item["effective_status"],
                                "diagnostic": retry["effective_status"]
                                if retry
                                else None,
                                "extended_budget": {
                                    k: item["additional_budget_diagnostic"][k]
                                    for k in ("timeout_ms", "effective_status")
                                }
                                if item.get("additional_budget_diagnostic")
                                else None,
                            }
                        )
                    receipt = receipts.get(item["native_report_sha256"])
                    if (
                        receipt
                        and not receipt.get("needs_model")
                        and not receipt.get("expected_match")
                    ):
                        latest_unexpected.setdefault(group, []).append(
                            item["native_report_sha256"]
                        )
                outcome["native_matches"] = (
                    auto_stats["matches"] - eligible_batch_matches
                )
                outcome["native_only_executions"] = auto_stats["executions"] - len(rows)
                outcome["total_itp_matches"] = (
                    outcome["native_matches"] + count["both_match"] + count["itp_only"]
                )
                latest_counts.update(outcome)
                latest_outcomes.update(outs)
                for k, v in costs.items():
                    latest_costs[k].extend(v)
            if itp_path.exists():
                itp_refs[group] = {
                    "frozen_401": itp_refs[group],
                    "current": reference(itp_path),
                }
        if remaining:
            raise ValueError("orphan Auto records")
        ful = read(fulminate_path)
        cases = ful.get("cases", ful.get("runs", []))
        tasks, pairings, _ = inputs(group)
        mapping = defaultdict(set)
        for (variant, case_id, strategy), cn_names in pairings.items():
            for name in cn_names:
                mapping[name, case_id].add(variant)
        no_contract = {
            (scope["variant"], case_id)
            for scope in finite_coverage["groups"][group]["scope_exceptions"]
            if scope["kind"] == "target_contract_na"
            for case_id in scope["cases"]
        }
        plan = read(ROOT / "benchmark/programs" / group / "evaluation-plan.json")
        different_contract = {
            (pair["cn_variant"], case["id"], pair["qcp_variant"])
            for pair in plan["pairings"]
            if pair.get("contract_comparison", {}).get("same_contract_comparison")
            is False
            for case in pair["cases"]
        }
        seen = set()
        for r in cases:
            case_id = r.get("case", r.get("case_id"))
            name = r["variant"]
            qcp = r.get("paired_qcp_variant", r.get("qcp_variant"))
            candidates = mapping[name, case_id]
            if qcp is None:
                if len(candidates) != 1:
                    raise ValueError(f"{group}: ambiguous CN/QCP pairing")
                (qcp,) = candidates
            pair = (name, case_id, qcp)
            if qcp not in candidates or pair in seen:
                raise ValueError(f"{group}: invalid pairing {pair}")
            seen.add(pair)
            raw = r.get(
                "raw_actual",
                r.get(
                    "actual", r.get("status", r.get("runtime_test", {}).get("status"))
                ),
            )
            checked = r.get("matches_expected", r.get("correct"))
            if checked is None:
                checked = r.get("actual", r.get("status")) == r["expected"]
            for strategy in ("inline", "modular"):
                expected, auto_ok = observed[qcp, case_id, strategy]
                if (
                    raw in ("NOT_BUILT", "COMPILE_ERROR", "BUILD_ERROR", "NOT_RUN")
                    or r.get("executed") is False
                ):
                    outcome = "unavailable_fulminate"
                elif (name, case_id) in no_contract or r.get(
                    "contract_checked"
                ) is False:
                    outcome = "body_only"
                elif pair in different_contract:
                    outcome = "different_contract"
                elif expected != r["expected"]:
                    outcome = "different_expected"
                else:
                    outcome = {
                        (True, True): "both_match",
                        (True, False): "tespec_only",
                        (False, True): "fulminate_only",
                        (False, False): "neither_match",
                    }[bool(auto_ok), bool(checked)]
                if outcome in ("tespec_only", "fulminate_only"):
                    discordant[group].append([name, qcp, case_id, strategy, outcome])
                if "locked_original" in r:
                    original_profiles[strategy].update(
                        {
                            "input_pairs": 1,
                            "auto_matches": int(auto_ok),
                            "original_not_built": int(
                                r["locked_original"].get("status") == "NOT_BUILT"
                            ),
                            "adapted_fulminate_matches": int(checked),
                        }
                    )
                gstats[strategy][outcome] += 1
                totals[strategy][outcome] += 1
        if seen != {(name, c, q) for (name, c), vs in mapping.items() for q in vs}:
            raise ValueError(
                f"{group}: Fulminate outcomes do not cover the declared pairs"
            )
        groups[group] = dict(gstats)
        refs[group] = reference(fulminate_path)
    result = {
        "schema": "paired-tool-comparison/v1",
        "auto_implementation_sha256": subset["implementation_sha256"],
        "unique_auto": dict(native_auto),
        "outcomes": dict(all_statuses),
        "fresh_remainder": actual_remainder,
        "input_pairs": sum(totals["inline"].values()),
        "paired": dict(totals),
        "result_cohort_digest": digest(subset),
        "auto_evidence": auto_refs,
        "itp_evidence": itp_refs,
        "paired_cost_baseline_hashes": sorted(profiles, key=str),
        "contract_scope_evidence": reference(RESULTS / "fulminate-coverage.json"),
        "primary_verdicts": primary_verdicts,
        "groups": groups,
        "fulminate_evidence": refs,
        "discordant": dict(discordant),
        "compatibility_profile": dict(original_profiles),
        "same_native_residuals": dict(same_counts),
        "same_native_itp_outcomes": dict(same_outcomes),
        "paired_postprocessing_costs": {
            k: (max(v) if k.endswith("rss") else sum(v))
            for k, v in same_costs.items()
            if v
        },
    }
    native_path = RESULTS / "latest-native-costs.json"
    if native_path.is_file():
        native = read(native_path)["totals"]
        if native["executions"] != native_auto["executions"]:
            raise ValueError("Native costs cover a different matrix")
        result["native_costs"] = {
            "evidence": reference(native_path),
            "totals": {
                k: v
                for k, v in native.items()
                if isinstance(v, (int, float)) or k in ("layout_prepare", "batch_auto")
            },
        }
    if latest:
        if latest_counts["residual"] != latest["residuals"]:
            raise ValueError("Current residual count differs from inventory")
        result["latest_routes"] = {
            "inventory": reference(latest_path),
            "counts": dict(latest_counts),
            "itp_residual_outcomes": dict(latest_outcomes),
            "auto_batch_vs_single": discrepancies,
            "paired_postprocessing_costs": {
                k: (max(v) if k.endswith("rss") else sum(v))
                for k, v in latest_costs.items()
                if v
            },
        }
    print(
        {
            k: v
            for k, v in result.items()
            if k
            not in (
                "groups",
                "fulminate_evidence",
                "discordant",
                "auto_evidence",
                "itp_evidence",
            )
        }
    )
    if args.publish:
        anomalies = RESULTS / "tespec-unexpected/auto-full-matrix.json"
        save(
            anomalies,
            {
                "schema": "tespec-auto-full-matrix-unexpected/v1",
                "executions": native_auto["executions"],
                "matches": native_auto["matches"],
                "unexpected": sum(reasons.values()),
                "native_reasons": reasons,
                "groups": unexpected,
                "reproduce": "python3 tools/benchmark/measure_current_executions.py --reproduce --group GROUP --case CASE --variant VARIANT --strategy STRATEGY --scratch SCRATCH --workers 1",
                "scope": "Zero-based indexes into executions in each cited receipt. Retain source, input, native report and original goal SHA-256, both verdict stages, oracle, timed-out retries and measured costs. Consult current-itp.json only for the same native report and goal.",
            },
        )
        result["unexpected_evidence"] = reference(anomalies)
        if latest:
            err = RESULTS / "tespec-unexpected/latest-itp.json"
            save(
                err,
                {
                    "schema": "tespec-latest-itp-unexpected/v1",
                    "native_only_unexpected": reference(anomalies),
                    "groups": {
                        g: {
                            "receipts": itp_refs[g]["current"],
                            "single_native_reports": keys,
                        }
                        for g, keys in latest_unexpected.items()
                    },
                    "scope": "Exceptions with a finished ITP attempt, indexed by exact single-input native report. No-model native-only outcomes are shared by both routes. Pending attempts are counted in the separate comparison.",
                },
            )
            result["latest_routes"]["unexpected_evidence"] = reference(err)
        save(RESULTS / "paired-tool-comparison.json", result)
        index["four_tool_measurement"] = {
            "schema": "four-tool-measured-coverage/v1",
            "comparison": reference(RESULTS / "paired-tool-comparison.json"),
            "scope": "Current measured executions and costs. complete_groups elsewhere retains the historical four-tool archival profile.",
            "groups": len(groups),
            "cn_main_observed": len(groups),
            "qcp_main_observed": len(groups),
            "fulminate_executed_pairs": result["input_pairs"],
            "auto_executions": native_auto["executions"],
            "auto_matches": native_auto["matches"],
            "itp_residuals": same_counts["residual"],
            "itp_attempted": same_counts["attempted"],
            "itp_awaiting": same_counts["awaiting"],
            "groups_all_residuals_attempted": sum(
                g["itp_attempts"]["attempted"] == g["itp_attempts"]["residual"]
                for g in groups.values()
            ),
            "itp_pairs_with_observed_phase_costs": same_counts["paired_cost_records"],
        }
        if latest:
            four = index["four_tool_measurement"]
            four["historical_401"] = {
                k: four[k]
                for k in (
                    "itp_residuals",
                    "itp_attempted",
                    "itp_awaiting",
                    "groups_all_residuals_attempted",
                    "itp_pairs_with_observed_phase_costs",
                )
            }
            four.update(
                itp_residuals=latest_counts["residual"],
                itp_attempted=latest_counts["attempted"],
                itp_awaiting=latest_counts["awaiting"],
                itp_pairs_with_observed_phase_costs=latest_counts[
                    "paired_cost_records"
                ],
                groups_all_residuals_attempted=sum(
                    all(
                        g["latest_" + s]["residual"] == g["latest_" + s]["attempted"]
                        for s in ("inline", "modular")
                    )
                    for g in groups.values()
                ),
            )
        import json

        index_path.write_text(json.dumps(index, ensure_ascii=False, indent=2) + "\n")
        (RESULTS / "paired-tool-comparison.md").write_text(markdown(result))


if __name__ == "__main__":
    main()
