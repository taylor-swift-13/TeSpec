#!/usr/bin/env python3
"""Audit compact current evaluations, including explicit unresolved executions.

No experiment is run, and no UNKNOWN is upgraded by this auditor. Actual shared
executions are counted once; variant/input coverage is audited independently.
"""
from pathlib import Path
import hashlib,json,math,re,csv,sys
sys.path.insert(0,str(Path(__file__).resolve().parents[2]))
from spectest.certificates import check_candidate_commands,goal_interface,assumption_audit_from_output,strip_comments

SCHEMA='tespec-current-group-evaluation/v2'
def need(x,msg):
 if not x:raise ValueError(msg)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def load(p):return json.loads(p.read_text())
def digest(h):return isinstance(h,str) and bool(re.fullmatch('[0-9a-f]{64}',h))
def ref(root,r):
 p=(root/r['path']).resolve()
 need(p.is_relative_to(root.resolve()) and p.is_file(),'Missing/outside evidence '+str(p))
 need(sha(p)==r['sha256'],'Evidence hash mismatch '+str(p))
 return p

def identity_ref(root,r):
 """Hash installed runtime identities without copying compiled libraries."""
 p=Path(r['path']);p=p if p.is_absolute() else root/p
 p=p.resolve();need(p.is_file() and sha(p)==r['sha256'],'Runtime/standard compiled identity changed '+str(p))
 need(p.suffix in ('.v','.vo') or p.name=='_CoqProject','Unexpected runtime identity kind')
 return p

def standard_identity(r):
 need(r.get('qualified_name') and r.get('package') and r.get('tool_version'),'Incomplete installed standard identity')
 for k in ['source_sha256','compiled_sha256']:need(digest(r.get(k)),'Missing standard identity '+k)
 need(r.get('installed_path'),'Missing installed standard identity path')
 # Identity metadata survives machines where the package is not installed.
 # When present locally, verify the actual pair rather than trusting metadata.
 p=Path(r['installed_path'])
 for path,key in [(p.with_suffix('.v'),'source_sha256'),(p.with_suffix('.vo'),'compiled_sha256')]:
  if path.is_file():need(sha(path)==r[key],'Installed standard package differs '+str(path))
def finite(x,positive=False):return type(x) in (int,float) and math.isfinite(x) and (x>0 if positive else x>=0)
def aggregate(measures,ids):
 need(len(ids)==len(set(ids)),'Repeated cost id')
 rows=[measures[k] for k in ids]
 return {'wall_seconds':sum(r['wall_seconds'] for r in rows),'max_process_rss_kib':max((r['max_process_rss_kib'] for r in rows),default=0),'tokens':None if any(r['tokens'] is None for r in rows) else sum(r['tokens'] for r in rows),'measurements':len(rows),'model_calls':sum(r['stage']=='agent' for r in rows)}

def names_from_audit(text):
 names,unsupported=assumption_audit_from_output(text)
 need(not unsupported,'Unsafe/unrecognized assumption audit records')
 return {'CNotation.eval_addr_expr' if n=='eval_addr_expr' else n for n in names}

def audit_coverage(p,goal,candidate,proof_files):
 """Inspect original type bindings, rather than accepting coverage_audited."""
 inventory=dict(goal_interface(goal.read_text()));code=strip_comments(candidate.read_text())
 module=goal.stem
 need(not re.search(r'\bModule\s+(?:Type\s+)?'+re.escape(module)+r'\b',code),'Candidate shadows original Goal module')
 # A complete exact original module ascription is checked by Coq compilation.
 complete=re.search(r'\bModule\s+(\w+)\s*:\s*'+re.escape(module)+r'\.VC_Correct\s*\.(.*?)\bEnd\s+\1\s*\.',code,re.S)
 if complete:
  for field in p['targets']:
   statement=inventory[field]
   definition=re.search(r'\bDefinition\s+'+re.escape(field)+r'\s*:=\s*(\w+)\s*\.',complete[2])
   if definition:
    need(re.search(r'\b(?:Theorem|Lemma)\s+'+re.escape(definition[1])+r'\s*:\s*'+re.escape(module)+r'\.'+re.escape(statement)+r'\s*\.',code),'Certificate field has no exact original theorem type '+field)
   else:
    need(re.search(r'\b(?:Theorem|Lemma)\s+'+re.escape(field)+r'\s*:\s*'+re.escape(module)+r'\.'+re.escape(statement)+r'\s*\.',complete[2]),'Missing exact original interface field '+field)
  return
 # A directly named selected theorem is itself type checked by Coq; no wrapper
 # is necessary when its fully qualified original type is preserved.
 if p.get('coverage_style')=='direct-original-targets':
  require_map=p.get('target_theorems',{})
  need(set(require_map)==set(p['targets']),'Direct target theorem map incomplete')
  for field,theorem in require_map.items():
   need(re.fullmatch(r'[A-Za-z_]\w*',theorem) and re.search(r'\b(?:Theorem|Lemma)\s+'+re.escape(theorem)+r'\s*:\s*'+re.escape(module)+r'\.'+re.escape(inventory[field])+r'\s*\.',code),'Direct theorem is not exact original target '+field)
  return
 # Test certificates can prove a selected original interface in Coverage.v.
 need('coverage' in proof_files,'Missing compiled original coverage source')
 coverage=strip_comments(proof_files['coverage'].read_text())
 need(re.search(r'\bInclude\s+Candidate\.Proofs\s*\.',coverage),'Coverage does not include actual candidate module')
 for field in p['targets']:
  statement=inventory[field]
  need(re.search(r'\b(?:Theorem|Lemma)\s+'+re.escape(field)+r'\s*:\s*'+re.escape(module)+r'\.'+re.escape(statement)+r'\s*\.',code),'Candidate omitted exact original target '+field)
  if set(p['targets'])!=set(inventory):
   need(re.search(r'\bAxiom\s+'+re.escape(field)+r'\s*:\s*'+re.escape(module)+r'\.'+re.escape(statement)+r'\s*\.',coverage),'Partial coverage original type differs')
  else:need(re.search(r':\s*'+re.escape(module)+r'\.VC_Correct\s*\.',coverage),'Coverage is not the original complete interface')

def audit_certificate(root,proof_ref,measures,kind,seen_models,seen_checks):
 p=load(ref(root,proof_ref))
 need(p['schema']=='tespec-current-proof/v1' and p['kind']==kind,'Wrong proof schema/scope')
 goal=ref(root,p['goal']);candidate=ref(root,p['candidate'])
 check_candidate_commands(candidate.read_text())
 inventory=dict(goal_interface(goal.read_text()))
 need(p['targets'] and len(p['targets'])==len(set(p['targets'])) and set(p['targets'])<=set(inventory),'Original target inventory mismatch')
 if kind=='qcp':need(set(p['targets'])==set(inventory),'QCP omitted an original VC')
 need(p['status']=='PASS','Unproved certificate selected for writeback')
 if p.get('certificate_review'):
  review=p['certificate_review'];source=load(ref(root,review['source_certificate']))
  need(review['reuse_kind']=='EXACT_GOAL_CERTIFICATE_REVIEW' and source['status']=='PASS','Invalid reuse source status')
  need(source.get('execution_id')==review['source_execution']!=p.get('execution_id'),'Reuse source execution differs')
  need(source['goal']['sha256']==p['goal']['sha256']==review['original_goal_sha256'],'Reuse Goal differs')
  need(source['candidate']['sha256']==review['source_candidate_sha256'],'Reuse source Candidate differs')
  need(source['attempts'][-1]['checks'][-1]['source_receipt_sha256']==review['source_receipt_sha256'],'Reuse source receipt differs')
  need(source['source']['sha256']==p['source']['sha256'] and source.get('native_input')==p.get('native_input'),'Reuse source/input context differs')
  need(source.get('logical_context')==p.get('logical_context'),'Reuse ABI/runtime context differs')
  refs=[d for d in p['dependencies'] if Path(d['path']).name=='ReferenceCandidate.v']
  if refs:need(len(refs)==1 and refs[0]['sha256']==source['candidate']['sha256'],'Imported source certificate module differs')
 for d in p['dependencies']:ref(root,d)
 if p.get('logical_context'):
  context=load(ref(root,p['logical_context']))
  need(context['schema']=='tespec-frozen-logical-context/v1','Wrong frozen context schema')
  actual_deps={Path(d['path']).stem:d['sha256'] for d in p['dependencies']}
  for d in context['coq_dependencies']:need(actual_deps.get(d['module'])==d['sha256'],'Original logical dependency context changed')
  for d in context['runtime_dependencies']:
   for path,key in [('source','sha256'),('compiled','compiled_sha256')]:
    target=Path(d[path]).resolve();need(target.is_relative_to(root/'runtime'),'Unexpected runtime identity path')
    identity_ref(root,{'path':str(target),'sha256':d[key]})
 proof_files={name:ref(root,d) for name,d in p['proof_files'].items()}
 audit_coverage(p,goal,candidate,proof_files)
 need(p['attempts'] and p['selected_attempt']==p['attempts'][-1]['attempt'],'Unchecked later attempt')
 for attempt in p['attempts']:
  model=measures[attempt['model']]
  need(model['stage']=='agent' and model['requested_model']=='gpt-6.1-sol','Wrong model stage')
  need(attempt['model'] not in seen_models,'One model counted for multiple proof tasks')
  seen_models.add(attempt['model'])
  locked=model['locked_goal_and_helper_sha256']
  need(p['goal']['sha256'] in locked.values(),'Model did not freeze original Goal')
  if attempt['attempt']==p['selected_attempt']:
   for dep in p['dependencies']:need(dep['sha256'] in locked.values(),'Selected model dependency not frozen')
  for check in attempt['checks']:
   receipt=ref(root,check['receipt'])
   need(sha(receipt)==check['receipt_sha256'],'Checker receipt hash differs')
   original=load(receipt)
   if original.get('schema')=='tespec-current-checker-record/v1':
    need(digest(original.get('source_receipt_sha256')),'Compact checker lost original receipt identity')
    for key in ['status','selected_goals','measurements','kernel_replay_mode','candidate_sha256','original_goal_sha256']:
     need(original[key]==check[key],'Compact checker binding differs '+key)
    need(original.get('source_logs') and all(digest(x) for x in original['source_logs'].values()),'Compact checker lost original log identities')
   need(original.get('candidate_sha256',original.get('proof_sha256'))==check['candidate_sha256'],'Actual checker receipt candidate differs')
   need(original.get('original_goal_sha256')==check['original_goal_sha256'],'Actual checker receipt Goal differs')
   need(check['receipt_sha256'] not in seen_checks,'One checker counted for multiple executions')
   seen_checks.add(check['receipt_sha256'])
   need(check['candidate_sha256']==model['candidate_sha256'],'Checked candidate differs from model')
   need(check['original_goal_sha256']==p['goal']['sha256'],'Checked Goal differs')
   need(set(check['selected_goals'])==set(p['targets']),'Checked target coverage differs')
   need(check['measurements'],'Checker has no measured stages')
   need(len(check['measurements'])==len(set(check['measurements'])),'Repeated checker measurement id')
   for mid in check['measurements']:
    need(mid in measures and mid in p['measurement_ids'],'Checker cost omitted from proof ledger')
    marker='measurement:'+mid
    need(marker not in seen_checks,'Checker measurement reused across tasks/attempts')
    seen_checks.add(marker)
  need(attempt['model'] in p['measurement_ids'],'Model attempt omitted from proof costs')
 final=p['attempts'][-1];model=measures[final['model']];need(final['checks'],'Final attempt has no checker');check=final['checks'][-1]
 need(model['exit_code']==0 and model['candidate_sha256']==p['candidate']['sha256'],'Successful model does not bind final proof')
 need(model['token_usage'] and model['tokens'] is not None,'Selected proof model lacks actual usage receipt')
 need(check['status']=='PASS' and check['kernel_replay_mode']=='full','Missing full independent kernel')
 need(all(measures[m]['exit_code']==0 for m in check['measurements']),'Final check contains failed stage')
 kernels=[measures[m] for m in check['measurements'] if measures[m]['stage']=='kernel']
 need(len(kernels)==1 and any(Path(c).name=='coqchk' for c in kernels[0]['command']),'Missing full coqchk command')
 kernel_target=proof_files['coverage'].stem if 'coverage' in proof_files else candidate.stem
 need(kernel_target in kernels[0]['command'],'Kernel replay does not check the actual coverage/candidate module')
 need(not any(x in kernels[0]['command'] for x in ['-norec','-admit','-admit-recursive']),'Kernel skips dependencies')
 need(all(not x.startswith(('-admit','-norec')) for x in kernels[0]['command']),'Kernel skips dependency checking')
 compiled=[measures[m] for m in check['measurements'] if measures[m]['stage'] in ['compile','coq']]
 need(compiled and any(str(candidate.name) in ' '.join(m['command']) for m in compiled),'Final candidate has no actual compiler stage')
 if 'coverage' in proof_files:need(any(proof_files['coverage'].name in ' '.join(m['command']) for m in compiled),'Coverage source was not compiled')
 if p.get('helper_assumption_audit'):
  helper=p['helper_assumption_audit'];raw=helper['actual_output'];h=hashlib.sha256(raw.encode()).hexdigest()
  need(h==helper['actual_output_sha256'] and h in check.get('source_logs',{}).values(),'Helper audit output lacks original measured log binding')
  need(names_from_audit(raw)==set(helper['actual_assumptions'])==set(helper['proof_symbols']) and not helper['additional_symbols'],'Helper assumption audit differs')
  need(raw.count('Closed under the global context')==helper['closed_count'],'Helper closed count differs')
  need('AllAudit.v' in proof_files,'Missing helper audit source')
  prints=re.findall(r'Print Assumptions\s+([A-Za-z_]\w*(?:\.[A-Za-z_]\w*)*)\s*\.',strip_comments(proof_files['AllAudit.v'].read_text()))
  need(prints==helper['audited_definitions'],'Helper audit source omitted/reordered definitions')
  need(any('AllAudit.v' in ' '.join(m['command']) for m in compiled),'Helper audit source was not compiled')
 need(all(measures[mid]['tool']==('qcp' if kind=='qcp' else 'tespec') for mid in p['measurement_ids']),'Proof ledger claims another tool costs')
 text=check['audit_text'];need(hashlib.sha256(text.encode()).hexdigest()==check['audit_sha256'],'Audit text hash changed')
 names=names_from_audit(text)
 need(text.count('Closed under the global context')+text.count('Axioms:')==len(p['targets'])+p.get('additional_audited_theorems',0),'Assumption audit omits targets')
 need({'CNotation.eval_addr_expr' if n=='eval_addr_expr' else n for n in check['assumptions']}==names,'Assumption inventory changed')
 # Trust is established by the original statements and concrete runtime audit,
 # not membership in a global permissive allowlist.
 differential=load(ref(root,p['assumption_differential']))
 target_diffs=differential['targets'];need(len(target_diffs)==len(p['targets'])+p.get('additional_audited_theorems',0),'Per-target assumption audit incomplete')
 observed=set()
 for item in target_diffs.values():
  baseline=names_from_audit(item['statement']['raw_block']);actual=names_from_audit(item['proof']['raw_block'])
  need(set(item['statement']['assumptions'])==baseline and set(item['proof']['assumptions'])==actual,'Per-target assumptions differ from raw output')
  need(set(item['additional_proof_assumptions'])==actual-baseline,'Incorrect assumption differential');observed|=actual
 need(observed==names,'Per-goal assumptions differ from final audit')
 original_names={n for n,v in target_diffs.items() if v['original_vc']}
 need(len(original_names)==len(p['targets']),'Wrong original/additional theorem denominator')
 for field in p['targets']:
  statement=inventory[field]
  matches=[v for v in target_diffs.values() if v['original_vc'] and v['statement']['qualified_term']==goal.stem+'.'+statement]
  need(len(matches)==1,'Original target missing from differential '+field)
 extras=set().union(*(set(v['additional_proof_assumptions']) for v in target_diffs.values()))
 if extras:
  need(p.get('assumption_qualification') and p.get('globally_closed') is False,'Missing explicit relative-assumption qualification')
  need(p.get('runtime_identity'),'Missing actual compiled runtime identity')
  for item in p['runtime_identity']:identity_ref(root,item)
  need(p.get('installed_standard_identity'),'Missing installed standard package identity')
  for item in p['installed_standard_identity']:standard_identity(item)
  need('identity_audit' in proof_files and p.get('identity_audit_receipt'),'Missing compiled standard/runtime identity audit source or receipt')
  identity=load(ref(root,p['identity_audit_receipt']))
  need(identity['exit_code']==0 and digest(identity.get('source_sha256')) and identity['source_sha256']==sha(proof_files['identity_audit']),'Identity audit source/compilation differs')
  audited=set().union(*(set(v['assumptions']) for v in differential['audited_existing_runtime_lemmas']))
  need(extras<=audited,'Extra proof assumptions lack concrete existing-runtime lemma audit')
 if kind=='qcp' and p.get('additional_audited_theorems'):
  need(p['additional_audited_theorems']==1 and len(inventory)==17,'Unexpected QCP strong obligation inventory')
  code=strip_comments(candidate.read_text())
  strong=re.search(r'\bTheorem\s+strong_add_return_wit_1\s*:(.*?)\.\s*Proof\.',code,re.S)
  raw=strip_comments(goal.read_text());left=re.search(r'Definition\s+add_return_wit_1\s*:=\s*\((.*?)\)\s*\\/',raw,re.S)
  norm=lambda s:re.sub(r'\s+','',s)
  need(strong and left and norm(strong[1])==norm(left[1]),'Strong obligation is not exact original left entailment')
  parent=re.search(r'Theorem\s+primary_add_return_wit_1\s*:.*?Proof\.(.*?)Qed\.',code,re.S)
  need(parent and re.search(r'\bleft\s*\.',parent[1]) and re.search(r'\bexact\s+strong_add_return_wit_1\s*\.',parent[1]),'Parent did not prove strong original left')
 need(aggregate(measures,p['measurement_ids'])==p['metrics'],'Proof costs differ')
 return p

def audit_current_group(group,root,index=None,allow_partial=False):
 root=Path(root).resolve();base=root/'benchmark/results'/group
 index=load(base/'index.json') if index is None else index
 data=load(ref(root,index['current_evaluation']))
 need(data['schema']==SCHEMA and data['program_group']==group,'Wrong current group/schema')
 plan=load(ref(root,data['plan']));manifest=load(root/'benchmark/programs'/group/'manifest.json')
 sources={}
 for item in manifest['variants']:
  v=load(root/item['manifest'])
  sources[v['id']]={lang:ref(root,source) for lang,source in v['files'].items()}
 for source in data['sources']:ref(root,source)
 costs=load(ref(root,data['cost_ledger']))
 measures={m['id']:m for m in costs['measurements']}
 need(len(measures)==len(costs['measurements']),'Duplicate measurement id')
 for m in measures.values():
  need(finite(m['wall_seconds']) and finite(m['max_process_rss_kib'],True),'Missing actual time/RSS')
  need((m['tokens'] is None or type(m['tokens']) is int and m['tokens']>=0) and m['exit_code'] is not None,'Invalid usage/exit status')
  if m['stage']=='agent':
   need(m['requested_model']=='gpt-6.1-sol','Wrong requested model')
   if m.get('token_usage'):
    for u in m['token_usage']:
     need(all(type(u.get(k)) is int and u[k]>=0 for k in ['input_tokens','output_tokens']),'Malformed actual token usage')
     need(u.get('cached_input_tokens',0)<=u['input_tokens'] and u.get('reasoning_output_tokens',0)<=u['output_tokens'],'Token subset exceeds total')
    need(m['tokens']==sum(u['input_tokens']+u['output_tokens'] for u in m['token_usage']),'Token double counting')
    need(m['usage_events']==[{'type':'turn.completed','usage':u} for u in m['token_usage']],'Usage events differ')
   else:
    need(m['tokens'] is None and not m.get('usage_events') and m.get('usage_missing_reason'),'Missing usage must remain explicitly unknown')
   for k in ['raw_event_log_sha256','prompt_sha256','candidate_sha256','source_receipt_sha256']:need(digest(m[k]),'Missing model provenance '+k)
  else:need(m['tokens']==0,'Non-model stage has fabricated model tokens')
 for tool in ['cn','qcp','fulminate','tespec']:
  ids=[k for k,m in measures.items() if m['tool']==tool]
  need(aggregate(measures,ids)==costs['totals'][tool],'Tool cost accounting mismatch')
 cases={};expected_keys=set()
 for pair in plan['pairings']:
  for case in pair['cases']:
   k=(pair['cn_variant'],case['id']);need(k not in cases and case['precondition_valid'],'Duplicate/illegal case')
   need(case['expected'] in ['PASS','FAIL','ERROR'],'UNKNOWN is not an admissible semantic expectation')
   cases[k]=(case,pair)
   for strategy in ['inline','modular']:
    for mode in ['off','on']:expected_keys.add((*k,strategy,mode))
 f=load(ref(root,data['tool_results']['fulminate']))
 need(len(f['runs'])==len(cases),'Fulminate coverage incomplete')
 seen=set()
 for r in f['runs']:
  k=(r['variant'],r['case_id']);need(k in cases and k not in seen,'Duplicate/unplanned Fulminate input');seen.add(k)
  case,pair=cases[k]
  need(r['source_sha256']==sha(sources[r['variant']]['cn']),'CN source mismatch')
  need(r['expected']==case.get('expected_by_tool',{}).get('fulminate_test',case['expected']),'Fulminate expectation changed')
  need(r['expected'] in ['PASS','FAIL','ERROR'],'Invalid Fulminate expectation')
  need(digest(r['harness_sha256']),'Missing harness identity')
  need(measures[r['pipeline']]['exit_code']==0 and (measures[r['test']]['exit_code']==0)==(r['status']=='PASS'),'Fulminate status differs from executable')
 cn=load(ref(root,data['tool_results']['cn']))
 need(cn['verdict'] in ['VERIFIED','VERIFIED_WITH_COMPAT_HEADERS'],'CN incomplete')
 need(cn['source']['sha256']==sha(sources[plan['primary_cn_variant']]['cn']),'CN primary source mismatch')
 need(measures[cn['verification']]['exit_code']==0,'CN verification failed')
 need(re.search(r'\b'+re.escape(plan['function'])+r'\s+--\s+pass\b',cn['verification_output']),'CN did not verify target')
 for r in cn.get('dependencies',[]):ref(root,r)
 seen_models=set();seen_checks=set()
 qcp=audit_certificate(root,data['qcp_certificate'],measures,'qcp',seen_models,seen_checks)
 need(qcp['source']['sha256']==sha(sources[plan['primary_qcp_variant']]['qcp']),'QCP primary source mismatch')
 seen=set();execution_ids=set();native_ids=set();resolved=0;itps=0
 for r in data['executions']:
  need(r['execution_id'] not in execution_ids,'Duplicate actual execution');execution_ids.add(r['execution_id'])
  need(r['strategy'] in ['inline','modular'] and r['spatial_smt'] in ['off','on'],'Bad mode')
  need(r['execution_mode']=='all-boundaries','Wrong VC policy')
  need(r['measurement'] in measures and measures[r['measurement']]['stage']=='native','Missing native measurement')
  need(r['measurement'] not in native_ids,'One native measurement counted as multiple actual executions');native_ids.add(r['measurement'])
  need(r['cn_pairings'] and len(r['cn_pairings'])==len(set(r['cn_pairings'])),'Empty/repeated shared CN pairing')
  for vid in r['cn_pairings']:
   key=(vid,r['case_id'],r['strategy'],r['spatial_smt'])
   need(key in expected_keys and key not in seen,'Ambiguous shared input coverage');seen.add(key)
   case,pair=cases[(vid,r['case_id'])]
   need(r['input']==case['binds'] and r['source_sha256']==sha(sources[pair['qcp_variant']]['qcp']),'Shared execution changed source/input')
   expected=case.get('expected_by_execution_strategy',{}).get(r['strategy'],case.get('expected_by_tool',{}).get('tespec_'+r['spatial_smt'],case['expected']))
   need(expected in ['PASS','FAIL','ERROR'],'UNKNOWN cannot count as an expected successful result')
   need(expected==r['expected'],'Frozen expected changed')
  if r.get('certificate'):
   p=audit_certificate(root,r['certificate'],measures,'test',seen_models,seen_checks);itps+=1
   need(p['execution_id']==r['execution_id'] and p['native_receipt_sha256']==r['native_receipt_sha256'],'ITP/native execution binding differs')
   need(p['source']['sha256']==r['source_sha256'],'Test certificate source differs from executed source')
   need(p['goal']['sha256']==r['vc_sha256']['goal'] and set(p['targets'])==set(r['residual_vcs']),'ITP differs from original residual VC')
   need(r['raw_status']=='UNKNOWN' and r['execution_completed'] and r['final_status']=='PASS' and r['precondition_result']=='SAT','Unsafe ITP writeback')
  else:
   need(r['raw_status']==r['final_status'] and r['raw_precondition_result']==r['precondition_result'],'Uncertified result writeback')
  if r['final_status']=='PASS':need(r['execution_completed'] and r['precondition_result']=='SAT' and (not r['residual_vcs'] or r.get('certificate')),'Incomplete execution accepted')
  if r['final_status']!='UNKNOWN' and r['final_status']==r['expected']:resolved+=1
  else:
   need(r.get('unexpected_ref') and r['final_status'] in ['UNKNOWN','ERROR','FAIL','PASS'],'Unrecorded mismatch')
   ref(root,r['unexpected_ref'])
 need(seen==expected_keys,'Missing input/strategy/mode coverage')
 need(len(data['executions'])==data['actual_executions'] and len(cases)==data['paired_inputs'],'Wrong denominator')
 need(itps==data['itp_executions'] and resolved==data['expected_matches'],'Result summary mismatch')
 verdict_complete=(resolved==len(data['executions']) and all(r['status']!='UNKNOWN' and r['status']==r['expected'] for r in f['runs']))
 resource_complete=all(m['tokens'] is not None for m in measures.values())
 complete=verdict_complete and resource_complete
 need(data['complete'] is complete and index['complete'] is complete,'Incorrect overall completion flag')
 need(data['verdict_complete'] is verdict_complete and index['verdict_complete'] is verdict_complete,'Incorrect verdict completeness flag')
 need(data['resource_metrics_complete'] is resource_complete,'Incorrect resource completeness flag')
 need(index['resource_metrics_complete'] is resource_complete,'Index resource completeness differs')
 if 'resource_metrics_complete' in costs:need(costs['resource_metrics_complete'] is resource_complete,'Ledger resource completeness differs')
 if 'verdict_complete' in costs:need(costs['verdict_complete'] is verdict_complete,'Ledger verdict completeness differs')
 need(complete or allow_partial,'Unresolved results require --allow-partial')
 table=load(base/'result-cost.json');need(table['complete'] is complete,'Cost table completion mismatch')
 need(table['verdict_complete'] is verdict_complete and table['resource_metrics_complete'] is resource_complete,'Cost table verdict/resource completeness mismatch')
 for r in table['costs']:
  if r.get('measurement_ids'):
   a=aggregate(measures,r['measurement_ids']);n=r.get('divisor',1)
   need(finite(n,True),'Invalid displayed cost divisor')
   need(abs(r['wall_seconds']-a['wall_seconds']/n)<1e-8 and r['tokens']==(None if a['tokens'] is None else a['tokens']/n),'Displayed time/token differs')
 print(('PASS' if complete else 'PARTIAL')+f' {group}: {len(cases)} pairs, {len(execution_ids)} actual executions, {itps} checked ITP tasks; all retained hashes/costs audited.')
 return data
