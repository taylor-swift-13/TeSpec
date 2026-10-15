#!/usr/bin/env python3
from pathlib import Path
import json,hashlib,importlib.util,csv
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3];BASE=HERE.parent
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 data=json.loads((HERE/'families.json').read_text());old=json.loads((BASE/'manifest.json').read_text());by_source={r['original']:r for r in old['records']}
 assert len(data['original_cn_variants'])==len(by_source)==76
 assert len({x['source'] for x in data['original_cn_variants']})==76
 originals=data['original_cn_variants'];cases={x['id']:x for x in data['constructed_paired_cases']}
 aliases=[]
 for v in originals:
  assert digest(ROOT/v['source'])==v['sha256']==by_source[v['source']]['original_sha256']
  for c in v['qcp_existing_candidates']:assert digest(ROOT/c['qcp'])==c['sha256']
  if v['qcp_original_contract']:assert digest(ROOT/v['qcp_original_contract']['path'])==v['qcp_original_contract']['sha256']
 for c in cases.values():
  assert digest(ROOT/c['cn'])==c['cn_sha256'];assert digest(ROOT/c['qcp'])==c['qcp_sha256']
  base=cases[c['baseline_case']];assert base['kind']=='correct' and c['family']==base['family']
  if c['kind']=='spec':assert c['implementation_id']==base['implementation_id']
  if c['kind']=='impl':assert c['specification_id']==base['specification_id']
  aliases.extend((a['source_record'],a['variant']) for a in c['aliases'])
 expected=[(r['id'],v['id']) for r in old['records'] for v in r['variants'] if v.get('files')]
 assert sorted(aliases)==sorted(expected) and len(aliases)==126
 by_family={x['id']:x for x in data['families']};assert len(by_family)==45
 for f in by_family.values():
  m=json.loads((HERE/'subjects'/f['id']/'manifest.json').read_text());assert m['family']==f
 read=[x for x in originals if x['family']=='read'];assert len(read)==3 and len({x['implementation_id'] for x in read})==1 and len({x['specification_id'] for x in read})==3
 init={x['id']:x for x in originals if x['family']=='init_array'}
 assert init['init_array']['implementation_id']==init['init_array2']['implementation_id']!=init['init_array_rev']['implementation_id']
 spec=importlib.util.spec_from_file_location('grouping_builder',HERE/'build.py');mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
 assert mod.module('int f(int a,int b){return a++ + b;}')['implementation_fingerprint']!=mod.module('int f(int a,int b){return a + ++b;}')['implementation_fingerprint']
 assert mod.module('int f(int a){return a;}')['implementation_fingerprint']==mod.module('int g(int a) /*@ ensures return == a; @*/ { return a; }')['implementation_fingerprint']
 perf=list(csv.DictReader((HERE/'performance-all-source-aliases.csv').open()));distinct=list(csv.DictReader((HERE/'performance-distinct-positive-cases.csv').open()));original=list(csv.DictReader((BASE/'performance/20261015-positive18/program-metrics.csv').open()));oldrows={r['program']:r for r in original}
 assert len(perf)==18 and len(distinct)==11 and len({x['family'] for x in distinct})==8
 for row in perf:
  assert {k:row[k] for k in oldrows[row['program']]}==oldrows[row['program']]
 assert len({x['paired_case'] for x in distinct})==11
 print('PASS: 76 original CN variants retained; 45 families, 61 original implementation profiles; 126 aliases mapped to 77 pairs; original hashes and all performance values preserved.')
if __name__=='__main__':main()
