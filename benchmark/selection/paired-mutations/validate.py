#!/usr/bin/env python3
"""Audit seven-slot coverage, paired bodies, isolated mutations and proof/source hashes."""
from pathlib import Path
import hashlib,json,re
HERE=Path(__file__).resolve().parent
digest=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def plain(s):return re.sub(r'/\*.*?\*/','',s,flags=re.S).replace('#include "verification_stdlib.h"\n','').strip()
def spec(s):return re.findall(r'/\*@.*?\*/',s,re.S)
def main():
 m=json.loads((HERE/'manifest.json').read_text());assert len(m['records'])==76
 proofs={x['source']:x for x in json.loads((HERE/'manual-proof-receipts.json').read_text())}
 runs={(x['source'],x['variant']):x for x in json.loads((HERE/'run-results.json').read_text())}
 generated=0;pending=0
 for row in m['records']:
  vs=row['variants'];assert len({x['id'] for x in vs})==len(vs)
  if not vs[0]['files']:
   assert all(not x['files'] for x in vs);pending+=1;continue
  generated+=1;texts={};fingerprints=set()
  for v in vs:
   assert set(v['files'])=={'cn','qcp'}
   for lang,f in v['files'].items():
    p=HERE/f['path'];assert digest(p)==f['sha256'],str(p)
    text=p.read_text();assert 'trusted' not in text
    texts[(v['id'],lang)]=text
   cn=texts[v['id'],'cn'];q=texts[v['id'],'qcp'];assert plain(cn)==plain(q)
   fingerprint=digest(HERE/v['files']['cn']['path'])+digest(HERE/v['files']['qcp']['path']);assert fingerprint not in fingerprints;fingerprints.add(fingerprint)
   if v['id'].startswith('spec'):
    for lang in ['cn','qcp']:assert plain(texts[v['id'],lang])==plain(texts['correct',lang])
   if v['id'].startswith('impl'):
    for lang in ['cn','qcp']:assert spec(texts[v['id'],lang])==spec(texts['correct',lang])
   if v['id']=='correct' and v.get('qcp_status')=='VERIFIED_AUTOMATIC_PLUS_CHECKED_MANUAL':
    proof=proofs[row['id']];assert proof['status']=='KERNEL_CHECKED'
    assert digest(HERE/proof['goal'])==proof['goal_sha256']
    assert digest(HERE/proof['proof'])==proof['manual_sha256']
    current=HERE/runs[(row['id'],'correct')]['qcp']['evidence_path']/'vc/qcp_goal.v'
    assert digest(current)==proof['goal_sha256']
 assert sum(bool(v.get('files')) for row in m['records'] for v in row['variants'])==m['summary']['generated_variants'];assert pending==m['summary']['pending_source_groups']
 print(f'PASS: {generated} source groups (historical generated variants), {pending} explicitly pending groups; body/spec/hash checks passed.')
if __name__=='__main__':main()
