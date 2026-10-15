#!/usr/bin/env python3
"""Execute an explicit reviewed group plan, retaining per-execution costs and logs."""
import argparse,collections,datetime,json,re,shutil,sys,tempfile
from pathlib import Path
from test_read_variants import ROOT,CN,measure,sha,save
from evaluation_provenance import snapshot
from evaluation_expectations import matches as matches_expected

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--group',required=True);a=parser.parse_args()
    group=ROOT/'benchmark/programs'/a.group;planpath=group/'evaluation-plan.json';plan=json.loads(planpath.read_text());assert plan['program_group']==a.group
    keys=[(pair['cn_variant'],case['id']) for pair in plan['pairings'] for case in pair['cases']]
    assert len(keys)==len(set(keys)), 'Each (CN variant, case id) must identify one target/pairing; use distinct case IDs for different clients'
    for pair in plan['pairings']:
        assert isinstance(pair.get('function',plan['function']),str)
        for case in pair['cases']:
            assert isinstance(case['binds'].get('args',{}),dict) and isinstance(case['binds'].get('values'),dict), 'Every case needs valid args and an explicit values object'
            assert case['expected'] in ['PASS','FAIL','ERROR'] and case['precondition_valid']
    out=ROOT/'benchmark/results'/a.group/plan['run_id'];variants={}
    snapshot_path=out/'evaluation-plan.executed.json'
    if snapshot_path.exists():assert sha(snapshot_path)==sha(planpath),'Do not overwrite a measured run with a changed plan'
    else:save(snapshot_path,plan)
    for p in (group/'variants').glob('*/manifest.json'):
        v=json.loads(p.read_text());variants[v['id']]=(p,v)
    report={'schema':'tespec-group-finite-evaluation/v1','program_group':a.group,'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'evaluation_plan':str(planpath.relative_to(ROOT)),'plan_sha256':sha(planpath),'evaluation_plan_snapshot':str(snapshot_path.relative_to(ROOT)),'toolchain':{'cn_sha256':sha(CN),'executor_sha256':sha(ROOT/'bin/tespec-symexec'),'build':json.loads((ROOT/'bin/tespec-symexec.build.json').read_text()),'driver_sha256':sha(Path(__file__)),'compiler_wrapper_sha256':sha(ROOT/'tools/benchmark/gcc-no-builtins.sh'),'evaluation_source_snapshot':snapshot()},'runs':[]}
    reuse_path=ROOT/plan['reuse_fulminate_from'] if plan.get('reuse_fulminate_from') else None
    reuse_rows={(r['variant'],r['case']):r for r in json.loads(reuse_path.read_text())['runs']} if reuse_path else {}
    for pair in plan['pairings']:
        vid,qid=pair['cn_variant'],pair['qcp_variant'];vp,v=variants[vid];qv=variants[qid][1];cn=ROOT/v['files']['cn']['path'];qcp=ROOT/qv['files']['qcp']['path']
        assert sha(cn)==v['files']['cn']['sha256'] and sha(qcp)==qv['files']['qcp']['sha256']
        source=re.split(r'\nint main\s*\(',cn.read_text(),maxsplit=1)[0]
        for case in pair['cases']:
            assert case['precondition_valid']
            cid=case['id'];folder=out/vp.parent.name/cid;cached=folder/'receipt.json'
            if cached.exists():
                row=json.loads(cached.read_text());assert row['plan_case']==case;report['runs'].append(row);continue
            inp=vp.parent/'tests'/plan['run_id']/cid;inp.mkdir(parents=True,exist_ok=True)
            harness=inp/'fulminate.cn.c';harness.write_text(source+'\nint main(void) /*@ ensures return == 0i32; @*/ { '+case['cn_body']+' return 0; }\n')
            binds=inp/'binds.json';save(binds,[dict(case['binds'],id=cid)])
            row={'variant':vid,'paired_qcp_variant':qid,'case':cid,'initial':case.get('value'),'expected':case['expected'],'plan_case':case,'cn_source_sha256':sha(cn),'qcp_source_sha256':sha(qcp),'harness':str(harness.relative_to(ROOT)),'harness_sha256':sha(harness),'binds':str(binds.relative_to(ROOT)),'binds_sha256':sha(binds),'precondition_valid':True}
            previous=reuse_rows.get((vid,cid))
            if previous:
                assert previous['cn_source_sha256']==row['cn_source_sha256'] and previous['harness_sha256']==row['harness_sha256']
                for key in ['fulminate_pipeline','fulminate_test','instrumented_sources','instrumented_binary_sha256']:row[key]=previous[key]
                row['fulminate_reuse']={'report':str(reuse_path.relative_to(ROOT)),'variant':vid,'case':cid,'scope':'Exact CN source and harness byte hashes match; retain actual original measurements once.'}
            else:
                with tempfile.TemporaryDirectory(prefix='tespec-group-') as tmp:
                    row['fulminate_pipeline']=measure([CN,'instrument','--run','--cc='+str(ROOT/'tools/benchmark/gcc-no-builtins.sh'),'--output-dir='+tmp,*['-I'+str(ROOT/inc) for inc in v['files']['cn'].get('include_dirs',[])],harness],folder/'fulminate-pipeline')
                    generated=list(Path(tmp).glob('*.exec.c'))
                    for g in generated:shutil.copyfile(g,folder/g.name)
                    row['instrumented_sources']=[{'path':str((folder/g.name).relative_to(ROOT)),'sha256':sha(g)} for g in generated]
                    binaries=list(Path(tmp).glob('*.exec.out'))
                    if len(binaries)==1:
                        row['instrumented_binary_sha256']=sha(binaries[0]);m=measure([binaries[0]],folder/'fulminate-test');m['status']='PASS' if m['exit_code']==0 else 'FAIL';row['fulminate_test']=m
                    else:row['fulminate_test']={'status':'NOT_BUILT','wall_seconds':None,'resources':None,'tokens':0,'model_calls':0}
            for mode in ['off','on']:
                dest=folder/('tespec-'+mode);m=measure([sys.executable,'-m','spectest','run',qcp,'--function',pair.get('function',plan['function']),'--binds',binds,'--execution-mode','all-boundaries','--output-dir',dest/'artifacts','--timeout','30','--compact','--spatial-smt' if mode=='on' else '--no-spatial-smt','--spatial-smt-timeout-ms','2000','-I',str(ROOT/'runtime/qcip/QCP_examples/QCP_demos_human'),*[flag for inc in qv['files']['qcp'].get('include_dirs',[]) for flag in ['-I',str(ROOT/inc)]]],dest,timeout=90)
                p=dest/'artifacts/report.json';m['report']=str(p.relative_to(ROOT)) if p.exists() else None;data=json.loads(p.read_text()) if p.exists() else {};m['statuses']=[x.get('status') for x in data.get('results',[])];m['status']=m['statuses'][0] if len(m['statuses'])==1 else 'ERROR';row['tespec_'+mode]=m
            save(cached,row);report['runs'].append(row);save(out/'results.json',report);print(a.group,vid,cid,row['expected'],'fulminate',row['fulminate_test']['status'],'OFF',row['tespec_off']['status'],'ON',row['tespec_on']['status'],flush=True)
    runs=report['runs'];report['summary']={'configurations':len(plan['pairings']),'variant_language_records':len(variants),'case_pairs':len(runs),'expected':dict(collections.Counter(r['expected'] for r in runs))}
    for tool in ['fulminate_test','tespec_off','tespec_on']:report['summary'][tool]={'statuses':dict(collections.Counter(r[tool]['status'] for r in runs)),'expected_matches':sum(matches_expected(r,tool) for r in runs)}
    save(out/'results.json',report);print(json.dumps(report['summary']),flush=True)
    from collect_tespec_unexpected import collect
    collect()
if __name__=='__main__':main()
