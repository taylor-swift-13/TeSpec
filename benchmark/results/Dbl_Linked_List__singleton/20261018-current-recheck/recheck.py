from pathlib import Path
import sys,json,hashlib,subprocess,datetime,os,tempfile
R=Path(__file__).resolve().parents[4];O=Path(__file__).resolve().parent
sys.path.insert(0,str(R))
from tools.finite_spatial_smt.regress_completed_groups import measure
G=R/"benchmark/results/Dbl_Linked_List__singleton"
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(): (O/"results.json").write_text(json.dumps(result,ensure_ascii=False,indent=2)+"\n")
base_path=G/"20261016-evaluation/results.json";base=json.loads(base_path.read_text());primary=json.loads((G/"20261016-primary-native/receipt.json").read_text())
cn=R/primary["cn_source"];qcp=R/primary["qcp_source"]
assert h(cn)==primary["cn_source_sha256"] and h(qcp)==primary["qcp_source_sha256"]
assert h(Path(primary["cn"]["command"][0]))==base["toolchain"]["cn_sha256"]
files=[cn,qcp,base_path,R/"bin/tespec-symexec",R/"spectest/spatial_smt.py",R/"tools/finite_spatial_smt/qcp_import.py",R/"tools/finite_spatial_smt/regress_completed_groups.py"]
for row in base["runs"]:
 for k in ["harness","binds"]:
  p=R/row[k];assert h(p)==row[k+"_sha256"];files.append(p)
frozen={str(p.relative_to(R)):h(p) for p in files}
result={"schema":"tespec-group-current-recheck/v1","group":"Dbl_Linked_List__singleton","inspection_order":23,"git_revision":subprocess.check_output(["git","rev-parse","HEAD"],cwd=R,text=True).strip(),"started_utc":datetime.datetime.now(datetime.timezone.utc).isoformat(),"baseline":str(base_path.relative_to(R)),"source_sha256":frozen,"case_pairs":len(base["runs"]),"runs":[],"cn":None,"scope":"Current actual CN/Fulminate/teSpec native recheck. QCP proof is audited/reused separately; no new model or ITP calls."}
env=["/usr/bin/env","OPAM_SWITCH_PREFIX=/home/yangfp/.opam/tespec-cn-20260416","PATH=/home/yangfp/.opam/tespec-cn-20260416/bin:"+os.environ.get("PATH","")]
save()
result["cn"]=measure([*env,*primary["cn"]["command"]],O/"cn-original",60);save()
for row in base["runs"]:
 entry={"case":row["case"],"initial":row["initial"],"expected":row["expected"],"variant":row["variant"],"paired_qcp_variant":row["paired_qcp_variant"],"modes":{}}
 result["runs"].append(entry)
 for mode in ["off","on"]:
  dest=O/row["case"]/mode
  metrics=R/"benchmark/results/spatial-smt-regressions/20261018-singleton-current-recheck"/row["case"]/(mode+"-phase-metrics.json")
  metrics.parent.mkdir(parents=True,exist_ok=True)
  cmd=list(row["tespec_"+mode]["command"]);cmd[cmd.index("--output-dir")+1]=str(dest/"artifacts");assert cmd[1:3]==["-m","spectest"]
  wrapped=[cmd[0],"-B",str(R/"tools/finite_spatial_smt/regress_completed_groups.py"),"--_worker",str(metrics),"--",*cmd[3:]]
  m=measure(wrapped,dest/"execution",60);rp=dest/"artifacts/report.json"
  assert rp.exists(),m
  report=json.loads(rp.read_text());case=report['results'][0]
  entry['modes'][mode]={"measurement":m,"report":str(rp.relative_to(R)),"report_sha256":h(rp),"status":case.get("status"),"reason":case.get("reason"),"precondition":case.get("precondition_result"),"execution_completed":case.get("execution_completed"),"executor_error":case.get("executor_error"),"residual_vcs":case.get("residual_vcs"),"vc_results":case.get("vc_results"),"spatial_smt":case.get("spatial_smt"),"itp_task_count":len(report.get("itp_vcs",[])),"phase_measurement":str(metrics.relative_to(R))}
  save()
 with tempfile.TemporaryDirectory(prefix="singleton-recheck-") as tmp:
  cmd=list(row['fulminate_pipeline']['command']);cmd=[("--output-dir="+tmp) if x.startswith("--output-dir=") else x for x in cmd]
  m=measure([*env,*cmd],O/row["case"]/"fulminate-pipeline",60)
  products=[{"name":p.name,"sha256":h(p),"bytes":p.stat().st_size} for p in Path(tmp).rglob('*') if p.is_file()]
  entry['fulminate_pipeline']={"measurement":m,"generated_files":products,"status":"NOT_BUILT" if m['exit_code']!=0 else "PIPELINE_SUCCEEDED_REQUIRES_REVIEW","separate_test_time_seconds":None,"separate_test_rss_kib":None}
 save();print(row['case'],*[entry['modes'][m]['status'] for m in ['off','on']],"Fulminate exit",m['exit_code'],flush=True)
result['finished_utc']=datetime.datetime.now(datetime.timezone.utc).isoformat()
result['frozen_files_unchanged']={p:h(R/p)==sha for p,sha in frozen.items()}
assert all(result['frozen_files_unchanged'].values())
save()
