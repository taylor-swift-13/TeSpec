#!/usr/bin/env python3
"""Freeze cell, indexed-array and uninitialized-char-block paired suites."""
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
spec=importlib.util.spec_from_file_location('scalar_helpers',HERE/'prepare-scalar.py')
helper=importlib.util.module_from_spec(spec);spec.loader.exec_module(helper)
U32=2**32-1
CASES={
 'cn_double_it':dict(function='double_it',order=['p'],shape='cells',ctype='unsigned int',kind='unsigned int',logical={'p':'P'},cn=('return == P + P;','return == P + P + 1;'),qcp=('__return == P + P &&','__return == P + P + 1 &&'),impl=('return m;','return n;')),
 'cn_five_six':dict(function='five_six',order=['p','q'],shape='cells',ctype='unsigned int',kind='unsigned int',logical={'p':'P','q':'Q'},cn=('return == 5;','return == 6;'),qcp=('__return == 5 &&','__return == 6 &&'),impl=('return *p;','return *q;')),
 'cn_array_load2':dict(function='read',order=['p','n','i'],shape='arrays',ctype='int',kind='int',logical={'p':'l'},cn=('return == a1[i];','return == a1[i] + 1;'),qcp=('__return == l[i] &&','__return == l[i] + 1 &&'),impl=('return p[i];','return p[n - 1];')),
 'cn_array_read_two':dict(function='array_read_two',order=['p','n','i','j'],shape='arrays',ctype='unsigned int',kind='unsigned int',logical={'p':'l'},cn=('return == A[i] + A[j];','return == A[i] + A[j] + 1;'),qcp=('__return == l[i] + l[j] &&','__return == l[i] + l[j] + 1 &&'),impl=('return (tmp1 + tmp2);','return tmp1;')),
 'qcp_chars_initialize':dict(function='chars_initialize',order=['a','n','m'],shape='arrays',ctype='char',kind='void',logical={'a':None},cn=('B[i] == m','B[i] == m + 1'),qcp=('repeat_Z(m, n)','repeat_Z(m + 1, n)'),impl=('a[i] = m;','a[i] = 0;')),
}
TYPES={'int':ctypes.c_int,'unsigned int':ctypes.c_uint,'char':ctypes.c_byte}

def generated(ident,c,count,seed):
 if c['shape']=='cells':
  ranges=[(0,U32//2)] if ident=='cn_double_it' else [(0,U32)]*2
  return [({},dict(zip(c['logical'],v))) for v in helper.samples(ranges,lambda *v:True,count,seed)]
 rng=random.Random(seed);seen=set();rows=[];trial=0
 values={'int':[helper.MIN,helper.MIN+1,-100,-1,0,1,100,helper.MAX-1,helper.MAX],'unsigned int':[0,1,2,100,U32//2,U32//2+1,U32-1,U32],'char':[-128,-127,-1,0,1,65,126,127]}[c['ctype']]
 lens=[0,1,2,3,4,8,16] if ident=='qcp_chars_initialize' else [2,3,4,8,16] if ident=='cn_array_read_two' else [1,2,3,4,8,16]
 if ident=='qcp_chars_initialize':
  # Pin both signed-char extrema in nonempty as well as empty blocks.
  for m in values:
   for n in [0,1,16]:
    args={'n':n,'m':m};data=([-128,127]*8)[:n]
    seen.add(json.dumps(args,sort_keys=True));rows.append((args,{'a':data}))
 while len(rows)<count:
  n=lens[trial%len(lens)];p=next(iter(c['logical']))
  mode=(trial//len(lens))%4
  if mode==0:data=[values[(trial//len(lens))%len(values)]]*n
  elif mode==1:data=[values[(trial+k)%len(values)] for k in range(n)]
  elif mode==2:data=rng.choices(values,k=n)
  else:data=[rng.randint(min(values),max(values)) for _ in range(n)]
  args={'n':n}
  if ident=='qcp_chars_initialize':args['m']=values[trial%len(values)] if trial%2 else rng.randint(-128,127)
  else:
   args['i']=trial%n
   if ident=='cn_array_read_two':args['j']=(args['i']+1+trial//n%(n-1))%n
  trial+=1
  if ident=='cn_array_read_two' and data[args['i']]+data[args['j']]>U32:continue
  key=json.dumps(args if ident=='qcp_chars_initialize' else [args,data],sort_keys=True)
  if key in seen:continue
  seen.add(key);rows.append((args,{p:data}))
  if trial>100000:raise ValueError('Input admission budget exhausted')
 return rows

def model(ident,args,heap):
 final={p:list(v) if isinstance(v,list) else v for p,v in heap.items()}
 if ident=='cn_double_it':ret=2*heap['p']
 elif ident=='cn_five_six':ret=5;final={'p':5,'q':6}
 elif ident=='cn_array_load2':ret=heap['p'][args['i']]
 elif ident=='cn_array_read_two':ret=heap['p'][args['i']]+heap['p'][args['j']]
 elif ident=='qcp_chars_initialize':ret=None;final['a']=[args['m']]*args['n']
 return ret,final

def spec_holds(ident,args,heap,ret,final):
 if ident=='qcp_chars_initialize':return all(x==args['m']+1 for x in final['a'])
 expected,_=model(ident,args,heap)
 return ret==(6 if ident=='cn_five_six' else expected+1)

def original_holds(ident,args,heap,ret,final):
 expected,eheap=model(ident,args,heap)
 # The five_six original preserves ownership but does not constrain cell values.
 return ret==5 if ident=='cn_five_six' else (ret,final)==(expected,eheap)

def compile_native(text,folder,c):
 src=folder/'subject.c';lib=folder/'subject.so'
 src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M))
 subprocess.run(['gcc','-std=c11','-O1','-Wall','-Wextra','-fsigned-char','-shared','-fPIC',str(src),'-o',str(lib)],check=True,capture_output=True)
 fn=getattr(ctypes.CDLL(str(lib)),c['function']);typ=TYPES[c['ctype']]
 fn.argtypes=[ctypes.POINTER(typ) if name in c['logical'] else typ if name=='m' else ctypes.c_int for name in c['order']]
 fn.restype=None if c['kind']=='void' else TYPES[c['kind']]
 return fn

def execute(fn,c,args,heap):
 typ=TYPES[c['ctype']]
 storage={p:(typ*max(1,len(v)))(*(v or [0])) if isinstance(v,list) else typ(v) for p,v in heap.items()}
 callargs=[(storage[p] if c['shape']=='arrays' else ctypes.byref(storage[p])) if p in storage else args[p] for p in c['order']]
 ret=fn(*callargs)
 return ret,{p:list(storage[p])[:len(v)] if isinstance(v,list) else storage[p].value for p,v in heap.items()}

def main():
 parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));parser.add_argument('--count',type=int,default=128);parser.add_argument('--seed',type=int,default=20261013);a=parser.parse_args()
 if a.count<128:parser.error('At least 128 admitted inputs')
 summaries=[]
 with tempfile.TemporaryDirectory(prefix='paired-memory-native-') as temp:
  for ident in a.cases:
   c=CASES[ident];draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text()
   assert helper.body(cn)==helper.body(qcp)
   variants={'reference':(cn,qcp),'spec_mutation':(helper.edit_once(cn,c['cn']),helper.edit_once(qcp,c['qcp'])),'impl_mutation':(helper.edit_code_once(cn,c['impl']),helper.edit_code_once(qcp,c['impl']))}
   folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,(s,t) in variants.items():
    assert helper.body(s)==helper.body(t)
    (folder/f'{variant}.cn.c').write_text(s);(folder/f'{variant}.qcp.c').write_text(t)
   functions=[]
   for variant in ['reference','impl_mutation']:
    d=Path(temp)/ident/variant;d.mkdir(parents=True);functions.append(compile_native(variants[variant][0],d,c))
   inputs=[]
   for index,(args,heap) in enumerate(generated(ident,c,a.count,a.seed)):
    expected,final=model(ident,args,heap);observed,actual=execute(functions[0],c,args,heap);mutant,mheap=execute(functions[1],c,args,heap)
    assert (observed,actual)==(expected,final),(ident,args,heap)
    arguments={p:4096+4096*list(c['logical']).index(p) if p in c['logical'] else args[p] for p in c['order']}
    logical={v:heap[p] for p,v in c['logical'].items() if v is not None}
    name=f'input_{index:03d}'
    inputs.append({'id':name,'args':arguments,c['shape']:heap,'qcp_bind':{'id':name,'args':arguments,'values':logical},'expected_return':expected,'expected_heap':final,'native_reference_return':observed,'native_reference_heap':actual,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':not spec_holds(ident,args,heap,observed,actual),'impl_mutation_violated':not original_holds(ident,args,heap,mutant,mheap)})
   for kind in ['spec','impl']:assert any(x[kind+'_mutation_violated'] for x in inputs),(ident,kind)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':c['function'],'parameter_order':c['order'],'element_c_type':c['ctype'],'return_kind':c['kind'],'pointer_aliases':{},'seed':a.seed,'input_count':len(inputs),'domain_complete':False,'admission':'Original ownership and arithmetic guards; indexed accesses in range and distinct for read_two; double cell bounded by UINT_MAX/2; char write-only blocks, no initial list binder','review_scope':'Original initialized cells/arrays or write-only byte-block ownership, actual weaker five_six postcondition, and matched return/final-heap predicates','reviewed_cn_sha256':helper.sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':helper.sha(draft/'subject.qcp.c'),'generator_path':Path(__file__).name,'generator_sha256':helper.sha(Path(__file__)),'generator_dependencies':{'prepare-scalar.py':helper.sha(HERE/'prepare-scalar.py')},'tool_runs_checked':False,'native_abi':'independent whole-heap model and typed int32/uint32/signed-char host replay; two ABI replay recorded separately','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':c['cn'],'qcp_edit':c['qcp']},'impl_mutation':{'kind':'impl','shared_c_edit':c['impl']}},'inputs':inputs,'files':{p.name:helper.sha(p) for p in sorted(folder.glob('*.c'))}}
   if c['shape']=='cells':suite['cell_logical_values']=c['logical'];suite['domain_ranges']={p:[0,U32//2 if ident=='cn_double_it' else U32] for p in c['logical']}
   else:
    suite['pointer_lists']=c['logical'];suite['minimum_array_length']=0 if ident=='qcp_chars_initialize' else 2 if ident=='cn_array_read_two' else 1
    if ident=='qcp_chars_initialize':suite['native_c_flags']=['-fsigned-char'];suite['uninitialized_pointer_blocks']=['a']
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
   row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)};summaries.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/memory-preparation-summary.json').write_text(json.dumps({'scope':'independent native state model, actual-postcondition witnesses; tool verdicts separate','cases':summaries},indent=2)+'\n')
if __name__=='__main__':main()
