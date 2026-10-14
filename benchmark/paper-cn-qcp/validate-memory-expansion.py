#!/usr/bin/env python3
"""Validate new source-derived memory suites, bindings, mutation separation and receipts.
The allowed Pre names are manually reviewed for these selected contracts; this
is deliberately not a general free-variable parser for arbitrary QCP syntax.
"""
import hashlib,json,re,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1];sys.path.insert(0,str(ROOT))
from spectest.core import _find_function_spec,specialize_source
from spectest.core import analyze_source

def read(p):return json.loads(p.read_text())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def annotations(s):return re.findall(r'/\*@.*?\*/',s,re.S)
def body(s):return re.sub(r'/\*@.*?\*/|^\s*#include[^\n]*','',s,flags=re.S|re.M)
def check_variants(folder,lang):
 texts={v:(folder/(v+'.'+lang+'.c')).read_text() for v in ['reference','spec_mutation','impl_mutation']}
 assert body(texts['reference'])==body(texts['spec_mutation'])
 assert body(texts['reference'])!=body(texts['impl_mutation'])
 assert annotations(texts['reference'])==annotations(texts['impl_mutation'])
 return texts

def check_pre(text,c,bindings):
 candidate=_find_function_spec(text,c['function']);pre=candidate.body.split('Require',1)[1].split('Ensure',1)[0]
 allowed=c['pre_free_variables']
 # These particular Pre clauses contain no value quantifier; reject extending
 # this limited lexical audit to one without an explicit scope-aware review.
 assert not re.search(r'\b(exists|forall)\b',pre)
 info=analyze_source(text,c['function'])
 assert set(allowed['args'])<={v['name'] for v in info['argument_bindings']}
 assert set(allowed['values'])<={v['name'] for v in info['value_bindings']}
 for k in ['args','values']:
  assert all(re.search(r'(?<![\w])'+re.escape(n)+r'(?![\w])',pre) for n in allowed[k])
 for b in bindings:
  assert set(b['args'])==set(allowed['args']);assert set(b['values'])==set(allowed['values'])
  assert set(b.get('types',{}))<={t['name'] for t in info['type_bindings']}
  specialize_source(text,c['function'],b['values'],argument_bindings=b['args'],type_bindings=b.get('types'))


def main():
 totals={};catalog=[]
 for track in ['upstream-memory','qcp-memory-v2','fulminate-memory']:
  entries=read(HERE/track/'catalog.json')['programs'];count=0
  for e in entries:
   folder=HERE/track/e['path'];c=read(folder/('suite.json' if track=='upstream-memory' else 'case.json'))
   assert sha(ROOT/c['source'])==c['source_sha256']
   assert sha(HERE/track/'prepare.py')==c['generator_sha256']
   for name,digest in c['files'].items():assert sha(folder/name)==digest,(e['id'],name)
   if track=='upstream-memory':
    cn=check_variants(folder,'cn');qcp=check_variants(folder,'qcp')
    for v in cn:assert body(cn[v]).strip()==body(qcp[v]).strip()
    original=(ROOT/c['source']).read_text()
    for dep,digest in c['source_dependencies'].items():
     assert sha(ROOT/dep)==digest
     original=original.replace('#include "'+Path(dep).name+'"',(ROOT/dep).read_text())
    assert cn['reference']==original
    rows=c['inputs'];check_pre(qcp['reference'],c,[r['qcp_bind'] for r in rows])
    for r in rows:
     assert r['qcp_bind']['args']==r['args']
     if 'structs' in r:assert r['qcp_bind']['values']==dict(zip(['X','Y'],r['structs']['p'].values()))
     else:assert list(r['qcp_bind']['values'].values())==list(r['cells'].values())
   elif track=='qcp-memory-v2':
    qcp=check_variants(folder,'qcp');assert (folder/'reference.qcp.c').read_bytes()==(ROOT/c['source']).read_bytes()
    rows=read(folder/'binds.json');check_pre(qcp['reference'],c,rows)
    if c.get('fixture_prefix'):
     for v,s in qcp.items():assert (folder/('execution_'+v+'.qcp.c')).read_text()==c['fixture_prefix']+s
    if e['id']=='qcp_original_liteos_list_empty':
     for r in rows:
      term=r['values']['l']['qcp'];addresses=list(map(int,re.findall(r'Build_DL_Node\(0,(\d+)\)',term)))
      assert len(set(addresses))==len(addresses)
      assert all(a%4==0 and a>=8192 for a in addresses)
   else:
    cn=check_variants(folder,'cn');assert (folder/'reference.cn.c').read_bytes()==(ROOT/c['source']).read_bytes()
    rows=read(folder/'inputs.json')
    for r in rows:
     for k in ['args','values']:assert set(r['pre_instance'][k])==set(c['pre_free_variables'][k])
   assert len(rows)==c['input_count']==e['inputs'];assert len({r['id'] for r in rows})==len(rows)
   count+=len(rows);catalog.append({'id':e['id'],'track':track,'path':str(folder.relative_to(HERE)),'memory':e['memory'],'inputs':len(rows)})
  totals[track]={'subjects':len(entries),'inputs':count}
 review=HERE/'review-20261014/memory-expansion'
 paired=read(review/'paired6-replay.json');assert paired['summary']['mismatches']==0 and paired['summary']['missing_results']==0
 assert sha(review/'paired-driver-snapshot.py')==paired['driver_sha256']
 for track,name in [('qcp-memory-v2','qcp11'),('fulminate-memory','fulminate3')]:
  report=read(review/(name+'-replay.json'));assert sha(HERE/track/'run.py')==report['driver_sha256']
  assert report['summary']['missing_results']==0
  for r in report['runs']:assert r['case_sha256']==sha(HERE/track/'cases'/r['case']/'case.json')
  assert all(x['status']=='UNKNOWN' or x['status']==x.get('expected',x.get('expected_by_manual_model')) for r in report['runs'] for x in r['results'])
 output={'status':'PASS','tracks':totals,'new_subjects':sum(v['subjects'] for v in totals.values()),'new_fixed_inputs':sum(v['inputs'] for v in totals.values()),'programs':catalog,'scope':'source and receipt integrity; mutation separation; manually audited Pre-only binding names for new selected contracts; no claim of arbitrary-predicate validity or certified translation equivalence'}
 (review/'validation.json').write_text(json.dumps(output,indent=2)+'\n');print(json.dumps({k:v for k,v in output.items() if k!='programs'}))
if __name__=='__main__':main()
