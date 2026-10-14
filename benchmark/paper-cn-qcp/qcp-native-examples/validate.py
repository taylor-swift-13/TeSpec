#!/usr/bin/env python3
"""Check source preservation, mutation separation and frozen binding structure."""
import hashlib
import json
from pathlib import Path
import re
import sys
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
sys.path.insert(0,str(ROOT))
from spectest.core import analyze_source
def read(p):return json.loads(p.read_text())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    catalog=read(HERE/'catalog.json');count=0
    for e in catalog['programs']:
        folder=HERE/e['path'];c=read(folder/'case.json');rows=read(folder/'binds.json')
        assert sha(folder/'reference.qcp.c')==sha(ROOT/c['source'])==c['source_sha256']
        assert sha(HERE/'prepare.py')==c['generator_sha256']
        for name,digest in c['files'].items():assert sha(folder/name)==digest
        texts={v:(folder/(v+'.qcp.c')).read_text() for v in ('reference','spec_mutation','impl_mutation')}
        body=lambda t:re.sub(r'/\*@.*?\*/','',t,flags=re.S)
        assert body(texts['reference'])==body(texts['spec_mutation'])
        assert body(texts['reference'])!=body(texts['impl_mutation'])
        assert re.findall(r'/\*@.*?\*/',texts['reference'],re.S)==re.findall(r'/\*@.*?\*/',texts['impl_mutation'],re.S)
        info=analyze_source(texts['reference'],c['function'],c.get('spec'))
        names={x['name'] for x in info['argument_bindings']};values={x['name'] for x in info['value_bindings']}
        assert len(rows)==e['inputs']==c['input_count']==4
        for b in rows:
            assert set(b['args'])==names and set(b['values'])==values
            assert all(type(b['args'][x['name']]) is int for x in info['argument_bindings'])
            if 'rows' in b['values']:
                m=b['values']['rows']['value'];assert b['values']['rows']['type']=='list (list Z)'
                if 'dict_size' in b['args']:
                    assert len(m)==b['args']['dict_size']
                    assert all(0<len(r)<=100 and r[-1]==0 and all(0<v<128 for v in r[:-1]) for r in m)
                else:
                    assert len(m)==b['args']['grid_rows']
                    assert all(len(r)==b['args']['grid_cols'] and all(v in (0,1) for v in r) for r in m)
                    assert 1<=b['args']['capacity']<=10
            if c['function']=='dequeue':assert type(b['values']['x']) is int and isinstance(b['values']['l'],list)
            if c['function']=='eval':assert len(b['values']['l'])==100 and b['values']['e0']['type']=='expr'
            if c['function']=='insert':assert b['values']['tr']['type']=='tree'
            count+=1
    print(json.dumps({'status':'PASS','subjects':len(catalog['programs']),'fixed_bindings':count,'reference_sources_byte_identical':True,'scope':'artifact and binding-format checks; no arbitrary-predicate validity proof or CN equivalence claim'}))
if __name__=='__main__':main()
