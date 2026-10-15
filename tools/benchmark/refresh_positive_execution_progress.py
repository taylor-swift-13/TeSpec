#!/usr/bin/env python3
"""Publish measured positive-test ITP progress without completing missing universal stages."""
import argparse,collections,json,statistics,subprocess
from test_read_variants import ROOT,save,sha
from publish_abs_tool_results import stage
from attach_cell_leak_itp import mode_costs,statistics_for_off

def main(group):
 base=ROOT/'benchmark/results'/group;plan=json.loads((ROOT/'benchmark/programs'/group/'evaluation-plan.json').read_text());run=base/plan['run_id'];data=json.loads((run/'results.json').read_text());rows=data['runs'];modes={}
 for mode in ['off','on']:
  ms=[r['tespec_'+mode] for r in rows];needed=[m for m in ms if m['status']=='UNKNOWN'];done=[m['itp']['metrics'] for m in needed if m.get('itp')];pending=len(needed)-len(done);times=[m['wall_seconds'] for m in ms];peaks=[m['resources']['max_process_rss_kib']/1024 for m in ms]
  modes[mode]={'native_status_counts':dict(collections.Counter(m['status'] for m in ms)),'final_status_counts':dict(collections.Counter(m.get('final_status',m['status']) for m in ms)),'expected_matches':sum(r['tespec_'+mode].get('final_status',r['tespec_'+mode]['status'])==r['expected'] for r in rows),'execution_wall_seconds_total':sum(times),'mean_execution_wall_seconds':statistics.mean(times),'mean_execution_peak_rss_mib':statistics.mean(peaks),'maximum_execution_peak_rss_mib':max(peaks),'executions_requiring_itp_for_verdict':len(needed),'completed_independent_itp_executions':len(done),'pending_independent_itp_executions':pending,'itp_completed_subset_wall_seconds':sum(x['total_seconds'] for x in done),'itp_completed_subset_tokens':sum(x['tokens'] for x in done),'itp_wall_seconds_counted':None if pending else sum(x['total_seconds'] for x in done),'mean_itp_seconds_when_required':None if pending or not done else statistics.mean(x['total_seconds'] for x in done)}
 save(run/'statistics.json',{'schema':'tespec-group-spatial-smt-comparison/v1','program_group':group,'case_pairs':len(rows),'results_sha256':sha(run/'results.json'),'modes':modes,'complete':False,'certificate':'Native SMT NOT_CHECKED; attached ITP receipts independently kernel checked.'})
 off=[r['tespec_off']['itp']['metrics'] for r in rows if r['tespec_off'].get('itp')];pending=modes['off']['pending_independent_itp_executions'];s=json.loads((base/'tespec/statistics.json').read_text());s.update(itp_required_executions=modes['off']['executions_requiring_itp_for_verdict'],itp_completed_executions=len(off),itp_pending_executions=pending,itp_evidence_index=str((base/'20261016-positive-itp-per-execution/index.json').relative_to(ROOT)))
 s['tokens']=None if pending else sum(x['tokens'] for x in off);s['model_calls']=None if pending else sum(x['model_calls'] for x in off)
 s['stages']=s['stages'][:1]+[dict(stage(n,None if pending else sum(x[k] for x in off),None if pending or not off else max(x['peak_process_memory_mib'][n] for x in off),None if pending else sum(x['tokens'] for x in off) if n=='agent_proof_filling' else 0),completed_subset_wall_seconds=sum(x[k] for x in off),completed_subset_tokens=sum(x['tokens'] for x in off) if n=='agent_proof_filling' else 0,completed_subset_max_process_peak_mib=max((x['peak_process_memory_mib'][n] for x in off),default=None)) for n,k in [('agent_proof_filling','agent_proof_filling_seconds'),('coq_compilation_and_assumption_audit','coq_compile_audit_seconds'),('independent_kernel_check','independent_kernel_check_seconds')]];save(base/'tespec/statistics.json',s)
 if not pending and off:statistics_for_off(rows,base/'tespec/itp-average.json')
 p=base/'tespec/results.json';d=json.loads(p.read_text());d['summary']['correct']=modes['off']['expected_matches'];d['summary']['native_status_counts']=modes['off']['native_status_counts'];d['summary']['final_status_counts']=modes['off']['final_status_counts']
 for c in d['cases']:
  row=next(x for x in rows if x['variant']==c['variant'] and x['case']==c['case']);m=row['tespec_off'];c.update(actual=m.get('final_status',m['status']),matches_expected=m.get('final_status',m['status'])==row['expected'],itp=m.get('itp'))
 save(p,d);p=base/'coverage-gap.json';d=json.loads(p.read_text());d.update(tespec_off_matches=modes['off']['expected_matches'],tespec_on_matches=modes['on']['expected_matches'],pending_independent_positive_itp_executions=sum(modes[m]['pending_independent_itp_executions'] for m in modes),test_itp_evidence=str((base/'20261016-positive-itp-per-execution/index.json').relative_to(ROOT)));save(p,d)
 ledger=ROOT/'benchmark/results/tespec-unexpected';triage=json.loads((ledger/'triage.json').read_text());idx=json.loads((ledger/'index.json').read_text())
 for issue in idx['issues']:
  if issue['group']!=group:continue
  # Exact report and mode binding, avoiding inference from case display names.
  match=next((row['tespec_'+mode] for row in rows for mode in ['off','on'] if row['tespec_'+mode].get('report')==issue['report']),None)
  if match and match.get('itp'):triage.setdefault(issue['id'],{}).update(status='RESOLVED_POSITIVE_EXECUTION_ITP',itp_conclusion='All original residual VCs proved for this exact finite execution; compile, original-statement assumption audit and full independent kernel check passed.',itp_receipt=match['itp']['receipt'])
 save(ledger/'triage.json',triage)
 subprocess.run(['python3','tools/benchmark/audit_positive_execution_attempts.py','--group',group],cwd=ROOT,check=True)
 for script in ['collect_tespec_unexpected','build_group_cost_tables','refresh_benchmark_progress']:subprocess.run(['python3','tools/benchmark/'+script+'.py'],cwd=ROOT,check=True)
 print(group,'positive ITP done',sum(modes[m]['completed_independent_itp_executions'] for m in modes),'pending',sum(modes[m]['pending_independent_itp_executions'] for m in modes),flush=True)
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--group',required=True);a=p.parse_args();main(a.group)
