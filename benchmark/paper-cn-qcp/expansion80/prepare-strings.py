#!/usr/bin/env python3
"""Prepare signed-byte strings, original ghost lengths and exact heap mutations."""
import argparse,ctypes,hashlib,importlib.util,json,random,re,subprocess,tempfile
from pathlib import Path
HERE=Path(__file__).resolve().parent
s=importlib.util.spec_from_file_location('scalar_preparation',HERE/'prepare-scalar.py');scalar=importlib.util.module_from_spec(s);s.loader.exec_module(scalar)
CASES={
 'cav_string_first_char':('string_first_char',['s'],'char',['n'],('return == S[0]','return == S[0] + 1'),('__return == l[0]','__return == l[0] + 1'),('return s[0];','return s[1];')),
 'cav_string_last_char':('string_last_char',['s'],'char',['n'],('return == S[n-1]','return == S[n-1] + 1'),('__return == l[n - 1]','__return == l[n - 1] + 1'),('return s[i];','return s[0];')),
 'cav_string_length':('algo_string_length',['s'],'int',['n'],('return == n;','return == n + 1;'),('__return == n &&','__return == n + 1 &&'),('return i;','return i + 1;')),
 'cav_string_equal':('string_equal',['a','b'],'int',['na','nb'],('return == 1 && na == nb','return == 0 && na == nb'),('__return == 1 &&','__return == 0 &&'),('return 0;','return 1;')),
 'cav_string_to_upper_ascii':('string_to_upper_ascii',['s'],'void',['n'],('B[i] == A[i] - 32','B[i] == A[i] - 31'),('Znth(i, lr, 0) == Znth(i, l, 0) - 32','Znth(i, lr, 0) == Znth(i, l, 0) - 31'),('s[i] = s[i] - 32;','s[i] = s[i] - 31;')),
 'cav_string_reverse_copy':('string_reverse_copy',['n','src','dst'],'void',[],('D2[i] == S[n-1-i]','D2[i] == S[i]'),('app(rev(l), cons(0, nil))','app(l, cons(0, nil))'),('dst[n] = 0;','dst[n] = 1;')),
}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def inputs(ident,count,seed):
 rng=random.Random(seed);seen=set();result=[];t=0
 chars=[-128,-127,-1,1,9,32,64,65,90,96,97,98,121,122,123,126,127]
 lengths=[1,2,3,4,8,16] if ident in ['cav_string_first_char','cav_string_last_char'] else [0,1,2,3,4,8,16]
 while len(result)<count:
  n=lengths[t%len(lengths)];mode=(t//len(lengths))%3
  body=([chars[(t//len(lengths))%len(chars)]]*n if mode==0 else [chars[(i+t)%len(chars)] for i in range(n)] if mode==1 else rng.choices(chars,k=n))
  values={'n':n}
  if ident=='cav_string_equal':
   category=(t//len(lengths))%4
   other=list(body)
   if category==1 and other:other[0]=next(x for x in chars if x!=other[0])
   if category==2:other=other+[rng.choice(chars)]
   if category==3 and other:other[-1]=next(x for x in chars if x!=other[-1])
   arrays={'a':body+[0],'b':other+[0]};values={'na':n,'nb':len(other),'la':body,'lb':other}
  elif ident=='cav_string_reverse_copy':
   arrays={'src':body+[0],'dst':[rng.randint(-128,127) for _ in range(n+1)]};values.update({'l':body,'d':arrays['dst']})
  else:arrays={'s':body+[0]};values['l']=body
  key=json.dumps([arrays,values],sort_keys=True)
  if key not in seen:seen.add(key);result.append((arrays,values))
  t+=1
  if t>100000:raise ValueError('String generation exhausted')
 return result

def model(ident,arrays,values):
 final={p:list(v) for p,v in arrays.items()};ret=None
 if ident=='cav_string_first_char':ret=arrays['s'][0]
 elif ident=='cav_string_last_char':ret=arrays['s'][-2]
 elif ident=='cav_string_length':ret=len(arrays['s'])-1
 elif ident=='cav_string_equal':ret=int(arrays['a']==arrays['b'])
 elif ident=='cav_string_to_upper_ascii':final['s']=[v-32 if 97<=v<=122 else v for v in arrays['s']]
 elif ident=='cav_string_reverse_copy':final['dst']=list(reversed(arrays['src'][:-1]))+[0]
 else:raise ValueError(ident)
 return ret,final

def spec_holds(ident,arrays,values,ret,final):
 if ident=='cav_string_first_char':return ret==arrays['s'][0]+1
 if ident=='cav_string_last_char':return ret==arrays['s'][-2]+1
 if ident=='cav_string_length':return ret==values['n']+1
 if ident=='cav_string_equal':return arrays['a']!=arrays['b']
 if ident=='cav_string_to_upper_ascii':return all(v==old-31 if 97<=old<=122 else v==old for old,v in zip(arrays['s'],final['s']))
 if ident=='cav_string_reverse_copy':return final['dst']==arrays['src']
 raise ValueError(ident)

def compile_native(text,folder,function,order,kind):
 src=folder/'subject.c';lib=folder/'subject.so';src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M))
 subprocess.run(['gcc','-std=c11','-O1','-Wall','-Wextra','-fsigned-char','-shared','-fPIC',str(src),'-o',str(lib)],check=True,capture_output=True)
 library=ctypes.CDLL(str(lib));fn=getattr(library,function);fn.argtypes=[ctypes.c_int if p=='n' else ctypes.POINTER(ctypes.c_byte) for p in order];fn.restype=ctypes.c_byte if kind=='char' else ctypes.c_int if kind=='int' else None
 return fn

def native(fn,order,arrays,values):
 storage={p:(ctypes.c_byte*len(v))(*v) for p,v in arrays.items()};ret=fn(*(values[p] if p=='n' else storage[p] for p in order))
 return ret,{p:list(v) for p,v in storage.items()}

def main():
 parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));parser.add_argument('--count',type=int,default=128);parser.add_argument('--seed',type=int,default=20261013);a=parser.parse_args()
 if a.count<128:parser.error('At least 128 inputs per subject')
 summaries=[]
 with tempfile.TemporaryDirectory(prefix='paired-string-oracle-') as tmp:
  for ident in a.cases:
   function,order,kind,ghosts,ce,qe,ie=CASES[ident];draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text()
   sc=scalar.edit_once(cn,ce);sq=scalar.edit_once(qcp,qe)
   # Equal has two identical return-0 statements: mutate only the mismatch branch.
   if ident=='cav_string_equal':ie=('if (a[i] != b[i]) {\n            return 0;','if (a[i] != b[i]) {\n            return 1;')
   ic=scalar.edit_code_once(cn,ie);iq=scalar.edit_code_once(qcp,ie);folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,c,q in [('reference',cn,qcp),('spec_mutation',sc,sq),('impl_mutation',ic,iq)]:
    assert scalar.body(c)==scalar.body(q);(folder/f'{variant}.cn.c').write_text(c);(folder/f'{variant}.qcp.c').write_text(q)
   assert scalar.body(cn)==scalar.body(sc)!=scalar.body(ic)
   functions=[]
   for variant,text in [('reference',cn),('impl_mutation',ic)]:
    d=Path(tmp)/ident/variant;d.mkdir(parents=True);functions.append(compile_native(text,d,function,order,kind))
   rows=[]
   for i,(arrays,values) in enumerate(inputs(ident,a.count,a.seed)):
    expected,final=model(ident,arrays,values);observed,heap=native(functions[0],order,arrays,values);mutant,mheap=native(functions[1],order,arrays,values);assert (expected,final)==(observed,heap)
    args={p:values[p] if p=='n' else 4096+4096*list(arrays).index(p) for p in order}
    # The explicit C length of reverse-copy is an argument, not a With binder.
    logical_binds={name:value for name,value in values.items() if name not in order}
    rows.append({'id':f'input_{i:03d}','args':args,'arrays':arrays,'logical_values':values,'qcp_bind':{'id':f'input_{i:03d}','args':args,'values':logical_binds},'expected_return':expected,'expected_heap':final,'native_reference_return':observed,'native_reference_heap':heap,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':not spec_holds(ident,arrays,values,observed,heap),'impl_mutation_violated':(mutant,mheap)!=(expected,final)})
   for mutation in ['spec','impl']:assert any(x[mutation+'_mutation_violated'] for x in rows)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'parameter_order':order,'return_kind':kind,'element_c_type':'char','native_c_flags':['-fsigned-char'],'heap_shape':'null_terminated_strings','cn_ghost_parameters':ghosts,'seed':a.seed,'input_count':len(rows),'domain_complete':False,'admission':'Signed char -128..127, nonzero body followed by owned terminator; exact logical lengths, disjoint full source/destination blocks. First/last nonempty; others admit empty strings. Destination for reverse is an arbitrary initialized buffer.','review_scope':'CN each-owned character maps correspond to QCP CharArray.full over body appended with terminator; logical lengths passed as CN ghost inputs where absent from the C signature','reviewed_cn_sha256':sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':sha(draft/'subject.qcp.c'),'generator_path':'prepare-strings.py','generator_sha256':sha(Path(__file__)),'tool_runs_checked':False,'native_abi':'signed 8-bit char; independent returned/final-byte model; paired native32/native64 replay pending','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':ce,'qcp_edit':qe},'impl_mutation':{'kind':'impl','shared_c_edit':ie}},'inputs':rows,'files':{p.name:sha(p) for p in folder.glob('*.c')}}
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n');row={'id':ident,'positive_inputs':len(rows),'spec_negative_witnesses':sum(x['spec_mutation_violated'] for x in rows),'impl_negative_witnesses':sum(x['impl_mutation_violated'] for x in rows)};summaries.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/string-preparation-summary.json').write_text(json.dumps({'scope':'signed-byte native state oracles and witnessed mutations; not tool verdicts','cases':summaries},indent=2)+'\n')
if __name__=='__main__':main()
