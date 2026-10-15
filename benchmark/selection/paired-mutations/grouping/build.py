#!/usr/bin/env python3
"""Index original CN variants and constructed paired cases without multiplying subjects."""
from pathlib import Path
import csv,hashlib,io,json,re,collections
HERE=Path(__file__).resolve().parent;BASE=HERE.parent;ROOT=HERE.parents[3];SOURCE=BASE.parent/'sources/fulminate-cn/src/examples'
GROUPS={
 'zero':['3.c','zero.c'],
 'read':['read.broken.c','read.c','read2.c'],
 'add':['add_0.c','add_1.c','add_2.c'],
 'array_load':['array_load.broken.c','array_load.c','array_load2.c'],
 'init_array':['init_array.c','init_array2.c','init_array_rev.c'],
 'transpose':['transpose.broken.c','transpose.c','transpose2.c'],
 'incr':['slf0_basic_incr.c','slf0_incr.broken.c','slf0_basic_incr.signed.c','slf0_basic_incr.signed.broken.c'],
 'example_let':['slf1_basic_example_let.c','slf1_basic_example_let.signed.c'],
 'quadruple':['slf2_basic_quadruple.c','slf2_basic_quadruple.signed.c'],
 'incr_two':['slf4_basic_incr_two.c','slf5_basic_aliased_call.broken.c','slf6_basic_incr_two_aliased_call.c','slf_incr2.c','slf_incr2_alias.c','slf_incr2_noalias.c'],
 'incr_first':['slf7_basic_incr_first.c','bcp_framerule.c'],
 'transfer':['slf8_basic_transfer.c','slf9_basic_transfer_aliased.c'],
 'ref':['slf10_basic_ref.c','slf13_basic_ref_with_frame.c'],
 'ref_greater':['slf11_basic_ref_greater.c','slf12_basic_ref_greater_abstract.c','slf_ref_greater.c'],
 'succ_using_incr':['slf14_basic_succ_using_incr_attempt.broken.c','slf15_basic_succ_using_incr_attempt_.c','slf16_basic_succ_using_incr.c'],
 'swap_array':['swap_array.c','runtime-extras/swap_array.c'],
 'dll_add':['Dbl_Linked_List/add.c','Dbl_Linked_List/add_orig.broken.c'],
 'dll_remove':['Dbl_Linked_List/remove.c','Dbl_Linked_List/remove_orig.broken.c'],
}
LOOKUP={source:group for group,sources in GROUPS.items() for source in sources};assert len(LOOKUP)==sum(map(len,GROUPS.values()))
def sha(data):return hashlib.sha256(data if isinstance(data,bytes) else data.encode()).hexdigest()
def family(path):return LOOKUP.get(path,path.removesuffix('.c').removesuffix('.broken').replace('/','__'))
LEX=re.compile(r'/\*[\s\S]*?\*/|//[^\n]*|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|[A-Za-z_]\w*|(?:0[xX][0-9a-fA-F]+|\d+)(?:[uUlL]*)|(?:>>=|<<=|\+\+|--|->|&&|\|\||<=|>=|==|!=|\+=|-=|\*=|/=|%=|<<|>>|&=|\|=|\^=|\.\.\.)|\S')
def module(text,whole=False):
 # Remove directives without moving source offsets; keep their dependencies separately.
 clean=re.sub(r'(?m)^\s*\#[^\n]*',lambda m:' '*len(m[0]),text)
 matches=[m for m in LEX.finditer(clean) if not m[0].startswith(('/*','//'))];tokens=[m[0] for m in matches]
 functions=[];layouts=[];start=i=0
 while i<len(tokens):
  if tokens[i]==';':start=i+1;i+=1;continue
  if tokens[i]!='{':i+=1;continue
  end=i+1;depth=1
  while end<len(tokens) and depth:
   depth+=(tokens[end]=='{')-(tokens[end]=='}');end+=1
  assert depth==0,'Unbalanced C braces'
  name=None
  if i>0 and tokens[i-1]==')':
   j=i-1;paren=1;j-=1
   while j>=0 and paren:
    paren+=(tokens[j]==')')-(tokens[j]=='(');j-=1
   if j>=0 and re.fullmatch(r'[A-Za-z_]\w*',tokens[j]):name=tokens[j]
  if name:
   functions.append({'name':name,'tokens':tokens[start:end],'signature_tokens':tokens[start:i],'start':matches[start].start(),'body_start':matches[i].start(),'end':matches[end-1].end()})
   start=end
  else:
   layouts.append(tokens[start:end]);start=end
  i=end
 assert functions,'No C function body found'
 selected=functions if whole or not any(x['name']!='main' for x in functions) else [x for x in functions if x['name']!='main']
 rename={f['name']:'FUNCTION_'+str(i) for i,f in enumerate(selected)}
 canonical={'layout_blocks':layouts,'functions':[[rename.get(t,t) for t in f['tokens']] for f in selected]}
 main=next((f for f in functions if f['name']=='main'),None)
 spec_end=len(text) if whole or selected==functions else main['start'] if main else len(text)
 specs=[re.sub(r'\s+',' ',m[1]).strip() for m in re.finditer(r'/\*@([\s\S]*?)\*/',text[:spec_end])]
 trusted=[f['name'] for f in functions if re.search(r'/\*@\s*trusted\s*;',text[f['start']:f['body_start']])]
 return {'implementation_fingerprint':sha(json.dumps(canonical,sort_keys=True)),'specification_fingerprint':sha(json.dumps(specs)),'functions':[f['name'] for f in selected],'signatures':[' '.join(f['signature_tokens']) for f in selected],'trusted_functions':trusted,'driver_fingerprint':sha(json.dumps(main['tokens'])) if main else None,'scope':'whole translation unit including main' if whole or selected==functions else 'non-main function module; client main retained separately','spec_texts':specs}
def dump(path,data):path.write_text(json.dumps(data,indent=2,ensure_ascii=False)+'\n')
def csvwrite(path,rows):
 s=io.StringIO();w=csv.DictWriter(s,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows);path.write_text(s.getvalue())
def main():
 legacy=json.loads((BASE/'manifest.json').read_text());source_rows={x['original']:x for x in legacy['records']}
 candidates=collections.defaultdict(list)
 for path,key in [(BASE.parent/'qcp-migration/simple/manifest.json','cases'),(BASE.parent/'qcp-migration/supplemental/registry.json','records')]:
  data=json.loads(path.read_text())
  for c in data[key]:
   if c.get('original') and c.get('qcp') and (ROOT/c['qcp']).is_file():candidates[c['original']].append({'id':c['id'],'qcp':c['qcp'],'sha256':sha((ROOT/c['qcp']).read_bytes()),'alignment':'RELATED_TRANSLATION_NOT_ASSUMED_ORIGINAL_CONTRACT_EQUIVALENT'})
 for c in json.loads((BASE.parent/'qcp-migration/manifest.json').read_text())['cases']:
  if c.get('upstream') and c.get('source') and (ROOT/c['source']).is_file():
   source=str((SOURCE/c['upstream']).relative_to(ROOT));candidates[source].append({'id':c['id'],'qcp':c['source'],'sha256':sha((ROOT/c['source']).read_bytes()),'alignment':'RELATED_TRANSLATION_NOT_ASSUMED_ORIGINAL_CONTRACT_EQUIVALENT'})
 fams={};originals=[];derived={};implementations={};specifications={};source_to_family={}
 def register(group,info,origin):
  impl='impl_'+info['implementation_fingerprint'][:16];spec='spec_'+info['specification_fingerprint'][:16]
  key=group+'/'+impl;entry=implementations.setdefault(key,{'id':impl,'family':group,'fingerprint':info['implementation_fingerprint'],'functions':info['functions'],'signatures':info['signatures'],'scope':info['scope'],'origins':[]});entry['origins'].append(origin)
  skey=group+'/'+spec;specifications.setdefault(skey,{'id':spec,'family':group,'fingerprint':info['specification_fingerprint'],'annotation_blocks':info['spec_texts'],'origins':[]})['origins'].append(origin)
  entry.setdefault('specification_ids',[]).append(spec)
  specifications[skey].setdefault('implementation_ids',[]).append(impl)
  return impl,spec
 for p in sorted(SOURCE.rglob('*.c')):
  relative=p.relative_to(SOURCE).as_posix();group=family(relative);source=str(p.relative_to(ROOT));info=module(p.read_text(),whole=relative.startswith(('runtime-extras/','runway/')))
  origin={'kind':'original_cn','source':source};impl,spec=register(group,info,origin)
  f=fams.setdefault(group,{'id':group,'original_sources':[],'original_implementation_ids':[],'constructed_case_ids':[]})
  f['original_sources'].append(source);f['original_implementation_ids'].append(impl);source_to_family[source]=group
  top=p.parent==SOURCE;runtime_negative=(p.parent==SOURCE/'runtime-extras' and p.name.endswith('.broken.c')) or relative in ['read.broken.c','slf14_basic_succ_using_incr_attempt.broken.c']
  runtime_excluded=relative.startswith(('Dbl_Linked_List/','runway/'))
  record={'id':relative.removesuffix('.c').replace('/','__'),'family':group,'source':source,'sha256':sha(p.read_bytes()),'implementation_id':impl,'specification_id':spec,'implementation_scope':info['scope'],'functions':info['functions'],'trusted_functions':info['trusted_functions'],'client_main_fingerprint':info['driver_fingerprint'],'original_static_expected':('FAIL' if p.name.endswith('.broken.c') else 'PASS') if top else 'NOT_SELECTED_BY_CHECK_SH','original_runtime_expected':'NOT_SELECTED' if runtime_excluded else 'FAIL' if runtime_negative else 'PASS','original_cn_verification':'NOT_RERUN_FOR_THIS_INDEX','qcp_original_contract_alignment':'PENDING_REVIEW','qcp_original_contract':None,'constructed_aliases':[],'qcp_existing_candidates':candidates[source]}
  reviewed={'read.broken.c':'qcp-migration/supplemental/read_missing_post/read_missing_post.qcp.c','read.c':'qcp-migration/simple/read.qcp.c','read2.c':'qcp-migration/simple/read2.qcp.c'}
  if relative in reviewed:
   qcp=BASE.parent/reviewed[relative];assert qcp.is_file()
   record['qcp_original_contract_alignment']='REVIEWED_READ_TARGET_CONTRACT_ONLY'
   record['qcp_original_contract']={'path':str(qcp.relative_to(ROOT)),'sha256':sha(qcp.read_bytes()),'scope':'read target only; original trusted main not claimed verified','contract_role':{'read.broken.c':'missing ownership postcondition, negative','read.c':'ownership-only valid weak contract','read2.c':'value and ownership preserving full contract'}[relative]}
  row=source_rows[source]
  basev=row['variants'][0]
  baseline_case='case_'+sha((BASE/basev['files']['cn']['path']).read_bytes()+(BASE/basev['files']['qcp']['path']).read_bytes())[:16] if basev.get('files') else None
  for v in row['variants']:
   if not v.get('files'):continue
   cn=BASE/v['files']['cn']['path'];qcp=BASE/v['files']['qcp']['path'];cinfo=module(cn.read_text());qinfo=module(qcp.read_text())
   assert cinfo['implementation_fingerprint']==qinfo['implementation_fingerprint']
   pair_hash=sha(cn.read_bytes()+qcp.read_bytes());case='case_'+pair_hash[:16]
   alias={'source_record':row['id'],'variant':v['id']};record['constructed_aliases'].append(case)
   ci,cs=register(group,cinfo,{'kind':'constructed_paired','case':case,**alias})
   item=derived.setdefault(case,{'id':case,'family':group,'implementation_id':ci,'specification_id':cs,'kind':v['kind'],'expected':v['expected'],'cn':str(cn.relative_to(ROOT)),'qcp':str(qcp.relative_to(ROOT)),'cn_sha256':sha(cn.read_bytes()),'qcp_sha256':sha(qcp.read_bytes()),'cn_status':v.get('cn_status'),'qcp_status':v.get('qcp_status'),'verification':v.get('verification'),'baseline_case':baseline_case,'aliases':[]})
   assert item['family']==group and item['kind']==v['kind'];item['aliases'].append(alias);f['constructed_case_ids'].append(case)
  originals.append(record)
 for item in derived.values():
  baseline=derived[item['baseline_case']]
  assert baseline['kind']=='correct' and baseline['family']==item['family']
  if item['kind']=='spec':assert item['implementation_id']==baseline['implementation_id']
  if item['kind']=='impl':assert item['specification_id']==baseline['specification_id']
 for f in fams.values():
  f['original_implementation_ids']=sorted(set(f['original_implementation_ids']));f['constructed_case_ids']=sorted(set(f['constructed_case_ids']))
  cases=[derived[c] for c in f['constructed_case_ids']];f['counts']={'original_source_variants':len(f['original_sources']),'original_implementations':len(f['original_implementation_ids']),'all_original_and_constructed_implementations':sum(x['family']==f['id'] for x in implementations.values()),'unique_constructed_paired_cases':len(cases),'paired_positive_cases':sum(x['kind']=='correct' for x in cases),'constructed_spec_negatives':sum(x['kind']=='spec' for x in cases),'constructed_impl_negatives':sum(x['kind']=='impl' for x in cases)}
  f['minimum_constructed_seven_covered']=f['counts']['paired_positive_cases']>=1 and f['counts']['constructed_spec_negatives']>=3 and f['counts']['constructed_impl_negatives']>=3
 for entry in implementations.values():entry['specification_ids']=sorted(set(entry['specification_ids']))
 for entry in specifications.values():entry['implementation_ids']=sorted(set(entry['implementation_ids']))
 index={'schema':'tespec-cn-family-implementation-spec-variants/v1','policy':{'subject_unit':'Curated program family; all original CN source variants retained. Different interfaces/types remain explicit implementation profiles, not asserted equivalent.','implementation_identity':'C token fingerprint of selected function module plus inline layout blocks; whitespace/comments excluded and locally defined function names normalized. Not a proof of semantic equivalence; preprocessing and local-variable alpha equivalence are not inferred.','client_drivers':'Historical main is retained and fingerprinted separately for function modules. runtime-extras and runway keep main within implementation scope.','specification_identity':'Normalized CN annotation text; not a proof of logical equivalence. Missing postcondition, weak valid contract and false contract are different roles.','minimum_design':'At least one correct case, three false-spec cases and three bad-implementation cases per family. Original variants are additional; multiple correct implementations and valid weak specs are retained, not forced into negative slots.','legacy':'76 source rows and 532 planned slots are historical provenance counts, not 76 independent programs. Existing artifacts and raw timings are not deleted or rewritten.','qcp_pairing':'Constructed paired cases preserve their existing validation. Original CN contract alignment is separate; corrected QCP baselines never silently replace original negative/weak contracts.','split':'All family variants and duplicate aliases must remain in the same experimental split.'},'summary':{'original_cn_source_variants':len(originals),'program_families':len(fams),'original_implementation_profiles':sum(len(x['original_implementation_ids']) for x in fams.values()),'original_and_constructed_implementation_profiles':len(implementations),'constructed_source_alias_cases':sum(len(x['aliases']) for x in derived.values()),'distinct_constructed_cn_qcp_cases':len(derived),'paired_positive_cases':sum(x['kind']=='correct' for x in derived.values()),'families_with_paired_positive':sum(x['counts']['paired_positive_cases']>0 for x in fams.values()),'families_with_constructed_seven_minimum':sum(x['minimum_constructed_seven_covered'] for x in fams.values())},'families':list(fams.values()),'original_cn_variants':originals,'implementations':list(implementations.values()),'specifications':list(specifications.values()),'constructed_paired_cases':list(derived.values())}
 dump(HERE/'families.json',index)
 csvwrite(HERE/'original-cn-variants.csv',[{'family':x['family'],'source_variant':x['id'],'implementation':x['implementation_id'],'specification':x['specification_id'],'functions':','.join(x['functions']),'trusted_functions':','.join(x['trusted_functions']),'original_static_expected':x['original_static_expected'],'original_runtime_expected':x['original_runtime_expected'],'qcp_alignment':x['qcp_original_contract_alignment'],'source':x['source']} for x in originals])
 csvwrite(HERE/'family-summary.csv',[{'family':x['id'],**x['counts'],'minimum_seven_covered':x['minimum_constructed_seven_covered']} for x in fams.values()])
 perf=BASE/'performance/20261015-positive18/program-metrics.csv';metrics=[]
 if perf.exists():
  oldmetrics=list(csv.DictReader(perf.open()));preferred=['zero','read2','add_1','slf0_basic_incr','slf0_basic_incr.signed']
  ranked=sorted(oldmetrics,key=lambda x:(preferred.index(x['program']) if x['program'] in preferred else len(preferred),x['program']));seen=set();representatives=set()
  alias_to_case={(a['source_record'],a['variant']):x for x in derived.values() for a in x['aliases']}
  for x in ranked:
   case=alias_to_case[x['program'],'correct']
   if case['id'] not in seen:representatives.add(x['program']);seen.add(case['id'])
  for x in oldmetrics:
   case=alias_to_case[x['program'],'correct'];metrics.append({'family':case['family'],'implementation':case['implementation_id'],'paired_case':case['id'],'representative':x['program'] in representatives,**x})
  csvwrite(HERE/'performance-all-source-aliases.csv',metrics);csvwrite(HERE/'performance-distinct-positive-cases.csv',[x for x in metrics if x['representative']])
  index['summary']['measured_source_variants']=len(metrics);index['summary']['measured_distinct_positive_cases']=len(representatives);index['summary']['measured_program_families']=len(set(x['family'] for x in metrics));dump(HERE/'families.json',index)
 for f in fams.values():
  folder=HERE/'subjects'/f['id'];folder.mkdir(parents=True,exist_ok=True)
  dump(folder/'manifest.json',{'schema':index['schema'],'family':f,'original_cn_variants':[x for x in originals if x['family']==f['id']],'implementations':[x for x in implementations.values() if x['family']==f['id']],'specifications':[x for x in specifications.values() if x['family']==f['id']],'constructed_paired_cases':[derived[x] for x in f['constructed_case_ids']]})
 print(json.dumps(index['summary'],indent=2))
 for key in ['read','add','init_array']:
  f=fams[key];print(key,json.dumps(f['counts']))
if __name__=='__main__':main()
