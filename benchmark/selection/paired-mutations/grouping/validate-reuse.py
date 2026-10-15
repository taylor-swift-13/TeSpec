#!/usr/bin/env python3
"""Audit reusable evidence edges, hashes, status preservation and no-cardinality policy."""
from pathlib import Path
import collections,hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3];BASE=HERE.parent
def read(p):return json.loads(Path(p).read_text())
def lookup(data,pointer):
 if pointer=='':return data
 assert pointer.startswith('/'),pointer
 for part in pointer[1:].split('/'):
  part=part.replace('~1','/').replace('~0','~');data=data[int(part)] if isinstance(data,list) else data[part]
 return data
def main():
 data=read(HERE/'existing-variants-and-results.json');policy=data['policy'];groups=read(HERE/'families.json')
 for key in ['minimum_variants_per_family','maximum_variants_per_family','required_positive_count','required_negative_count']:assert policy[key] is None
 assert data['summary']['minimum_variants'] is None and data['summary']['required_positive_negative_ratio'] is None
 assert 'minimum_design' not in groups['policy'] and 'variant_cardinality' in groups['policy']
 artifacts={a['id']:a for a in data['artifacts']};parsed={}
 for a in artifacts.values():
  p=ROOT/a['path'];p.resolve().relative_to((ROOT/'benchmark/selection').resolve());assert p.is_file(),a
  assert hashlib.sha256(p.read_bytes()).hexdigest()==a['sha256'],a['path']
 def record(aid,pointer):
  if aid not in parsed:parsed[aid]=read(ROOT/artifacts[aid]['path'])
  return lookup(parsed[aid],pointer)
 variants={v['id']:v for v in data['variants']};inputs={v['id']:v for v in data['input_sets']};results={v['id']:v for v in data['results']}
 assert len(variants)==len(data['variants']) and len(results)==len(data['results'])
 assert sum(v['kind']=='original_cn' for v in variants.values())==76
 assert sum(v['kind']=='constructed_paired' for v in variants.values())==77
 for v in variants.values():
  assert set(v['input_set_ids'])<=inputs.keys() and set(v['result_ids'])<=results.keys()
  for f in v['files'].values():assert f['artifact'] in artifacts and f['sha256']==artifacts[f['artifact']]['sha256']
  for oid in v['result_ids']:assert v['id'] in results[oid]['variant_ids']
  for iid in v['input_set_ids']:assert v['id'] in inputs[iid]['variant_ids']
 for row in inputs.values():
  assert set(row['variant_ids'])<=variants.keys()
  assert set(row['files'])<=artifacts.keys()
  if row.get('locator_kind')=='embedded_c_function':
   assert row['function']=='main' and row['execution_status']=='ORIGINAL_MAIN_PRESENT_EXECUTION_NOT_ASSUMED'
  else:record(row['report'],row['record_pointer'])
 for row in results.values():
  original=record(row['report'],row['record_pointer']);assert set(row['variant_ids'])<=variants.keys()
  if row.get('input_set_id'):assert row['input_set_id'] in inputs
  if row['source_binding']=='EXACT_SOURCE_HASH':
   assert row['variant_ids']
   assert all(any(f['sha256']==row['recorded_source_sha256'] for f in variants[v]['files'].values()) for v in row['variant_ids'])
  if row['tool']=='tespec':assert row['reported_status']==original['status']
  for a in row.get('supporting_artifacts',[]):
   if a['state']=='HASH_MATCH':assert artifacts[a['artifact']]['sha256']==a['sha256']
 for oid in data['historical_unmatched_result_ids']:
  row=results[oid];assert not row['variant_ids'] and row['source_binding']=='HISTORICAL_RECORDED_HASH_NOT_CURRENT_VARIANT'
 for family in data['families']:
  assert family['minimum_required_variants'] is None and family['required_polarity_ratio'] is None
  assert family['variant_count']==len(family['variant_ids'])
  subject=read(HERE/'subjects'/family['family']/'manifest.json');assert subject['existing_variant_evidence']==family
 assert len(data['families'])==45
 old=read(BASE.parent/'qcp-migration/evidence/20261014/report.json')['tespec'];preserved=[r for r in results.values() if r['tool']=='tespec']
 assert len(preserved)==len(old)==192
 assert collections.Counter(str(x['reported_status']) for x in preserved)==collections.Counter(str(x['status']) for x in old)
 print(f"PASS: {len(variants)} variant records, {len(inputs)} input records, {len(results)} result observations; hashes, provenance links, historical UNKNOWN and variable cardinality checked.")
if __name__=='__main__':main()
