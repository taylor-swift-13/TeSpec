#!/usr/bin/env python3
"""Publish actual fresh-model and Coq ITP resource measurements."""
from pathlib import Path
import collections, hashlib, json, re

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'benchmark/results/read/20261015-itp-metered'
OLD=ROOT/'benchmark/results/read/20261015-itp-refutations'

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,d):p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')

def main():
    previous=json.loads((OLD/'receipt.json').read_text())
    attempts=[json.loads(p.read_text()) for p in sorted(OUT.glob('attempt-*/coq-receipt.json'))]
    assert attempts and attempts[-1].get('status')=='KERNEL_CHECKED'
    accepted=attempts[-1]
    models=[json.loads((ROOT/a['model_receipt']).read_text()) for a in attempts]
    assert all(m['requested_model']=='gpt-6.1-sol' and m['token_usage'] for m in models)
    compilations=[stage for a in attempts for stage in a['compilation']]
    kernels=[a['kernel_check'] for a in attempts if 'kernel_check' in a]
    usage=collections.Counter()
    for model in models:
        for turn in model['token_usage']:
            for key,value in turn.items():usage[key]+=value
    usage['total_tokens']=usage['input_tokens']+usage['output_tokens']
    coq_peak=max(s['resources']['max_process_rss_kib'] for s in compilations+kernels)
    client_peak=max(m['resources']['max_process_peak_working_set_bytes'] for m in models)
    model_time=sum(m['wall_seconds'] for m in models)
    compile_time=sum(s['wall_seconds'] for s in compilations)
    kernel_time=sum(s['wall_seconds'] for s in kernels)
    metrics={'requested_model':'gpt-6.1-sol','model_calls':len(models),'model_wall_seconds':model_time,
             'coq_compile_audit_wall_seconds':compile_time,'kernel_wall_seconds':kernel_time,
             'total_itp_wall_seconds':model_time+compile_time+kernel_time,
             'coq_peak_process_rss_kib':coq_peak,'model_client_peak_working_set_bytes':client_peak,
             'local_peak_process_resident_bytes':max(coq_peak*1024,client_peak),
             'local_peak_process_resident_mib':max(coq_peak*1024,client_peak)/1048576,
             'token_usage':dict(usage),'successful_attempt':accepted['attempt'],
             'memory_definition':'Maximum process resident memory across sequential stages: Linux GNU time %M for Coq and observed Windows process PeakWorkingSet for model client. Remote service/GPU memory excluded; not aggregate simultaneous process-tree RSS.',
             'time_definition':'Actual wall time of all model, compilation/audit and kernel stages in this new measured run; includes failed measured attempts if any. Shared stages counted once.',
             'reuse_definition':'The checked concrete-heap helper is reused, recompiled and counted. All 36 refutation/entry statements were freshly completed by the metered model; previous refutation solutions were not supplied.',
             'historical_run':'Earlier unmetered authoring receipts remain historical and are not retroactively assigned these measurements.'}
    proof=ROOT/accepted['candidate'];text=proof.read_text()
    assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',text)
    names=[f'case_{i:02d}_{kind}' for i in range(12) for kind in ['return_refuted','spatial_refuted','entry_sat']]
    assert re.findall(r'Print Assumptions\s+(case_\w+)\.',text)==names
    audit=(ROOT/accepted['compilation'][-1]['stdout']).read_text()
    assert audit.count('Closed under the global context')==36
    cases=[]
    goal_stages={Path(s['source']).stem:s for s in accepted['compilation']}
    for i,old in enumerate(previous['cases']):
        row=dict(old);goal_name=f'ReadUnknown{i:02d}Goal';goal_stage=goal_stages[goal_name]
        assert sha(ROOT/old['original_goal'])==old['original_goal_sha256']==goal_stage['source_sha256']
        row.update(goal_copy=goal_stage['source'],goal_copy_sha256=goal_stage['source_sha256'],proof=accepted['candidate'],proof_sha256=accepted['candidate_sha256'],
                   goal_compile=goal_stage,refutation_compile=accepted['compilation'][-1],
                   theorems=[f'case_{i:02d}_{k}' for k in ['return_refuted','spatial_refuted','entry_sat']],
                   assumptions='Closed under the global context; all 36 printed theorem audits checked',itp_status='REFUTED_KERNEL_CHECKED',resolved_test_status='FAIL')
        cases.append(row)
    receipt={'schema':'tespec-metered-read-itp/v1','cases':cases,'attempts':attempts,'models':models,
             'helper_compile':accepted['compilation'][0],'kernel_check':accepted['kernel_check'],'metrics':metrics,
             'summary':{'formally_refuted':12,'entry_satisfiable_proved':12,'spatial_splits_refuted':12,'assumption_audits_closed':36,'kernel_check_exit':0},
             'coq_version':accepted['coq_version'],'scope':metrics['reuse_definition']}
    save(OUT/'receipt.json',receipt)
    raw=json.loads((ROOT/'benchmark/results/read/20261015-variants/results.json').read_text())
    old_resolved=json.loads((OLD/'resolved-results.json').read_text())
    resolved=dict(old_resolved)
    resolved.update(schema='tespec-metered-read-itp-adjudication/v1',metrics=metrics,
                    measured_compile_and_kernel_wall_seconds_including_failed_attempts=compile_time+kernel_time,
                    measured_full_itp_wall_seconds_including_model_and_failed_attempts=metrics['total_itp_wall_seconds'],
                    peak_rss=metrics['local_peak_process_resident_bytes'],peak_rss_note=metrics['memory_definition'],
                    external_model_api_calls=len(models),proof_authoring_chat_tokens=None,
                    proof_authoring_model_tokens=usage['total_tokens'],token_note='Fresh gpt-6.1-sol authoring, actual CLI turn.completed usage. Historical conversation tokens are not reconstructed.')
    resolved.pop('unsuccessful_authoring_attempts',None)
    for i,c in enumerate(resolved['cases']):
        matches=[x for x in cases if x['variant']==c['variant'] and x['case']==c['case']]
        if matches:c['itp_proof']=matches[0]['proof'];c['itp_theorems']=matches[0]['theorems']
    save(OUT/'resolved-results.json',resolved)
    index_path=ROOT/'benchmark/results/read/index.json';index=json.loads(index_path.read_text())
    index.setdefault('adjudications',[]).append({'kind':'METERED_GPT61_COQ_KERNEL_CHECKED_REFUTATION','receipt':(OUT/'receipt.json').relative_to(ROOT).as_posix(),'resolved_results':(OUT/'resolved-results.json').relative_to(ROOT).as_posix()})
    # Avoid duplicate view entries when rebuilding measured summaries.
    index['adjudications']=list({x['receipt']:x for x in index['adjudications']}.values());save(index_path,index)
    save(OUT/'statistics.json',metrics)
    print(json.dumps(metrics,ensure_ascii=False),flush=True)

if __name__=='__main__':main()
