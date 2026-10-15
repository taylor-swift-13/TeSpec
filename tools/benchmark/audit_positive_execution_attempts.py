#!/usr/bin/env python3
"""Audit original-goal links and observed costs, including deferred proof repairs."""
import argparse,json,hashlib,collections
from test_read_variants import ROOT,save,sha
from attach_positive_execution_itp import validate_receipt

def main(group):
 base=ROOT/'benchmark/results'/group;folder=base/'20261016-positive-itp-per-execution';tasks=json.loads((folder/'tasks.json').read_text())['tasks'];plan=json.loads((ROOT/'benchmark/programs'/group/'evaluation-plan.json').read_text());rows=json.loads((base/plan['run_id']/'results.json').read_text())['runs'];entries=[]
 for task in tasks:
  current=folder/f'execution-{task["execution_index"]:02d}';modelpaths=sorted(current.glob('attempt-*/model-receipt.json'));receiptpaths=[p for p in sorted(current.glob('attempt-*/coq-receipt.json')) if json.loads(p.read_text()).get('status')!='COMPILING']
  if not modelpaths:continue
  models=[]
  for p in modelpaths:
   m=json.loads(p.read_text());assert sha(p.parent/'prompt.txt')==m['prompt_sha256'] and sha(p.parent/'agent.stdout.jsonl')==m['raw_event_log_sha256'];assert m['requested_model']=='gpt-6.1-sol' and m['locked_goal_and_helper_sha256']['ExecutionGoal.v']==task['goal_sha256'];models.append(m)
  receipts=[];accepted=[]
  row=next(x for x in rows if x['variant']==task['variant'] and x['case']==task['case'])
  for p in receiptpaths:
   d=json.loads(p.read_text());assert d['binding']==task
   for measured in d['compilation']+([d['kernel_check']] if d.get('kernel_check') else []):
    for stream in ['stdout','stderr']:assert sha(ROOT/measured[stream])==measured[stream+'_sha256']
   if d['status']=='KERNEL_CHECKED':validate_receipt(p,row,task['mode']);accepted.append(p)
   receipts.append(d)
  assert len(accepted)<=1
  comp=[m for d in receipts for m in d['compilation']];kernels=[d['kernel_check'] for d in receipts if d.get('kernel_check')];tokens=sum(e['input_tokens']+e['output_tokens'] for m in models for e in m['token_usage'])
  entries.append({'execution_index':task['execution_index'],'variant':task['variant'],'case':task['case'],'mode':task['mode'],'status':'KERNEL_CHECKED' if accepted else 'PENDING_OR_DEFERRED','original_residual_targets':task['residual_vcs'],'model_attempts':len(models),'finished_model_wall_seconds':sum(m['wall_seconds'] for m in models),'actual_tokens_in_finished_usage_events':tokens,'agent_max_process_peak_mib':max(m['resources']['max_process_peak_working_set_bytes'] for m in models)/1048576,'finished_coq_compile_audit_seconds':sum(m['wall_seconds'] for m in comp),'compile_max_process_rss_mib':max((m['resources']['max_process_rss_kib']/1024 for m in comp),default=None),'finished_kernel_seconds':sum(m['wall_seconds'] for m in kernels),'kernel_max_process_rss_mib':max((m['resources']['max_process_rss_kib']/1024 for m in kernels),default=None),'model_receipts':[{'path':str(p.relative_to(ROOT)),'sha256':sha(p)} for p in modelpaths],'coq_receipts':[{'path':str(p.relative_to(ROOT)),'sha256':sha(p)} for p in receiptpaths],'certificate_reuse_repairs':[d['proof_reference'] for d in receipts if d.get('proof_reference')]})
 result={'schema':'tespec-positive-itp-observed-attempt-costs/v1','program_group':group,'complete':len(entries)==len(tasks) and all(x['status']=='KERNEL_CHECKED' for x in entries),'required_executions':len(tasks),'observed_executions':len(entries),'checked_executions':sum(x['status']=='KERNEL_CHECKED' for x in entries),'observed_model_attempts':sum(x['model_attempts'] for x in entries),'observed_tokens':sum(x['actual_tokens_in_finished_usage_events'] for x in entries),'scope':'Raw observed completed phase measurements including every preserved failed/deferred model and compiler attempt. In-flight or not-started costs remain unknown. These are not final per-execution means and do not replace pending whole-group stages. Accepted original-target links and raw model/prompt/Coq logs are audited.','executions':entries};save(folder/'observed-attempt-costs.json',result)
 ledger=ROOT/'benchmark/results/tespec-unexpected';idx=json.loads((ledger/'index.json').read_text());triage=json.loads((ledger/'triage.json').read_text())
 for entry in entries:
  task=next(x for x in tasks if x['execution_index']==entry['execution_index']);issue=next((x for x in idx['issues'] if x['group']==group and x['report']==task['report']),None)
  if issue:triage.setdefault(issue['id'],{})['positive_itp_observed_attempts']={'source':str((folder/'observed-attempt-costs.json').relative_to(ROOT)),'execution_index':entry['execution_index'],'model_attempts':entry['model_attempts'],'actual_tokens':entry['actual_tokens_in_finished_usage_events'],'status':entry['status'],'qualification':'Proof-script compile/audit failures do not refute the program or its spec; preserve expected PASS and every failed attempt.'}
 save(ledger/'triage.json',triage)
 print('Audited positive attempts',group,result['checked_executions'],'checked /',result['observed_executions'],'observed;',result['observed_model_attempts'],'actual model attempts; total',result['observed_tokens'],'tokens',flush=True)
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--group',required=True);a=p.parse_args();main(a.group)
