#!/usr/bin/env python3
"""Prepare membership-based search, reversal and exhaustive least-root suites."""
import argparse
import ctypes
import importlib.util
import json
import math
from pathlib import Path
import random
import re
import shutil
import subprocess
import tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('scalar_helpers',HERE/'prepare-scalar.py');h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
OLD_ROOT='0 <= return; each(integer k; 0 <= k) {(return <= k) == (x <= k*k)};'
FINITE_ROOT='0 <= return; x <= return*return; return == 0 || (return-1)*(return-1) < x;'
SHIFTED_ROOT='0 <= return+1; x <= (return+1)*(return+1); return+1 == 0 || return*return < x;'
CASES={
 'cav_binary_search':('binary_search',['n','a','target'],'int',('return != -1 || A[i] != target','return != -1 || A[i] == target'),('l[i] != target','l[i] == target'),('return mid;','return -1;')),
 'cav_array_reverse':('array_reverse_in_place',['n','a'],'void',('B[k] == A[n-1-k]','B[k] == A[k]'),('rev(l)','l'),('a[right] = tmp;','a[right] = a[left];')),
 'control_unbounded_root':('root_cell',['p'],'int',(FINITE_ROOT,SHIFTED_ROOT),('least_root(x,r)','least_root(x,r+1)'),('*p = r;','*p = r + 1;')),
}
def generate(ident,count,seed):
 if ident=='control_unbounded_root':return [({'x':n},{}) for n in range(101)]
 rng=random.Random(seed);out=[];seen=set();trial=0;edges=[h.MIN,h.MIN+1,-100,-1,0,1,100,h.MAX-1,h.MAX]
 while len(out)<count:
  n=[0,1,2,3,4,8,16,32][trial%8];mode=trial//8%5
  data=([edges[trial//40%len(edges)]]*n if mode==0 else [edges[(trial+i)%len(edges)] for i in range(n)] if mode==1 else sorted(rng.choices(edges,k=n),reverse=mode==2) if mode in [2,3] else [rng.randint(h.MIN,h.MAX) for _ in range(n)])
  args={'n':n}
  if ident=='cav_binary_search':
   data.sort()
   if n and trial%2:target=data[trial%n]
   else:
    target=edges[trial%len(edges)] if trial%3 else rng.randint(h.MIN,h.MAX)
    while target in data:target=rng.randint(h.MIN,h.MAX)
   args['target']=target
  key=json.dumps([args,data],sort_keys=True);trial+=1
  if key in seen:continue
  seen.add(key);out.append((args,{'a':data}))
 return out

def compile_native(text,folder,function,order,ident,kind):
 src=folder/'subject.c';lib=folder/'subject.so';src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M));subprocess.run(['gcc','-std=c11','-O1','-shared','-fPIC',str(src),'-o',str(lib)],check=True,capture_output=True)
 fn=getattr(ctypes.CDLL(str(lib)),function);fn.argtypes=[ctypes.POINTER(ctypes.c_int) if name in ['a','p'] else ctypes.c_int for name in order];fn.restype=None if kind=='void' else ctypes.c_int
 return fn

def execute(fn,order,ident,args,heap):
 if ident=='control_unbounded_root':
  cell=ctypes.c_int(args['x']);ret=fn(ctypes.byref(cell));return ret,{'p':cell.value}
 storage=(ctypes.c_int*max(1,args['n']))(*(heap['a'] or [0]));ret=fn(*(storage if name=='a' else args[name] for name in order));return ret,{'a':list(storage)[:args['n']]}

def search_holds(ret,data,target):
 return target not in data if ret==-1 else 0<=ret<len(data) and data[ret]==target

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));p.add_argument('--count',type=int,default=128);p.add_argument('--seed',type=int,default=20261013);a=p.parse_args()
 if a.count<128:p.error('At least 128 unique paired inputs, except exhaustive 101-value least-root domain')
 summaries=[]
 with tempfile.TemporaryDirectory(prefix='search-root-native-') as temp:
  for ident in a.cases:
   function,order,kind,ce,qe,ie=CASES[ident];original=HERE.parent/'cases'/ident;cn=(original/'subject.cn.c').read_text();qcp=(original/'subject.qcp.c').read_text()
   if ident=='control_unbounded_root':cn=h.edit_once(cn,(OLD_ROOT,FINITE_ROOT))
   variants={'reference':(cn,qcp),'spec_mutation':(h.edit_once(cn,ce),h.edit_once(qcp,qe)),'impl_mutation':(h.edit_code_once(cn,ie),h.edit_code_once(qcp,ie))};folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,(s,t) in variants.items():
    assert h.body(s)==h.body(t)
    (folder/f'{variant}.cn.c').write_text(s);(folder/f'{variant}.qcp.c').write_text(t)
   for file in original.glob('*.v'):shutil.copyfile(file,folder/file.name)
   functions=[]
   for variant in ['reference','impl_mutation']:
    d=Path(temp)/ident/variant;d.mkdir(parents=True);functions.append(compile_native(variants[variant][0],d,function,order,ident,kind))
   inputs=[]
   for i,(args,heap) in enumerate(generate(ident,a.count,a.seed)):
    observed,actual=execute(functions[0],order,ident,args,heap);mutant,mheap=execute(functions[1],order,ident,args,heap)
    if ident=='control_unbounded_root':
     x=args['x'];r=math.isqrt(x);expected=r+int(r*r<x);final={'p':expected};assert (observed,actual)==(expected,final)
     arguments={'p':4096};values={'x':x};data={'cells':{'p':x}};spec_bad=True;impl_bad=(mutant,mheap)!=(expected,final)
    else:
     values={'l':heap['a']};arguments={name:4096 if name=='a' else args[name] for name in order};data={'arrays':heap}
     if ident=='cav_binary_search':
      expected=heap['a'].index(args['target']) if args['target'] in heap['a'] else -1;final=heap
      assert search_holds(observed,heap['a'],args['target']) and actual==final
      spec_bad=observed==-1 and not all(v==args['target'] for v in heap['a'])
      impl_bad=not search_holds(mutant,heap['a'],args['target']) or mheap!=final
     else:
      expected=None;final={'a':list(reversed(heap['a']))};assert (observed,actual)==(expected,final)
      spec_bad=actual!=heap;impl_bad=(mutant,mheap)!=(expected,final)
    name=f'input_{i:03d}';inputs.append({'id':name,'args':arguments,**data,'qcp_bind':{'id':name,'args':arguments,'values':values},'expected_return':expected,'expected_heap':final,'native_reference_return':observed,'native_reference_heap':actual,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':spec_bad,'impl_mutation_violated':impl_bad})
   for mutation in ['spec','impl']:assert any(i[mutation+'_mutation_violated'] for i in inputs)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'parameter_order':order,'return_kind':kind,'element_c_type':'int','seed':a.seed,'input_count':len(inputs),'domain_complete':ident=='control_unbounded_root','admission':'Original owned int32 memory and size bounds; sorted arrays for binary search; least-root value domain x=0..100 exhausted at a canonical owned address','review_scope':'Any correct matching search index allowed; full reverse/unchanged array checks; exact least-root return and final cell with equivalent CN finite monitor','reviewed_cn_sha256':h.sha(original/'subject.cn.c'),'reviewed_qcp_sha256':h.sha(original/'subject.qcp.c'),'generator_path':Path(__file__).name,'generator_sha256':h.sha(Path(__file__)),'generator_dependencies':{'prepare-scalar.py':h.sha(HERE/'prepare-scalar.py')},'tool_runs_checked':False,'native_abi':'independent linear-membership/reversal/isqrt models and typed host storage; two ABI replay separate','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':ce,'qcp_edit':qe},'impl_mutation':{'kind':'impl','shared_c_edit':ie}},'inputs':inputs,'files':{p.name:h.sha(p) for p in folder.iterdir() if p.suffix in {'.c','.v'}}}
   if ident=='control_unbounded_root':
    proof=HERE.parents[2]/'paper/theory/LeastRootRewrite.v'
    suite.update(cell_logical_values={'p':'x'},pointer_aliases={},domain_ranges={'p':[0,100]},domain_complete_scope='owned-cell contents at a canonical valid address',cn_reference_transform={'kind':'proved-annotation-replacement','old':OLD_ROOT,'new':FINITE_ROOT,'proof_path':'paper/theory/LeastRootRewrite.v','proof_sha256':h.sha(proof),'theorem':'least_root_finite_characterization'})
   else:suite.update(pointer_lists={'a':'l'},minimum_array_length=0)
   if ident=='cav_binary_search':suite['return_contract']={'kind':'search_index','array':'a','target':'target'};suite['representative_return_scope']='first match is a representative oracle value; actual native verification permits every matching index'
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n');row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)};summaries.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/search-root-preparation-summary.json').write_text(json.dumps({'scope':'independent input/witness preparation, not complete tool admission','cases':summaries},indent=2)+'\n')
if __name__=='__main__':main()
