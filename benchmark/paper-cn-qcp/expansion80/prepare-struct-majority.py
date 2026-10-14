#!/usr/bin/env python3
"""Prepare typed struct and strict-majority suites with independent witnesses."""
import argparse
from collections import Counter
import ctypes
import importlib.util
import json
from pathlib import Path
import random
import re
import subprocess
import tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('scalar_helpers',HERE/'prepare-scalar.py');helper=importlib.util.module_from_spec(spec);spec.loader.exec_module(helper)
class IntPair(ctypes.Structure):
 _fields_=[('a',ctypes.c_int),('b',ctypes.c_int)]
CASES={
 'qcp_swap_int_pair':('swap_int_pair',('Q.a == P.b','Q.a == P.a'),('store_int_pair(p, y, x)','store_int_pair(p, x, x)'),('p->b = temp;','p->b = p->a;')),
 'qcp_majorityElement':('majorityElement',('2 * Count(A,numsSize,return) > numsSize','2 * Count(A,numsSize,return) <= numsSize'),('IsMajorityElement(__return, l)','!(IsMajorityElement(__return, l))'),('return candidate;','return 0;')),
}
def majority_samples(count,seed):
 rng=random.Random(seed);rows=[];seen=set();trial=0;values=[helper.MIN,helper.MIN+1,-100,-1,0,1,100,helper.MAX-1,helper.MAX]
 while len(rows)<count:
  n=[1,2,3,4,5,8,16][trial%7];value=values[(trial//7)%len(values)] if trial%2==0 else rng.randint(helper.MIN,helper.MAX)
  repeats=n if trial%3==0 else n//2+1
  other=[v for v in values if v!=value]
  data=[value]*repeats+[rng.choice(other) for _ in range(n-repeats)]
  if trial%4==0:data.sort()
  elif trial%4==1:data.sort(reverse=True)
  elif trial%4==2:rng.shuffle(data)
  key=tuple(data);trial+=1
  if key in seen:continue
  seen.add(key);rows.append(data)
 return rows

def native(text,d,function):
 src=d/'subject.c';lib=d/'subject.so';src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M))
 subprocess.run(['gcc','-std=c11','-O1','-shared','-fPIC',str(src),'-o',str(lib)],capture_output=True,check=True)
 fn=getattr(ctypes.CDLL(str(lib)),function)
 fn.argtypes=[ctypes.POINTER(IntPair)] if function=='swap_int_pair' else [ctypes.POINTER(ctypes.c_int),ctypes.c_int]
 fn.restype=None if function=='swap_int_pair' else ctypes.c_int
 return fn

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));p.add_argument('--count',type=int,default=128);p.add_argument('--seed',type=int,default=20261013);a=p.parse_args()
 if a.count<128:p.error('At least 128 admitted inputs')
 summaries=[]
 with tempfile.TemporaryDirectory(prefix='paired-struct-majority-') as tmp:
  for ident in a.cases:
   function,cn_edit,qcp_edit,impl_edit=CASES[ident];draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text()
   variants={'reference':(cn,qcp),'spec_mutation':(helper.edit_once(cn,cn_edit),helper.edit_once(qcp,qcp_edit)),'impl_mutation':(helper.edit_code_once(cn,impl_edit),helper.edit_code_once(qcp,impl_edit))}
   folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,(s,t) in variants.items():
    assert helper.body(s)==helper.body(t)
    (folder/f'{variant}.cn.c').write_text(s);(folder/f'{variant}.qcp.c').write_text(t)
   functions=[]
   for variant in ['reference','impl_mutation']:
    d=Path(tmp)/ident/variant;d.mkdir(parents=True);functions.append(native(variants[variant][0],d,function))
   inputs=[]
   samples=helper.samples([(helper.MIN,helper.MAX)]*2,lambda *v:True,a.count,a.seed) if ident=='qcp_swap_int_pair' else majority_samples(a.count,a.seed)
   for index,values in enumerate(samples):
    name=f'input_{index:03d}'
    if ident=='qcp_swap_int_pair':
     x,y=values;heap={'p':{'a':x,'b':y}};expected=None;final={'p':{'a':y,'b':x}};args={'p':4096};logical={'x':x,'y':y};outputs=[]
     for fn in functions:
      pair=IntPair(x,y);ret=fn(ctypes.byref(pair));outputs.append((ret,{'p':{'a':pair.a,'b':pair.b}}))
     spec_bad=y!=x # Mutant keeps Q.b=P.a but replaces Q.a=P.b by Q.a=P.a.
     shape={'structs':heap}
    else:
     count=Counter(values);expected,frequency=count.most_common(1)[0];assert 2*frequency>len(values)
     heap={'nums':values};final={'nums':list(values)};args={'nums':4096,'numsSize':len(values)};logical={'l':values};outputs=[]
     for fn in functions:
      storage=(ctypes.c_int*len(values))(*values);ret=fn(storage,len(values));outputs.append((ret,{'nums':list(storage)}))
     spec_bad=True;shape={'arrays':heap}
    observed,actual=outputs[0];mutant,mheap=outputs[1];assert (observed,actual)==(expected,final),(ident,values)
    original_bad=(mutant,mheap)!=(expected,final) if ident=='qcp_swap_int_pair' else (2*count[mutant]<=len(values) or mheap!=heap)
    inputs.append({'id':name,'args':args,**shape,'qcp_bind':{'id':name,'args':args,'values':logical},'expected_return':expected,'expected_heap':final,'native_reference_return':observed,'native_reference_heap':actual,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':spec_bad,'impl_mutation_violated':original_bad})
   for kind in ['spec','impl']:assert any(i[kind+'_mutation_violated'] for i in inputs),(ident,kind)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'parameter_order':['p'] if ident=='qcp_swap_int_pair' else ['nums','numsSize'],'return_kind':'void' if ident=='qcp_swap_int_pair' else 'int','seed':a.seed,'input_count':len(inputs),'domain_complete':False,'admission':'Owned int32 pair or preserved nonempty int32 array with an actual strict majority; majority n<=50000, votes and loop increments representable','review_scope':'Struct RW field values match store_int_pair; strict count majority matches IsMajorityElement; independent returned value and whole-memory models','reviewed_cn_sha256':helper.sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':helper.sha(draft/'subject.qcp.c'),'generator_path':Path(__file__).name,'generator_sha256':helper.sha(Path(__file__)),'generator_dependencies':{'prepare-scalar.py':helper.sha(HERE/'prepare-scalar.py')},'tool_runs_checked':False,'native_abi':'host typed int32 struct/array oracle; two native ABI controls recorded separately','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':cn_edit,'qcp_edit':qcp_edit},'impl_mutation':{'kind':'impl','shared_c_edit':impl_edit}},'inputs':inputs,'files':{p.name:helper.sha(p) for p in sorted(folder.glob('*.c'))}}
   if ident=='qcp_swap_int_pair':suite.update(struct_types={'p':'struct int_pair'},struct_field_order={'p':['a','b']},struct_logical_values={'p':{'a':'x','b':'y'}},qcp_include_dirs=['runtime/qcip/QCP_examples/QCP_demos_tutorial'])
   else:suite.update(pointer_lists={'nums':'l'},array_lengths={'nums':['numsSize']},minimum_array_length=1,array_length_parameter='numsSize')
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
   row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)};summaries.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/struct-majority-preparation-summary.json').write_text(json.dumps({'scope':'independent native and actual-contract mutation witnesses; tool verdicts separate','cases':summaries},indent=2)+'\n')
if __name__=='__main__':main()
