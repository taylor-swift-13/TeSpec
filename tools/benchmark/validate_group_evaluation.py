#!/usr/bin/env python3
"""Audit current group result/proof/cost publication without rerunning experiments."""
import argparse,json,re
from test_read_variants import ROOT,sha
from evaluation_expectations import matches as matches_expected
from attach_cell_leak_itp import validate_receipt

def load(p):return json.loads(p.read_text())
def main():
    p=argparse.ArgumentParser();p.add_argument('--group',required=True);a=p.parse_args();g=ROOT/'benchmark/programs'/a.group;b=ROOT/'benchmark/results'/a.group;manifest=load(g/'manifest.json');idx=load(b/'index.json');data=load(ROOT/idx['evaluation']);runs=data['runs'];table=load(b/'result-cost.json');assert table['complete']
    variants={load(ROOT/v['manifest'])['id']:load(ROOT/v['manifest']) for v in manifest['variants']};covered=set()
    for r in runs:
        covered.update([r['variant'],r['paired_qcp_variant']]);assert r['precondition_valid'] and r['expected'] in ['PASS','FAIL','ERROR']
        for k in ['harness','binds']:assert sha(ROOT/r[k])==r[k+'_sha256']
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
    q=load(ROOT/idx['qcp_receipt']);assert q['status']=='VERIFIED_KERNEL_CHECKED' and q['kernel_check']['exit_code']==0
    assert sha(ROOT/q['proof'])==q['proof_sha256'];assert sha(ROOT/q['original_goal'])==q['original_goal_sha256'];assert sha(ROOT/q['goal'])==q['original_goal_sha256']
    candidate=(ROOT/q['proof']).read_text();assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',candidate)
    model=q['model'];assert model['requested_model']=='gpt-6.1-sol' and model['exit_code']==0;assert sha((ROOT/idx['qcp_receipt']).parent/'agent.stdout.jsonl')==model['raw_event_log_sha256']
    for attempt_model in q.get('models',[model]):
        assert attempt_model['locked_goal_and_helper_sha256']['PrimaryQcpGoal.v']==q['original_goal_sha256']
        folder=(ROOT/idx['qcp_receipt']).parent if attempt_model is model or attempt_model==model else (ROOT/idx['qcp_receipt']).parent/'model-attempts'/('attempt-'+str(attempt_model['attempt']))
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
