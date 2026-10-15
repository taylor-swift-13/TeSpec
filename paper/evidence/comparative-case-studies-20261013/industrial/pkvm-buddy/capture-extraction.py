#!/usr/bin/env python3
"""Capture actual helper post-states for the original extracted-page spec mutation."""
import argparse
from collections import Counter
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('native_replay',HERE/'run-native.py')
native=importlib.util.module_from_spec(spec);spec.loader.exec_module(native)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',required=True,type=Path);a=p.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=False)
    data=json.loads((HERE/'model-traces.json').read_text())
    report={'scope':'Actual read-only original-C helper post-states and a necessary link condition of the original spec mutation; no Fulminate/QCP contract-tool verdict claimed',
            'dependencies':{p.name:sha(p) for p in [Path(__file__),HERE/'extraction-observer.c',HERE/'native-adapter.c',HERE/'run-native.py',HERE/'prepare-traces.py',HERE/'model-traces.json']},'runs':[]}
    for bits in (32,64):
        exe=out/f'native{bits}';cmd=['gcc','-std=gnu11','-O1',f'-m{bits}','-finstrument-functions',str(HERE/'extraction-observer.c'),'-o',str(exe)]
        build=subprocess.run(cmd,text=True,capture_output=True);(out/f'build{bits}.log').write_text(build.stdout+build.stderr);assert build.returncode==0,build.stderr
        results=[]
        for trace in data['traces']:
            handles={name:i for i,name in enumerate(dict.fromkeys(op['handle'] for op in trace['operations']))}
            encoded=f"{trace['initial_state']['model_start_pfn']} {len(trace['operations'])}\n"
            kinds={'alloc':'A','get':'G','put':'P','put_all':'F'}
            encoded+=''.join(f"{kinds[o['op']]} {handles[o['handle']]} {o.get('order',0)}\n" for o in trace['operations'])
            run=subprocess.run([str(exe)],input=encoded,text=True,capture_output=True,timeout=30);assert run.returncode==0,(trace['id'],run.returncode,run.stderr)
            stream=[json.loads(line) for line in run.stdout.splitlines()];states=[];witnesses=[]
            for row in stream:
                if row.get('event')!='extract_post':states.append(row);continue
                step=len(states)-1;op=trace['operations'][step]
                assert op['op']=='alloc' and row['order']==op['order'] and row['refcount']==0
                prior=states[-1];root=row['root'];order=row['order']
                available=[(start,k) for start,k in prior['free'] if k>=order]
                assert available and available[0][0]==root
                assert prior['meta'][root][0]==0 and prior['meta'][root][1]>=order
                assert row['prev']==row['next']==0 and row['header']!=0 and row['pool_start']>0
                # Original vmemmap_l_wf's prev/next clauses require either the
                # pool header or a physical address contained in the pool.
                link_condition=(row['prev']==row['header'] or row['pool_start']<=row['prev']<row['pool_end'])
                assert not link_condition
                witnesses.append({'step':step,'pre_native_state':prior,'post_native_fields':row,'mutant_link_necessary_condition':False})
            audited=native.replay(trace,states);assert audited['status']=='PASS',(trace['id'],audited)
            successful=sum(s['result']>=0 for o,s in zip(trace['operations'],states[1:]) if o['op']=='alloc')
            assert len(witnesses)==successful
            results.append({'id':trace['id'],'native_reference_status':'PASS','native_returncode':0,'successful_allocations':successful,'original_spec_mutation_witnessed':bool(witnesses),'witnesses':witnesses,'native_states':states})
        record={'abi':bits,'build_command':cmd,'build_returncode':0,'summary':{'reference_pass':len(results),'traces_with_spec_mutation_witness':sum(r['original_spec_mutation_witnessed'] for r in results),'helper_post_witnesses':sum(len(r['witnesses']) for r in results)},'results':results};report['runs'].append(record)
        with gzip.open(out/'report.json.gz','wt') as f:json.dump(report,f,indent=2)
        print(json.dumps(record['summary']),flush=True)
    return 0

if __name__=='__main__':raise SystemExit(main())
