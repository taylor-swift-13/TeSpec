#!/usr/bin/env python3
"""Finite scalar abs evaluation; immutable inputs, resumable per-case receipts."""
from pathlib import Path
import collections, datetime, json, re, sys, tempfile
from test_read_variants import ROOT, CN, measure, sha, save
GROUP=ROOT/'benchmark/programs/abs'
OUT=ROOT/'benchmark/results/abs/20261016-evaluation'
def expected(vid,x):
    if '231246662bd8cebf' in vid or '90ccad4b1077da1b' in vid: return 'PASS' if x>=0 else 'FAIL'
    if '2a6e78e52e760702' in vid: return 'PASS' if x==0 else 'FAIL'
    if '64bc0d58cbb360cd' in vid or 'd36d895752e7a406' in vid: return 'PASS' if x<=0 else 'FAIL'
    return 'FAIL' if x==-2147483648 else 'PASS'
def main():
    import argparse
    from cn_toolchain import installed_identity
    global OUT
    parser=argparse.ArgumentParser();parser.add_argument('--output',type=Path,default=OUT);OUT=parser.parse_args().output.resolve()
    if not OUT.is_relative_to((ROOT/'benchmark/results').resolve()):parser.error('output must stay under benchmark/results')
    if OUT.exists() and any(OUT.iterdir()):parser.error('Use a fresh --output; historical measurements cannot be relabelled with the current toolchain')
    cn_build=installed_identity()
    variants={}
    for p in sorted((GROUP/'variants').glob('*/manifest.json')):
        v=json.loads(p.read_text()); variants[v['id']]=(p,v)
    report={'schema':'tespec-group-finite-evaluation/v1','program_group':'abs','started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'scope':'Finite target-function tests; original trusted main excluded. No universal verification in these measurements.','toolchain':{'cn_build':cn_build,'cn_sha256':sha(CN),'executor_sha256':sha(ROOT/'bin/tespec-symexec'),'build':json.loads((ROOT/'bin/tespec-symexec.build.json').read_text()),'driver_sha256':sha(Path(__file__))},'runs':[]}
    for vid,(vp,v) in variants.items():
        if 'cn' not in v['files']: continue
        qid='qcp_existing:c6e1d6f95af325bd17c0' if vid=='cn_original:abs' else vid
        qv=variants[qid][1]; cn=ROOT/v['files']['cn']['path']; qcp=ROOT/qv['files']['qcp']['path']
        assert sha(cn)==v['files']['cn']['sha256'] and sha(qcp)==qv['files']['qcp']['sha256']
        source=re.split(r'\nint main\s*\(',cn.read_text(),maxsplit=1)[0]
        values=[-2147483647,-7,-1,0,1,7,2147483647]
        if 'a1dfee652c7b9649' in vid: values=[-2147483648]+values
        for i,x in enumerate(values):
            cid=f'value_{i}';folder=OUT/vp.parent.name/cid; cached=folder/'receipt.json'
            if cached.exists():
                row=json.loads(cached.read_text());assert row['initial']==x; report['runs'].append(row);continue
            inp=vp.parent/'tests/20261016-evaluation'/cid;inp.mkdir(parents=True,exist_ok=True)
            harness=inp/'fulminate.cn.c';lit='(-2147483647-1)' if x==-2147483648 else str(x)
            harness.write_text(source+'\nint main(void) /*@ ensures return == 0i32; @*/ { abs('+lit+'); return 0; }\n')
            binds=inp/'binds.json';save(binds,[{'id':cid,'args':{'x':x},'values':{}}])
            row={'variant':vid,'paired_qcp_variant':qid,'case':cid,'initial':x,'expected':expected(vid,x),'cn_source_sha256':sha(cn),'qcp_source_sha256':sha(qcp),'harness':str(harness.relative_to(ROOT)),'harness_sha256':sha(harness),'binds':str(binds.relative_to(ROOT)),'binds_sha256':sha(binds),'precondition_valid':True}
            with tempfile.TemporaryDirectory(prefix='tespec-abs-') as tmp:
                row['fulminate_pipeline']=measure([CN,'instrument','--run','--cc='+str(ROOT/'tools/benchmark/gcc-no-builtins.sh'),'--output-dir='+tmp,harness],folder/'fulminate-pipeline')
                generated=list(Path(tmp).glob('*.exec.c'))
                import shutil
                for g in generated: shutil.copyfile(g,folder/g.name)
                row['instrumented_sources']=[{'path':str((folder/g.name).relative_to(ROOT)),'sha256':sha(g)} for g in generated]
                binaries=list(Path(tmp).glob('*.exec.out'))
                if len(binaries)==1:
                    row['instrumented_binary_sha256']=sha(binaries[0]);m=measure([binaries[0]],folder/'fulminate-test');m['status']='PASS' if m['exit_code']==0 else 'FAIL';row['fulminate_test']=m
                else: row['fulminate_test']={'status':'NOT_BUILT','wall_seconds':None,'resources':None,'tokens':0,'model_calls':0}
            for mode in ['off','on']:
                dest=folder/('tespec-'+mode)
                m=measure([sys.executable,'-m','spectest','run',qcp,'--function','abs','--binds',binds,'--execution-mode','all-boundaries','--output-dir',dest/'artifacts','--timeout','30','--compact','--spatial-smt' if mode=='on' else '--no-spatial-smt','--spatial-smt-timeout-ms','2000'],dest,timeout=90)
                p=dest/'artifacts/report.json'; m['report']=str(p.relative_to(ROOT)) if p.exists() else None
                data=json.loads(p.read_text()) if p.exists() else {};m['statuses']=[r.get('status') for r in data.get('results',[])];m['status']=m['statuses'][0] if len(m['statuses'])==1 else 'ERROR';row['tespec_'+mode]=m
            save(cached,row);report['runs'].append(row);save(OUT/'results.json',report)
            print(vid,cid,x,row['expected'],'fulminate',row['fulminate_test']['status'],'off',row['tespec_off']['status'],'on',row['tespec_on']['status'],flush=True)
    runs=report['runs'];report['summary']={'configurations':len({r['variant'] for r in runs}),'variant_language_records':len(variants),'case_pairs':len(runs),'expected':dict(collections.Counter(r['expected'] for r in runs))}
    for tool in ['fulminate_test','tespec_off','tespec_on']:
        report['summary'][tool]={'statuses':dict(collections.Counter(r[tool]['status'] for r in runs)),'expected_matches':sum(r[tool]['status']==r['expected'] for r in runs)}
    save(OUT/'results.json',report);print(json.dumps(report['summary']),flush=True)
if __name__=='__main__':main()
