#!/usr/bin/env python3
"""Prepare actual owned list-node graphs with independent logical-list oracles."""
import argparse
import ctypes
import importlib.util
import json
from pathlib import Path
import random
import re
import subprocess
import tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('helpers',HERE/'prepare-scalar.py');h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
spec=importlib.util.spec_from_file_location('paired',HERE.parent/'run.py');paired=importlib.util.module_from_spec(spec);spec.loader.exec_module(paired)
class Node(ctypes.Structure):pass
Node._fields_=[('data',ctypes.c_int),('next',ctypes.POINTER(Node))]
CASES={
 'cn_list_length':('length',['l'],{'l':'xs'},'unsigned int',('return == Length(xs);','return == Length(xs) + 1;'),('__return == Zlength(xs)','__return == Zlength(xs) + 1'),('return 0;','return 1;')),
 'qcp_list_length':('length',['p'],{'p':'xs'},'int',('return == Length(xs);','return == Length(xs) + 1;'),('__return == Zlength(xs)','__return == Zlength(xs) + 1'),('n++;','n += 2;')),
 'qcp_list_reverse':('reverse',['p'],{'p':'xs'},'struct list *',('ys == Reverse(xs)','ys == Append(Reverse(xs),Cons{Head:0,Tail:Nil{}})'),('sll(__return,rev(xs))','sll(__return,app(rev(xs),cons(0,nil)))'),('v -> next = w;','v -> next = (void *)0;')),
 'qcp_list_append':('append',['x','y'],{'x':'xs','y':'ys'},'struct list *',('zs == Append(xs,ys)','zs == Append(Append(xs,ys),Cons{Head:0,Tail:Nil{}})'),('sll(__return,app(xs,ys))','sll(__return,app(app(xs,ys),cons(0,nil)))'),('t -> next = y;','t -> next = (void *)0;')),
}
def samples(order,count,seed):
 rng=random.Random(seed);rows=[];seen=set();trial=0;edges=[h.MIN,h.MIN+1,-100,-1,0,1,100,h.MAX-1,h.MAX];lens=[0,1,2,3,4,8,16,32]
 while len(rows)<count:
  logical={}
  for j,p in enumerate(order):
   n=lens[(trial if j==0 else trial//8)%len(lens)];mode=(trial//8+j)%5
   values=[edges[(trial//40+j)%len(edges)]]*n if mode==0 else [edges[(trial+k+j)%len(edges)] for k in range(n)] if mode==1 else sorted(rng.choices(edges,k=n),reverse=mode==2) if mode in [2,3] else [rng.randint(h.MIN,h.MAX) for _ in range(n)]
   logical[p]=values
  key=json.dumps(logical,sort_keys=True);trial+=1
  if key in seen:continue
  seen.add(key);rows.append(logical)
 return rows

def graph_of(logical):
 nodes=[];heads={}
 for pointer,values in logical.items():
  start=len(nodes);names=[f'node_{start+i}' for i in range(len(values))];heads[pointer]=names[0] if names else None
  for i,v in enumerate(values):nodes.append({'id':names[i],'address':4096+4096*(start+i),'data':v,'next':names[i+1] if i+1<len(names) else None})
 return {'nodes':nodes,'heads':heads}

def model(ident,graph,logical):
 nodes=[dict(n) for n in graph['nodes']];order=CASES[ident][1]
 if ident in ['cn_list_length','qcp_list_length']:return len(logical[order[0]]),None,nodes
 if ident=='qcp_list_reverse':
  previous=None
  for n in nodes:n['next']=previous;previous=n['id']
  return 0 if previous is None else next(n['address'] for n in nodes if n['id']==previous),previous,nodes
 head=graph['heads']['x'] or graph['heads']['y']
 xsize=len(logical['x'])
 if xsize:nodes[xsize-1]['next']=graph['heads']['y']
 return 0 if head is None else next(n['address'] for n in nodes if n['id']==head),head,nodes

def native(text,folder,function,kind):
 src=folder/'subject.c';lib=folder/'subject.so';src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M));subprocess.run(['gcc','-std=c11','-O1','-shared','-fPIC',str(src),'-o',str(lib)],check=True,capture_output=True)
 fn=getattr(ctypes.CDLL(str(lib)),function);fn.argtypes=[ctypes.POINTER(Node)]*(2 if function=='append' else 1);fn.restype=ctypes.c_void_p if '*' in kind else ctypes.c_uint if kind=='unsigned int' else ctypes.c_int
 return fn

def execute(fn,order,kind,graph):
 storage={n['id']:Node(n['data']) for n in graph['nodes']};addresses={ctypes.addressof(storage[n['id']]):n['id'] for n in graph['nodes']};virtual={n['id']:n['address'] for n in graph['nodes']}
 for n in graph['nodes']:storage[n['id']].next=ctypes.pointer(storage[n['next']]) if n['next'] is not None else ctypes.POINTER(Node)()
 ret=fn(*(ctypes.pointer(storage[graph['heads'][p]]) if graph['heads'][p] is not None else ctypes.POINTER(Node)() for p in order))
 node_id=addresses.get(ret) if ret else None
 if '*' in kind:assert ret is None or ret in addresses;ret=virtual[node_id] if node_id else 0
 final=[]
 for n in graph['nodes']:
  pointer=ctypes.cast(storage[n['id']].next,ctypes.c_void_p).value
  assert pointer is None or pointer in addresses
  final.append({'id':n['id'],'address':n['address'],'data':storage[n['id']].data,'next':addresses[pointer] if pointer else None})
 return ret,node_id,final

def reachable(head,nodes):
 byid={n['id']:n for n in nodes};seen=set();values=[]
 while head is not None:
  if head in seen or head not in byid:return None
  seen.add(head);values.append(byid[head]['data']);head=byid[head]['next']
 return values

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));p.add_argument('--count',type=int,default=128);p.add_argument('--seed',type=int,default=20261013);a=p.parse_args()
 if a.count<128:p.error('At least 128 distinct logical list inputs')
 summaries=[]
 with tempfile.TemporaryDirectory(prefix='owned-list-native-') as tmp:
  for ident in a.cases:
   function,order,binders,kind,ce,qe,ie=CASES[ident];source=HERE.parent/'cases'/ident;cn=(source/'subject.cn.c').read_text();qcp=(source/'subject.qcp.c').read_text();variants={'reference':(cn,qcp),'spec_mutation':(h.edit_once(cn,ce),h.edit_once(qcp,qe)),'impl_mutation':(h.edit_code_once(cn,ie),h.edit_code_once(qcp,ie))};folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,(s,t) in variants.items():
    assert paired.c_body(s)==paired.c_body(t)
    (folder/f'{variant}.cn.c').write_text(s);(folder/f'{variant}.qcp.c').write_text(t)
   functions=[]
   for variant in ['reference','impl_mutation']:
    d=Path(tmp)/ident/variant;d.mkdir(parents=True);functions.append(native(variants[variant][0],d,function,kind))
   inputs=[]
   for i,logical in enumerate(samples(order,a.count,a.seed)):
    graph=graph_of(logical);expected,head,final=model(ident,graph,logical);observed,observed_head,actual=execute(functions[0],order,kind,graph);mutant,mutant_head,mheap=execute(functions[1],order,kind,graph);assert (observed,actual)==(expected,final),(ident,logical)
    if '*' in kind:assert observed_head==head
    if ident in ['cn_list_length','qcp_list_length']:bad=mutant!=expected or any(reachable(graph['heads'][p],mheap)!=logical[p] for p in order)
    else:bad=reachable(mutant_head,mheap)!=(list(reversed(logical['p'])) if ident=='qcp_list_reverse' else logical['x']+logical['y'])
    addresses={n['id']:n['address'] for n in graph['nodes']};args={p:addresses.get(graph['heads'][p],0) for p in order};name=f'input_{i:03d}'
    item={'id':name,'args':args,'graph':graph,'logical_lists':logical,'qcp_bind':{'id':name,'args':args,'values':{binders[p]:logical[p] for p in order}},'expected_return':expected,'expected_graph_nodes':final,'native_reference_return':observed,'native_reference_graph_nodes':actual,'native_mutant_return':mutant,'native_mutant_graph_nodes':mheap,'spec_mutation_violated':True,'impl_mutation_violated':bad}
    if '*' in kind:item.update(expected_return_node=head,native_reference_return_node=observed_head,native_mutant_return_node=mutant_head)
    inputs.append(item)
   assert any(i['impl_mutation_violated'] for i in inputs)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'parameter_order':order,'return_kind':kind,'graph_schema':{'c_type':'struct list','value_fields':['data'],'link_fields':['next']},'list_logical_values':binders,'seed':a.seed,'input_count':len(inputs),'domain_complete':False,'admission':'Finite acyclic owned int32-data lists, disjoint node sets for append; CN unsigned length <UINT_MAX or signed length <=INT_MAX; null heads exactly for empty lists','review_scope':'CN Items/Nodes and QCP list-Z/sll represent identical data sequence and owned links; independent list sequence oracle plus full native node/pointer controls','reviewed_cn_sha256':h.sha(source/'subject.cn.c'),'reviewed_qcp_sha256':h.sha(source/'subject.qcp.c'),'generator_path':Path(__file__).name,'generator_sha256':h.sha(Path(__file__)),'generator_dependencies':{'prepare-scalar.py':h.sha(HERE/'prepare-scalar.py'),'../run.py':h.sha(HERE.parent/'run.py')},'tool_runs_checked':False,'native_abi':'actual ctypes/C node storage and pointer links; normalized virtual addresses only in QCP binding; two native ABI controls separate','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':ce,'qcp_edit':qe},'impl_mutation':{'kind':'impl','shared_c_edit':ie}},'inputs':inputs,'files':{p.name:h.sha(p) for p in folder.glob('*.c')}}
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n');row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':len(inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)};summaries.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/list-preparation-summary.json').write_text(json.dumps({'scope':'typed node graphs and actual-contract witnesses; no tool admission/proof completion','cases':summaries},indent=2)+'\n')
if __name__=='__main__':main()
