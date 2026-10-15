#!/usr/bin/env python3
"""Reuse existing variants/inputs/results; never infer new verdicts or fill quotas."""
from pathlib import Path
import collections,csv,hashlib,io,json,re
HERE=Path(__file__).resolve().parent;BASE=HERE.parent;ROOT=HERE.parents[3];SEL=BASE.parent;MIG=SEL/'qcp-migration'
HASH={};ART={};VAR={};OBS={};INPUT={};BYHASH=collections.defaultdict(set)
def sha(p):
 p=Path(p)
 if p not in HASH:HASH[p]=hashlib.sha256(p.read_bytes()).hexdigest()
 return HASH[p]
def digest(s):return hashlib.sha256(s.encode()).hexdigest()
def read(p):return json.loads(Path(p).read_text())
def safe(p):
 p=Path(p)
 try:p.resolve().relative_to(SEL.resolve())
 except ValueError:return None
 return p if p.is_file() else None
def normalise(s,parent=None):
 p=Path(str(s))
 if '/benchmark/' in str(s):p=ROOT/'benchmark'/str(s).split('/benchmark/',1)[1]
 elif not p.is_absolute():p=(parent or ROOT)/p
 return safe(p)
def artifact(p):
 p=safe(p)
 if p is None:return None
 rel=p.relative_to(ROOT).as_posix();key='file_'+digest(rel)[:16]
 ART.setdefault(key,{'id':key,'path':rel,'sha256':sha(p)})
 return key
def variant(key,kind,families,files=None,**metadata):
 entry=VAR.setdefault(key,{'id':key,'kind':kind,'families':[],'files':{},'origins':[],'input_set_ids':[],'result_ids':[]})
 entry['families']=sorted(set(entry['families'])|set(families));entry.update(metadata)
 for language,path in (files or {}).items():
  p=safe(path)
  if p:
   f={'artifact':artifact(p),'sha256':sha(p)};entry['files'][language]=f;BYHASH[f['sha256']].add(key)
 return entry
def observation(report,pointer,tool,status,targets=(),binding='RELATED_RECORD_ONLY',scope=None,metrics=None,source_hash=None,**metadata):
 key='result_'+digest(str(report)+'#'+pointer+'#'+tool)[:20]
 row={'id':key,'report':artifact(report),'record_pointer':pointer,'tool':tool,'reported_status':status,'variant_ids':sorted(set(targets)),'source_binding':binding,'recorded_source_sha256':source_hash,'scope':scope,'metrics':metrics or {},**metadata}
 OBS[key]=row
 for target in row['variant_ids']:VAR[target]['result_ids'].append(key)
 return key
def inputset(report,pointer,targets,count=None,status='RECORDED_INPUTS',paths=(),**metadata):
 key='input_'+digest(str(report)+'#'+pointer)[:20]
 INPUT[key]={'id':key,'report':artifact(report),'record_pointer':pointer,'variant_ids':sorted(set(targets)),'input_count':count,'execution_status':status,'files':[artifact(p) for p in paths if safe(p)],**metadata}
 for target in targets:VAR[target]['input_set_ids'].append(key)
 return key
def result_status(row):
 for key in ['status','qcp_status','native_status','returncode','exit_code','kernel_check_exit','kernel_exit']:
  if key in row:return row[key]
 return 'RECORDED_NO_VERDICT_FIELD'
def pointer_child(pointer,key):return pointer+'/'+str(key).replace('~','~0').replace('/','~1')
def walk(data,pointer=''):
 if isinstance(data,dict):
  yield pointer,data
  for key,value in data.items():yield from walk(value,pointer_child(pointer,key))
 elif isinstance(data,list):
  for key,value in enumerate(data):yield from walk(value,pointer_child(pointer,key))
def main():
 groups=read(HERE/'families.json');source_family={r['source']:r['family'] for r in groups['original_cn_variants']}
 original_by_source={r['source']:'cn_original:'+r['id'] for r in groups['original_cn_variants']}
 for row in groups['original_cn_variants']:
  item=variant(original_by_source[row['source']],'original_cn',[row['family']],{'cn':ROOT/row['source']},implementation_id=row['implementation_id'],specification_id=row['specification_id'],scope=row['implementation_scope'],cn_static_expected=row['original_static_expected'],cn_runtime_expected=row['original_runtime_expected'],current_execution='NOT_RERUN_BY_INDEXER')
  item['origins'].append({'source':row['source'],'original_qcp_alignment':row['qcp_original_contract_alignment']})
 aliases={}
 for row in groups['constructed_paired_cases']:
  key='constructed:'+row['id'];item=variant(key,'constructed_paired', [row['family']],{'cn':ROOT/row['cn'],'qcp':ROOT/row['qcp']},implementation_id=row['implementation_id'],specification_id=row['specification_id'],expected=row['expected'],existing_cn_status=row['cn_status'],existing_qcp_status=row['qcp_status'],existing_verification=row['verification'],baseline='constructed:'+row['baseline_case'])
  item['origins'].extend(row['aliases'])
  for a in row['aliases']:aliases[a['source_record'],a['variant']]=key
 registered_paths={};migration_ids={};manifest_inputs=[]
 def qcp_variant(path,source=None,origin=None,declared_hash=None,notes=None,record_pointer=None,expected=None,declared_status=None,declared_scope=None):
  p=safe(path)
  if p is None:return None
  key='qcp_existing:'+sha(p)[:20];family=source_family.get(source);item=variant(key,'existing_qcp_translation',[family] if family else [],{'qcp':p},original_cn_contract_alignment='NOT_ASSUMED_EQUIVALENT_TO_CORRECTED_CONTRACT')
  item['origins'].append({'catalogue':origin,'catalogue_artifact':artifact(normalise(origin)) if origin and normalise(origin) else None,'record_pointer':record_pointer,'declared_expected':expected,'declared_status':declared_status,'declared_scope':declared_scope,'path':p.relative_to(ROOT).as_posix(),'original_cn_source':source,'declared_source_sha256':declared_hash,'current_file_matches_declared_hash':None if declared_hash is None else sha(p)==declared_hash,'notes':notes})
  registered_paths[p]=key
  return key
 for path,listkey in [(MIG/'simple/manifest.json','cases'),(MIG/'supplemental/manifest.json','cases'),(MIG/'supplemental/registry.json','records')]:
  for i,row in enumerate(read(path)[listkey]):
   q=normalise(row['qcp']);v=qcp_variant(q,row['original'],path.relative_to(ROOT).as_posix(),row.get('qcp_sha256'),row.get('migration_notes'),'/'+listkey+'/'+str(i),row.get('expected'),row.get('qcp_status',row.get('status',row.get('native_status'))),row.get('validation_scope',row.get('verified_scope',row.get('main_scope')))) if q else None
   if v:
    migration_ids[path.parent.name,row['id']]=v
    preparation=row.get('input_preparation',{})
    if preparation:
     paths=[normalise(preparation[x]) for x in ['binds','job'] if preparation.get(x)];paths=[p for p in paths if p]
     manifest_inputs.append((path,'/'+listkey+'/'+str(i)+'/input_preparation',v,preparation,paths))
 old_manifest=MIG/'manifest.json';oldrows=read(old_manifest)['cases'];old_variants={};old_input_sets={}
 for i,row in enumerate(oldrows):
  source=str((SEL/'sources/fulminate-cn/src/examples'/row['upstream']).relative_to(ROOT));q=MIG/row['source'];v=qcp_variant(q,source,str(old_manifest.relative_to(ROOT)),row.get('source_sha256'),row.get('notes'));old_variants[row['id']]=v
  if v:
   for j,target in enumerate(row['targets']):old_input_sets[row['id'],target['function']]=inputset(old_manifest,f'/cases/{i}/targets/{j}/binds',[v],len(target['binds']),'FROZEN_INPUTS_WITH_SEPARATE_RESULTS',function=target['function'])
 # Preserve additional checked/counterexample/history sources, including prior-migration snapshots.
 stem_families=collections.defaultdict(set)
 for row in groups['original_cn_variants']:stem_families[Path(row['source']).name.removesuffix('.c').removesuffix('.broken')].add(row['family'])
 for ident,v in old_variants.items():
  if v:stem_families[ident].update(VAR[v]['families'])
 for p in sorted(MIG.rglob('*.c')):
  if p in registered_paths:continue
  rel=p.relative_to(MIG);parts=rel.parts
  if any(x.startswith('evidence') or x in ['inputs','artifacts','vc','native','proofs'] for x in parts[:-1]):continue
  text=p.read_text(errors='replace')
  if not any(re.search(r'\bRequire\b',m[1]) for m in re.finditer(r'/\*@([\s\S]*?)\*/',text)):continue
  stem=p.name.removesuffix('.c').removesuffix('.qcp');families=stem_families.get(stem,set())
  if 'queue-' in str(rel):families={'queue_all'}
  elif 'merge-sort' in str(rel):families={'mergesort'}
  elif 'runway' in str(rel):families={'runway__funcs2'}
  v=qcp_variant(p,origin='existing QCP source inventory; semantic/contract alignment not inferred')
  VAR[v]['families']=sorted(set(VAR[v]['families'])|families)
  VAR[v]['family_assignment']='SOURCE_CATALOGUE' if any(o.get('original_cn_source') for o in VAR[v]['origins']) else 'NAME_OR_DIRECTORY_ASSOCIATION' if families else 'UNASSIGNED_REVIEW_REQUIRED'
 for row in groups['original_cn_variants']:
  original=VAR[original_by_source[row['source']]];links=[]
  reviewed_hash=row['qcp_original_contract']['sha256'] if row['qcp_original_contract'] else None
  for v in VAR.values():
   if v['kind']!='existing_qcp_translation':continue
   if not any(o.get('original_cn_source')==row['source'] for o in v['origins']):continue
   exact_review=reviewed_hash is not None and v['files']['qcp']['sha256']==reviewed_hash
   links.append({'variant_id':v['id'],'alignment':'REVIEWED_READ_TARGET_CONTRACT_ONLY' if exact_review else 'RELATED_TRANSLATION_OR_CORRECTED_BASELINE_NOT_ASSUMED_ORIGINAL_SPEC_EQUIVALENT'})
   v.setdefault('related_original_cn_variant_ids',[]).append(original['id'])
  original['related_qcp_variants']=links
  original['related_constructed_variants']=sorted({aliases[a['source_record'],a['variant']] for c in groups['constructed_paired_cases'] for a in c['aliases'] if a['source_record']==row['id']})
 for report,pointer,v,preparation,paths in manifest_inputs:inputset(report,pointer,[v],preparation.get('count'),'PREPARED_NOT_ASSUMED_EXECUTED',paths,reported_status=preparation.get('status'))
 # Constructed CN/QCP runs retain their original stage statuses. A residual is not a rejection.
 runfile=BASE/'run-results.json'
 for i,row in enumerate(read(runfile)):
  v=aliases[row['source'],row['variant']]
  for tool in ['cn','qcp']:
   data=row[tool];h=data.get('source_sha256');binding='EXACT_SOURCE_HASH' if h and v in BYHASH[h] else 'LOCKED_MANIFEST_ALIAS_AND_COMMAND_NO_SEPARATE_SOURCE_HASH'
   observation(runfile,f'/{i}/{tool}',tool,result_status(data),[v],binding,scope='Original recorded stage; no new execution or verdict upgrade.',source_hash=h,manual_obligations=data.get('unit_manual_obligations'))
 witnessfile=BASE/'witness-receipts.json'
 for i,row in enumerate(read(witnessfile)):
  v=aliases[row['source'],row['variant']];folder=BASE/'cases'/row['source']/row['variant']/'witness';harness=folder/'witness.c';assert sha(harness)==row['harness_sha256']
  inputs=inputset(witnessfile,f'/{i}',[v],1,'EXECUTED_C_OBSERVATION',[harness],scope=row['scope'])
  observation(witnessfile,f'/{i}','native_c_witness',row['status'],[v],'HARNESS_HASH_AND_LOCKED_VARIANT_ALIAS',scope=row['scope'],input_set_id=inputs,exit_code=row['exit_code'],expected_ub=row['expected_ub'])
 # Import matching native/proof receipts from all historical QCP reports.
 filenames={'report.json','verification-index.json','verification-report.json','manual-proof-receipts.json','negative-proof-receipts.json','verification-receipt.json','scalar-report.json'}
 proof_by_name=collections.defaultdict(list)
 for proof in sorted(MIG.rglob('*.v')):proof_by_name[proof.name].append(proof)
 reportfiles=sorted(p for p in MIG.rglob('*.json') if p.name in filenames or p.name.endswith('-report.json'))
 unbound=[]
 for report in reportfiles:
  artifact(report)
  try:data=read(report)
  except (ValueError,OSError):continue
  for pointer,row in walk(data):
   h=row.get('qcp_source_sha256') or row.get('source_sha256')
   if not isinstance(h,str) or not re.fullmatch('[0-9a-f]{64}',h):continue
   if not any(k in row for k in ['status','native_status','qcp_status','functions','kernel_check_exit','kernel_exit','returncode']):continue
   targets=sorted(BYHASH.get(h,[]));binding='EXACT_SOURCE_HASH' if targets else 'HISTORICAL_RECORDED_HASH_NOT_CURRENT_VARIANT'
   isproof=any(k in row for k in ['kernel_check_exit','kernel_exit','proved_original_vcs','manual_proofs'])
   supporting=[]
   declarations=row.get('artifacts',{}) if isinstance(row.get('artifacts'),dict) else {}
   if row.get('proof_file') and row.get('proof_sha256'):declarations={**declarations,row['proof_file']:row['proof_sha256']}
   for filename,expected in declarations.items():
    if not isinstance(expected,str) or not re.fullmatch('[0-9a-f]{64}',expected):continue
    candidates=proof_by_name.get(Path(filename).name,[]);direct=normalise(filename,report.parent)
    if direct:candidates=[direct]+candidates
    matches=[p for p in candidates if sha(p)==expected]
    supporting.append({'reported_file':filename,'sha256':expected,'artifact':artifact(matches[0]) if matches else None,'state':'HASH_MATCH' if matches else 'MISSING_OR_CHANGED_KEEP_HISTORICAL'})
   obs=observation(report,pointer,'coq_receipt' if isproof else 'qcp_native',result_status(row),targets,binding,row.get('scope'),source_hash=h,recorded_goal_sha256=row.get('original_generated_goal_sha256',row.get('generated_goal_sha256')),supporting_artifacts=supporting,recorded_theorems=row.get('proved_original_vcs',row.get('manual_proofs',row.get('theorems'))),recorded_toolchain={k:row[k] for k in ['native_binary_sha256','native_toolchain','coq_version'] if k in row},proof_artifacts_replay='NOT_RERUN; recorded source, proof and goal hashes retained' if isproof else None)
   if not targets:unbound.append(obs)
 # Original migration instance results use frozen case/input IDs, not a claim about every input.
 for report in sorted((MIG/'evidence').rglob('report.json')):
  data=read(report)
  for i,row in enumerate(data.get('tespec',[])):
   v=old_variants.get(row.get('case'));targets=[v] if v else []
   native=next((x for x in data.get('native',[]) if x.get('case')==row.get('case')),{});h=native.get('source_sha256');match=v and h and v in BYHASH.get(h,[])
   observation(report,f'/tespec/{i}','tespec',row.get('status'),targets,'ARCHIVED_CASE_BASE_SOURCE_HASH' if match else 'HISTORICAL_CASE_ID_ONLY_NOT_CURRENT_SOURCE_PROOF',scope='Recorded finite instance; preserve UNKNOWN and execution limits.',source_hash=h,input_set_id=old_input_sets.get((row.get('case'),row.get('function'))),input_id=row.get('id'),function=row.get('function'),execution_mode=row.get('mode'),reason=row.get('reason'),detail=row.get('detail'))

 # Keep embedded historical main drivers as declared inputs, not as executed tests.
 for row in groups['original_cn_variants']:
  if row['client_main_fingerprint']:
   target=original_by_source[row['source']]
   inputset(ROOT/row['source'],'embedded-main-driver',[target],None,'ORIGINAL_MAIN_PRESENT_EXECUTION_NOT_ASSUMED',[ROOT/row['source']],driver_fingerprint=row['client_main_fingerprint'],locator_kind='embedded_c_function',function='main',scope='Historical main including concrete setup/assertions; trusted does not establish static verification or execution.')
 # Existing sanitizer/allocation-count witnesses are concrete C observations, not QCP proofs.
 witness_report=MIG/'supplemental/negative-witnesses/report.json'
 supplemental={x['id']:x for x in read(MIG/'supplemental/manifest.json')['cases']}
 for i,row in enumerate(read(witness_report)['results']):
  harness=witness_report.parent/(row['id']+'.c');assert sha(harness)==row['source_sha256']
  source=supplemental[row['id']]['original'];q=migration_ids.get(('supplemental',row['id']));targets=[original_by_source[source]]+([q] if q else [])
  inp=inputset(witness_report,f'/results/{i}',targets,1,'EXECUTED_C_WITNESS',[harness],scope=row['scope'])
  observation(witness_report,f'/results/{i}','native_c_witness',{'compile_exit':row['compile_exit'],'run_exit':row['run_exit']},targets,'HASHED_C_HARNESS_WITH_EXPLICIT_SOURCE_CASE_RELATION',scope=row['scope'],source_hash=row['source_sha256'],input_set_id=inp,observed=row['observed'],harness_artifact=artifact(harness))
 for subfolder,filename,source_name,active_id in [('array-client-normalization','report.json','array_load.broken.c','array_main_verified'),('runway-normalization','differential-report.json','runway/funcs2.c','runway_snapshot')]:
  report=MIG/'supplemental'/subfolder/filename;data=read(report);harnesses=[x for x in report.parent.glob('*.c') if sha(x)==data['source_sha256']];assert len(harnesses)==1
  source='benchmark/selection/sources/fulminate-cn/src/examples/'+source_name;targets=[original_by_source[source]];q=migration_ids.get(('supplemental',active_id))
  if q:targets.append(q)
  if subfolder=='array-client-normalization':
   for i,row in enumerate(data['results']):
    inp=inputset(report,f'/results/{i}',targets,None,'EXECUTED_C_DIFFERENTIAL_DRIVER',harnesses,abi=row['abi'],scope=data['scope'])
    observation(report,f'/results/{i}','native_c_differential',{'compile_exit':row['compile_exit'],'run_exit':row['run_exit']},targets,'HASHED_DIFFERENTIAL_C_HARNESS_NOT_QCP_CERTIFICATE',scope=data['scope'],source_hash=data['source_sha256'],input_set_id=inp,abi=row['abi'])
  else:
   count=re.search(r'(\d+) valid boundary states',data['stdout']);inp=inputset(report,'',targets,int(count[1]) if count else None,'EXECUTED_C_DIFFERENTIAL_DRIVER',harnesses,scope=data['scope'])
   observation(report,'','native_c_differential',{'compile_exit':data['compile_exit'],'execution_exit':data['execution_exit']},targets,'HASHED_DIFFERENTIAL_C_HARNESS_NOT_QCP_CERTIFICATE',scope=data['scope'],source_hash=data['source_sha256'],input_set_id=inp)

 # Paired universal manual certificates retain hashes but are not re-proved during indexing.
 proof=BASE/'manual-proof-receipts.json'
 for i,row in enumerate(read(proof)):
  v=aliases[row['source'],'correct'];goal=BASE/row['goal'];manual=BASE/row['proof'];assert sha(goal)==row['goal_sha256'] and sha(manual)==row['manual_sha256']
  observation(proof,f'/{i}','coq_receipt',row['status'],[v],'GOAL_AND_PROOF_HASH_WITH_LOCKED_VARIANT_ALIAS',scope=row['scope'],goal_artifact=artifact(goal),proof_artifact=artifact(manual))
 # Preserve all final and pilot inputs/resources and actual model token receipts without remeasurement.
 PERF=BASE/'performance/20261015-positive18'
 for cohort,report in [('pilot',PERF/'raw-results.json'),('final',PERF/'automatic-final/raw-results.json')]:
  data=read(report);root=report.parent
  for i,row in enumerate(data['runs']):
   v=aliases[row['source'],'correct'];snapshot=PERF/'inputs'/row['source'];exact=all(sha(snapshot/(lang+'.c'))==VAR[v]['files'][lang]['sha256'] for lang in ['cn','qcp']);assert exact
   binds=root/row['source']/'binds.json';inputs=inputset(report,f'/runs/{i}',[v],row['input_count'],'EXECUTED_FROZEN_INPUTS',[binds],cohort=cohort,repeat=row['repeat'])
   for tool in ['cn','qcp_auto','fulminate_pipeline','fulminate_test','tespec_auto']:
    stage=row[tool];metrics={k:stage[k] for k in ['wall_seconds','resources'] if k in stage};status=stage.get('statuses',stage.get('native_result',stage.get('exit_code')))
    observation(report,f'/runs/{i}/{tool}',tool,status,[v],'LOCKED_SOURCE_SNAPSHOTS_AND_FROZEN_BINDS',scope='Universal CN/QCP auto stage; finite inputs for Fulminate/teSpec. Pilot and final remain separate.',metrics=metrics,input_set_id=inputs,cohort=cohort,repeat=row['repeat'])
 model=PERF/'model-proof-results.json'
 for i,row in enumerate(read(model)):
  v=aliases[row['source'],'correct'];observation(model,f'/{i}','qcp_model_proof',row['status'],[v],'HASH_CHECKED_PROOF_RECEIPT_AND_LOCKED_VARIANT',scope='Recorded GPT-6.1-sol proof generation, repairs, compilation, assumption audit and independent kernel check.',metrics={'model_wall_seconds':row['model']['wall_seconds'],'token_usage':row['model']['token_usage'],'previous_attempts':[{k:a[k] for k in ['wall_seconds','token_usage','requested_model']} for a in row['model'].get('previous_attempts',[])],'kernel_replay':{k:row['kernel_replay'][k] for k in ['exit_code','wall_seconds','resources']}},configured_model=row['model']['requested_model'])
 for v in VAR.values():
  v['input_set_ids']=sorted(set(v['input_set_ids']));v['result_ids']=sorted(set(v['result_ids']))
 families=[]
 for f in groups['families']:
  vids=sorted(k for k,v in VAR.items() if f['id'] in v['families']);resultids=sorted({oid for vid in vids for oid in VAR[vid]['result_ids']});inputids=sorted({iid for vid in vids for iid in VAR[vid]['input_set_ids']})
  row={'family':f['id'],'variant_ids':vids,'input_set_ids':inputids,'result_ids':resultids,'variant_count':len(vids),'input_set_count':len(inputids),'recorded_result_count':len(resultids),'minimum_required_variants':None,'required_polarity_ratio':None};families.append(row)
  subject=HERE/'subjects'/f['id']/'manifest.json';d=read(subject);d['existing_variant_evidence']=row;subject.write_text(json.dumps(d,indent=2,ensure_ascii=False)+'\n')
 summary={'program_families':len(families),'original_cn_variants':sum(v['kind']=='original_cn' for v in VAR.values()),'distinct_constructed_paired_variants':sum(v['kind']=='constructed_paired' for v in VAR.values()),'existing_qcp_source_variants':sum(v['kind']=='existing_qcp_translation' for v in VAR.values()),'all_variant_records':len(VAR),'input_set_records':len(INPUT),'recorded_result_observations':len(OBS),'source_hashed_result_observations':sum(v['source_binding']=='EXACT_SOURCE_HASH' for v in OBS.values()),'historical_unmatched_source_hash_observations':len(unbound),'families_with_recorded_results':sum(bool(x['result_ids']) for x in families),'families_with_input_sets':sum(bool(x['input_set_ids']) for x in families),'minimum_variants':None,'required_positive_negative_ratio':None}
 catalogue={'schema':'tespec-existing-variant-evidence/v1','policy':read(HERE/'policy.json'),'summary':summary,'families':families,'variants':list(VAR.values()),'input_sets':list(INPUT.values()),'results':list(OBS.values()),'artifacts':list(ART.values()),'historical_unmatched_result_ids':unbound}
 (HERE/'existing-variants-and-results.json').write_text(json.dumps(catalogue,indent=2,ensure_ascii=False)+'\n')
 buf=io.StringIO();w=csv.DictWriter(buf,fieldnames=['variant','kind','families','languages','input_sets','recorded_results','recorded_status_counts','cn','qcp']);w.writeheader()
 for v in VAR.values():w.writerow({'variant':v['id'],'kind':v['kind'],'families':','.join(v['families']),'languages':','.join(v['files']),'input_sets':len(v['input_set_ids']),'recorded_results':len(v['result_ids']),'recorded_status_counts':json.dumps(dict(collections.Counter(OBS[oid]['tool']+':'+json.dumps(OBS[oid]['reported_status'],sort_keys=True) for oid in v['result_ids'])),sort_keys=True),'cn':ART.get(v['files'].get('cn',{}).get('artifact'),{}).get('path'),'qcp':ART.get(v['files'].get('qcp',{}).get('artifact'),{}).get('path')})
 (HERE/'existing-variant-results.csv').write_text(buf.getvalue())
 print(json.dumps(summary,indent=2))
if __name__=='__main__':main()
