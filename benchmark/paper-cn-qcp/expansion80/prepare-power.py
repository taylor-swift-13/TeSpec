#!/usr/bin/env python3
"""Prepare original power semantics with a kernel-checked equivalent CN contract."""
import ctypes
import importlib.util
import json
from pathlib import Path
import random
import re
import subprocess
import tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('helpers',HERE/'prepare-scalar.py')
h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
MAX=2147483647

def is_power(x,n):
    if x==1:return True
    if n==1:return False
    while x%n==0:x//=n
    return x==1

def samples():
    rows=[];seen=set()
    def add(x,n):
        if 1<=x<=MAX and 1<=n<=MAX and x*n<=MAX and (x,n) not in seen:
            seen.add((x,n));rows.append((x,n))
    for pair in [(1,1),(2,1),(MAX,1),(1,MAX),(1,MAX-1),(1,46340),(46340,46340),(MAX//2,2),(2**29,2),(2**29-1,2),(2**29+1,2)]:add(*pair)
    for n in (2,3,4,5,7,10,31,100,46340):
        x=1
        while x*n<=MAX:
            add(x,n);add(x-1,n);add(x+1,n);x*=n
    # Keep boundaries and diverse bases rather than let the first base consume the suite.
    required=rows[:11]
    rng=random.Random(20261013);remaining=rows[11:];rng.shuffle(remaining)
    rows=required+remaining[:117];seen=set(rows)
    while len(rows)<128:
        n=rng.choice([1,2,3,5,7,31,100,46340,rng.randint(1,MAX)])
        x=rng.randint(1,MAX//n)
        if (x,n) not in seen:seen.add((x,n));rows.append((x,n))
    return rows

def native(text,folder):
    src=folder/'subject.c';lib=folder/'subject.so'
    src.write_text(re.sub(r'^\s*#include[^\n]*','',text,flags=re.M))
    subprocess.run(['gcc','-std=c11','-O1','-shared','-fPIC','-Wl,-Bsymbolic',str(src),'-o',str(lib)],check=True,capture_output=True)
    fn=ctypes.CDLL(str(lib)).p076_is_simple_power
    fn.argtypes=[ctypes.c_int,ctypes.c_int];fn.restype=ctypes.c_int
    return fn

def main():
    ident='cav_simple_power';source=HERE/'contract-translations'/ident
    cn=(source/'subject.cn.c').read_text();qcp=(source/'subject.qcp.c').read_text()
    ce=('(return != 0) == (PowerSearch(x,n,1,31) != 0)', '(1-return != 0) == (PowerSearch(x,n,1,31) != 0)')
    qe=('is_simple_power_spec(x@pre,n@pre,__return)', 'is_simple_power_spec(x@pre,n@pre,1-__return)')
    ie=('if (p==x) return 1;', 'if (p==x) return 0;')
    variants={'reference':(cn,qcp),'spec_mutation':(h.edit_once(cn,ce),h.edit_once(qcp,qe)),
              'impl_mutation':(h.edit_code_once(cn,ie),h.edit_code_once(qcp,ie))}
    folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
    for variant,(c,q) in variants.items():
        assert h.body(c)==h.body(q)
        (folder/f'{variant}.cn.c').write_text(c);(folder/f'{variant}.qcp.c').write_text(q)
    (folder/'p076_is_simple_power.v').write_bytes((source/'p076_is_simple_power.v').read_bytes())
    with tempfile.TemporaryDirectory(prefix='power-native-') as tmp:
        functions=[]
        for variant in ('reference','impl_mutation'):
            d=Path(tmp)/variant;d.mkdir();functions.append(native(variants[variant][0],d))
        inputs=[]
        for i,(x,n) in enumerate(samples()):
            expected=int(is_power(x,n));observed=functions[0](x,n);mutant=functions[1](x,n)
            assert observed==expected
            name=f'input_{i:03d}';args={'x':x,'n':n}
            inputs.append({'id':name,'args':args,'qcp_bind':{'id':name,'args':args,'values':{}},
                           'expected_return':expected,'native_reference_return':observed,'native_mutant_return':mutant,
                           'spec_mutation_violated':((1-observed)!=0)!=bool(expected),
                           'impl_mutation_violated':(mutant!=0)!=bool(expected)})
    suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':'p076_is_simple_power',
           'parameter_order':['x','n'],'return_kind':'int','seed':20261013,'input_count':len(inputs),
           'domain_complete':False,'domain_ranges':{'x':[1,MAX],'n':[1,MAX]},
           'admission':'Original positive int32 x,n and x*n<=INT_MAX; includes base 1, exponent zero, largest admitted products and near-powers.',
           'review_scope':'Original unbounded QCP existential remains unchanged. CN PowerSearch/31 is mathematically equivalent on the original domain, kernel checked; independent oracle uses repeated division, not the C multiplication loop.',
           'contract_translation_receipt':'evidence/power-contract-theory-20261013/receipt.json',
           'reviewed_cn_sha256':h.sha(source/'subject.cn.c'),'reviewed_qcp_sha256':h.sha(source/'subject.qcp.c'),
           'generator_path':Path(__file__).name,'generator_sha256':h.sha(Path(__file__)),
           'generator_dependencies':{'prepare-scalar.py':h.sha(HERE/'prepare-scalar.py'),'theory/PowerSearchRewrite.v':h.sha(HERE/'theory/PowerSearchRewrite.v')},
           'tool_runs_checked':False,'native_abi':'Typed native int function oracle; separate native32/native64 controls.',
           'variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':ce,'qcp_edit':qe},'impl_mutation':{'kind':'impl','shared_c_edit':ie}},
           'inputs':inputs,'files':{p.name:h.sha(p) for p in folder.iterdir() if p.suffix in ('.c','.v')}}
    (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
    print(json.dumps({'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs),'powers':sum(i['expected_return'] for i in inputs)}))

if __name__=='__main__':main()
