#!/usr/bin/env python3
"""Prepare recursive GCD and pointer-returning sorting interface suites."""
import argparse
import ctypes
import importlib.util
import json
import math
from pathlib import Path
import re
import subprocess
import tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('array_helpers',HERE/'prepare-arrays.py');arrays=importlib.util.module_from_spec(spec);spec.loader.exec_module(arrays);scalar=arrays.scalar
CASES={
 'qcp_simple_arith_gcd':('gcd',('return == Gcd(x,y)','return == Gcd(x,y) + 1'),('__return == Zgcd(x,y)','__return == Zgcd(x,y) + 1'),('return abs(x);','return 0;')),
 'qcp_sortArray':('sortArray',('R2 == numsSize;','R2 == numsSize + 1;'),('&& *returnSize == numsSize\n*/','&& *returnSize == numsSize + 1\n*/'),('nums[j] > key','nums[j] < key')),
}
def native(text,d,ident):
 src=d/'subject.c';lib=d/'subject.so';src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M));subprocess.run(['gcc','-std=c11','-O1','-shared','-fPIC',str(src),'-o',str(lib)],check=True,capture_output=True)
 fn=getattr(ctypes.CDLL(str(lib)),CASES[ident][0])
 if ident=='qcp_simple_arith_gcd':fn.argtypes=[ctypes.c_int]*2;fn.restype=ctypes.c_int
 else:fn.argtypes=[ctypes.POINTER(ctypes.c_int),ctypes.c_int,ctypes.POINTER(ctypes.c_int)];fn.restype=ctypes.c_void_p
 return fn

def gcd_inputs(count,seed):
 values=set(scalar.samples([(scalar.MIN+1,scalar.MAX)]*2,lambda *v:True,count,seed))
 required={(0,0),(0,scalar.MAX),(scalar.MIN+1,0),(scalar.MAX,scalar.MAX),(1,-1),(-1,1)}
 for x,y in [(1836311903,1134903170),(1134903170,701408733),(100,75)]:
  for a in [x,-x]:
   for b in [y,-y]:required.add((a,b))
 values|=required
 while len(values)>count:values.remove(max(values-required))
 return sorted(values)

def c_euclid_steps(x,y):
 steps=0
 while y:
  remainder=abs(x)%abs(y)
  if x<0:remainder=-remainder
  x,y=y,remainder;steps+=1
 return steps

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));p.add_argument('--count',type=int,default=128);p.add_argument('--seed',type=int,default=20261013);a=p.parse_args()
 if a.count<128:p.error('At least 128 unique shared inputs')
 summary=[]
 with tempfile.TemporaryDirectory(prefix='paired-interface-native-') as tmp:
  for ident in a.cases:
   function,cn_edit,qcp_edit,impl_edit=CASES[ident];draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text();variants={'reference':(cn,qcp),'spec_mutation':(scalar.edit_once(cn,cn_edit),scalar.edit_once(qcp,qcp_edit)),'impl_mutation':(scalar.edit_code_once(cn,impl_edit),scalar.edit_code_once(qcp,impl_edit))}
   folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,(s,t) in variants.items():
    assert scalar.body(s)==scalar.body(t)
    (folder/f'{variant}.cn.c').write_text(s);(folder/f'{variant}.qcp.c').write_text(t)
   import shutil
   for file in draft.glob('*.v'):shutil.copyfile(file,folder/file.name)
   functions=[]
   for variant in ['reference','impl_mutation']:
    d=Path(tmp)/ident/variant;d.mkdir(parents=True);functions.append(native(variants[variant][0],d,ident))
   inputs=[]
   samples=gcd_inputs(a.count,a.seed) if ident=='qcp_simple_arith_gcd' else arrays.generate('cav_array_first',{'a':'l'},a.count,a.seed)
   for index,values in enumerate(samples):
    name=f'input_{index:03d}'
    if ident=='qcp_simple_arith_gcd':
     x,y=values;expected=math.gcd(x,y);observed=functions[0](x,y);mutant=functions[1](x,y);args={'x':x,'y':y}
     assert observed==expected,(values,observed,expected)
     item={'id':name,'args':args,'qcp_bind':{'id':name,'args':args,'values':{}},'expected_return':expected,'native_reference_return':observed,'native_mutant_return':mutant,'spec_mutation_violated':True,'impl_mutation_violated':mutant!=expected,'c_euclid_iterations':c_euclid_steps(x,y)}
    else:
     parameters,blocks=values;data=blocks['a'];n=parameters['n'];initial_cell=[scalar.MIN,-1,0,1,scalar.MAX][index%5];args={'nums':4096,'numsSize':n,'returnSize':8192};expected=4096;final={'nums':sorted(data),'returnSize':n};outputs=[]
     for fn in functions:
      storage=(ctypes.c_int*n)(*data);size=ctypes.c_int(initial_cell);address=fn(storage,n,ctypes.byref(size));assert address==ctypes.addressof(storage)
      outputs.append((4096,{'nums':list(storage),'returnSize':size.value}))
     observed,actual=outputs[0];mutant,mheap=outputs[1];assert (observed,actual)==(expected,final)
     item={'id':name,'args':args,'arrays':{'nums':data},'cells':{'returnSize':initial_cell},'qcp_bind':{'id':name,'args':args,'values':{'l':data}},'expected_return':expected,'expected_heap':final,'native_reference_return':observed,'native_reference_heap':actual,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':True,'impl_mutation_violated':mheap!=final}
    inputs.append(item)
   assert len({json.dumps([i['args'],i['qcp_bind']['values']],sort_keys=True) for i in inputs})==a.count
   for kind in ['spec','impl']:assert any(i[kind+'_mutation_violated'] for i in inputs)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'seed':a.seed,'input_count':len(inputs),'domain_complete':False,'parameter_order':['x','y'] if ident=='qcp_simple_arith_gcd' else ['nums','numsSize','returnSize'],'admission':'Signed int32 x/y excluding INT_MIN for GCD; or separate owned nums array and writable returnSize cell with 1<=numsSize<=50000','review_scope':'Mathematical nonnegative gcd with standard abs helper, or nondecreasing permuted returned array and exact output length; actual native pointer correspondence checked','reviewed_cn_sha256':arrays.sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':arrays.sha(draft/'subject.qcp.c'),'generator_path':Path(__file__).name,'generator_sha256':arrays.sha(Path(__file__)),'generator_dependencies':{name:arrays.sha(HERE/name) for name in ['prepare-arrays.py','prepare-scalar.py']},'tool_runs_checked':False,'native_abi':'typed host original/mutant oracle; two native ABI controls recorded separately','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':cn_edit,'qcp_edit':qcp_edit},'impl_mutation':{'kind':'impl','shared_c_edit':impl_edit}},'inputs':inputs,'files':{p.name:arrays.sha(p) for p in sorted(folder.iterdir()) if p.suffix in {'.c','.v'}}}
   if ident=='qcp_simple_arith_gcd':suite.update(domain_ranges={'x':[scalar.MIN+1,scalar.MAX],'y':[scalar.MIN+1,scalar.MAX]},return_kind='int')
   else:suite.update(element_c_type='int',pointer_lists={'nums':'l'},array_lengths={'nums':['numsSize']},array_length_parameter='numsSize',minimum_array_length=1,cell_logical_values={'returnSize':None},pointer_aliases={},uninitialized_cells=['returnSize'],return_kind='int *',return_pointer_parameter='nums')
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
   row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)};summary.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/interface-preparation-summary.json').write_text(json.dumps({'scope':'independent math/pointer/whole-memory controls and mutation witnesses; no tool verdicts','cases':summary},indent=2)+'\n')
if __name__=='__main__':main()
