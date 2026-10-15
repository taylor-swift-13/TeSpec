#!/usr/bin/env python3
"""Replay actual paired CN/QCP inputs; failures and manual VCs retain distinct statuses."""
from pathlib import Path
import argparse,hashlib,json,os,subprocess,time
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def native(binary, source, output, timeout, include):
    output.mkdir(parents=True)
    command = [
        str(binary),
        "--input-file=" + str(source),
        "--Json-output",
        "--no-strategy-gen",
        "--gen-and-backup",
        "--coq-output-dir=" + str(output / "vc"),
        "--no-logic-path",
        "--disable-solver-info",
        "--no-exec-info",
        "-I" + str(include),
    ]
    try:
        result = subprocess.run(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            timeout=timeout,
            cwd=binary.parents[2],
        )
        code, log = result.returncode, result.stdout
    except subprocess.TimeoutExpired as exc:
        code = "TIMEOUT"
        log = exc.stdout or ""
        if isinstance(log, bytes):
            log = log.decode(errors="replace")
    (output / "executor.log").write_text(log)
    try:
        raw = json.loads(log)
    except json.JSONDecodeError:
        raw = {}
    functions = {}
    for row in raw.get("WitnessList") or []:
        if not row.get("Witness"):
            continue
        counts = row["Witness"]["total_witness_count"]
        status = "RESIDUAL" if counts["manual"] else "AUTOMATICALLY_DISCHARGED"
        if counts["auto_solved"] == 0 and counts["manual"] == 0:
            status = "EMPTY_WITNESSES"
        functions[row["functionName"]] = dict(status=status, **counts)
    status = (
        "COMPLETED" if code == 0 and raw.get("result") == "success" else "TOOL_ERROR"
    )
    if code == "TIMEOUT":
        status = "TIMEOUT"
    message = (raw.get("errormessage") or {}).get("Main Error Message", "")
    error_kind = None
    if (
        "postcondition contradicts the current path condition" in message
        or "every return post branch" in message
    ):
        error_kind = "postcondition_rejected"
    elif "Cannot derive the precondition of function" in message:
        error_kind = "call_precondition_not_established"
    return dict(
        status=status,
        returncode=code,
        command=command,
        source_sha256=digest(source),
        log_sha256=digest(output / "executor.log"),
        error=raw.get("errormessage"),
        error_kind=error_kind,
        functions=functions,
        certificate="NOT_CHECKED",
        unit_manual_obligations=sum(r["manual"] for r in functions.values()),
    )

def main():
 p=argparse.ArgumentParser(description=__doc__)
 p.add_argument('--cn-switch',type=Path,required=True)
 p.add_argument('--qcp-binary',type=Path,required=True)
 p.add_argument('--qcp-include',type=Path,required=True)
 p.add_argument('--timeout',type=float,default=40)
 p.add_argument('--output',type=Path,required=True)
 a=p.parse_args();here=Path(__file__).resolve().parent
 manifest=json.loads((here/'manifest.json').read_text());out=a.output.resolve()
 out.mkdir(parents=True,exist_ok=True)
 if any(out.iterdir()):p.error('Output directory must be empty')
 env=os.environ.copy();env['OPAM_SWITCH_PREFIX']=str(a.cn_switch.resolve());env['PATH']=str(a.cn_switch.resolve()/'bin')+os.pathsep+env.get('PATH','')
 results=[]
 for row in manifest['records']:
  for v in row['variants']:
   if not v['files']:continue
   for f in v['files'].values():
    if digest(here/f['path'])!=f['sha256']:raise ValueError('Input changed: '+f['path'])
   d=out/row['id']/v['id'];d.mkdir(parents=True)
   cmd=[str(a.cn_switch.resolve()/'bin/cn'),'verify',str(here/v['files']['cn']['path'])]
   try:
    proc=subprocess.run(cmd,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,env=env,timeout=a.timeout)
    code,log=proc.returncode,proc.stdout
   except subprocess.TimeoutExpired as exc:code,log='TIMEOUT',str(exc.stdout)
   (d/'cn.log').write_text(log)
   q=native(a.qcp_binary.resolve(),here/v['files']['qcp']['path'],d/'qcp',a.timeout,a.qcp_include.resolve())
   results.append({'source':row['id'],'variant':v['id'],'expected':v['expected'],'cn':{'exit_code':code,'command':cmd,'status':'VERIFIED' if code==0 else 'REVIEW_DIAGNOSTIC'},'qcp':q})
   (out/'results.json').write_text(json.dumps(results,indent=2)+'\n')
   print(row['id'],v['id'],code,q['status'],flush=True)
 metadata={'manifest_sha256':digest(here/'manifest.json'),'qcp_binary_sha256':digest(a.qcp_binary.resolve()),'cn_binary_sha256':digest(a.cn_switch.resolve()/'bin/cn'),'cn_version':subprocess.run([str(a.cn_switch.resolve()/'bin/cn'),'--version'],capture_output=True,text=True,env=env).stdout.strip(),'policy':'No failing exit code or manual VC automatically counted as semantic rejection.'}
 (out/'toolchain.json').write_text(json.dumps(metadata,indent=2)+'\n')
if __name__=='__main__':main()
