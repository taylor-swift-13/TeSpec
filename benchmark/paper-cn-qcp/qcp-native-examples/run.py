#!/usr/bin/env python3
"""Replay original QCP examples with frozen spec-based bindings."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import subprocess
import sys
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(p.read_text())
def save(p,v):p.write_text(json.dumps(v,indent=2,ensure_ascii=False)+'\n')
def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path,required=True);ap.add_argument('--timeout',type=float,default=3);a=ap.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=False)
    report={'schema':'tespec-original-qcp-replay/v1','scope':'original examples, QCP only; CN translation and independent input admission pending','binary_sha256':sha(ROOT/'bin/tespec-symexec'),'driver_sha256':sha(Path(__file__)),'timeout':a.timeout,'execution_mode':'entry-exit','runs':[]}
    for entry in read(HERE/'catalog.json')['programs']:
        folder=HERE/entry['path'];c=read(folder/'case.json');bindings=read(folder/'binds.json');expected={x['id']:x for x in c['expectations']}
        assert sha(ROOT/c['source'])==c['source_sha256']==sha(folder/'reference.qcp.c')
        for name,digest in c['files'].items():assert sha(folder/name)==digest
        for variant in ('reference','spec_mutation','impl_mutation'):
            dest=out/c['id']/variant;dest.mkdir(parents=True)
            command=[sys.executable,'-m','spectest','run',str(folder/(variant+'.qcp.c')),'--function',c['function'],'--binds',str(folder/'binds.json'),'--output-dir',str(dest/'qcp'),'--execution-mode','entry-exit','--timeout',str(a.timeout),'--loop-unroll-limit','128','--call-depth-limit','128','--compact']
            if c.get('spec'):command+=['--spec',c['spec']]
            for d in c['include_dirs']:command+=['-I',str(ROOT/d)]
            with (dest/'run.log').open('w') as stream:r=subprocess.run(command,cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT,timeout=a.timeout*len(bindings)+30)
            rows=[];result=dest/'qcp/report.json'
            if result.exists():
                for item in read(result)['results']:
                    rows.append({'id':item['id'],'status':item.get('test_result') or item['status'],'diagnostic_status':item['status'],'expected_by_manual_model':expected[item['id']][variant],'reason':item.get('reason'),'phases':item.get('phases'),'error':item.get('error')})
            report['runs'].append({'case':c['id'],'variant':variant,'command':command,'returncode':r.returncode,'case_sha256':sha(folder/'case.json'),'binds_sha256':sha(folder/'binds.json'),'results':rows,'missing_results':len(bindings)-len(rows)})
            save(out/'report.json',report)
        print(c['id'],'completed',flush=True)
    report['summary']={'programs':len(read(HERE/'catalog.json')['programs']),'fixed_bindings':sum(x['inputs'] for x in read(HERE/'catalog.json')['programs']),'variant_executions':sum(len(r['results']) for r in report['runs']),'missing_results':sum(r['missing_results'] for r in report['runs']),'counts':dict(Counter(x['status'] for r in report['runs'] for x in r['results'])),'reasons':dict(Counter(x['reason'] for r in report['runs'] for x in r['results'])),'cn_paired_subjects':0}
    save(out/'report.json',report);print(json.dumps(report['summary'],ensure_ascii=False))
if __name__=='__main__':main()
