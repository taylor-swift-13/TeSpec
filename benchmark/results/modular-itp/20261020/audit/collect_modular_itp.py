#!/usr/bin/env python3
"""Audit all actual per-execution model/Coq attempts and publish conditional mean costs."""
from pathlib import Path
from collections import Counter
import argparse,json,re,shutil,sys,statistics
from meter_read_itp_coq import ROOT,COQ,save,sha
from modular_execution_itp import statements,OUT
def audit(receipt,binding):
 assert binding["expected"]=="FAIL"
 assert receipt["status"]=="KERNEL_CHECKED" and receipt["final_status"]=="FAIL"
 assert receipt["kernel_check"]["exit_code"]==0
 assert receipt["execution_index"]==binding["execution_index"]
 kernel=receipt["kernel_check"]["command"]
 assert Path(kernel[0])==COQ/"coqchk" and kernel[-1]=="Candidate"
 assert "-norec" not in kernel and "-admit" not in kernel
 assert receipt["binding"]==binding
 for key in ["source","binds","report","goal"]:
  assert sha(ROOT/binding[key]["path"])==binding[key]["sha256"]
 candidate=ROOT/receipt["candidate"];assert sha(candidate)==receipt["candidate_sha256"]
 assert statements(candidate.read_text())==[tuple(x) for x in binding["theorems"]]
 reference_text=(candidate.parent/"ReferenceProof.v").read_text()
 prefix=reference_text[:re.search(r"\bTheorem\s+",reference_text).start()]
 canonical=prefix+"\nRequire Import ReferenceProof.\n"+"".join("Theorem "+n+" : "+v+".\nProof. exact ReferenceProof."+n+". Qed.\n" for n,v in binding["theorems"])+"".join("Print Assumptions "+n+".\n" for n,v in binding["theorems"])
 assert "".join(candidate.read_text().split())=="".join(canonical.split()),"Changed scope/header or noncanonical exact-certificate reference"

 assert not re.search(r"\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b",candidate.read_text())
 names=[n for n,t in binding["theorems"]]
 for n in binding["residual_vcs"]:
  target=binding["goal_module"]+"."+n.removeprefix("proof_of_")
  assert any(re.search(r"~\s*"+re.escape(target)+r"\b",t) for _,t in binding["theorems"]),target
 assert any(t==binding["goal_module"]+"."+binding["group"]+"_precondition_wit_1" or t.endswith("_precondition_wit_1") for _,t in binding["theorems"])
 assert receipt["assumptions"]["new_axioms"]==[]
 raw=(ROOT/receipt["assumptions"]["raw_audit"]).read_text()
 assert raw.count("Closed under the global context")==len(names) and not raw.replace("Closed under the global context","").strip()
 for stage in receipt["compilation"]+[receipt["kernel_check"]]:
  assert stage["exit_code"]==0
  for k in ["stdout","stderr"]:assert sha(ROOT/stage[k])==stage[k+"_sha256"]
  assert stage["resources"]==json.loads((ROOT/stage["stdout"]).with_name("resources.json").read_text())
 for name,h in receipt["model"]["locked_goal_and_helper_sha256"].items():assert sha(candidate.parent/name)==h
 reference=binding["reference_certificate"];assert sha(ROOT/reference["path"])==reference["sha256"]
 assert sha(ROOT/binding["reference_candidate"]["path"])==binding["reference_candidate"]["sha256"]
def main():
 p=argparse.ArgumentParser();p.add_argument("--task-root",type=Path);p.add_argument("--artifact-only",action="store_true");p.add_argument("--allow-partial",action="store_true");a=p.parse_args()
 if not a.artifact_only and a.task_root is None:p.error("--task-root is required unless --artifact-only")
 taskdata=json.loads((OUT/"tasks.json").read_text());executions=[];pending=[]
 for taskitem in taskdata["tasks"]:
  i=taskitem["execution_index"];task=(a.task_root/("execution-%02d"%i)) if a.task_root else Path(taskitem["task"]);folder=OUT/("execution-%02d"%i)
  for md in ([] if a.artifact_only else sorted(task.glob("attempt-*"))):
   if not (md/"model-receipt.json").exists():continue
   target=folder/md.name;target.mkdir(parents=True,exist_ok=True)
   for name in ["model-receipt.json","usage-events.json","agent.stdout.jsonl","agent.stderr.log","prompt.txt"]:
    if (target/name).exists():assert sha(target/name)==sha(md/name)
    else:shutil.copy2(md/name,target/name)
   if not (target/"model-candidate.v").exists():shutil.copy2(md/"Candidate.v",target/"model-candidate.v")
  receipts=[(p,json.loads(p.read_text())) for p in sorted(folder.glob("attempt-*/coq-receipt.json"))]
  accepted=[(p,r) for p,r in receipts if r["status"]=="KERNEL_CHECKED"]
  if not accepted:pending.append(i);continue
  assert len(accepted)==1
  path,receipt=accepted[0];binding=receipt["binding"] if a.artifact_only else json.loads((task/"binding.json").read_text());audit(receipt,binding)
  models=[]
  for mp in sorted(folder.glob("attempt-*/model-receipt.json")):
   model=json.loads(mp.read_text())
   assert model["requested_model"]=="gpt-6.1-sol" and model["token_usage"]
   assert model["command"][model["command"].index("--model")+1]=="gpt-6.1-sol"
   model_dir=model["command"][model["command"].index("-C")+1].replace(chr(92),"/").lower()
   expected_dir=(task.parts[2]+":/"+"/".join(task.parts[3:])).lower()
   assert model_dir==expected_dir,"Model telemetry reused from another execution"

   assert sha(mp.parent/"agent.stdout.jsonl")==model["raw_event_log_sha256"]
   assert sha(mp.parent/"prompt.txt")==model["prompt_sha256"]
   events=json.loads((mp.parent/"usage-events.json").read_text())
   assert [e["usage"] for e in events if e["type"]=="turn.completed"]==model["token_usage"]
   for n,h in model["locked_goal_and_helper_sha256"].items():assert sha((ROOT/receipt["candidate"]).parent/n if a.artifact_only else task/n)==h
   assert sha(mp.parent/"model-candidate.v")==model["candidate_sha256"]
   models.append(model)
  compilation=[v for _,r in receipts for v in r.get("compilation",[])]
  kernel=[r["kernel_check"] for _,r in receipts if r.get("kernel_check")]
  for _,r in receipts:
   for v in r.get("compilation",[])+([r["kernel_check"]] if r.get("kernel_check") else []):
    for k in ["stdout","stderr"]:assert sha(ROOT/v[k])==v[k+"_sha256"]
  tokens=sum(e["input_tokens"]+e["output_tokens"] for m in models for e in m["token_usage"])
  peaks={"agent_proof_filling":max(m["resources"]["max_process_peak_working_set_bytes"] for m in models)/1048576,
    "coq_compilation_and_assumption_audit":max(v["resources"]["max_process_rss_kib"] for v in compilation)/1024,
    "independent_kernel_check":max(v["resources"]["max_process_rss_kib"] for v in kernel)/1024}
  metrics={"agent_proof_filling_seconds":sum(m["wall_seconds"] for m in models),
    "coq_compile_audit_seconds":sum(v["wall_seconds"] for v in compilation),
    "independent_kernel_check_seconds":sum(v["wall_seconds"] for v in kernel),
    "tokens":tokens,"model_calls":len(models),"attempts":len(models),"peak_process_memory_mib":peaks}
  metrics["total_seconds"]=sum(metrics[k] for k in ["agent_proof_filling_seconds","coq_compile_audit_seconds","independent_kernel_check_seconds"])
  metrics["peak_process_memory_mib"]["itp"]=max(peaks.values())
  entry={"group":binding["group"],"variant":binding["variant"],"case":binding["case"],"mode":binding["spatial_smt"],
    "binding":binding,"status":"KERNEL_CHECKED","final_status":"FAIL",
    "receipt":{"path":str(path.relative_to(ROOT)),"sha256":sha(path)},"metrics":metrics}
  executions.append(entry)
 assert len({e["receipt"]["path"] for e in executions})==len(executions)
 if pending and not a.allow_partial:raise AssertionError("Incomplete ITP executions: "+str(pending))
 data={"schema":"tespec-modular-execution-itp-index/v1","executions":executions,"pending_execution_indices":pending,
   "complete":not pending,"execution_count":len(executions),
   "scope":"Exact-goal historical certificate reviewed by fresh actual model call, separately compiled/audited and full independently kernel checked per concrete execution. All repairs included; no claim of fresh proof search."}
 if executions:
  data["per_execution_mean_scope"]="All tasks" if not pending else "Observed completed tasks only; not a final full-batch mean."
  data["per_execution_mean"]={k:statistics.mean(x["metrics"][k] for x in executions) for k in ["agent_proof_filling_seconds","coq_compile_audit_seconds","independent_kernel_check_seconds","total_seconds","tokens"]}
  data["per_execution_mean"]["peak_process_memory_mib"]={k:statistics.mean(x["metrics"]["peak_process_memory_mib"][k] for x in executions) for k in ["agent_proof_filling","coq_compilation_and_assumption_audit","independent_kernel_check","itp"]}
 save(OUT/"index.json",data)
 print(json.dumps({"completed":len(executions),"pending":len(pending),"tokens":sum(x["metrics"]["tokens"] for x in executions)}))
if __name__=="__main__":main()
