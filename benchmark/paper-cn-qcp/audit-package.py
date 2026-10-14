#!/usr/bin/env python3
"""Audit frozen identities, binding shapes, address relations, and mutation pairing.
This validates the artifact encoding, not arbitrary separation predicates.
"""
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(ROOT))
from spectest.core import analyze_source
spec=importlib.util.spec_from_file_location('paired_artifact',HERE/'run.py')
pair=importlib.util.module_from_spec(spec);spec.loader.exec_module(pair)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    catalog=json.loads((HERE/'expansion80/catalog.json').read_text())
    originals={p['id']:p for p in catalog['programs']}
    subjects=[];manifest={}
    for group in ('expansion80','memory-controls'):
      for path in sorted((HERE/group/'suites').glob('*/suite.json')):
        s=json.loads(path.read_text());inputs=s['inputs'];folder=path.parent
        assert len(inputs)==s['input_count'] and len({r['id'] for r in inputs})==len(inputs)
        manifest[str(path.relative_to(HERE))]=sha(path)
        for name,digest in s['files'].items():
            assert sha(folder/name)==digest,(s['id'],name)
            manifest[str((folder/name).relative_to(HERE))]=digest
        for v in ('reference','spec_mutation','impl_mutation'):
            assert pair.c_body((folder/(v+'.cn.c')).read_text())==pair.c_body((folder/(v+'.qcp.c')).read_text()),(s['id'],v)
        for lang in ('cn','qcp'):
            texts={v:(folder/(v+'.'+lang+'.c')).read_text() for v in s['variants']}
            assert pair.c_body(texts['reference'])==pair.c_body(texts['spec_mutation'])
            assert pair.c_body(texts['reference'])!=pair.c_body(texts['impl_mutation'])
            for v in ('spec_mutation','impl_mutation'):
                edits=s['variants'][v]
                edits=edits.get(lang+'_edit',edits.get(lang+'_edits',edits.get('shared_c_edit')))
                replacements=edits if isinstance(edits[0],list) else [edits]
                for old,new in replacements:
                    assert texts['reference'].count(old)>=1
                    assert new in texts[v]
        analysis=analyze_source((folder/'reference.qcp.c').read_text(),s['function'])
        pointers=[a['name'] for a in analysis['argument_bindings'] if a['pointer_like']]
        declared_args={a['name'] for a in analysis['argument_bindings']}
        required_args={a['name'] for a in analysis['argument_bindings'] if a['required']}
        declared_values={v['name'] for v in analysis['value_bindings']}
        required_values={v['name'] for v in analysis['value_bindings'] if v['required']}
        for r in inputs:
            b=r['qcp_bind'];assert b['id']==r['id'] and b['args']==r['args']
            assert required_args<=set(b['args'])<=declared_args,(s['id'],r['id'],'args')
            assert required_values<=set(b['values'])<=declared_values,(s['id'],r['id'],'With')
            assert all(type(b['args'].get(a)) is int and 0<=b['args'][a]<2**32 for a in pointers),(s['id'],r['id'],'pointer')
            for a,base in s.get('pointer_aliases',{}).items():assert r['args'][a]==r['args'][base]
            for a,offset in s.get('pointer_offsets',{}).items():assert r['args'][a]==r['args'][offset['base']]+4*r['args'][offset['index_arg']]
            for a,value in s.get('pointer_lists',{}).items():
                if value is not None:assert b['values'][value]==r['arrays'][a]
            for a,value in s.get('cell_logical_values',{}).items():
                if value is not None:assert b['values'][value]==r['cells'][a]
            # Validate disjoint storage intervals where this suite explicitly
            # records distinct owned regions; aliases are references to them.
            regions=[];width=1 if s.get('element_c_type')=='char' else 4
            for a,data in r.get('arrays',{}).items():regions.append((a,r['args'][a],len(data)*width,width))
            for a in r.get('cells',{}):regions.append((a,r['args'][a],4,4))
            for a in r.get('structs',{}):regions.append((a,r['args'][a],4*len(s['struct_field_order'][a]),4))
            for a in s.get('pointer_boxes',{}):regions.append((a,r['args'][a],4,4))
            graph=r.get('graph')
            if graph:
                nodes={n['id']:n for n in graph['nodes']};assert len(nodes)==len(graph['nodes'])
                size=4*(len(s['graph_schema']['value_fields'])+len(s['graph_schema']['link_fields']))
                for node in nodes.values():
                    regions.append((node['id'],node['address'],size,4))
                    for field in s['graph_schema']['link_fields']:assert node[field] is None or node[field] in nodes
                for a,head in graph['heads'].items():assert r['args'][a]==(nodes[head]['address'] if head else 0)
            for a,base,length,align in regions:
                assert base%align==0 and base+length<=2**32
                if length:assert base>0
            owned=sorted((base,base+length,name) for name,base,length,align in regions if length)
            for left,right in zip(owned,owned[1:]):assert left[1]<=right[0],(s['id'],r['id'],'overlap',left,right)
            if s.get('memory_control'):
                args=r['args'];expected=r['expected_heap']
                if s['id']=='flat_matrix_fill':
                    assert len(r['arrays']['a'])==args['rows']*args['cols']
                    assert expected['a']==[args['value']]*(args['rows']*args['cols'])
                    violated=args['rows']*args['cols']>0
                elif s['id']=='interior_store':
                    assert 0<=args['k']<args['n']==len(r['arrays']['a'])
                    model=r['arrays']['a'].copy();model[args['k']]=args['value'];assert expected['a']==model
                    violated=True
                else:
                    assert expected['target']==args['value'];violated=True
                assert r['spec_mutation_violated']==violated
                assert r['impl_mutation_violated']==(violated and args['value']!=0)
        subjects.append({'id':s['id'],'group':group,'category':originals.get(s['id'],{}).get('category',s.get('memory_class')),'inputs':len(inputs),'pointer_parameters':pointers,'all_entry_addresses_numeric':True,'logical_variables':sorted(declared_values),'internal_graph_addresses_bound_in_qcp':False if s.get('graph_schema') else None,'mutation_witnesses':{k:sum(r[k+'_mutation_violated'] for r in inputs) for k in ('spec','impl')},'suite':str(path.relative_to(HERE)),'suite_sha256':sha(path)})
    missing=[p['id'] for p in catalog['programs'] if p['id'] not in {s['id'] for s in subjects}]
    for name in ('replay-frozen.py','audit-package.py','memory-controls/prepare.py'):
        manifest[name]=sha(HERE/name)
    result={'schema':'tespec-benchmark-package-audit/v1','scope':'encoding, shared C bodies, fixed files and concrete address consistency; no general precondition/equivalence proof','status':'PASS','original_target':80,'original_prepared':sum(s['group']=='expansion80' for s in subjects),'original_inputs':sum(s['inputs'] for s in subjects if s['group']=='expansion80'),'supplemental_prepared':sum(s['group']=='memory-controls' for s in subjects),'supplemental_inputs':sum(s['inputs'] for s in subjects if s['group']=='memory-controls'),'missing_original_suites':missing,'memory_coverage_gaps':['shared/cyclic heap graphs','doubly linked lists with back pointers','pointer-to-pointer ragged matrices','unions and overlapping storage','malloc/free lifetime and allocator production implementation'],'full_80_complete':False,'subjects':subjects,'files':manifest}
    (HERE/'package-audit.json').write_text(json.dumps(result,indent=2,ensure_ascii=False)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ('subjects','files')},ensure_ascii=False))
if __name__=='__main__':main()
