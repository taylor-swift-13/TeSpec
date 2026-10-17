from pathlib import Path
import sys,json,hashlib,subprocess,datetime,os
R=Path(__file__).resolve().parents[4]
O=Path(__file__).resolve().parent
sys.path.insert(0,str(R))
from tools.finite_spatial_smt.regress_completed_groups import measure

def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,d):p.write_text(json.dumps(d,indent=2,ensure_ascii=False)+"\n")
old=R/"benchmark/results/const_example_lessgood/20261016-evaluation/results.json"
base=json.loads(old.read_text());row=base["runs"][0]
primary=json.loads((R/"benchmark/results/const_example_lessgood/20261016-primary-native/receipt.json").read_text())
cn=R/primary["cn_source"];qcp=R/primary["qcp_source"];binds=R/row["binds"]
assert digest(cn)==primary["cn_source_sha256"]
assert digest(qcp)==primary["qcp_source_sha256"]
assert digest(binds)==row["binds_sha256"]
assert digest(Path(primary["cn"]["command"][0]))==base["toolchain"]["cn_sha256"]
sources=[cn,qcp,binds,old,R/"spectest/spatial_smt.py",R/"tools/finite_spatial_smt/qcp_import.py",R/"bin/tespec-symexec",R/"tools/finite_spatial_smt/regress_completed_groups.py"]
frozen={str(p.relative_to(R)):digest(p) for p in sources}
result={"schema":"tespec-group-scope-recheck/v1","group":"const_example_lessgood","meaning_of_group_22":"Next pending group after 21 complete, following the preserved nightly pending queue, with completed array_load removed.","started_utc":datetime.datetime.now(datetime.timezone.utc).isoformat(),"git_revision":subprocess.check_output(["git","rev-parse","HEAD"],cwd=R,text=True).strip(),"baseline":str(old.relative_to(R)),"source_sha256":frozen,"expected":row["expected"],"test_pairs":1,"cn":{},"tespec":{},"model_calls":0,"tokens":0,"formal_complete_count_unchanged":21}
save(O/"results.json",result)
for mode in ["off","on"]:
 dest=O/("tespec-"+mode)
 metrics=R/"benchmark/results/spatial-smt-regressions/20261018-const-example-lessgood-scope-v2"/(mode+"-phase-metrics.json")
 metrics.parent.mkdir(parents=True,exist_ok=True)
 cmd=list(row["tespec_"+mode]["command"])
 cmd[cmd.index("--output-dir")+1]=str(dest/"artifacts")
 assert cmd[1:3]==["-m","spectest"]
 wrapped=[cmd[0],"-B",str(R/"tools/finite_spatial_smt/regress_completed_groups.py"),"--_worker",str(metrics),"--",*cmd[3:]]
 receipt=measure(wrapped,dest/"execution",60)
 report_path=dest/"artifacts/report.json"
 report=json.loads(report_path.read_text()) if report_path.exists() else {}
 case=(report.get("results") or [{}])[0]
 result["tespec"][mode]={"measurement":receipt,"report":str(report_path.relative_to(R)),"report_sha256":digest(report_path) if report_path.exists() else None,"status":case.get("status"),"precondition":case.get("precondition_result"),"execution_completed":case.get("execution_completed"),"vc_results":case.get("vc_results"),"spatial_smt":case.get("spatial_smt"),"itp_tasks":len(report.get("itp_vcs",[])),"phase_measurement":str(metrics.relative_to(R))}
 save(O/"results.json",result)
 print("teSpec",mode,case.get("status"),"SMT",case.get("spatial_smt",{}).get("attempted",0),flush=True)
cncmd=list(primary["cn"]["command"])
for name,path in [("original",cn),("untrusted-diagnostic",O/"untrusted-diagnostic.c")]:
 if name!="original":
  text=cn.read_text();assert text.count("/*@ trusted; @*/")==1
  path.write_text(text.replace("/*@ trusted; @*/",""))
 cmd=["/usr/bin/env","OPAM_SWITCH_PREFIX=/home/yangfp/.opam/tespec-cn-20260416","PATH=/home/yangfp/.opam/tespec-cn-20260416/bin:"+os.environ.get("PATH",""),*cncmd[:-1],str(path)]
 receipt=measure(cmd,O/("cn-"+name),60)
 result["cn"][name]={"source":str(path.relative_to(R)),"source_sha256":digest(path),"measurement":receipt,"scope":"Original main is trusted; acceptance does not certify body." if name=="original" else "Diagnostic derived source only: remove the trusted directive, preserve literal definition, assertion and C body. This is not a certificate for the unchanged original variant."}
 save(O/"results.json",result)
 print("CN",name,receipt["exit_code"],flush=True)
result["frozen_files_unchanged"]={p:digest(R/p)==h for p,h in frozen.items()}
assert all(result["frozen_files_unchanged"].values())
result["finished_utc"]=datetime.datetime.now(datetime.timezone.utc).isoformat()
save(O/"results.json",result)
