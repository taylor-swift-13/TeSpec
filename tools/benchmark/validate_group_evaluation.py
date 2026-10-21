#!/usr/bin/env python3
"""Audit current group result/proof/cost publication without rerunning experiments."""
import argparse,json,re
from test_read_variants import ROOT,sha
from evaluation_expectations import matches as matches_expected
from execution_itp_receipts import validate_receipt
from publish_group_evaluation import repository_path,run_directory,cn_attempt_costs,audit_reused_qcp_native

def load(p):return json.loads(p.read_text())
def validate_compact(ROOT,g,b,manifest,idx,evaluation,nativepath,proofpath,data):
    assert load(b/'result-cost.json')['complete']
    variants={load(ROOT/v['manifest'])['id']:load(ROOT/v['manifest']) for v in manifest['variants']}
    covered=set()
    for row in data['runs']:
        covered.update([row['variant'],row['paired_qcp_variant']])
        assert row['precondition_valid'] and row['expected'] in ['PASS','FAIL','ERROR']
        assert sha(ROOT/variants[row['variant']]['files']['cn']['path'])==row['cn_source_sha256']
        assert sha(ROOT/variants[row['paired_qcp_variant']]['files']['qcp']['path'])==row['qcp_source_sha256']
        for key in ['fulminate_pipeline','fulminate_test','tespec_off','tespec_on']:
            measurement=row[key]
            assert measurement['wall_seconds']>=0 and measurement['resources']['max_process_rss_kib']>0
        assert row['fulminate_test']['status']==row['expected']
        assert row['tespec_off'].get('final_status',row['tespec_off']['status'])==row['expected']
        assert row['tespec_on'].get('final_status',row['tespec_on']['status'])==row['expected']
    assert covered==set(variants)
    native=load(nativepath);proof=load(proofpath)
    assert idx['native_receipt_sha256']==sha(nativepath)
    published=load(b/'cn/results.json');assert published['evidence_sha256']==sha(nativepath)
    assert native['cn']['exit_code']==0 and native['qcp']['exit_code']==0
    assert sha(ROOT/native['cn_source'])==native['cn_source_sha256']
    assert sha(ROOT/native['qcp_source'])==native['qcp_source_sha256']
    assert proof['status']=='VERIFIED_KERNEL_CHECKED' and proof['kernel_check']['exit_code']==0
    assert native['goal_sha256']==proof['original_goal_sha256']
    assert sha(ROOT/proof['proof'])==proof['proof_sha256']
    for strategy in ['inline','modular']:
        evidence=load(ROOT/manifest['execution_strategy_evidence'][strategy])
        assert evidence['summary']['passed'] and evidence['summary']['regressions']==0
        assert all(row['status']==row['expected'] for row in evidence['runs'])
    print(f'PASS {manifest["program_group"]}: compact durable evidence, exact source/proof hashes, full primary verification and inline/modular OFF/ON decisions.')

def main():
    p=argparse.ArgumentParser();p.add_argument('--group',required=True);p.add_argument('--run-id');p.add_argument('--native-receipt');p.add_argument('--qcp-receipt');a=p.parse_args();g=ROOT/'benchmark/programs'/a.group;b=ROOT/'benchmark/results'/a.group;manifest=load(g/'manifest.json');idx=load(b/'index.json')
    evaluation=repository_path(idx['evaluation'])
    if a.run_id:assert evaluation==run_directory(b,a.run_id)/'results.json', 'Requested batch is not the published evaluation'
    cn_publication=load(b/'cn/results.json')
    nativepath=repository_path(idx.get('native_receipt',cn_publication['evidence']))
    if a.native_receipt:assert nativepath==repository_path(a.native_receipt), 'Requested native receipt is not the published receipt'
    proofpath=repository_path(idx['qcp_receipt'])
    if a.qcp_receipt:assert proofpath==repository_path(a.qcp_receipt), 'Requested QCP receipt is not the published receipt'
    data=load(evaluation);runs=data['runs'];table=load(b/'result-cost.json');assert table['complete']
    if data.get('schema')=='tespec-compact-group-evidence/v1':
        validate_compact(ROOT,g,b,manifest,idx,evaluation,nativepath,proofpath,data)
        return
    variants={load(ROOT/v['manifest'])['id']:load(ROOT/v['manifest']) for v in manifest['variants']};covered=set()
    for r in runs:
        covered.update([r['variant'],r['paired_qcp_variant']]);assert r['precondition_valid'] and r['expected'] in ['PASS','FAIL','ERROR']
        for k in ['harness','binds']:assert sha(ROOT/r[k])==r[k+'_sha256']
        for dep in r.get('runtime_dependency_fixtures',[])+([r['qcp_execution_wrapper']] if r.get('qcp_execution_wrapper') else []):assert (ROOT/dep['path']).resolve().is_relative_to(ROOT) and sha(ROOT/dep['path'])==dep['sha256']
        for lang,vid in [('cn',r['variant']),('qcp',r['paired_qcp_variant'])]:assert sha(ROOT/variants[vid]['files'][lang]['path'])==r[lang+'_source_sha256']==variants[vid]['files'][lang]['sha256']
        for k in ['fulminate_pipeline','fulminate_test','tespec_off','tespec_on']:
            m=r[k];assert m['resources']['max_process_rss_kib']>0 and m['wall_seconds']>0
            for field in ['stdout','stderr']:assert sha(ROOT/m[field])==m[field+'_sha256']
            if k.startswith('tespec'):
                assert sha(ROOT/m['report'])==m['report_sha256'];assert load(ROOT/m['report'])['results'][0]['status']==m['status']
        for mode in ['off','on']:
            if r['tespec_'+mode].get('itp'):
                m=r['tespec_'+mode];assert sha(ROOT/m['itp']['receipt'])==m['itp']['receipt_sha256'];validate_receipt(ROOT/m['itp']['receipt'],r,mode)
        for f in r['instrumented_sources']:assert sha(ROOT/f['path'])==f['sha256']
    assert covered==set(variants),'Some existing variant records have not been tested'
    for tool,key in [('fulminate','fulminate_test'),('tespec','tespec_off')]:
        pub=load(b/tool/'results.json');assert pub['summary']['case_pairs']==len(runs);assert pub['summary']['correct']==sum(matches_expected(r,key) for r in runs)
    native=load(nativepath)
    if idx.get('native_receipt_sha256'):assert sha(nativepath)==idx['native_receipt_sha256']
    if cn_publication.get('evidence_sha256'):assert sha(nativepath)==cn_publication['evidence_sha256']
    assert repository_path(cn_publication['evidence'])==nativepath and cn_publication['verdict']=='VERIFIED'
    assert cn_publication['original_measurement']==native['cn']
    assert sha(repository_path(cn_publication['source']['path']))==native['cn_source_sha256']==cn_publication['source']['sha256']
    attempts,cnstat=cn_attempt_costs(nativepath,native);audit_reused_qcp_native(native)
    published_cnstat=load(b/'cn/statistics.json')
    for key,value in cnstat.items():assert published_cnstat[key]==value, 'CN attempt accounting mismatch: '+key
    if native.get('additional_cn_attempts'):assert cn_publication['additional_cn_attempts']==attempts[1:]
    if native.get('cn_scope'):assert cn_publication['scope']==native['cn_scope']
    qcp_publication=load(b/'qcp/results.json')
    assert repository_path(qcp_publication['receipt'])==proofpath
    assert sha(repository_path(qcp_publication['source']['path']))==native['qcp_source_sha256']==qcp_publication['source']['sha256']
    q=load(proofpath);assert q['status']=='VERIFIED_KERNEL_CHECKED' and q['kernel_check']['exit_code']==0
    assert q['original_goal_sha256']==native['goal_sha256']
    assert sha(ROOT/q['proof'])==q['proof_sha256'];assert sha(ROOT/q['original_goal'])==q['original_goal_sha256'];assert sha(ROOT/q['goal'])==q['original_goal_sha256']
    candidate=(ROOT/q['proof']).read_text();assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',candidate)
    model=q['model'];assert model['requested_model']=='gpt-6.1-sol' and model['exit_code']==0;assert sha(proofpath.parent/'agent.stdout.jsonl')==model['raw_event_log_sha256']
    for attempt_model in q.get('models',[model]):
        assert attempt_model['locked_goal_and_helper_sha256']['PrimaryQcpGoal.v']==q['original_goal_sha256']
        folder=proofpath.parent if attempt_model is model or attempt_model==model else proofpath.parent/'model-attempts'/('attempt-'+str(attempt_model['attempt']))
        assert sha(folder/'agent.stdout.jsonl')==attempt_model['raw_event_log_sha256']
        assert sha(folder/'prompt.txt')==attempt_model['prompt_sha256']
        if folder.name.startswith('attempt-'):assert sha(folder/'Candidate.v')==attempt_model['candidate_sha256']
    if q.get('verdict')=='VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS':
        audit=q['assumptions'];assert audit['standard_library_axioms']==['FunctionalExtensionality.functional_extensionality_dep']
        assert sha(ROOT/audit['policy'])==audit['policy_sha256']
        baseline=(ROOT/audit['statement_and_runtime_helper_audit']).read_text();assert 'RUNTIME_HELPER' in baseline and 'FunctionalExtensionality.functional_extensionality_dep' in baseline
        assert audit['new_proof_axiom_declarations']==[]
    stat=load(b/'qcp/statistics.json');assert abs(sum(x['wall_seconds'] for x in stat['stages'])-stat['wall_seconds'])<1e-7;assert stat['tokens']==sum(u['input_tokens']+u['output_tokens'] for m in q.get('models',[model]) for u in m['token_usage'])
    modes=load(ROOT/manifest['test_modes_statistics']);assert modes['results_sha256']==sha(ROOT/idx['evaluation']);assert modes['case_pairs']==len(runs)
    for mode in ['off','on']:
        assert modes['modes'][mode]['expected_matches']==sum(matches_expected(r,'tespec_'+mode) for r in runs)
    print(f'PASS {a.group}: {len(covered)} language records, {len(runs)} input pairs, exact source/log/proof hashes, full primary verification and disjoint stage costs.')
if __name__=='__main__':main()
