#!/usr/bin/env python3
"""Address-binding ablation on unchanged QCP bodies and logical values."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=False)
    summary={'schema':'tespec-address-ablation/v1','scope':'diagnostic, not new members of expansion80 or isolated timing','binary_sha256':sha(ROOT/'bin/tespec-symexec'),'driver_sha256':sha(Path(__file__)),'cases':[]}
    cases=[('knapsack',ROOT/'runtime/qcip/QCP_examples/LLM_bench/Algorithms/zero_one_knapsack/zero_one_knapsack.c','zeroOneKnapsack'),('interior',HERE.parent/'memory-controls/suites/interior_store/reference.qcp.c','interior_store'),('house_robber',ROOT/'runtime/qcip/QCP_examples/LLM_bench/Algorithms/house_robber/house_robber.c','rob')]
    for name,source,function in cases:
        binds=HERE/(name+'.binds.json');dest=out/name
        cmd=[sys.executable,'-m','spectest','run',str(source),'--function',function,'--binds',str(binds),'--output-dir',str(dest),'--execution-mode','entry-exit','--timeout','3','--loop-unroll-limit','128','--call-depth-limit','128','--compact','-I',str(ROOT/'runtime/qcip/QCP_examples/QCP_demos_human')]
        with (out/(name+'.log')).open('w') as stream:completed=subprocess.run(cmd,cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT,timeout=45)
        report=json.loads((dest/'report.json').read_text())
        rows=[]
        for row in report['results']:
            executor=Path(row['generated_source']).parent/'executor.json'
            try: raw=json.loads(executor.read_text()) if executor.exists() else {}
            except json.JSONDecodeError: raw={}
            rows.append({'id':row['id'],'status':row['status'],'test_result':row.get('test_result'),'reason':row.get('reason'),'phases':row.get('phases'),'execution_completed':raw.get('spec_test',{}).get('completed'),'seconds':row.get('resources',{}).get('wall_seconds'),'executor_error':raw.get('errormessage')})
        summary['cases'].append({'id':name,'source':str(source.relative_to(ROOT)),'source_sha256':sha(source),'binds_sha256':sha(binds),'returncode':completed.returncode,'results':rows})
    (out/'summary.json').write_text(json.dumps(summary,indent=2,ensure_ascii=False)+'\n');print(json.dumps(summary,ensure_ascii=False))
if __name__=='__main__':main()
