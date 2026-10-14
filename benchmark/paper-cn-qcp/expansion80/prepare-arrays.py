#!/usr/bin/env python3
"""Freeze matched array inputs, native heap oracles and witnessed mutations."""
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

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('scalar_preparation', HERE/'prepare-scalar.py')
scalar = importlib.util.module_from_spec(spec); spec.loader.exec_module(scalar)
MIN, MAX = -(2**31), 2**31-1
# parameter order, pointer/logical-list pairs, return kind, two matched spec edits,
# and a shared executable mutation. Native functional models below are separate.
CASES = {
 'cav_array_first': (['n','a'], {'a':'l'}, 'int',
  ('return == A[0]', 'return == A[0] + 1'), ('__return == l[0]', '__return == l[0] + 1'),
  ('return a[0];', 'return a[n - 1];')),
 'cav_array_last': (['n','a'], {'a':'l'}, 'int',
  ('return == A[n-1]', 'return == A[n-1] + 1'), ('__return == l[n@pre - 1]', '__return == l[n@pre - 1] + 1'),
  ('return a[n - 1];', 'return a[0];')),
 'cav_array_fill_value': (['n','k','a'], {'a':'l'}, 'void',
  ('B[i] == k', 'B[i] == k + 1'), ('lr[i] == k', 'lr[i] == k + 1'),
  ('a[i] = k;', 'a[i] = 0;')),
 'cav_array_increment': (['n','a'], {'a':'l'}, 'void',
  ('B[i] == A[i] + 1', 'B[i] == A[i] + 2'), ('lr[i] == l[i] + 1', 'lr[i] == l[i] + 2'),
  ('a[i] = a[i] + 1;', 'a[i] = a[i];')),
 'cav_array_negate': (['n','a','out'], {'a':'la','out':'lo'}, 'void',
  ('O2[i] == -A[i]', 'O2[i] == -A[i] + 1'), ('lr[i] == -la[i]', 'lr[i] == -la[i] + 1'),
  ('out[i] = -a[i];', 'out[i] = a[i];')),
 'cav_copy_array': (['n','src','dst'], {'src':'ls','dst':'ld'}, 'void',
  ('V2 == U', 'V2 == V'), ('IntArray::full(dst, n, ls)', 'IntArray::full(dst, n, ld)'),
  ('dst[i] = src[i];', 'dst[i] = 0;')),
 'cav_reverse_copy': (['n','src','dst'], {'src':'ls','dst':'ld'}, 'void',
  ('V2[i] == U[n-1-i]', 'V2[i] == U[i]'), ('rev(ls)', 'ls'),
  ('dst[i] = src[n - 1 - i];', 'dst[i] = 0;')),
 'cav_rotate_left_by_one': (['n','a'], {'a':'l'}, 'void',
  ('B[n-1] == A[0]', 'B[n-1] == A[0] + 1'), ('lr[i] == l[0]', 'lr[i] == l[0] + 1'),
  ('a[n - 1] = first;', 'a[n - 1] = 0;')),
}

def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()

def model(ident, arrays, args):
    final={k:list(v) for k,v in arrays.items()}; ret=None
    if ident=='cav_array_first': ret=arrays['a'][0]
    elif ident=='cav_array_last': ret=arrays['a'][-1]
    elif ident=='cav_array_fill_value': final['a']=[args['k']]*args['n']
    elif ident=='cav_array_increment': final['a']=[v+1 for v in arrays['a']]
    elif ident=='cav_array_negate': final['out']=[-v for v in arrays['a']]
    elif ident=='cav_copy_array': final['dst']=list(arrays['src'])
    elif ident=='cav_reverse_copy': final['dst']=list(reversed(arrays['src']))
    elif ident=='cav_rotate_left_by_one': final['a']=arrays['a'][1:]+arrays['a'][:1]
    else: raise ValueError(ident)
    return ret,final

def spec_holds(ident, arrays, args, ret, final):
    if ident=='cav_array_first': return ret==arrays['a'][0]+1
    if ident=='cav_array_last': return ret==arrays['a'][-1]+1
    if ident=='cav_array_fill_value': return all(v==args['k']+1 for v in final['a'])
    if ident=='cav_array_increment': return all(v==old+2 for v,old in zip(final['a'],arrays['a']))
    if ident=='cav_array_negate': return all(v==-old+1 for v,old in zip(final['out'],arrays['a']))
    if ident=='cav_copy_array': return final['dst']==arrays['dst']
    if ident=='cav_reverse_copy': return final['dst']==arrays['src']
    if ident=='cav_rotate_left_by_one': return final['a'][-1]==arrays['a'][0]+1
    raise ValueError(ident)

def generate(ident,pointers,count,seed):
    rng=random.Random(seed); seen=set(); rows=[]
    nonempty=ident in {'cav_array_first','cav_array_last','cav_rotate_left_by_one'}
    values=[MIN,MIN+1,-100,-2,-1,0,1,2,100,MAX-1,MAX]
    if ident=='cav_array_increment': values.remove(MAX)
    if ident=='cav_array_negate': values.remove(MIN)
    trials=0
    while len(rows)<count:
        n=([1,2,3,4,8,16] if nonempty else [0,1,2,3,4,8,16])[trials%(6 if nonempty else 7)]
        arrays={}
        for i,pointer in enumerate(pointers):
            # Uniform, repeated, alternating, ordered and arbitrary shapes.
            mode=(trials//7+i)%5
            if mode==0: data=[values[(trials//35+i)%len(values)]]*n
            elif mode==1: data=[0]*n
            elif mode==2: data=[values[(j+trials+i)%len(values)] for j in range(n)]
            elif mode==3: data=sorted(rng.choices(values,k=n))
            else: data=[rng.randint(MIN+(ident=='cav_array_negate'),MAX-(ident=='cav_array_increment')) for _ in range(n)]
            arrays[pointer]=data
        args={'n':n}
        if ident=='cav_array_fill_value':args['k']=values[trials%len(values)] if trials%2==0 else rng.randint(MIN,MAX)
        key=json.dumps([args,arrays],sort_keys=True)
        if key not in seen: seen.add(key);rows.append((args,arrays))
        trials+=1
        if trials>100000:raise ValueError('Input generation exhausted')
    return rows

def native_library(source,folder,ident,order,pointers,kind):
    src=folder/(ident+'.c'); lib=folder/(ident+'.so')
    src.write_text(re.sub(r'^\s*#include[^\n]*','',source,flags=re.M))
    subprocess.run(['gcc','-std=c11','-O1','-Wall','-Wextra','-shared','-fPIC',str(src),'-o',str(lib)],check=True,capture_output=True)
    library=ctypes.CDLL(str(lib));fn=getattr(library,ident.removeprefix('cav_'))
    fn.argtypes=[ctypes.POINTER(ctypes.c_int) if p in pointers else ctypes.c_int for p in order]
    fn.restype=ctypes.c_int if kind=='int' else None
    return fn

def run_native(fn,order,args,arrays):
    storage={p:(ctypes.c_int*max(1,len(v)))(*(v or [0])) for p,v in arrays.items()}
    ret=fn(*(storage[p] if p in storage else args[p] for p in order))
    final={p:list(storage[p])[:len(v)] for p,v in arrays.items()}
    return ret,final

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES))
    parser.add_argument('--count',type=int,default=128)
    parser.add_argument('--seed',type=int,default=20261013)
    a=parser.parse_args()
    if a.count<128:parser.error('At least 128 admitted inputs per subject')
    summary=[]
    with tempfile.TemporaryDirectory(prefix='paired-array-oracle-') as tmp:
        for ident in a.cases:
            order,pointers,kind,cn_edit,qcp_edit,impl_edit=CASES[ident]
            draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text()
            spec_cn=scalar.edit_once(cn,cn_edit);spec_qcp=scalar.edit_once(qcp,qcp_edit)
            impl_cn=scalar.edit_code_once(cn,impl_edit);impl_qcp=scalar.edit_code_once(qcp,impl_edit)
            folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
            for variant,c,q in [('reference',cn,qcp),('spec_mutation',spec_cn,spec_qcp),('impl_mutation',impl_cn,impl_qcp)]:
                assert scalar.body(c)==scalar.body(q)
                (folder/f'{variant}.cn.c').write_text(c);(folder/f'{variant}.qcp.c').write_text(q)
            assert scalar.body(cn)==scalar.body(spec_cn)!=scalar.body(impl_cn)
            # Keep exported function name fixed while separating shared-library files.
            native_dirs=[]
            for variant,text in [('reference',cn),('impl_mutation',impl_cn)]:
                d=Path(tmp)/ident/variant;d.mkdir(parents=True);native_dirs.append(native_library(text,d,ident,order,pointers,kind))
            inputs=[]
            for i,(args,arrays) in enumerate(generate(ident,pointers,a.count,a.seed)):
                expected,expected_heap=model(ident,arrays,args)
                observed,heap=run_native(native_dirs[0],order,args,arrays)
                actual,mut_heap=run_native(native_dirs[1],order,args,arrays)
                assert (observed,heap)==(expected,expected_heap),(ident,args,arrays)
                bind_args={p:(4096+4096*list(pointers).index(p) if p in pointers else args[p]) for p in order}
                entry={'id':f'input_{i:03d}','args':bind_args,'arrays':arrays,'qcp_bind':{'id':f'input_{i:03d}','args':bind_args,'values':{pointers[p]:v for p,v in arrays.items()}},'expected_return':expected,'expected_heap':expected_heap,'native_reference_return':observed,'native_reference_heap':heap,'native_mutant_return':actual,'native_mutant_heap':mut_heap,'spec_mutation_violated':not spec_holds(ident,arrays,args,observed,heap),'impl_mutation_violated':(actual,mut_heap)!=(expected,expected_heap)}
                inputs.append(entry)
            for kind_name in ('spec','impl'):assert any(i[kind_name+'_mutation_violated'] for i in inputs)
            suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':ident.removeprefix('cav_'),'parameter_order':order,'pointer_lists':pointers,'return_kind':kind,'seed':a.seed,'input_count':len(inputs),'domain_complete':False,'admission':'Signed int32 inputs; n equals allocated array length, distinct array blocks, increment excludes INT_MAX and negate excludes INT_MIN; first/last/rotate require n>=1','review_scope':'CN maps and QCP lists cover exactly n owned cells, disjoint for two blocks; corresponding elementwise/return conditions manually reviewed','reviewed_cn_sha256':sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':sha(draft/'subject.qcp.c'),'generator_path':'prepare-arrays.py','generator_sha256':sha(Path(__file__)),'tool_runs_checked':False,'native_abi':'host signed int32 with independent return and whole-array models; paired native32/native64 replay pending','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':cn_edit,'qcp_edit':qcp_edit},'impl_mutation':{'kind':'impl','shared_c_edit':impl_edit}},'inputs':inputs,'files':{p.name:sha(p) for p in folder.glob('*.c')}}
            (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
            row={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)}
            summary.append(row);print(json.dumps(row),flush=True)
    (HERE/'suites/array-preparation-summary.json').write_text(json.dumps({'scope':'native heap/return oracles and witnessed mutations; not CN/QCP tool verdicts','cases':summary},indent=2)+'\n')

if __name__=='__main__':main()
