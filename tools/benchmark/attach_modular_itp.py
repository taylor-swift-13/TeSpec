#!/usr/bin/env python3
"""Attach exact per-execution kernel receipts; preserve native decisions and all costs."""
from pathlib import Path
import argparse,csv,json,shutil,statistics
from meter_read_itp_coq import ROOT,save,sha
from collect_modular_itp import audit
def main(index_path):
 index=json.loads(index_path.read_text());assert index["complete"] and not index["pending_execution_indices"]
 accepted={}
 for e in index["executions"]:
  rp=ROOT/e["receipt"]["path"];assert sha(rp)==e["receipt"]["sha256"]
  receipt=json.loads(rp.read_text());audit(receipt,e["binding"])
  key=(e["group"],e["variant"],e["case"],e["mode"]);assert key not in accepted
  accepted[key]=e
 globalpath=ROOT/"benchmark/results/modular-result-cost-index.json";globalindex=json.loads(globalpath.read_text());runid="20261020"
 ready=set()
 for g in globalindex["groups"]:
  for c in json.loads((ROOT/g["json"]).read_text())["cases"]:
   if c["itp_conclusion"] in ["PENDING","KERNEL_CHECKED_REFUTATION"]:
    ready.add((c["group"],c["variant"],c["case"],c["spatial_smt"]))
 assert ready==set(accepted),"Unmatched or extra per-execution proof coverage"
 snap=index_path.parent/"native-before-itp";snap.mkdir(exist_ok=True)
 if not (snap/globalpath.name).exists():shutil.copy2(globalpath,snap/globalpath.name)
 all_cases=[];groups=[]
 for pointer in globalindex["groups"]:
  gp=ROOT/pointer["json"];data=json.loads(gp.read_text());group=data["program_group"];folder=gp.parent
  archive=snap/group;archive.mkdir(exist_ok=True)
  for name in ["result-cost.json","result-cost.md","result-cost.csv"]:
   if not (archive/name).exists():shutil.copy2(folder/name,archive/name)
  for case in data["cases"]:
   key=(group,case["variant"],case["case"],case["spatial_smt"]);case.setdefault("native_matched",case["matched"])
   case.setdefault("native_reason",case["reason"]);case.setdefault("final_reason",case["reason"])
   case.setdefault("original_status",case["native_status"])
   if key not in accepted:continue
   e=accepted[key];b=e["binding"]
   assert case["native_status"]=="UNKNOWN" and case["execution_completed"] and case["expected"]=="FAIL"
   assert b["report"]==case["report"] and b["source"]==case["source"] and b["binds"]==case["binds"]
   assert b["goal"]==next(x for x in case["vc_artifacts"] if x["kind"]=="goal")
   case.update(final_status="FAIL",final_reason="coq_kernel_refuted_all_original_residual_vcs",matched=True,itp_conclusion="KERNEL_CHECKED_REFUTATION",
               itp={"status":e["status"],"final_status":e["final_status"],"receipt":e["receipt"],"metrics":e["metrics"],
                    "scope":index["scope"]})
  data["costs"]=[x for x in data["costs"] if x["stage"] not in ["itp_total","additional_entry_exit_diagnostic"]]
  for mode in ["off","on"]:
   cases=[x for x in data["cases"] if x["spatial_smt"]==mode]
   finished=[accepted[(group,x["variant"],x["case"],mode)] for x in cases if (group,x["variant"],x["case"],mode) in accepted]
   v=data["modes"][mode];v.setdefault("native_unknown_executions",v["unknown_executions"])
   v["final_status_counts"]={s:sum(x["final_status"]==s for x in cases) for s in ["PASS","FAIL","UNKNOWN","ERROR"]}
   v["final_expected_matches"]=sum(x["matched"] for x in cases);v["completed_itp_executions"]=len(finished)
   v["unknown_executions"]=sum(x["final_status"]=="UNKNOWN" for x in cases)
   v["pending_itp_executions"]=sum(x["itp_conclusion"]=="PENDING" for x in cases)
   v["evaluation_complete"]=all(x["matched"] for x in cases)
   v["itp_status"]="MEASURED" if finished else ("BLOCKED" if v["blocked_unknown_executions"] else "NOT_REQUIRED")
   for label,timekey in [("agent_proof_filling","agent_proof_filling_seconds"),("coq_compilation_and_assumption_audit","coq_compile_audit_seconds"),("independent_kernel_check","independent_kernel_check_seconds")]:
    cost=next(x for x in data["costs"] if x["mode"]==mode and x["stage"]==label)
    if not finished:continue
    cost.update(executions=len(finished),mean_wall_seconds=statistics.mean(x["metrics"][timekey] for x in finished),
       mean_peak_process_rss_mib=statistics.mean(x["metrics"]["peak_process_memory_mib"][label] for x in finished),
       mean_tokens=statistics.mean(x["metrics"]["tokens"] for x in finished) if label=="agent_proof_filling" else 0,
       status="MEASURED",memory_scope="Mean per-execution stage maximum across all attempts; Windows model client peak or Linux Coq process RSS. Remote service/GPU excluded.")
   data["costs"].append({"mode":mode,"stage":"itp_total","executions":len(finished),
       "mean_wall_seconds":statistics.mean(x["metrics"]["total_seconds"] for x in finished) if finished else None,
       "mean_peak_process_rss_mib":statistics.mean(x["metrics"]["peak_process_memory_mib"]["itp"] for x in finished) if finished else None,
       "mean_tokens":statistics.mean(x["metrics"]["tokens"] for x in finished) if finished else None,
       "status":"MEASURED" if finished else ("BLOCKED" if v["blocked_unknown_executions"] else "NOT_REQUIRED"),
       "memory_scope":"Mean per-execution maximum across stages; total overlaps the three proof stage rows, never add twice."})
  diagnostic=index_path.parent/"additional-native-diagnostic-costs.json"
  if group=="array_load" and diagnostic.exists():
   extra=json.loads(diagnostic.read_text())
   data["additional_native_diagnostics"]={"path":str(diagnostic.relative_to(ROOT)),"sha256":sha(diagnostic),"scope":extra["scope"]}
   for m,c in extra["modes"].items():
    data["costs"].append({"mode":m,"stage":"additional_entry_exit_diagnostic","executions":c["executions"],
      "mean_wall_seconds":c["mean_wall_seconds"],"mean_peak_process_rss_mib":c["mean_peak_process_rss_mib"],"mean_tokens":0,
      "status":"MEASURED","memory_scope":"Additional diagnostic: mean per-execution maximum across two actual invocations including configuration retry; not part of ITP total."})
  data["evaluation_complete"]=all(x["matched"] for x in data["cases"])
  data["new_model_calls"]=sum(x["itp"]["metrics"]["model_calls"] for x in data["cases"] if x.get("itp"))
  data["new_itp_certificates"]=sum(bool(x.get("itp")) for x in data["cases"])
  data["new_model_tokens"]=sum(x["itp"]["metrics"]["tokens"] for x in data["cases"] if x.get("itp"))
  data["itp_index"]={"path":str(index_path.relative_to(ROOT)),"sha256":sha(index_path)}
  data.setdefault("native_scope",data["scope"])
  data["scope"]="Modular native runs with appended independently metered per-execution ITP; original native decisions and source/goal evidence preserved."
  save(gp,data)
  with (folder/"result-cost.csv").open("w",newline="") as f:
   w=csv.DictWriter(f,fieldnames=list(data["costs"][0]));w.writeheader();w.writerows(data["costs"])
  lines=["# "+group+"：modular 结果与成本","","原生分类保持；最终分类附加逐次内核检查的ITP结论。",
     "","| 模式 | 原生 PASS/FAIL/UNKNOWN/ERROR | 最终 PASS/FAIL/UNKNOWN/ERROR | 最终匹配 | 已完成ITP |",
     "| --- | --- | --- | ---: | ---: |"]
  for m,v in data["modes"].items():
   lines.append("| %s | %s | %s | %d/%d | %d |"%(m," / ".join(str(v["native_status_counts"].get(k,0)) for k in ["PASS","FAIL","UNKNOWN","ERROR"]),
      " / ".join(str(v["final_status_counts"].get(k,0)) for k in ["PASS","FAIL","UNKNOWN","ERROR"]),v["final_expected_matches"],v["executions"],v["completed_itp_executions"]))
  lines+=["","| 模式 | 阶段 | 执行数 | 平均秒 | 平均单次峰值MiB | 平均token | 状态 |","| --- | --- | ---: | ---: | ---: | ---: | --- |"]
  def fmt(x):return "—" if x is None else "%.6f"%x
  for c in data["costs"]:lines.append("| %s | %s | %d | %s | %s | %s | %s |"%(c["mode"],c["stage"],c["executions"],fmt(c["mean_wall_seconds"]),fmt(c["mean_peak_process_rss_mib"]),fmt(c["mean_tokens"]),c["status"]))
  lines+=["","ITP按一次执行全部残余VC计量，所有模型/编译/内核失败与修复均计入；只展示条件均值和逐执行阶段峰值均值。使用gpt-6.1-sol实际CLI计量审阅完全相同原始Goal的历史证书，每次仍单独编译、假设审计和完整独立coqchk。不是从零证明搜索；没有把旧证明成本重复计费。",
      "","原生CLI/执行器/空间SMT为嵌套阶段，不能相加。证明三个阶段分别计量，itp_total与三个分项重叠不可再次相加；远程模型内存不在本地RSS范围内。BLOCKED表示执行未完成，无整次执行VC目标，未伪造ITP时间。",
      "","[完整逐次证据](result-cost.json)；[成本CSV](result-cost.csv)；[原四工具组表](../../result-cost.md)。"]
  (folder/"result-cost.md").write_text("\n".join(lines)+"\n")
  pointer.update(evaluation_complete=data["evaluation_complete"],modes=data["modes"])
  save(folder.parent/"index.json",pointer);groups.append(pointer);all_cases+=data["cases"]
 globalindex.update(groups=groups,fully_adjudicated_groups=sum(x["evaluation_complete"] for x in groups),
   native_unmatched=sum(not x["native_matched"] for x in all_cases),
   unmatched=sum(not x["matched"] for x in all_cases),completed_itp_executions=len(accepted),itp_index=str(index_path.relative_to(ROOT)))
 globalindex["scope"]="Modular native runs plus separately model-reviewed, Coq-compiled, assumption-audited and independently kernel-checked per-execution ITP. Historical original group flags retain their own scope."
 save(globalpath,globalindex)
 lines=["# Modular 各组结果与成本","","| 程序组 | 输入对 | OFF最终匹配 | ON最终匹配 | 剩余UNKNOWN OFF/ON |","| --- | ---: | ---: | ---: | ---: |"]
 for x in groups:
  off,on=x["modes"]["off"],x["modes"]["on"]
  lines.append("| [%s](%s) | %d | %d/%d | %d/%d | %d / %d |"%(x["program_group"],x["report"].removeprefix("benchmark/results/"),x["case_pairs"],off["final_expected_matches"],off["executions"],on["final_expected_matches"],on["executions"],off["unknown_executions"],on["unknown_executions"]))
 lines+=["","原生与ITP后最终分类均保留；独立逐次ITP成本见各组表。BLOCKED未完成执行不算成功。"]
 globalpath.with_suffix(".md").write_text("\n".join(lines)+"\n")
 ledgerpath=ROOT/globalindex["unexpected_ledger"];ledger=json.loads(ledgerpath.read_text())
 for c in ledger["results"]:
  updated=next(x for x in all_cases if (x["group"],x["variant"],x["case"],x["spatial_smt"])==(c["group"],c["variant"],c["case"],c["spatial_smt"]))
  c.update(updated)
  c["classification"]="RESOLVED_ITP_KERNEL_REFUTATION" if c.get("itp") else "BLOCKED_EXECUTION_INCOMPLETE"
 ledger.update(native_unmatched=len(ledger["results"]),resolved_after_itp=sum(x["matched"] for x in ledger["results"]),unmatched=sum(not x["matched"] for x in ledger["results"]))
 save(ledgerpath,ledger)
 print(json.dumps({"itp_completed":len(accepted),"unmatched_after_itp":globalindex["unmatched"],"groups_complete":globalindex["fully_adjudicated_groups"]}))
if __name__=="__main__":
 p=argparse.ArgumentParser();p.add_argument("--itp-index",type=Path,required=True);a=p.parse_args();main(a.itp_index.resolve())
