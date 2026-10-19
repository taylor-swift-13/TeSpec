#!/usr/bin/env python3
"""Exact-goal certificate review and independently measured ITP per modular execution."""
from pathlib import Path
import argparse,json,re,shlex,shutil,sys
from meter_read_itp_coq import ROOT,COQ,RUNTIME,measure,save,sha
OUT=ROOT/"benchmark/results/modular-itp/20261020"
def statements(t):
 return [(m[1],re.sub(r"\s+"," ",m[2]).strip()) for m in re.finditer(r"Theorem\s+(\w+)\s*:\s*(.*?)\.\s*Proof\.",t,re.S)]
def prepare(taskroot):
 if (OUT/"tasks.json").exists():
  old=json.loads((OUT/"tasks.json").read_text())
  for entry in old["tasks"]:
   binding=json.loads((taskroot/("execution-%02d"%entry["execution_index"])/"binding.json").read_text())
   for key in ["source","binds","report","goal"]:
    assert sha(ROOT/binding[key]["path"])==binding[key]["sha256"]
  print("RESUME EXISTING",len(old["tasks"]),"immutable tasks; no model or proof file overwritten",flush=True)
  return
 idx=json.loads((ROOT/"benchmark/results/modular-result-cost-index.json").read_text());tasks=[]
 for group in idx["groups"]:
  for c in json.loads((ROOT/group["json"]).read_text())["cases"]:
   if c["itp_conclusion"]!="PENDING":continue
   index=len(tasks);task=taskroot/("execution-%02d"%index);task.mkdir(parents=True,exist_ok=True)
   goal=next(x for x in c["vc_artifacts"] if x["kind"]=="goal")
   assert sha(ROOT/goal["path"])==goal["sha256"]
   oracle=c["historical_itp_comparison_oracle"];ref=oracle.get("evidence",[oracle])[0]["receipt"]
   assert sha(ROOT/ref["path"])==ref["sha256"]
   prior=json.loads((ROOT/ref["path"]).read_text())
   if c["group"]=="read":
    old=prior["attempts"][-1];oldgoal=prior["case_binding"]["goal_copy"];oldhash=prior["case_binding"]["original_goal_sha256"]
    model=prior["models"][-1]
   else:
    old=prior;oldgoal=old["binding"]["goal"];oldhash=old["binding"]["goal_sha256"];model=old["model"]
   assert old["status"]=="KERNEL_CHECKED" and old["kernel_check"]["exit_code"]==0
   assert oldhash==goal["sha256"]==sha(ROOT/oldgoal)
   previous=ROOT/old["candidate"];assert sha(previous)==old["candidate_sha256"]
   locked=model["locked_goal_and_helper_sha256"];order=[]
   for stage in old["compilation"]:
    if stage["exit_code"]:continue
    name=Path(stage["command"][-1]).name
    if name in locked and name not in order:order.append(name)
   assert set(order)==set(locked)
   for name in order:
    source=previous.parent/name
    assert sha(source)==locked[name]
    (task/name).write_bytes((ROOT/goal["path"]).read_bytes() if sha(source)==oldhash else source.read_bytes())
   text=previous.read_text();names=statements(text);assert len(names) in [3,5]
   assert not re.search(r"\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b",text)
   (task/"ReferenceProof.v").write_text(text)
   prefix=text[:re.search(r"\bTheorem\s+",text).start()]
   candidate=prefix+"\nRequire Import ReferenceProof.\n"+"".join("Theorem "+n+" : "+t+".\nProof. Admitted.\n" for n,t in names)+"".join("Print Assumptions "+n+".\n" for n,t in names)
   (task/"Candidate.v").write_text(candidate);(task/"template.txt").write_text(candidate)
   binding={**c,"execution_index":index,"goal":goal,"goal_module":next(Path(n).stem for n in order if locked[n]==oldhash),
      "reference_certificate":ref,"reference_candidate":{"path":str(previous.relative_to(ROOT)),"sha256":sha(previous)},
      "compile_order":order+["ReferenceProof.v","Candidate.v"],
      "reuse_kind":"EXACT_ORIGINAL_GOAL_CERTIFICATE_REVIEW_WITH_FRESH_PER_EXECUTION_COQ_KERNEL_CHECK",
      "theorems":names,"residual_vcs":json.loads((ROOT/c["report"]["path"]).read_text())["results"][0]["residual_vcs"]}
   save(task/"binding.json",binding)
   prompt="Review the supplied kernel-checked certificate for this ONE execution. All original Goal bytes SHA256 match exactly. Fill only Candidate.v, preserving EVERY theorem statement and Print Assumptions. Each theorem can use the same-named ReferenceProof theorem with exact ReferenceProof.NAME; this explicitly authorized reuse is recorded. Do not change any other file, add assumptions, admits, unchecked casts or alter imported goals. No delegation, model calls, shell/compiler calls. Controller separately meters compilation, original-statement assumption audit and full independent coqchk. This task must cover ALL residual VC negations AND entry satisfiability, plus supplied heap facts; do not claim program PASS: expected verdict is FAIL after refutation.\n\nCandidate template:\n"+candidate+"\nImmutable certificate reference:\n"+text
   (task/"prompt.txt").write_text(prompt)
   tasks.append({"execution_index":index,"group":c["group"],"variant":c["variant"],"case":c["case"],"mode":c["spatial_smt"],"task":str(task)})
 save(OUT/"tasks.json",{"schema":"tespec-modular-execution-itp-tasks/v1","tasks":tasks,"tasks_count":len(tasks)})
 print("PREPARED",len(tasks),flush=True)
def compile_one(root,index,attempt):
 task=root/("execution-%02d"%index);binding=json.loads((task/"binding.json").read_text())
 folder=OUT/("execution-%02d"%index)/("attempt-%d"%attempt);receiptpath=folder/"coq-receipt.json"
 previous=None
 if receiptpath.exists():
  previous=json.loads(receiptpath.read_text())
  if previous["status"]=="KERNEL_CHECKED":return 0
  if previous["status"]!="COMPILING":return 1
  if any(Path(x["command"][-1]).name=="StatementAudit.v" for x in previous["compilation"]):
   raise RuntimeError("Post-audit Coq execution already exists; inspect active process before resuming, never overwrite measured stages")
  save(folder/"controller-metadata-before-resume.json",previous)
 folder.mkdir(parents=True,exist_ok=True);src=folder/"proofs";src.mkdir(exist_ok=True)
 md=task/("attempt-%d"%attempt);model=json.loads((md/"model-receipt.json").read_text())
 assert model["exit_code"]==0 and model["token_usage"] and model["requested_model"]=="gpt-6.1-sol"
 assert sha(md/"prompt.txt")==model["prompt_sha256"]
 assert sha(ROOT/binding["goal"]["path"])==binding["goal"]["sha256"]
 assert sha(ROOT/binding["report"]["path"])==binding["report"]["sha256"]
 assert sha(ROOT/binding["source"]["path"])==binding["source"]["sha256"]
 assert sha(ROOT/binding["binds"]["path"])==binding["binds"]["sha256"]
 for f,h in model["locked_goal_and_helper_sha256"].items():
  assert sha(task/f)==h;shutil.copy2(task/f,src/f)
 for name in ["model-receipt.json","usage-events.json","agent.stdout.jsonl","agent.stderr.log","prompt.txt"]:
  shutil.copy2(md/name,folder/name)
 save(folder/"binding.json",binding)
 candidate=(md/"Candidate.v").read_text()
 assert statements(candidate)==[tuple(v) for v in binding["theorems"]]
 assert not re.search(r"\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b",candidate)
 for n,t in binding["theorems"]:assert "Print Assumptions "+n+"." in candidate
 assert sha(md/"Candidate.v")==model["candidate_sha256"]
 shutil.copy2(md/"Candidate.v",src/"Candidate.v")
 parts=shlex.split((RUNTIME/"_CoqProject").read_text());flags=[str(RUNTIME/t) if i%3==1 else t for i,t in enumerate(parts)]+["-Q",str(src),""]
 receipt={"schema":"tespec-modular-execution-itp-receipt/v1","execution_index":index,"attempt":attempt,"binding":binding,"model":model,
    "candidate":str((src/"Candidate.v").relative_to(ROOT)),"candidate_sha256":sha(src/"Candidate.v"),
    "compilation":previous["compilation"] if previous else [],"status":"COMPILING"}
 save(receiptpath,receipt)
 for name in binding["compile_order"]:
  if any(Path(v["command"][-1]).name==name and v["exit_code"]==0 for v in receipt["compilation"]):continue
  m=measure([COQ/"coqc",*flags,src/name],folder/"compilation"/Path(name).stem,src)
  receipt["compilation"].append(m);save(receiptpath,receipt)
  if m["exit_code"]:
   receipt["status"]="COMPILE_FAILED";save(receiptpath,receipt)
   print((ROOT/m["stderr"]).read_text()[-4000:],flush=True);return 1
 audit=(ROOT/receipt["compilation"][-1]["stdout"]).read_text()
 if audit.count("Closed under the global context")!=len(binding["theorems"]) or audit.replace("Closed under the global context","").strip():
  receipt["status"]="ASSUMPTION_AUDIT_REJECTED";save(receiptpath,receipt);return 1
 module=binding["goal_module"];residual=[x.removeprefix("proof_of_") for x in binding["residual_vcs"]]
 stmt=src/"StatementAudit.v";stmt.write_text("Require Import "+module+".\n"+"".join("Print Assumptions "+module+"."+n+".\n" for n in residual))
 m=measure([COQ/"coqc",*flags,stmt],folder/"compilation/StatementAudit",src);receipt["compilation"].append(m)
 receipt["assumptions"]={"globally_closed_theorems":len(binding["theorems"]),"new_axioms":[],"raw_audit":receipt["compilation"][-2]["stdout"],"original_statement_audit":m["stdout"]}
 save(receiptpath,receipt)
 if m["exit_code"]:receipt["status"]="STATEMENT_AUDIT_FAILED";save(receiptpath,receipt);return 1
 receipt["kernel_check"]=measure([COQ/"coqchk","-silent",*flags,"Candidate"],folder/"kernel-check",src)
 receipt["status"]="KERNEL_CHECKED" if receipt["kernel_check"]["exit_code"]==0 else "KERNEL_FAILED"
 receipt["final_status"]="FAIL" if receipt["status"]=="KERNEL_CHECKED" else None
 save(receiptpath,receipt)
 for p in src.iterdir():
  if p.suffix in [".vo",".vos",".vok",".glob",".aux"] or p.name in [".lia.cache",".nia.cache"]:p.unlink()
 print(receipt["status"],index,attempt,flush=True)
 return int(receipt["status"]!="KERNEL_CHECKED")
def main():
 p=argparse.ArgumentParser();p.add_argument("action",choices=["prepare","compile"]);p.add_argument("--task-root",type=Path,required=True);p.add_argument("--execution",type=int);p.add_argument("--attempt",type=int,default=1);a=p.parse_args()
 if a.action=="prepare":prepare(a.task_root)
 else:raise SystemExit(compile_one(a.task_root,a.execution,a.attempt))
if __name__=="__main__":main()
