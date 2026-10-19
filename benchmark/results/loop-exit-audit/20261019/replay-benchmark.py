"""Read-only source review: replay existing loop-group cases with current binary."""
from pathlib import Path
import hashlib,json,sys
ROOT=Path(__file__).resolve().parents[4]
sys.path.insert(0,str(ROOT))
from tools.finite_spatial_smt.regress_completed_groups import measure,save
def sha(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()
out=Path(__file__).parent/"benchmark-replay"
rows=[]
for group in ("init_array","list_all"):
    history=ROOT/"benchmark/results"/group/"20261016-evaluation/results.json"
    old=json.loads(history.read_text())
    for index,item in enumerate(old["runs"]):
        if group=="list_all" and "IntList_rev_loop" not in item["case"]: continue
        for mode in ("off","on"):
            folder=out/group/("case-%02d"%index)/mode
            cmd=list(item["tespec_"+mode]["command"])
            cmd[cmd.index("--output-dir")+1]=str(folder/"artifacts")
            cmd+=["--qcp-binary",str(ROOT/"bin/tespec-symexec"),
                  "--execution-strategy","inline","--instance-trace"]
            source=Path(cmd[cmd.index("run")+1])
            binds=Path(cmd[cmd.index("--binds")+1])
            assert sha(source)==item["qcp_source_sha256"]
            assert sha(binds)==item["binds_sha256"]
            if "include strategies" in source.read_text():
                cmd=[sys.executable,str(ROOT/"tools/benchmark/with_legacy_strategy_locator.py"),
                     "--source",str(source),"--",*cmd]
            measurement=measure(cmd,folder,45)
            entry={"group":group,"case":item["case"],"mode":mode,"expected":item["expected"],
                   "initial":item["initial"],"source":str(source),"source_sha256":sha(source),
                   "binds":str(binds),"binds_sha256":sha(binds),"measurement":measurement}
            report=folder/"artifacts/report.json"
            if report.exists():
                result=json.loads(report.read_text())["results"][0]
                raw=Path(result["stdout"])
                spec=json.loads(raw.read_text()).get("spec_test",{}) if raw.exists() else {}
                entry.update({k:result.get(k) for k in ["status","reason","execution_completed","executor_error","precondition_result","resources"]})
                entry.update(report=str(report),report_sha256=sha(report),
                             raw=str(raw),branch_evaluation=spec.get("branch_evaluation"),
                             limit_reason=spec.get("limit_reason"))
            else: entry["capture_error"]="no report"
            rows.append(entry)
            save(out/"summary.json",{"binary_sha256":sha(ROOT/"bin/tespec-symexec"),"runs":rows,"sources_unchanged":True})
            print(group,item["case"],mode,entry.get("status"),entry.get("reason"),flush=True)
