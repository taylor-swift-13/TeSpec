#!/usr/bin/env python3
"""Prepare sorting, sum and merge suites with whole-array independent oracles."""
import argparse
from collections import Counter
import importlib.util
import json
from pathlib import Path
import random
import tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('array_helpers',HERE/'prepare-arrays.py')
arrays=importlib.util.module_from_spec(spec);spec.loader.exec_module(arrays)
scalar=arrays.scalar
CASES={
 'cav_array_sum':(['n','a'],{'a':'l'},'int',{'a':['n']},('return == Sum(A,n);','return == Sum(A,n) + 1;'),('__return == sum(l)','__return == sum(l) + 1'),('ret += a[i];','ret -= a[i];')),
 'cav_insertion_sort':(['n','a'],{'a':'l'},'void',{'a':['n']},None,('insertion_sort_spec(l, lr)','lr == l'),('a[j] > key','a[j] < key')),
 'cav_merge_sorted_arrays':(['n','a','m','b','out'],{'a':'la','b':'lb','out':'lo'},'void',{'a':['n'],'b':['m'],'out':['n','m']},None,('IntArray::full(out, n + m, merge_sorted_arrays_spec(la, lb))','IntArray::full(out, n + m, lo)'),('if (a[i] <= b[j])','if (a[i] >= b[j])')),
}
def cn_mutation(ident,cn,edit):
 if edit:return edit
 # Replace the ordering and multiset part of the postcondition by unchanged
 # output. Ownership and preserved source-array assertions remain intact.
 ownership_end = (cn.index('};', cn.index('ensures')) + 2 if ident=='cav_insertion_sort'
                  else cn.index('B2 == B;', cn.index('ensures')) + len('B2 == B;'))
 start=cn.index('each(integer i;', ownership_end)
 end=cn.index('@*/',start)
 old=cn[start:end]
 return old,('B == A; ' if ident=='cav_insertion_sort' else 'O2 == O; ')

def samples(ident,count,seed):
 rng=random.Random(seed);rows=[];seen=set();trial=0;lens=[0,1,2,3,4,8,16]
 values=[-10000,-1,0,1,10000] if ident=='cav_array_sum' else [scalar.MIN,scalar.MIN+1,-100,-1,0,1,100,scalar.MAX-1,scalar.MAX]
 while len(rows)<count:
  n=lens[trial%len(lens)];m=lens[(trial//len(lens))%len(lens)]
  mode=(trial//len(lens))%5
  def data(length,offset):
   if mode==0:return [values[(trial//35+offset)%len(values)]]*length
   if mode==1:return [values[(trial+i+offset)%len(values)] for i in range(length)]
   if mode==2:return sorted(rng.choices(values,k=length),reverse=True)
   if mode==3:return sorted(rng.choices(values,k=length))
   return [rng.randint(min(values),max(values)) for _ in range(length)]
  args={'n':n};heap={'a':data(n,0)}
  if ident=='cav_merge_sorted_arrays':
   args['m']=m;heap={'a':sorted(heap['a']),'b':sorted(data(m,1)),'out':data(n+m,2)}
  key=json.dumps([args,heap],sort_keys=True)
  trial+=1
  if key in seen:continue
  seen.add(key);rows.append((args,heap))
  if trial>100000:raise ValueError('Input generation exhausted')
 return rows

def model(ident,heap,args):
 final={p:list(v) for p,v in heap.items()};ret=None
 if ident=='cav_array_sum':ret=sum(heap['a'])
 elif ident=='cav_insertion_sort':final['a']=sorted(heap['a'])
 else:final['out']=sorted(heap['a']+heap['b'])
 return ret,final

def original_holds(ident,heap,args,ret,final):
 if ident=='cav_array_sum':return ret==sum(heap['a']) and final==heap
 output='a' if ident=='cav_insertion_sort' else 'out'
 source=heap['a'] if output=='a' else heap['a']+heap['b']
 sorted_ok=all(x<=y for x,y in zip(final[output],final[output][1:]))
 preserved=True if output=='a' else final['a']==heap['a'] and final['b']==heap['b']
 return sorted_ok and Counter(final[output])==Counter(source) and preserved

def spec_holds(ident,heap,args,ret,final):
 if ident=='cav_array_sum':return ret==sum(heap['a'])+1 and final==heap
 return final==heap

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));p.add_argument('--count',type=int,default=128);p.add_argument('--seed',type=int,default=20261013);a=p.parse_args()
 if a.count<128:p.error('At least 128 distinct admitted inputs')
 summaries=[]
 with tempfile.TemporaryDirectory(prefix='paired-algorithm-native-') as temp:
  for ident in a.cases:
   order,pointers,kind,lengths,cn_edit,qcp_edit,impl_edit=CASES[ident]
   draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text();cn_edit=cn_mutation(ident,cn,cn_edit)
   variants={'reference':(cn,qcp),'spec_mutation':(scalar.edit_once(cn,cn_edit),scalar.edit_once(qcp,qcp_edit)),'impl_mutation':(scalar.edit_code_once(cn,impl_edit),scalar.edit_code_once(qcp,impl_edit))}
   folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,(s,t) in variants.items():
    assert scalar.body(s)==scalar.body(t)
    (folder/f'{variant}.cn.c').write_text(s);(folder/f'{variant}.qcp.c').write_text(t)
   import shutil
   for file in draft.glob('*.v'):shutil.copyfile(file,folder/file.name)
   functions=[]
   for variant in ['reference','impl_mutation']:
    dest=Path(temp)/ident/variant;dest.mkdir(parents=True);functions.append(arrays.native_library(variants[variant][0],dest,ident,order,pointers,kind))
   inputs=[]
   for index,(args,heap) in enumerate(samples(ident,a.count,a.seed)):
    expected,final=model(ident,heap,args);observed,actual=arrays.run_native(functions[0],order,args,heap);mutant,mheap=arrays.run_native(functions[1],order,args,heap)
    assert (observed,actual)==(expected,final) and original_holds(ident,heap,args,observed,actual),(ident,args,heap)
    arguments={name:4096+4096*list(pointers).index(name) if name in pointers else args[name] for name in order};name=f'input_{index:03d}'
    inputs.append({'id':name,'args':arguments,'arrays':heap,'qcp_bind':{'id':name,'args':arguments,'values':{logical:heap[pointer] for pointer,logical in pointers.items()}},'expected_return':expected,'expected_heap':final,'native_reference_return':observed,'native_reference_heap':actual,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':not spec_holds(ident,heap,args,observed,actual),'impl_mutation_violated':not original_holds(ident,heap,args,mutant,mheap)})
   for mutation in ['spec','impl']:assert any(x[mutation+'_mutation_violated'] for x in inputs),(ident,mutation)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':ident.removeprefix('cav_'),'parameter_order':order,'pointer_lists':pointers,'array_lengths':lengths,'return_kind':kind,'seed':a.seed,'input_count':len(inputs),'domain_complete':False,'admission':'Owned disjoint signed-int32 arrays; sum elements in [-10000,10000] and n<=10000 ensure every partial sum in int32; merge inputs sorted, n+m<=INT_MAX','review_scope':'Preserved source arrays and mathematical sum, or sorted output with exact multiplicities; CN support-based count checking equivalent to universal multiset relation; merged sorted sequence characterization checked in Rocq','reviewed_cn_sha256':arrays.sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':arrays.sha(draft/'subject.qcp.c'),'generator_path':Path(__file__).name,'generator_sha256':arrays.sha(Path(__file__)),'generator_dependencies':{name:arrays.sha(HERE/name) for name in ['prepare-arrays.py','prepare-scalar.py']},'tool_runs_checked':False,'native_abi':'host int32 return and whole-array original/mutant controls; two ABI replay separate','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':cn_edit,'qcp_edit':qcp_edit},'impl_mutation':{'kind':'impl','shared_c_edit':impl_edit}},'inputs':inputs,'files':{file.name:arrays.sha(file) for file in sorted(folder.iterdir()) if file.suffix in {'.c','.v'}}}
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
   row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)};summaries.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/algorithm-preparation-summary.json').write_text(json.dumps({'scope':'independent native state and actual-contract mutation witnesses; no tool verdicts','cases':summaries},indent=2)+'\n')
if __name__=='__main__':main()
