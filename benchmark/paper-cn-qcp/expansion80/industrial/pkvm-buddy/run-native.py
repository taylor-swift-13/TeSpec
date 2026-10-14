#!/usr/bin/env python3
"""Replay frozen original industrial C with an oracle following actual allocations."""
import argparse
from collections import Counter
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import subprocess
HERE=Path(__file__).resolve().parent
EXP=HERE.parents[1]
SNAP=EXP/'source-snapshots/fulminate/pkvm-buddy'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
spec=importlib.util.spec_from_file_location('model',HERE/'prepare-traces.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

class OracleViolation(Exception):
    def __init__(self,category,message):self.category=category;super().__init__(message)

def require(condition,message,category='owned_state'):
    if not condition:raise OracleViolation(category,message)

def actual_alloc(model,op,start):
    handle,order=op['handle'],op['order']
    require(handle not in model.live,'allocation reuses a live handle','client_admission')
    if start==-1:
        # Original postcondition permits NULL; report this supplemental property separately.
        require(not any(model.free[k] for k in range(order,10)),
                'NULL despite an available block','supplemental_completeness')
        return
    require(0<=start and start+(1<<order)<=8,'allocation outside pool')
    require((model.base_pfn+start)%(1<<order)==0,'allocation is not order aligned')
    roots=[(k,root) for k in range(order,10) for root in model.free[k]
           if root<=start and start+(1<<order)<=root+(1<<k)]
    require(len(roots)==1,'allocation is not contained in a unique owned free block')
    level,root=roots[0];model.free[level].remove(root)
    while level>order:
        level-=1;middle=root+(1<<level)
        if start<middle:model.free[level].add(middle)
        else:model.free[level].add(root);root=middle
    require(root==start,'returned block cannot be produced by buddy splitting')
    model.live[handle]=(start,order,1)

def check_snapshot(model,state):
    require('error' not in state,state.get('error','bad state'))
    model.check()
    free=[(int(start),int(order)) for start,order in state['free']]
    require(len(free)==len(set(free)),'duplicate free-list root')
    require(set(free)=={(start,order) for order,blocks in model.free.items() for start in blocks},
            'free partition differs from actual-allocation oracle')
    require(state['max_order']==4,'unexpected production max_order for eight pages')
    require(len(state['meta'])==8,'metadata page count differs')
    roots={start:(0,order) for start,order in free}
    for start,order,refs in model.live.values():
        require(start not in roots,'root simultaneously live and free')
        roots[start]=(refs,order)
    for index,(refs,order,flags) in enumerate(state['meta']):
        require((refs,order)==roots.get(index,(0,255)),f'metadata at page {index} differs')
        require(flags==0,f'flags at page {index} changed')

def replay(trace,states,complete=True):
    model=m.Buddy(base_pfn=trace['initial_state']['model_start_pfn'])
    checked=[]
    try:
        require(bool(states) and len(states)<=len(trace['operations'])+1,
                'missing or extra native operation snapshots','native_execution')
        if complete:require(len(states)==len(trace['operations'])+1,
                            'missing native operation snapshots','native_execution')
        check_snapshot(model,states[0])
        checked.append({'step':-1,'native':states[0],'oracle':model.state()})
        for index,(op,state) in enumerate(zip(trace['operations'],states[1:])):
            if op['op']=='alloc':
                actual_alloc(model,op,state['result'])
                if state['result']>=0:require(state['zeroed']==1,'allocated block is not zeroed')
            else:model.apply(op)
            check_snapshot(model,state)
            checked.append({'step':index,'native':state,'oracle':model.state()})
        if complete:
            require(not model.live,'trace does not release every actual live handle','client_admission')
            require(model.free==model.initial_free,'pool not recovered after final releases')
    except (OracleViolation,AssertionError) as error:
        category=getattr(error,'category','owned_state')
        return {'status':'ERROR' if category in ('native_execution','client_admission') else 'FAIL','category':category,
                'diagnostic':str(error),'first_bad_step':len(checked)-1,'checked':checked}
    return {'status':'PASS' if complete else 'VALID_PREFIX','checked':checked}

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=False)
    inputs=json.loads((HERE/'model-traces.json').read_text());candidate=json.loads((HERE/'candidate.json').read_text())
    report={'schema':'tespec-industrial-native-replay/v1',
            'scope':'Original allocator C on actual mapped pages; independent owned-state/zeroing oracle and supplemental allocation-completeness checks. Original CN spec-mutant verdicts and QCP translation are pending.',
            'driver_sha256':sha(HERE/'native-adapter.c'),'runner_sha256':sha(Path(__file__)),
            'model_generator_sha256':sha(HERE/'prepare-traces.py'),'input_sha256':sha(HERE/'model-traces.json'),
            'source_revision':candidate['source_revision'],
            'source_files':{p.name:sha(p) for p in SNAP.iterdir() if p.is_file()},'runs':[]}
    for variant in ['reference','impl_coalescing_alignment']:
        folder=out/variant;source=folder/'source';source.mkdir(parents=True)
        for f in SNAP.iterdir():
            if f.is_file():shutil.copy2(f,source/f.name)
        if variant!='reference':shutil.copyfile(source/'bug2.page_alloc.c',source/'page_alloc.c')
        for bits in [32,64]:
            exe=folder/f'native{bits}';cmd=['gcc','-std=gnu11','-O1',f'-m{bits}',
                '-DALLOCATOR_SOURCE="'+str(source/'page_alloc.c')+'"',str(HERE/'native-adapter.c'),'-o',str(exe)]
            build=subprocess.run(cmd,text=True,capture_output=True)
            (folder/f'build{bits}.log').write_text(build.stdout+build.stderr)
            assert build.returncode==0,build.stderr
            rows=[]
            for trace in inputs['traces']:
                handles={name:i for i,name in enumerate(dict.fromkeys(op['handle'] for op in trace['operations']))}
                encoded=str(trace['initial_state']['model_start_pfn'])+' '+str(len(trace['operations']))+'\n'
                kinds={'alloc':'A','get':'G','put':'P','put_all':'F'}
                encoded+=''.join(f"{kinds[op['op']]} {handles[op['handle']]} {op.get('order',0)}\n" for op in trace['operations'])
                run=subprocess.run([str(exe)],input=encoded,text=True,capture_output=True,timeout=20)
                states=[json.loads(line) for line in run.stdout.splitlines()]
                if run.returncode==0:result=replay(trace,states)
                else:
                    # An exit code alone is not an oracle violation. Audit every observed
                    # state up to the interruption; an already violated owned invariant
                    # is sufficient evidence even if a later operation was interrupted.
                    result=replay(trace,states,complete=False)
                    if result['status']!='FAIL':
                        result.update(status='ERROR',category='native_execution',diagnostic=run.stderr)
                result['native_states']=states
                rows.append({'id':trace['id'],'native_returncode':run.returncode,**result})
            record={'variant':variant,'abi':bits,'build_command':cmd,'build_returncode':build.returncode,
                    'summary':dict(Counter(r['status'] for r in rows)),'results':rows}
            report['runs'].append(record)
            with gzip.open(out/'report.json.gz','wt') as f:json.dump(report,f,indent=2)
            print(json.dumps({k:v for k,v in record.items() if k!='results' and k!='build_command'}),flush=True)
    return 0

if __name__=='__main__':raise SystemExit(main())
