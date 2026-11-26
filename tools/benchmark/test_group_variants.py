#!/usr/bin/env python3
"""Execute an explicit reviewed group plan, retaining per-execution costs and logs."""
import argparse,collections,datetime,json,re,shutil,sys,tempfile
from pathlib import Path
from test_read_variants import ROOT,CN,measure,sha,save
from evaluation_provenance import snapshot
from cn_toolchain import installed_identity
from cn_result_reuse import assert_resume_compatible, assert_fulminate_reuse_compatible, input_files_identity
from evaluation_expectations import matches as matches_expected
from current_test_plan import executed_source, load_current_plan, select_qcp_input

def compiler_wrapper(plan):
    """Resolve an optional, hash-pinned execution-support compiler wrapper."""
    config=plan.get('fulminate_compiler_wrapper')
    if config is None:
        return ROOT/'tools/benchmark/gcc-no-builtins.sh'
    path=(ROOT/config['path']).resolve()
    if not path.is_relative_to(ROOT.resolve()) or not path.is_file():
        raise ValueError('Fulminate compiler wrapper must be a repository file')
    if sha(path)!=config['sha256']:
        raise ValueError('Fulminate compiler wrapper hash mismatch')
    return path

def freeze_test_plan(out, planpath, oracle_hash, has_existing_report):
    out.mkdir(parents=True, exist_ok=True)
    snapshot_path = out / 'evaluation-plan.executed.json'
    oracle_snapshot = out / 'tespec-fault-oracle.executed.json'
    if oracle_hash and has_existing_report and not oracle_snapshot.is_file():
        raise ValueError('Use a fresh run ID for the new fault oracle')
    if snapshot_path.is_file():
        if sha(snapshot_path) != sha(planpath):
            raise ValueError('A measured run is bound to a different plan')
    else:
        shutil.copyfile(planpath, snapshot_path)
    if oracle_hash:
        if not oracle_snapshot.exists():
            shutil.copyfile(planpath.with_name('tespec-fault-oracle.json'), oracle_snapshot)
        if sha(oracle_snapshot) != oracle_hash:
            raise ValueError('Existing batch is bound to a different fault oracle')
    return snapshot_path

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--group',required=True);parser.add_argument('--run-id',help='Fresh result batch identifier; defaults to the reviewed plan run_id');a=parser.parse_args()
    group=ROOT/'benchmark/programs'/a.group;planpath=group/'evaluation-plan.json';plan,oracle_hash=load_current_plan(planpath);assert plan['program_group']==a.group
    keys=[(pair['cn_variant'],case['id']) for pair in plan['pairings'] for case in pair['cases']]
    assert len(keys)==len(set(keys)), 'Each (CN variant, case id) must identify one target/pairing; use distinct case IDs for different clients'
    for pair in plan['pairings']:
        assert isinstance(pair.get('function',plan['function']),str)
        for case in pair['cases']:
            assert isinstance(case['binds'].get('args',{}),dict) and isinstance(case['binds'].get('values'),dict), 'Every case needs valid args and an explicit values object'
            assert case['expected'] in ['PASS','FAIL','ERROR','CRASH'] and case['precondition_valid']
    run_id=a.run_id or plan['run_id']
    assert re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9_.-]*',run_id),'run_id must be a single directory name'
    out=ROOT/'benchmark/results'/a.group/run_id;variants={}
    wrapper=compiler_wrapper(plan)
    current_toolchain={'input_files_sha256':input_files_identity(ROOT,group),'cn_build':installed_identity(),'cn_sha256':sha(CN),'executor_sha256':sha(ROOT/'bin/tespec-symexec'),'build':json.loads((ROOT/'bin/tespec-symexec.build.json').read_text()),'driver_sha256':sha(Path(__file__)),'compiler_wrapper_sha256':sha(wrapper),'evaluation_source_snapshot':snapshot()}
    guard=out/'toolchain.json'
    if oracle_hash:
        current_toolchain['tespec_fault_oracle_sha256'] = oracle_hash
    old_report=out/'results.json'
    if guard.exists():assert_resume_compatible({'toolchain':json.loads(guard.read_text())},current_toolchain)
    elif old_report.exists():assert_resume_compatible(json.loads(old_report.read_text()),current_toolchain)
    elif out.exists() and any(out.iterdir()):raise RuntimeError('Unidentified partial run; choose a new --run-id without overwriting it')
    reuse_path=ROOT/plan['reuse_fulminate_from'] if plan.get('reuse_fulminate_from') else None
    reuse_report=json.loads(reuse_path.read_text()) if reuse_path else None
    if reuse_report:assert_fulminate_reuse_compatible(reuse_report,current_toolchain)
    snapshot_path = freeze_test_plan(out, planpath, oracle_hash, old_report.exists())
    if not guard.exists():save(guard,current_toolchain)
    for p in (group/'variants').glob('*/manifest.json'):
        v=json.loads(p.read_text());variants[v['id']]=(p,v)
    report={'schema':'tespec-group-finite-evaluation/v1','program_group':a.group,'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'evaluation_plan':str(planpath.relative_to(ROOT)),'plan_sha256':sha(planpath),'evaluation_plan_snapshot':str(snapshot_path.relative_to(ROOT)),'toolchain':current_toolchain,'runs':[]}
    if oracle_hash:
        report['tespec_fault_oracle']={'path':str((out/'tespec-fault-oracle.executed.json').relative_to(ROOT)), 'sha256':oracle_hash}
    reuse_path=ROOT/plan['reuse_fulminate_from'] if plan.get('reuse_fulminate_from') else None
    reuse_rows={(r['variant'],r['case']):r for r in reuse_report['runs']} if reuse_report else {}
    for pair in plan['pairings']:
        vid,qid=pair['cn_variant'],pair['qcp_variant'];vp,v=variants[vid];qv=variants[qid][1];cn=ROOT/v['files']['cn']['path'];qcp=ROOT/qv['files']['qcp']['path']
        assert sha(cn)==v['files']['cn']['sha256'] and sha(qcp)==qv['files']['qcp']['sha256']
        source=re.split(r'\nint main\s*\(',cn.read_text(),maxsplit=1)[0]
        for case in pair['cases']:
            assert case['precondition_valid']
            cid=case['id'];folder=out/vp.parent.name/cid;cached=folder/'receipt.json'
            selected=select_qcp_input(ROOT,qv['files']['qcp'],case,pair.get('function',plan['function']))
            qcp_input=ROOT/selected['path']
            if cached.exists():
                row=json.loads(cached.read_text());assert row['plan_case']==case;assert row['cn_source_sha256']==sha(cn) and row['qcp_source_sha256']==sha(qcp),'Cached inputs changed; choose a new --run-id';report['runs'].append(row);continue
            if folder.exists() and any(folder.iterdir()):raise RuntimeError('Partial execution directory has no receipt; choose a fresh --run-id to preserve failed artifacts: '+str(folder))
            inp=vp.parent/'tests'/run_id/cid;inp.mkdir(parents=True,exist_ok=True)
            harness=inp/'fulminate.cn.c';harness.write_text(source+'\nint main(void) /*@ ensures return == 0; @*/ { '+case['cn_body']+' return 0; }\n')
            binds=inp/'binds.json';save(binds,[dict(case['binds'],id=cid if re.fullmatch(r'[A-Za-z_]\w*',cid) else 'case_'+re.sub(r'\W','_',cid))])
            row={'variant':vid,'paired_qcp_variant':qid,'case':cid,'initial':case.get('value'),'expected':case['expected'],'plan_case':case,'cn_source_sha256':sha(cn),'qcp_source_sha256':sha(qcp),'harness':str(harness.relative_to(ROOT)),'harness_sha256':sha(harness),'binds':str(binds.relative_to(ROOT)),'binds_sha256':sha(binds),'precondition_valid':True}
            previous=reuse_rows.get((vid,cid))
            if previous:
                assert previous['cn_source_sha256']==row['cn_source_sha256'] and previous['harness_sha256']==row['harness_sha256']
                for key in ['fulminate_pipeline','fulminate_test','instrumented_sources','instrumented_binary_sha256']:row[key]=previous[key]
                row['fulminate_reuse']={'report':str(reuse_path.relative_to(ROOT)),'variant':vid,'case':cid,'scope':'Exact CN source and harness byte hashes match; retain actual original measurements once.'}
            else:
                with tempfile.TemporaryDirectory(prefix='tespec-group-') as tmp:
                    row['fulminate_pipeline']=measure([CN,'instrument','--run','--cc='+str(wrapper),'--output-dir='+tmp,*['-I'+str(ROOT/inc) for inc in v['files']['cn'].get('include_dirs',[])],harness],folder/'fulminate-pipeline')
                    generated=list(Path(tmp).glob('*.exec.c'))
                    for g in generated:shutil.copyfile(g,folder/g.name)
                    row['instrumented_sources']=[{'path':str((folder/g.name).relative_to(ROOT)),'sha256':sha(g)} for g in generated]
                    binaries=list(Path(tmp).glob('*.exec.out'))
                    if len(binaries)==1:
                        row['instrumented_binary_sha256']=sha(binaries[0]);m=measure([binaries[0]],folder/'fulminate-test');m['status']='PASS' if m['exit_code']==0 else 'FAIL';row['fulminate_test']=m
                    else:row['fulminate_test']={'status':'NOT_BUILT','wall_seconds':None,'resources':None,'tokens':0,'model_calls':0}
            if 'qcp_input_fixture' in case:
                row['qcp_input_fixture']=case['qcp_input_fixture']
            for mode in ['off','on']:
                dest=folder/('tespec-'+mode);command=[sys.executable,'-m','spectest','run',qcp_input,'--function',pair.get('function',plan['function']),'--binds',binds,'--execution-mode','all-boundaries','--output-dir',dest/'artifacts','--timeout','30','--compact','--spatial-smt' if mode=='on' else '--no-spatial-smt','--spatial-smt-timeout-ms','2000','-I',str(ROOT/'runtime/qcip/QCP_examples/QCP_demos_human'),*[flag for inc in selected.get('include_dirs',[]) for flag in ['-I',str(ROOT/inc)]]]
                if re.search(r'include\s+strategies\s+"/home/yangfp/teSpec/benchmark/selection/',qcp.read_text()):
                    locator=ROOT/'tools/benchmark/with_legacy_strategy_locator.py';row['qcp_execution_wrapper']={'path':str(locator.relative_to(ROOT)),'sha256':sha(locator),'policy':'Temporary byte-identical strategy locator compatibility, source unchanged.'};command=[sys.executable,locator,'--source',qcp,'--',*command]
                m=measure(command,dest,timeout=90)
                p=dest/'artifacts/report.json';m['report']=str(p.relative_to(ROOT)) if p.exists() else None;data=json.loads(p.read_text()) if p.exists() else {};m['statuses']=[x.get('status') for x in data.get('results',[])];m['status']=m['statuses'][0] if len(m['statuses'])==1 else 'ERROR'
                m['executed_source_sha256']=executed_source(data,selected['sha256']) if data.get('results') else None
                row['tespec_'+mode]=m
            row['runtime_dependency_fixtures']=[{'path':str(p.relative_to(ROOT)),'sha256':sha(p)} for p in sorted((qcp.parent.parent/'dependencies').glob('*')) if p.is_file()]
            save(cached,row);report['runs'].append(row);save(out/'results.json',report);print(a.group,vid,cid,row['expected'],'fulminate',row['fulminate_test']['status'],'OFF',row['tespec_off']['status'],'ON',row['tespec_on']['status'],flush=True)
    runs=report['runs'];report['summary']={'configurations':len(plan['pairings']),'variant_language_records':len(variants),'case_pairs':len(runs),'expected':dict(collections.Counter(r['expected'] for r in runs))}
    for tool in ['fulminate_test','tespec_off','tespec_on']:report['summary'][tool]={'statuses':dict(collections.Counter(r[tool]['status'] for r in runs)),'expected_matches':sum(matches_expected(r,tool) for r in runs)}
    save(out/'results.json',report);print(json.dumps(report['summary']),flush=True)
    from collect_tespec_unexpected import collect
    collect()
if __name__=='__main__':main()
