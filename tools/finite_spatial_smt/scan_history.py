"""Read historical JSON/JSON-stdout artifacts and preserve UNKNOWN path VCs.

This is a read-only scan of the supplied roots. Aggregate reports and executor
artifacts are kept as observations, then deduplicated by collect_corpus.py.
"""
import argparse
import collections
import json
import os
from pathlib import Path


SKIP={'.git','node_modules','_build','_opam','venv','__pycache__','SeparationLogic',
      'unifysl','compcert','cn','cn-20260416','cn-bv-20260911',
      'cn-artifact-oci-20261011','cn-artifact-oci-20261011-v2'}


def scan(roots):
    rows=[];seen=set()
    for root in roots:
        for directory,dirs,files in os.walk(root):
            dirs[:]=sorted(n for n in dirs if n not in SKIP)
            for name in sorted(files):
                if not(name.endswith('.json') or name in {'stdout.log','native.stdout','executor.stdout'}):continue
                path=Path(directory)/name
                if path.stat().st_size>8_000_000:continue
                try:data=json.loads(path.read_text())
                except (ValueError,UnicodeError):continue
                if not isinstance(data,dict):continue
                containers=[]
                if isinstance(data.get('spec_test'),dict):containers.append((data['spec_test'],data.get('functionName')))
                if isinstance(data.get('results'),list):
                    containers.extend((x,x.get('function')) for x in data['results'] if isinstance(x,dict))
                for source,fn in containers:
                    for index,v in enumerate(source.get('vc_results',[]) or []):
                        if v.get('status')!='UNKNOWN' or not v.get('path') or not v.get('goal'):continue
                        # A report can contain multiple tests with the same VC index.
                        # Include the full VC text and case id in observation identity.
                        identity=(str(path.resolve()),source.get('id'),index,v['path'],v['goal'])
                        if identity in seen:continue
                        seen.add(identity)
                        rows.append({'source':str(path.resolve()),'index':index,'case_id':source.get('id'),
                                     'function':fn,'layout':source.get('target_layout'),'vc':v,
                                     'entry':source.get('precondition_result'),
                                     'completed':source.get('completed',source.get('execution_completed')),
                                     'semantics':source.get('vc_semantics')})
    return rows


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--root',type=Path,action='append',required=True)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    if args.output.exists():raise SystemExit('Refusing to overwrite a frozen inventory')
    rows=scan(args.root);args.output.write_text(json.dumps(rows,indent=2)+'\n')
    print(json.dumps({'observations':len(rows),'roots':list(map(str,args.root))}))
