#!/usr/bin/env python3
"""Publish measured modular native runs without changing historical certificates."""
from pathlib import Path
from collections import Counter
import argparse,csv,hashlib,json,sys
ROOT=Path(__file__).resolve().parents[2]
def load(p): return json.loads(p.read_text())
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,data):
    p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(json.dumps(data,ensure_ascii=False,indent=2)+"\n")
def checked(ref):
    p=Path(ref["path"]); p=p if p.is_absolute() else ROOT/p
    if sha(p)!=ref["sha256"]: raise ValueError("Evidence changed: "+str(p))
    return p
def mean(xs): return sum(xs)/len(xs) if xs else None
def matches(x):
    return (x["current"]["status"]==x["expected"] and
            x["measurement"]["exit_code"] in (0,1) and
            (x["expected"]!="ERROR" or x["comparison"]["ok"]))
def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--results",type=Path,required=True)
    p.add_argument("--run-id",default="20261020")
    args=p.parse_args()
    if not args.run_id.isdigit():p.error("run-id must be a date")
    input_path=args.results.resolve();data=load(input_path)
    summary=data["summary"];coverage=summary["coverage"]
    if not (summary["run_complete"] and summary["unchanged_evidence"] and
            coverage["execution_strategy"]=="modular" and coverage["full_complete_group_suite"]):
        raise ValueError("Expected a completed, immutable, full modular native run")
    rows=data["runs"];reports={}
    ids={(x["group"],x["variant"],x["case"],x["mode"]) for x in rows}
    if len(ids)!=len(rows) or len(rows)!=coverage["executions"]:raise ValueError("Coverage mismatch")
    for x in rows:
        checked(x["source"]);checked(x["binds"])
        report=load(checked(x["report"]))
        if len(report["results"])!=1:raise ValueError("Expected one report result")
        case=report["results"][0]
        if case["status"]!=x["current"]["status"]:raise ValueError("Status mismatch")
        raw=Path(case["stdout"]);payload=load(raw);spec=payload.get("spec_test",{})
        if spec.get("execution_strategy")!="modular":raise ValueError("Not modular")
        for f in x["vc_artifacts"]:checked(f)
        reports[(x["group"],x["variant"],x["case"],x["mode"])]=(case,payload,raw)
    index=[];unexpected=[]
    for group in coverage["selected_groups"]:
        group_rows=[x for x in rows if x["group"]==group]
        folder=ROOT/"benchmark/results"/group/"modular"/args.run_id
        costs=[];modes={};case_rows=[]
        for mode in ("off","on"):
            selected=[x for x in group_rows if x["mode"]==mode]
            unknown=sum(x["current"]["status"]=="UNKNOWN" for x in selected)
            pending=sum(x["current"]["status"]=="UNKNOWN" and x["current"].get("execution_completed")
                        and bool(x["current"].get("residual_vcs")) for x in selected)
            blocked=unknown-pending
            modes[mode]={"executions":len(selected),
                "native_status_counts":dict(Counter(x["current"]["status"] for x in selected)),
                "native_expected_matches":sum(matches(x) for x in selected),
                "unknown_executions":unknown,"executions_requiring_itp":pending,"blocked_unknown_executions":blocked,
                "itp_status":"PENDING" if pending else ("BLOCKED" if blocked else "NOT_REQUIRED"),
                "evaluation_complete":all(matches(x) for x in selected)}
            for label,key in [("native_cli","native_cli"),("symbolic_executor","symbolic_executor")]:
                stage=[x["stage_measurements"][key] for x in selected]
                seconds=[v["wall_seconds"] for v in stage if v and v.get("wall_seconds") is not None]
                if label=="native_cli":
                    rss=[v["resources"]["max_process_rss_kib"]/1024 for v in stage if v and v.get("resources")]
                else:rss=[v["peak_rss_kib"]/1024 for v in stage if v and v.get("peak_rss_kib") is not None]
                costs.append({"mode":mode,"stage":label,"executions":len(selected),
                    "mean_wall_seconds":mean(seconds),"mean_peak_process_rss_mib":mean(rss),
                    "mean_tokens":0,"status":"MEASURED" if len(seconds)==len(rss)==len(selected) else "PENDING",
                    "memory_scope":"Mean of per-execution maximum process RSS; never batch peak / count."})
            spatial=[v for x in selected for v in x["stage_measurements"]["spatial_smt"]]
            seconds=[v["wall_seconds"] for v in spatial]
            rss=[v["sampled_peak_process_rss_kib"]/1024 for v in spatial if v.get("sampled_peak_process_rss_kib") is not None]
            costs.append({"mode":mode,"stage":"spatial_smt","executions":len(spatial),
                "mean_wall_seconds":mean(seconds),"mean_peak_process_rss_mib":mean(rss),
                "mean_tokens":0,"status":"MEASURED" if spatial else "NOT_REQUIRED",
                "memory_scope":"1 ms sampled process RSS peak including stage entry/exit; observed, not exact."})
            for label in ("agent_proof_filling","coq_compilation_and_assumption_audit","independent_kernel_check"):
                costs.append({"mode":mode,"stage":label,"executions":pending,
                    "mean_wall_seconds":None,"mean_peak_process_rss_mib":None,"mean_tokens":None,
                    "status":"PENDING" if pending else ("BLOCKED" if blocked else "NOT_REQUIRED"),
                    "memory_scope":"No new ITP attempt; historical conclusions are comparison oracles only."})
        for x in group_rows:
            key=(group,x["variant"],x["case"],x["mode"])
            case,payload,raw=reports[key]
            spec=payload.get("spec_test",{})
            pair=next(y for y in group_rows if y["variant"]==x["variant"] and y["case"]==x["case"] and y["mode"]!=x["mode"])
            item={"group":group,"variant":x["variant"],"case":x["case"],"spatial_smt":x["mode"],
                "execution_strategy":"modular","execution_mode":x["measurement"]["command"][x["measurement"]["command"].index("--execution-mode")+1],
                "result_scope":case.get("result_scope",spec.get("result_scope")),
                "declaration_call_policy":spec.get("declaration_call_policy"),
                "expected":x["expected"],"native_status":x["current"]["status"],
                "final_status":x["current"]["status"],"matched":matches(x),
                "reason":x["current"]["reason"],"execution_completed":x["current"].get("execution_completed"),
                "precondition_result":x["current"].get("precondition_result"),
                "source":x["source"],"binds":x["binds"],"report":x["report"],
                "raw":{"path":str(raw.relative_to(ROOT)),"sha256":sha(raw)},
                "vc_artifacts":x["vc_artifacts"],"reproduce_command":x["measurement"]["command"],
                "stdout":x["measurement"]["stdout"],"stderr":x["measurement"]["stderr"],
                "stage_measurements":x["stage_measurements"],
                "opposite_spatial_mode_status":pair["current"]["status"],
                "historical_itp_comparison_oracle":x["itp_comparison_oracle"],
                "itp_conclusion":("PENDING" if x["current"].get("execution_completed") and x["current"].get("residual_vcs")
                                  else "BLOCKED_NO_COMPLETE_EXECUTION_TARGET") if x["current"]["status"]=="UNKNOWN" else "NOT_REQUIRED",
                "sampling_events":case.get("sampling_events",[]),
                "spatial_smt_reason":(x["current"].get("spatial_smt") or {}).get("reason")}
            case_rows.append(item)
            if not matches(x):unexpected.append(item)
        result={"schema":"tespec-modular-group-supplement/v1","program_group":group,
            "run_id":args.run_id,"execution_strategy":"modular","native_run_complete":True,
            "evaluation_complete":all(x["matched"] for x in case_rows),
            "case_pairs":len(group_rows)//2,"modes":modes,"costs":costs,"cases":case_rows,
            "parent_results":{"path":str(input_path.relative_to(ROOT)),"sha256":sha(input_path)},
            "new_model_calls":0,"native_tokens":0,"new_itp_certificates":0,
            "scope":"Modular native supplement. CN/QCP/Fulminate historical evidence is referenced by the primary group table. Pending ITP is not successful detection.",
            "cost_policy":"Times are nested, not additive. Display means of per-execution time and peak RSS. Historical proof costs are not charged as new execution costs."}
        save(folder/"result-cost.json",result)
        with (folder/"result-cost.csv").open("w",newline="") as f:
            writer=csv.DictWriter(f,fieldnames=list(costs[0]));writer.writeheader();writer.writerows(costs)
        lines=["# "+group+"：modular 结果与成本","",
            "已执行全部 "+str(result["case_pairs"])+" 对已有输入，空间 SMT OFF/ON。原生结果和所需 ITP 完整性分别记录。",
            "","| 模式 | PASS / FAIL / UNKNOWN / ERROR | 原生预期匹配 | 待处理 UNKNOWN |",
            "| --- | --- | ---: | ---: |"]
        for mode,v in modes.items():
            lines.append("| %s | %s | %d/%d | %d |"%(mode," / ".join(str(v["native_status_counts"].get(k,0)) for k in ["PASS","FAIL","UNKNOWN","ERROR"]),v["native_expected_matches"],v["executions"],v["unknown_executions"]))
        lines+=["","| 模式 | 阶段 | 平均秒 | 平均单次峰值 MiB | 平均 token | 状态 |","| --- | --- | ---: | ---: | ---: | --- |"]
        def fmt(v):return "—" if v is None else "%.6f"%v
        for v in costs:lines.append("| %s | %s | %s | %s | %s | %s |"%(v["mode"],v["stage"],fmt(v["mean_wall_seconds"]),fmt(v["mean_peak_process_rss_mib"]),fmt(v["mean_tokens"]),v["status"]))
        lines+=["","CLI、执行器、空间 SMT 是嵌套阶段，不能相加。空间阶段 RSS 为1ms采样峰值。每次执行的全部残余VC组成一个ITP任务；未跑的证明阶段保留PENDING/null，UNKNOWN不算成功。",
            "","CN/QCP 主验证及 Fulminate 仍见 [原组表](../../result-cost.md)。[逐次证据与成本](result-cost.json)；[成本CSV](result-cost.csv)。"]
        (folder/"result-cost.md").write_text("\n".join(lines)+"\n")
        pointer={k:result[k] for k in ["program_group","run_id","execution_strategy","native_run_complete","evaluation_complete","case_pairs","modes"]}
        pointer.update({k:str((folder/("result-cost."+ext)).relative_to(ROOT)) for k,ext in [("report","md"),("json","json"),("csv","csv")]})
        save(folder.parent/"index.json",pointer);index.append(pointer)
    ledger=ROOT/"benchmark/results/tespec-unexpected"/("recheck-"+args.run_id+"-completed-modular.json")
    save(ledger,{"schema":"tespec-unexpected-recheck/v1","scope":"Full completed-group modular supplement; historical classifications unchanged.",
                 "executions":len(rows),"unmatched":len(unexpected),"results":unexpected})
    target=ROOT/"benchmark/results/modular-result-cost-index.json"
    save(target,{"schema":"tespec-modular-cost-index/v1","groups":index,
        "groups_total":len(index),"native_complete_groups":len(index),
        "fully_matched_native_groups":sum(x["evaluation_complete"] for x in index),
        "case_pairs":coverage["case_pairs"],"executions":len(rows),
        "unmatched":len(unexpected),"unexpected_ledger":str(ledger.relative_to(ROOT)),
        "scope":"Native modular supplement; UNKNOWN/PENDING is incomplete. Original group complete flags retain historical evaluation scope."})
    lines=["# Modular 各组结果与成本","",
           "| 程序组 | 输入对 | OFF 原生匹配 | ON 原生匹配 | UNKNOWN OFF / ON |",
           "| --- | ---: | ---: | ---: | ---: |"]
    for x in index:
        off,on=x["modes"]["off"],x["modes"]["on"]
        lines.append("| [%s](%s) | %d | %d/%d | %d/%d | %d / %d |"%(x["program_group"],x["report"].removeprefix("benchmark/results/"),x["case_pairs"],off["native_expected_matches"],off["executions"],on["native_expected_matches"],on["executions"],off["unknown_executions"],on["unknown_executions"]))
    lines+=["","全部已有变体和输入均已实际执行。UNKNOWN不算成功；证明阶段PENDING不计零成本。"]
    target.with_suffix(".md").write_text("\n".join(lines)+"\n")
    print(json.dumps({"groups":len(index),"executions":len(rows),"unmatched":len(unexpected)}))
    itp_index=ROOT/"benchmark/results/modular-itp"/args.run_id/"index.json"
    if itp_index.exists() and load(itp_index).get("complete"):
        from attach_modular_itp import main as attach
        attach(itp_index)

if __name__=="__main__": main()
