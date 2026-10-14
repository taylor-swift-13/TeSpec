#!/usr/bin/env python3
"""Prepare uint32 owned-cell and alias suites using independent state models."""
import argparse
import ctypes
import hashlib
import importlib.util
import json
from pathlib import Path
import random
import re
import subprocess
import tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('scalar_preparation',HERE/'prepare-scalar.py')
scalar=importlib.util.module_from_spec(spec);spec.loader.exec_module(scalar)
MAX=2**32-1
# function, order, owned-cell logical variables, aliases, return kind, domain,
# CN/QCP postcondition mutations and an executable mutation.
CASES={
 'cn_read2':('read',['p'],{'p':'P'},{},'unsigned int',[(0,MAX)],
  ('return == P;','return == P + 1;'),('__return == P &&','__return == P + 1 &&'),
  ('return *p;','return *p + 1;')),
 'cn_add_read':('add',['p','q'],{'p':'P','q':'Q'},{},'unsigned int',[(0,MAX)]*2,
  ('return == P + Q;','return == P + Q + 1;'),('__return == P + Q &&','__return == P + Q + 1 &&'),
  ('return m+n;','return m;')),
 'cn_slf0_basic_incr':('incr',['p'],{'p':'P'},{},'void',[(0,MAX-1)],
  ('P_post == P + 1;','P_post == P + 2;'),('data_at(p, unsigned int, P + 1)','data_at(p, unsigned int, P + 2)'),
  ('unsigned int m = n+1;','unsigned int m = n;')),
 'cn_slf3_basic_inplace_double':('inplace_double',['p'],{'p':'P'},{},'void',[(0,MAX//2)],
  ('P_post == P + P;','P_post == P + P + 1;'),('data_at(p, unsigned int, P + P)','data_at(p, unsigned int, P + P + 1)'),
  ('unsigned int m = n + n;','unsigned int m = n;')),
 'cn_slf9_basic_transfer_aliased':('transfer',['p','q'],{'p':'P'},{'q':'p'},'void',[(0,MAX)],
  ('n2 == 0;','n2 == 1;'),('Ensure data_at(p, unsigned int, 0)','Ensure data_at(p, unsigned int, 1)'),
  ('*q = 0;','*q = 1;')),
}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def admitted(ident,values):return ident!='cn_add_read' or sum(values)<=MAX

def spec_holds(ident,cells,ret,final):
 if ident=='cn_read2':return ret==cells['p']+1
 if ident=='cn_add_read':return ret==cells['p']+cells['q']+1
 if ident=='cn_slf0_basic_incr':return final['p']==cells['p']+2
 if ident=='cn_slf3_basic_inplace_double':return final['p']==2*cells['p']+1
 if ident=='cn_slf9_basic_transfer_aliased':return final['p']==1
 raise ValueError(ident)

def model(ident,cells):
 final=dict(cells);ret=None
 if ident=='cn_read2':ret=cells['p']
 elif ident=='cn_add_read':ret=cells['p']+cells['q']
 elif ident=='cn_slf0_basic_incr':final['p']=cells['p']+1
 elif ident=='cn_slf3_basic_inplace_double':final['p']=2*cells['p']
 elif ident=='cn_slf9_basic_transfer_aliased':final['p']=0
 else:raise ValueError(ident)
 return ret,final

def compile_native(text,folder,function,order,kind):
 src=folder/'subject.c';lib=folder/'subject.so'
 src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M))
 subprocess.run(['gcc','-std=c11','-O1','-Wall','-Wextra','-shared','-fPIC',str(src),'-o',str(lib)],check=True,capture_output=True)
 library=ctypes.CDLL(str(lib));fn=getattr(library,function)
 fn.argtypes=[ctypes.POINTER(ctypes.c_uint)]*len(order);fn.restype=ctypes.c_uint if kind!='void' else None
 return fn

def execute(fn,order,aliases,cells):
 storage={p:ctypes.c_uint(v) for p,v in cells.items()}
 ret=fn(*(ctypes.byref(storage[aliases.get(p,p)]) for p in order))
 return ret,{p:v.value for p,v in storage.items()}

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES))
 parser.add_argument('--count',type=int,default=128);parser.add_argument('--seed',type=int,default=20261013)
 a=parser.parse_args()
 if a.count<128:parser.error('At least 128 inputs per subject')
 summary=[]
 with tempfile.TemporaryDirectory(prefix='paired-uint-oracle-') as tmp:
  for ident in a.cases:
   function,order,logical,aliases,kind,ranges,cn_edit,qcp_edit,impl_edit=CASES[ident]
   draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text()
   sc=scalar.edit_once(cn,cn_edit);sq=scalar.edit_once(qcp,qcp_edit)
   ic=scalar.edit_code_once(cn,impl_edit);iq=scalar.edit_code_once(qcp,impl_edit)
   folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,c,q in [('reference',cn,qcp),('spec_mutation',sc,sq),('impl_mutation',ic,iq)]:
    assert scalar.body(c)==scalar.body(q)
    (folder/f'{variant}.cn.c').write_text(c);(folder/f'{variant}.qcp.c').write_text(q)
   assert scalar.body(cn)==scalar.body(sc)!=scalar.body(ic)
   functions=[]
   for variant,text in [('reference',cn),('impl_mutation',ic)]:
    d=Path(tmp)/ident/variant;d.mkdir(parents=True);functions.append(compile_native(text,d,function,order,kind))
   values=scalar.samples(ranges,lambda *v:admitted(ident,v),a.count,a.seed)
   # Retain explicit unsigned boundaries; equal random counts must not drop them.
   boundaries=[tuple(lo for lo,hi in ranges),tuple(hi for lo,hi in ranges)]
   if len(ranges)==2:boundaries += [(MAX,0),(0,MAX),(MAX//2,MAX-MAX//2)]
   else:boundaries += [(MAX//2,), (MAX//2+1,)]
   required={v for v in boundaries if admitted(ident,v) and all(lo<=x<=hi for x,(lo,hi) in zip(v,ranges))}
   selected=set(values)|required
   while len(selected)>a.count:selected.remove(max(selected-required))
   values=sorted(selected)
   assert len(values)==a.count
   inputs=[]
   for i,v in enumerate(values):
    cells=dict(zip(logical,v));expected,final=model(ident,cells)
    observed,heap=execute(functions[0],order,aliases,cells);mutant,mheap=execute(functions[1],order,aliases,cells)
    assert (observed,heap)==(expected,final),(ident,cells)
    args={p:4096+4096*list(logical).index(aliases.get(p,p)) for p in order}
    inputs.append({'id':f'input_{i:03d}','args':args,'cells':cells,'qcp_bind':{'id':f'input_{i:03d}','args':args,'values':{logical[p]:x for p,x in cells.items()}},'expected_return':expected,'expected_heap':final,'native_reference_return':observed,'native_reference_heap':heap,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':not spec_holds(ident,cells,observed,heap),'impl_mutation_violated':(mutant,mheap)!=(expected,final)})
   assert any(x['impl_mutation_violated'] for x in inputs)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'parameter_order':order,'cell_logical_values':logical,'pointer_aliases':aliases,'element_c_type':'unsigned int','return_kind':kind,'seed':a.seed,'input_count':len(inputs),'domain_complete':False,'domain_ranges':dict(zip(logical,ranges)),'admission':'Owned uint32 cells; disjoint p/q for add, identical p/q for transfer; add sum/increment/double bounds match original contracts. Aliased transfer admits full uint32 domain and defined unsigned wrap.','review_scope':'CN RW<unsigned int> and QCP data_at(unsigned int) with matched owned cells, pointer equality and exact return/final-cell relation','reviewed_cn_sha256':sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':sha(draft/'subject.qcp.c'),'generator_path':'prepare-cells.py','generator_sha256':sha(Path(__file__)),'tool_runs_checked':False,'native_abi':'host uint32 oracle; paired native32/native64 replay pending','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':cn_edit,'qcp_edit':qcp_edit},'impl_mutation':{'kind':'impl','shared_c_edit':impl_edit}},'inputs':inputs,'files':{p.name:sha(p) for p in folder.glob('*.c')}}
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
   row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':len(inputs),'impl_negative_witnesses':sum(x['impl_mutation_violated'] for x in inputs)};summary.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/cell-preparation-summary.json').write_text(json.dumps({'scope':'typed uint32 native state oracle and both witnessed mutation types; no CN/QCP verdicts','cases':summary},indent=2)+'\n')
if __name__=='__main__':main()
