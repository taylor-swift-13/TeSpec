#!/usr/bin/env python3
"""Publish actual native measurements with explicit trusted-CN and pending-QCP scope."""
import argparse,collections,json,statistics,subprocess
from test_read_variants import ROOT,save,sha
from publish_abs_tool_results import stage
from evaluation_expectations import matches as matches_expected, expected as expected_for_tool

def publish(group):
 b=ROOT/'benchmark/results'/group;g=ROOT/'benchmark/programs'/group
 plan=json.loads((g/'evaluation-plan.json').read_text());qualification=plan['cn_trust_qualification']
 assert qualification and not (b/'20261016-qcp-verify-complete/receipt.json').exists(), 'Use complete/partial certificate publisher for checked universal proofs'
 np=b/'20261016-primary-native/receipt.json'
 if not np.exists():np=b/'20261016-primary-native/pending-receipt.json'
 native=json.loads(np.read_text())
 # Early native failures preserve their original minimal receipt unchanged.
 # Bind its measured command to the same immutable manifest source now audited.
 variants={json.loads(p.read_text())['id']:json.loads(p.read_text()) for p in (g/'variants').glob('*/manifest.json')}
 for language in ['cn','qcp']:
  v=variants[plan['primary_'+language+'_variant']]['files'][language]
  assert sha(ROOT/v['path'])==v['sha256']
  measurement=native.get(language)
  if measurement:assert any(str(ROOT/v['path']) in str(arg) for arg in measurement['command'])
  native.setdefault(language+'_source',v['path']);native.setdefault(language+'_source_sha256',v['sha256'])
 run=b/plan['run_id'];data=json.loads((run/'results.json').read_text());rows=data['runs'];assert rows
 evidence=str((run/'results.json').relative_to(ROOT));cm=native['cn'];qm=native.get('qcp');modes={}
 save(b/'cn/results.json',{'tool':'cn','program_group':group,'verdict':plan.get('cn_acceptance_verdict','ACCEPTED_TARGETS_TRUSTED') if cm['exit_code']==0 else 'ORIGINAL_MODULE_REJECTED','scope':qualification,'primary_variant':plan['primary_cn_variant'],'source':native['cn_source'],'source_sha256':native['cn_source_sha256'],'evidence':str(np.relative_to(ROOT))})
 save(b/'cn/statistics.json',{'wall_seconds':cm['wall_seconds'],'peak_process_resident_mib':cm['resources']['max_process_rss_kib']/1024,'tokens':0,'model_calls':0,'verification_attempts_counted':1,'successful_verification_runs':int(cm['exit_code']==0),'scope_qualification':qualification})
 for tool,key in [('fulminate','fulminate_test'),('tespec','tespec_off')]:
  save(b/tool/'results.json',{'tool':tool,'program_group':group,'summary':{'case_pairs':len(rows),'correct':sum(matches_expected(x,key) for x in rows),'native_status_counts':dict(collections.Counter(x[key]['status'] for x in rows))},'evidence':evidence,'cases':[{'variant':x['variant'],'paired_qcp_variant':x['paired_qcp_variant'],'case':x['case'],'initial':x['initial'],'expected':expected_for_tool(x,key),'raw_actual':x[key]['status'],'actual':x[key]['status'],'matches_expected':matches_expected(x,key)} for x in rows]})
 for mode in ['off','on']:
  ms=[x['tespec_'+mode] for x in rows];unknown=sum(x['status']=='UNKNOWN' for x in ms);modes[mode]={'native_status_counts':dict(collections.Counter(x['status'] for x in ms)),'final_status_counts':dict(collections.Counter(x['status'] for x in ms)),'expected_matches':sum(matches_expected(x,'tespec_'+mode) for x in rows),'execution_wall_seconds_total':sum(x['wall_seconds'] for x in ms),'mean_execution_wall_seconds':statistics.mean(x['wall_seconds'] for x in ms),'mean_execution_peak_rss_mib':statistics.mean(x['resources']['max_process_rss_kib']/1024 for x in ms),'maximum_execution_peak_rss_mib':max(x['resources']['max_process_rss_kib']/1024 for x in ms),'executions_requiring_itp_for_verdict':unknown,'completed_independent_itp_executions':0,'pending_independent_itp_executions':unknown,'itp_wall_seconds_counted':None if unknown else 0}
 save(run/'statistics.json',{'program_group':group,'case_pairs':len(rows),'modes':modes,'complete':False,'certificate':'Native QCP/finite spatial SMT NOT_CHECKED; no execution ITP certificate inferred.','concurrency_context':str((run/'concurrency-context.json').relative_to(ROOT))})
 save(b/'fulminate/statistics.json',{'instrument_compile_initial_execution_wall_seconds_total':sum(x['fulminate_pipeline']['wall_seconds'] for x in rows),'test_execution_wall_seconds_total':(sum(x['fulminate_test']['wall_seconds'] for x in rows if x['fulminate_test']['wall_seconds'] is not None) if any(x['fulminate_test']['wall_seconds'] is not None for x in rows) else None),'pipeline_peak_process_rss_kib':max(x['fulminate_pipeline']['resources']['max_process_rss_kib'] for x in rows),'test_peak_process_rss_kib':max((x['fulminate_test']['resources']['max_process_rss_kib'] for x in rows if x['fulminate_test']['resources']),default=None),'tokens':0,'model_calls':0})
 save(b/'tespec/statistics.json',{'tokens':None,'model_calls':None,'itp_required_executions':modes['off']['executions_requiring_itp_for_verdict'],'stages':[stage('test_execution_and_vc_generation',modes['off']['execution_wall_seconds_total'],modes['off']['maximum_execution_peak_rss_mib'])]+[stage(n,None,None,None) for n in ['agent_proof_filling','coq_compilation_and_assumption_audit','independent_kernel_check']]})
 if modes['off']['executions_requiring_itp_for_verdict']==0:
  sp=b/'tespec/statistics.json';st=json.loads(sp.read_text());st.update(tokens=0,model_calls=0)
  for item in st['stages'][1:]:item.update(required=False,wall_seconds=0,total_tokens=0,peak_process_memory_mib=None,status='NOT_REQUIRED')
  save(sp,st)
 goals=[]
 if native.get('goal'):
  import re
  text=(ROOT/native['goal']).read_text();module=text.split('Module Type VC_Correct.',1)[-1].split('End VC_Correct.',1)[0];goals=re.findall(r'Axiom\s+(\w+)\s*:',module)
 save(b/'qcp/results.json',{'tool':'qcp','program_group':group,'verdict':'VC_GENERATED_PROOF_OR_REFUTATION_PENDING' if qm and qm['exit_code']==0 else 'NATIVE_GENERATION_INCOMPLETE','evidence':str(np.relative_to(ROOT)),'goal':native.get('goal'),'goal_sha256':native.get('goal_sha256'),'original_vc_correct_targets':goals,'source':native.get('qcp_source'),'source_sha256':native.get('qcp_source_sha256'),'scope':'Native generation alone is not verification. Positive original targets require full proofs; original negative modules require correctly scoped rejection/refutation, never a proof of false VC_Correct. Historical evidence is retained in the existing catalogue and not assigned fabricated zero costs.'})
 save(b/'qcp/statistics.json',{'tokens':None,'model_calls':None,'stages':[stage('vc_generation_and_automatic_processing',qm['wall_seconds'] if qm else None,qm['resources']['max_process_rss_kib']/1024 if qm else None)]+[stage(n,None,None,None) for n in ['agent_proof_filling','coq_compilation_and_assumption_audit','independent_kernel_check']]})
 ledger=ROOT/'benchmark/results/tespec-unexpected';idx=json.loads((ledger/'index.json').read_text());issues=[x for x in idx['issues'] if x['group']==group];triage=json.loads((ledger/'triage.json').read_text());details=[]
 for issue in issues:
  j=json.loads((ROOT/issue['report']).read_text())['results'][0];reason=j.get('reason');residual=j.get('residual_vcs',[])
  missing=reason=='missing_function_body'
  if missing:assert not j['execution_completed'] and not residual
  conclusion='NOT_PERFORMED_NO_COMPLETE_EXECUTION_OR_ORIGINAL_RESIDUAL_TARGET' if missing else 'PENDING_INDEPENDENT_PER_EXECUTION_ORIGINAL_TARGET_ITP; native SMT results do not substitute for a checked certificate.'
  cause=('External interface lacks an executable body: '+str(j.get('executor_error'))) if missing else ('Native result differs from immutable per-input oracle; reason='+str(reason)+'. Original residual targets='+str(residual))
  triage[issue['id']]={'status':'OPEN_EXTERNAL_FUNCTION_EXECUTION_GAP' if missing else 'OPEN_ORIGINAL_EXECUTION_VC_ITP_PENDING','cause':cause,'mode_comparison':str({m:modes[m]['native_status_counts'] for m in modes}),'itp_conclusion':conclusion,'coverage_gap':str((b/'coverage-gap.json').relative_to(ROOT)),'expectation_unchanged':True}
  details.append({'id':issue['id'],'report':issue['report'],'reason':reason,'residual_targets':residual,'execution_completed':j['execution_completed'],'itp_conclusion':conclusion})
 save(ledger/'triage.json',triage);gap={'program_group':group,'status':'INCOMPLETE_TRUST_SCOPE_AND_PENDING_CERTIFICATES','case_pairs':len(rows),'fulminate_matches':sum(matches_expected(x,'fulminate_test') for x in rows),'tespec_off_matches':modes['off']['expected_matches'],'tespec_on_matches':modes['on']['expected_matches'],'cn_trust_qualification':qualification,'original_primary_native':str(np.relative_to(ROOT)),'qcp_original_targets':goals,'issue_details':details,'single_entry_exception':'Each original no-argument main has exactly one distinct entry per existing translation; repeated runs are not invented additional inputs.','next_action':'Preserve all variants/oracles; finish original-target proof/refutation and per-execution ITP where available; add supported external execution for missing bodies. Continue other groups.'};save(b/'coverage-gap.json',gap)
 m=json.loads((g/'manifest.json').read_text());m.update(primary_variant=plan['primary_cn_variant'],primary_selection_status='NATIVE_SCOPE_RECORDED_QCP_AUDIT_PENDING',primary_verification={'cn_status':plan.get('cn_acceptance_verdict','ACCEPTED_TARGETS_TRUSTED') if cm['exit_code']==0 else 'ORIGINAL_MODULE_REJECTED','qcp_status':'PENDING_ORIGINAL_TARGET_CERTIFICATE','paired_qcp_variant':plan['primary_qcp_variant']},current_coverage_gap=str((b/'coverage-gap.json').relative_to(ROOT)),test_modes_statistics=str((run/'statistics.json').relative_to(ROOT)),tool_results={t:{'results':str((b/t/'results.json').relative_to(ROOT)),'statistics':str((b/t/'statistics.json').relative_to(ROOT))} for t in ['cn','qcp','fulminate','tespec']});save(g/'manifest.json',m);save(b/'index.json',{'program_group':group,'complete':False,'evaluation':evidence,'coverage_gap':str((b/'coverage-gap.json').relative_to(ROOT))})
 text=f"\n{group}: all existing variants, {len(rows)} actual input pairs; Fulminate {gap['fulminate_matches']}/{len(rows)} expected matches. OFF {modes['off']['native_status_counts']}, ON {modes['on']['native_status_counts']}. Original CN trust scope disclosed; QCP original generation targets {len(goals)}, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.\n"
 (run/'comparison.md').write_text('# '+group+' mode comparison\n'+text)
 for f in ['docs/benchmark-nightly-20261016.md','docs/benchmark-evaluation-progress.md']:
  p=ROOT/f;p.write_text(p.read_text()+text)
 p=ROOT/'benchmark/results/nightly-20261016/status.json';s=json.loads(p.read_text());s['deferred_groups'][group]={'reason':text.strip(),'evidence':str((b/'coverage-gap.json').relative_to(ROOT)),'next_action':gap['next_action']};save(p,s)
 for script in ['collect_tespec_unexpected','build_group_cost_tables','refresh_benchmark_progress']:subprocess.run(['python3','tools/benchmark/'+script+'.py'],cwd=ROOT,check=True)
 print(text,flush=True)
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--group',required=True);publish(p.parse_args().group)
