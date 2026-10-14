#!/usr/bin/env python3
"""Prepare disjoint acyclic binary-tree graphs with a node-count oracle."""
import ctypes
import importlib.util
import json
from pathlib import Path
import random
import re
import subprocess
import tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('helpers',HERE/'prepare-scalar.py')
h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
class Node(ctypes.Structure):pass
Node._fields_=[('key',ctypes.c_int),('value',ctypes.c_int),('left',ctypes.POINTER(Node)),('right',ctypes.POINTER(Node))]

def logical(head,nodes):
    if head is None:return 'empty'
    n=nodes[head]
    return f"make_tree({logical(n['left'],nodes)},{n['key']},{n['value']},{logical(n['right'],nodes)})"

def samples():
    rng=random.Random(20261013);rows=[];seen=set();trial=0
    lengths=[0,1,2,3,4,7,8,16,31,32,63,64,99,100]
    edges=[h.MIN,h.MIN+1,-1,0,1,h.MAX-1,h.MAX]
    while len(rows)<128:
        size=lengths[trial%len(lengths)];mode=trial//len(lengths)%4;trial+=1
        nodes=[{'id':f'node_{i}','address':4096+4096*i,
                'key':edges[(trial+i)%len(edges)] if trial<60 else rng.randint(h.MIN,h.MAX),
                'value':edges[(trial+2*i)%len(edges)] if trial<60 else rng.randint(h.MIN,h.MAX),
                'left':None,'right':None} for i in range(size)]
        slots=[(0,'left'),(0,'right')] if size else []
        for i in range(1,size):
            if mode<2:parent,field=i-1,('left' if mode==0 else 'right')
            elif mode==2:parent,field=(i-1)//2,('left' if i%2 else 'right')
            else:
                index=rng.randrange(len(slots));parent,field=slots.pop(index)
                slots.extend([(i,'left'),(i,'right')])
            nodes[parent][field]=nodes[i]['id']
        graph={'nodes':nodes,'heads':{'p':'node_0' if size else None}}
        key=logical(graph['heads']['p'],{n['id']:n for n in nodes})
        if key in seen:continue
        seen.add(key);rows.append((graph,key))
    return rows

def native(text,folder):
    src=folder/'subject.c';lib=folder/'subject.so'
    src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M))
    subprocess.run(['gcc','-std=c11','-O1','-shared','-fPIC','-Wl,-Bsymbolic',str(src),'-o',str(lib)],check=True,capture_output=True)
    fn=ctypes.CDLL(str(lib)).sample;fn.argtypes=[ctypes.POINTER(Node)];fn.restype=ctypes.c_int
    return fn

def execute(fn,graph):
    storage={n['id']:Node(n['key'],n['value']) for n in graph['nodes']}
    addresses={ctypes.addressof(v):k for k,v in storage.items()}
    pointer=lambda name:ctypes.pointer(storage[name]) if name else ctypes.POINTER(Node)()
    for n in graph['nodes']:
        for field in ('left','right'):setattr(storage[n['id']],field,pointer(n[field]))
    ret=fn(pointer(graph['heads']['p']));final=[]
    for n in graph['nodes']:
        value=storage[n['id']];out={'id':n['id'],'address':n['address'],'key':value.key,'value':value.value}
        for field in ('left','right'):
            address=ctypes.cast(getattr(value,field),ctypes.c_void_p).value
            assert address is None or address in addresses
            out[field]=addresses[address] if address else None
        final.append(out)
    return ret,final

def main():
    ident='control_tree_size';source=HERE.parent/'cases'/ident
    cn=(source/'subject.cn.c').read_text();qcp=(source/'subject.qcp.c').read_text()
    ce=('return == Size(t);','return == Size(t) + 1;')
    qe=('__return == tree_size(t) &&','__return == tree_size(t) + 1 &&')
    ie=('return 1 + sample(p->left) + sample(p->right);','return 1 + sample(p->left);')
    variants={'reference':(cn,qcp),'spec_mutation':(h.edit_once(cn,ce),h.edit_once(qcp,qe)),
              'impl_mutation':(h.edit_code_once(cn,ie),h.edit_code_once(qcp,ie))}
    folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
    for variant,(c,q) in variants.items():
        assert h.body(c)==h.body(q)
        (folder/f'{variant}.cn.c').write_text(c);(folder/f'{variant}.qcp.c').write_text(q)
    (folder/'TreeMeasure.v').write_bytes((source/'TreeMeasure.v').read_bytes())
    with tempfile.TemporaryDirectory(prefix='tree-native-') as tmp:
        functions=[]
        for variant in ('reference','impl_mutation'):
            d=Path(tmp)/variant;d.mkdir();functions.append(native(variants[variant][0],d))
        inputs=[]
        for i,(graph,term) in enumerate(samples()):
            observed,actual=execute(functions[0],graph);mutant,mheap=execute(functions[1],graph)
            expected=len(graph['nodes']);assert observed==expected and actual==graph['nodes']
            name=f'input_{i:03d}';args={'p':4096 if expected else 0}
            inputs.append({'id':name,'args':args,'graph':graph,
                           'qcp_bind':{'id':name,'args':args,'values':{'t':term}},
                           'expected_return':expected,'expected_graph_nodes':graph['nodes'],
                           'native_reference_return':observed,'native_reference_graph_nodes':actual,
                           'native_mutant_return':mutant,'native_mutant_graph_nodes':mheap,
                           'spec_mutation_violated':True,'impl_mutation_violated':mutant!=expected or mheap!=graph['nodes']})
    suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':'sample','parameter_order':['p'],
           'return_kind':'int','graph_schema':{'c_type':'struct tree','value_fields':['key','value'],'link_fields':['left','right']},
           'seed':20261013,'input_count':len(inputs),'domain_complete':False,
           'admission':'Acyclic owned binary trees with no shared nodes, 0..100 nodes and int32 key/value data; original size<=100 domain.',
           'review_scope':'CN Tree/Nodes/Size and QCP tree/store_tree/tree_size preserve identical keys, values and owned child links; independent count plus complete native graph oracle.',
           'reviewed_cn_sha256':h.sha(source/'subject.cn.c'),'reviewed_qcp_sha256':h.sha(source/'subject.qcp.c'),
           'generator_path':Path(__file__).name,'generator_sha256':h.sha(Path(__file__)),
           'generator_dependencies':{'prepare-scalar.py':h.sha(HERE/'prepare-scalar.py')},
           'tool_runs_checked':False,'native_abi':'Actual typed C nodes and links; normalized addresses only in logical bindings; separate native32/native64 controls.',
           'qcp_include_dirs':['runtime/qcip/QCP_examples','runtime/qcip/QCP_examples/QCP_demos_human'],
           'variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':ce,'qcp_edit':qe},'impl_mutation':{'kind':'impl','shared_c_edit':ie}},
           'inputs':inputs,'files':{p.name:h.sha(p) for p in folder.iterdir() if p.suffix in ('.c','.v')}}
    (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
    print(json.dumps({'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':len(inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)}))

if __name__=='__main__':main()
