#!/usr/bin/env python3
"""Expand historical simple smoke pairs with independent full-suite witnesses."""
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
spec=importlib.util.spec_from_file_location('scalar_helpers',HERE/'prepare-scalar.py');h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
U=2**32-1
class Point(ctypes.Structure):_fields_=[('x',ctypes.c_uint),('y',ctypes.c_uint)]
CASES={
 'cn_abs':('bench_abs',['x'],'scalar','int','int',('return == ((x >= 0) ? x : (0-x))','return == ((x >= 0) ? x : (0-x)) + 1'),[('__return == x &&','__return == x + 1 &&'),('__return == -x &&','__return == -x + 1 &&')],('return -x;','return x;')),
 'cn_swap':('swap',['p','q'],'cells','unsigned int','void',('P_post == Q && Q_post == P','P_post == P && Q_post == P'),[('Ensure data_at(p, unsigned int, Q)','Ensure data_at(p, unsigned int, P)')],('*q = m;','*q = n;')),
 'cn_transpose':('transpose',['p'],'structs','unsigned int','void',('P_post.x == P.y','P_post.x == P.x'),[('Ensure data_at(&(p->x), unsigned int, y)','Ensure data_at(&(p->x), unsigned int, x)')],('p->y = temp_x;','p->y = temp_y;')),
 'cn_array_swap':('array_swap',['p','n','i','j'],'arrays','int','void',('B == A[i: A[j], j: A[i]]','B == A'),[('replace_Znth(j,Znth(i,l,0),replace_Znth(i,Znth(j,l,0),l))','l')],('p[j] = tmp;','p[j] = 0;')),
 'qcp_array_sum':('arr_sum',['n','a'],'arrays','int','int',('return == Sum(A,n);','return == Sum(A,n) + 1;'),[('__return == sum(l)','__return == sum(l) + 1')],('ret += a[i];','ret -= a[i];')),
 'qcp_array_sum_zero':('arr_sum_update',['n','a'],'arrays','int','int',('return == Sum(A,n);','return == Sum(A,n) + 1;'),[('__return == sum(l)','__return == sum(l) + 1')],('ret += a[i];','ret -= a[i];')),
}
def generate(ident,count,seed):
 if ident=='cn_abs':return [({'x':v[0]}, {}) for v in h.samples([(h.MIN+1,h.MAX)],lambda *v:True,count,seed)]
 if ident in ['cn_swap','cn_transpose']:
  return [({},dict(zip(['p','q'] if ident=='cn_swap' else ['x','y'],v))) for v in h.samples([(0,U)]*2,lambda *v:True,count,seed)]
 rng=random.Random(seed);seen=set();out=[];trial=0;lens=[2,3,4,8,16,99] if ident=='cn_array_swap' else [1,2,3,4,8,16,99];edges=[h.MIN,-1,0,1,h.MAX] if ident=='cn_array_swap' else [0,1,2,50,98,99]
 while len(out)<count:
  n=lens[trial%len(lens)];mode=trial//len(lens)%4
  values=([edges[trial//24%len(edges)]]*n if mode==0 else [edges[(trial+i)%len(edges)] for i in range(n)] if mode==1 else rng.choices(edges,k=n) if mode==2 else [rng.randint(min(edges),max(edges)) for _ in range(n)])
  args={'n':n}
  if ident=='cn_array_swap':args.update(i=trial%n,j=(trial%n+1+trial//n%(n-1))%n)
  key=json.dumps([args,values],sort_keys=True);trial+=1
  if key in seen:continue
  seen.add(key);out.append((args,{'p' if ident=='cn_array_swap' else 'a':values}))
 return out

def model(ident,args,heap):
 final={p:list(v) if isinstance(v,list) else v for p,v in heap.items()};ret=None
 if ident=='cn_abs':ret=abs(args['x'])
 elif ident=='cn_swap':final={'p':heap['q'],'q':heap['p']}
 elif ident=='cn_transpose':final={'p':{'x':heap['y'],'y':heap['x']}}
 elif ident=='cn_array_swap':final['p'][args['i']],final['p'][args['j']]=heap['p'][args['j']],heap['p'][args['i']]
 elif ident=='qcp_array_sum':ret=sum(heap['a'])
 elif ident=='qcp_array_sum_zero':ret=sum(heap['a']);final['a']=[0]*args['n']
 return ret,final

def compile_native(text,folder,function,order,shape,ctype,kind):
 src=folder/'subject.c';lib=folder/'subject.so';src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M));subprocess.run(['gcc','-std=c11','-O1','-shared','-fPIC',str(src),'-o',str(lib)],check=True,capture_output=True)
 fn=getattr(ctypes.CDLL(str(lib)),function);typ=ctypes.c_uint if ctype=='unsigned int' else ctypes.c_int
 fn.argtypes=[ctypes.POINTER(Point) if shape=='structs' else ctypes.POINTER(typ) if name in ['p','q','a'] else ctypes.c_int for name in order];fn.restype=None if kind=='void' else ctypes.c_int
 return fn

def execute(fn,order,shape,ctype,args,heap):
 typ=ctypes.c_uint if ctype=='unsigned int' else ctypes.c_int
 if shape=='structs':
  p=Point(heap['x'],heap['y']);ret=fn(ctypes.byref(p));return ret,{'p':{'x':p.x,'y':p.y}}
 storage={p:(typ*len(v))(*v) if isinstance(v,list) else typ(v) for p,v in heap.items()}
 ret=fn(*(storage[p] if shape=='arrays' else ctypes.byref(storage[p]) if p in storage else args[p] for p in order)) if shape=='cells' else fn(*(storage[p] if p in storage else args[p] for p in order))
 return ret,{p:list(storage[p]) if isinstance(v,list) else storage[p].value for p,v in heap.items()}

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));p.add_argument('--count',type=int,default=128);p.add_argument('--seed',type=int,default=20261013);a=p.parse_args()
 if a.count<128:p.error('At least 128 unique admitted inputs')
 summaries=[]
 with tempfile.TemporaryDirectory(prefix='historical-native-') as tmp:
  for ident in a.cases:
   function,order,shape,ctype,kind,ce,qes,ie=CASES[ident];source=HERE.parent/'cases'/ident;cn=(source/'subject.cn.c').read_text();qcp=(source/'subject.qcp.c').read_text();sq=qcp
   for edit in qes:sq=h.edit_once(sq,edit)
   variants={'reference':(cn,qcp),'spec_mutation':(h.edit_once(cn,ce),sq),'impl_mutation':(h.edit_code_once(cn,ie),h.edit_code_once(qcp,ie))};folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,(s,t) in variants.items():
    assert h.body(s)==h.body(t)
    (folder/f'{variant}.cn.c').write_text(s);(folder/f'{variant}.qcp.c').write_text(t)
   functions=[]
   for variant in ['reference','impl_mutation']:
    d=Path(tmp)/ident/variant;d.mkdir(parents=True);functions.append(compile_native(variants[variant][0],d,function,order,shape,ctype,kind))
   inputs=[]
   for index,(args,heap) in enumerate(generate(ident,a.count,a.seed)):
    expected,final=model(ident,args,heap);observed,actual=execute(functions[0],order,shape,ctype,args,heap);mutant,mheap=execute(functions[1],order,shape,ctype,args,heap);assert (observed,actual)==(expected,final),(ident,args,heap)
    pointer_names=['p'] if shape=='structs' else list(heap) if shape!='scalar' else [];arguments={name:4096+4096*pointer_names.index(name) if name in pointer_names else args[name] for name in order}
    if shape=='scalar':logical={};data={};spec_bad=True
    elif shape=='cells':logical={'P':heap['p'],'Q':heap['q']};data={'cells':heap};spec_bad=heap['p']!=heap['q']
    elif shape=='structs':logical=heap;data={'structs':{'p':heap}};spec_bad=heap['x']!=heap['y']
    else:logical={'l':next(iter(heap.values()))};data={'arrays':heap};spec_bad=actual!=heap if ident=='cn_array_swap' else True
    name=f'input_{index:03d}';inputs.append({'id':name,'args':arguments,**data,'qcp_bind':{'id':name,'args':arguments,'values':logical},'expected_return':expected,'expected_heap':final,'native_reference_return':observed,'native_reference_heap':actual,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':spec_bad,'impl_mutation_violated':(mutant,mheap)!=(expected,final)})
   for mutation in ['spec','impl']:assert any(i[mutation+'_mutation_violated'] for i in inputs)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'parameter_order':order,'element_c_type':ctype,'return_kind':kind,'seed':a.seed,'input_count':len(inputs),'domain_complete':False,'admission':'Original historical pair preconditions; owned distinct pointers; abs excludes INT_MIN; array indices distinct/in range; sums use n<100 and values 0..99','review_scope':'Historical CN/QCP pair, independent return and complete final storage relation; witnessed mutants run on all inputs','reviewed_cn_sha256':h.sha(source/'subject.cn.c'),'reviewed_qcp_sha256':h.sha(source/'subject.qcp.c'),'generator_path':Path(__file__).name,'generator_sha256':h.sha(Path(__file__)),'generator_dependencies':{'prepare-scalar.py':h.sha(HERE/'prepare-scalar.py')},'tool_runs_checked':False,'native_abi':'typed host whole-storage oracle; two ABI replay recorded separately','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':ce,'qcp_edits':qes},'impl_mutation':{'kind':'impl','shared_c_edit':ie}},'inputs':inputs,'files':{p.name:h.sha(p) for p in folder.glob('*.c')}}
   if shape=='scalar':suite['domain_ranges']={'x':[h.MIN+1,h.MAX]}
   elif shape=='cells':suite.update(cell_logical_values={'p':'P','q':'Q'},pointer_aliases={})
   elif shape=='structs':suite.update(struct_types={'p':'struct point'},struct_field_order={'p':['x','y']},struct_logical_values={'p':{'x':'x','y':'y'}})
   else:suite.update(pointer_lists={'p':'l'} if ident=='cn_array_swap' else {'a':'l'},minimum_array_length=2 if ident=='cn_array_swap' else 1)
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n');row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)};summaries.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/existing-simple-preparation-summary.json').write_text(json.dumps({'scope':'historical pair expanded input/witness preparation; native state oracle, tool verdicts separate','cases':summaries},indent=2)+'\n')
if __name__=='__main__':main()
