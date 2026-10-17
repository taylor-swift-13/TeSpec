#!/usr/bin/env python3
"""Validate and attach independently checked per-execution positive residual-VC verdicts."""
from pathlib import Path
import json,re,statistics
from test_read_variants import ROOT,save,sha
from positive_execution_itp import DEFAULT_ITP_RUN_ID

def validate_receipt(path,row,mode):
    r=json.loads(path.read_text());b=r['binding'];assert r['status']=='KERNEL_CHECKED' and r['final_status']=='PASS' and r['kernel_check']['exit_code']==0
    assert b['variant']==row['variant'] and b['case']==row['case'] and b['mode']==mode
    assert b['qcp_source_sha256']==row['qcp_source_sha256'] and b['binds_sha256']==row['binds_sha256']==sha(ROOT/row['binds'])
    assert sha(ROOT/b['report'])==b['report_sha256'] and sha(ROOT/b['goal'])==b['goal_sha256']
    assert sha(ROOT/r['candidate'])==r['candidate_sha256'];text=(ROOT/r['candidate']).read_text();assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b',text)
    assert b['proof_kind']=='POSITIVE_ORIGINAL_RESIDUAL_VCS' and {x['name'] for x in r['goals']}=={'resolved_'+n for n in b['residual_vcs']}
    from positive_execution_itp import statements
    expected=[('resolved_'+n,'ExecutionGoal.'+n) for n in b['residual_vcs']]
    assert statements(text)==[(g['name'],g['statement']) for g in r['goals']]==expected
    if r.get('proof_reference'):
        ref=r['proof_reference'];prior_path=ROOT/ref['source_certificate'];assert sha(prior_path)==ref['source_certificate_sha256'];prior=json.loads(prior_path.read_text());assert prior['status']=='KERNEL_CHECKED' and prior['kernel_check']['exit_code']==0
        assert ref['original_goal_sha256']==b['goal_sha256']==prior['binding']['goal_sha256'] and b['residual_vcs']==prior['binding']['residual_vcs']
        assert b['qcp_source_sha256']==prior['binding']['qcp_source_sha256'] and b['binds_sha256']==prior['binding']['binds_sha256'];assert sha(ROOT/ref['source_candidate'])==ref['source_candidate_sha256']==prior['candidate_sha256']

    for s in r['compilation']+[r['kernel_check']]:
      for stream in ['stdout','stderr']:assert sha(ROOT/s[stream])==s[stream+'_sha256']
    from positive_execution_itp import symbols
    audit=(ROOT/r['assumptions']['raw_audit']).read_text();baseline=(ROOT/r['assumptions']['original_statement_audit']).read_text();allowed={'sizeof_union_type','sizeof_struct_type','sizeof_enum_type','sizeof_alias_type','eval_addr_expr'}
    if r['assumptions'].get('policy'):
        policy_path=ROOT/r['assumptions']['policy'];assert sha(policy_path)==r['assumptions']['policy_sha256'];policy=json.loads(policy_path.read_text())['test_itp_assumption_audit_policy'];assert policy['required_runtime_helper']=='join_assoc' and policy['allowed_standard_library_axioms']==['FunctionalExtensionality.functional_extensionality_dep'];baseline,helper=baseline.split('POSITIVE_RUNTIME_HELPER\n',1);extra=symbols(audit)-symbols(baseline);assert extra<=set(policy['allowed_standard_library_axioms']) and extra<=symbols(helper) and extra==set(r['assumptions']['standard_library_axioms'])
    else:assert symbols(audit)<=symbols(baseline)
    assert symbols(baseline)<=allowed and audit.count('Closed under the global context')+audit.count('Axioms:')==len(b['residual_vcs'])
    return r

def attach(group,allow_partial=False,run_id=None,itp_run_id=DEFAULT_ITP_RUN_ID):
    plan=json.loads((ROOT/'benchmark/programs'/group/'evaluation-plan.json').read_text());base=ROOT/'benchmark/results'/group;path=base/(run_id or plan['run_id'])/'results.json';data=json.loads(path.read_text());itp=base/itp_run_id;taskdata=json.loads((itp/'tasks.json').read_text());assert taskdata['evaluation_report']==str(path.relative_to(ROOT)), 'ITP tasks belong to a different evaluation batch';tasks=taskdata['tasks'];done=[];pending=[]
    for b in tasks:
      row=next(x for x in data['runs'] if x['variant']==b['variant'] and x['case']==b['case']);mode=b['mode'];assert row['tespec_'+mode]['status']=='UNKNOWN';assert b['paired_qcp_variant']==row['paired_qcp_variant'] and b['report']==row['tespec_'+mode]['report'], 'ITP binding does not match this execution report'
      folder=itp/f'execution-{b["execution_index"]:02d}';receipts=[(p,json.loads(p.read_text())) for p in sorted(folder.glob('attempt-*/coq-receipt.json'))];accepted=[(p,r) for p,r in receipts if r['status']=='KERNEL_CHECKED'];
      if not accepted and allow_partial:pending.append(b['execution_index']);continue
      assert len(accepted)==1,'Pending separate ITP '+str(b['execution_index']);p,r=accepted[0];validate_receipt(p,row,mode)
      modelpaths=sorted(folder.glob('attempt-*/model-receipt.json'));models=[json.loads(p.read_text()) for p in modelpaths];assert len(models)==max(m['attempt'] for m in models)
      for mp,m in zip(modelpaths,models):
        assert m['requested_model']=='gpt-6.1-sol' and m['token_usage'];assert sha(mp.parent/'agent.stdout.jsonl')==m['raw_event_log_sha256'];assert sha(mp.parent/'prompt.txt')==m['prompt_sha256'];assert m['locked_goal_and_helper_sha256']['ExecutionGoal.v']==b['goal_sha256']
      compile_rows=[s for _,a in receipts for s in a['compilation']];kernel_rows=[a['kernel_check'] for _,a in receipts if a.get('kernel_check')]
      model_seconds=sum(m['wall_seconds'] for m in models);compile_seconds=sum(s['wall_seconds'] for s in compile_rows);kernel_seconds=sum(s['wall_seconds'] for s in kernel_rows);tokens=sum(e['input_tokens']+e['output_tokens'] for m in models for e in m['token_usage'])
      peaks={'agent_proof_filling':max(m['resources']['max_process_peak_working_set_bytes'] for m in models)/1048576,'coq_compilation_and_assumption_audit':max(s['resources']['max_process_rss_kib'] for s in compile_rows)/1024,'independent_kernel_check':max(s['resources']['max_process_rss_kib'] for s in kernel_rows)/1024};peaks['itp']=max(peaks.values())
      metrics={'agent_proof_filling_seconds':model_seconds,'coq_compile_audit_seconds':compile_seconds,'independent_kernel_check_seconds':kernel_seconds,'total_seconds':model_seconds+compile_seconds+kernel_seconds,'tokens':tokens,'model_calls':len(models),'peak_process_memory_mib':peaks}
      evidence={'status':'KERNEL_CHECKED','final_status':'PASS','receipt':str(p.relative_to(ROOT)),'receipt_sha256':sha(p),'attempts':[{'path':str(p.relative_to(ROOT)),'sha256':sha(p)} for p,_ in receipts],'models':[{'path':str(p.relative_to(ROOT)),'sha256':sha(p)} for p in modelpaths],'metrics':metrics}
      if r.get('proof_reference'):evidence['proof_reference']=r['proof_reference']
      row['tespec_'+mode]['itp']=evidence;row['tespec_'+mode]['final_status']='PASS';done.append({'variant':row['variant'],'case':row['case'],'mode':mode,**evidence})
    snapshot=path.parent/'results.native-before-itp.json'
    if not snapshot.exists():snapshot.write_bytes(path.read_bytes())
    taskdata=json.loads((itp/'tasks.json').read_text());assert sha(snapshot)==taskdata['evaluation_report_sha256'];taskdata['evaluation_report_snapshot']=str(snapshot.relative_to(ROOT));save(itp/'tasks.json',taskdata)
    save(path,data);save(itp/'index.json',{'schema':'tespec-group-per-execution-itp/v1','group':group,'scope':'One independently model-filled, compiled, audited and kernel-checked task per execution, proving all original residual VCs; entry was native SAT and execution completed. No universal proof or fabricated counterexample substitutes for this execution. Native SMT decisions are not re-certified. All actual repair calls and compilation failures counted.','executions':done,'pending_execution_indices':pending,'complete':not pending})
    print('Attached',len(done),'independently kernel-checked execution verdicts',flush=True)

def mode_costs(rows,mode):
    ms=[r['tespec_'+mode]['itp']['metrics'] for r in rows if r['tespec_'+mode].get('itp')]
    if not ms:return {}
    return {'executions_requiring_itp_for_verdict':len(ms),'itp_wall_seconds_counted':sum(m['total_seconds'] for m in ms),'itp_tokens_counted':sum(m['tokens'] for m in ms),'mean_itp_seconds_when_required':statistics.mean(m['total_seconds'] for m in ms),'model_calls_newly_executed':sum(m['model_calls'] for m in ms),'tokens_newly_consumed':sum(m['tokens'] for m in ms)}

def statistics_for_off(rows,statistics_path):
    ms=[r['tespec_off']['itp']['metrics'] for r in rows if r['tespec_off'].get('itp')]
    if not ms:return None
    avg={'schema':'tespec-group-itp-execution-average/v1','estimated':False,'execution_count':len(ms),'mean_agent_proof_filling_seconds':statistics.mean(m['agent_proof_filling_seconds'] for m in ms),'mean_coq_compile_audit_seconds':statistics.mean(m['coq_compile_audit_seconds'] for m in ms),'mean_independent_kernel_check_seconds':statistics.mean(m['independent_kernel_check_seconds'] for m in ms),'mean_total_tokens':statistics.mean(m['tokens'] for m in ms),'process_memory':{k:{'mean_per_execution_peak_mib':statistics.mean(m['peak_process_memory_mib'][k] for m in ms),'maximum_per_execution_peak_mib':max(m['peak_process_memory_mib'][k] for m in ms)} for k in ms[0]['peak_process_memory_mib']},'policy':'Measured separately for every required execution; each execution includes every actual repair model and compile attempt. RSS means are means of actual per-execution maxima, never a batch peak divided by count.'};save(statistics_path,avg);return ms

if __name__=='__main__':
 import argparse
 p=argparse.ArgumentParser();p.add_argument('--group',required=True);p.add_argument('--allow-partial',action='store_true');p.add_argument('--run-id',help='Evaluation batch directory below the group; defaults to evaluation-plan run_id');p.add_argument('--itp-run-id',default=DEFAULT_ITP_RUN_ID,help='Proof batch directory below the group');a=p.parse_args();attach(a.group,a.allow_partial,a.run_id,a.itp_run_id)
