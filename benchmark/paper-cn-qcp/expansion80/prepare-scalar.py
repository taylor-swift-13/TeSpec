#!/usr/bin/env python3
"""Freeze scalar paired inputs and witnessed spec/impl mutations.

Native execution validates concrete functional witnesses; CN/QCP tool verdicts
are obtained separately. Preparation never promotes a draft to a measured pair.
"""
import argparse
import ctypes
import hashlib
import itertools
import json
from pathlib import Path
import random
import re
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
MIN, MAX = -(2**31), 2**31-1

# Each tuple names parameters, independent reference model, admission predicate,
# parameter ranges, matched postcondition edits, and one C-expression mutation.
CASES = {
 'cav_max_of_two': ('max_of_two', ['a','b'], lambda a,b:max(a,b), lambda a,b:True, [(MIN,MAX)]*2,
   ('a <= return','a < return'), ('a@pre <= __return','a@pre < __return'),
   ('return a;','return b;'), lambda r,a,b:r>a),
 'cav_max_of_three': ('max_of_three', ['a','b','c'], lambda a,b,c:max(a,b,c), lambda *a:True, [(MIN,MAX)]*3,
   ('a <= return','a < return'), ('a@pre <= __return','a@pre < __return'),
   ('return m;','return a;'), lambda r,a,b,c:r>a),
 'cav_min_of_three': ('min_of_three', ['a','b','c'], lambda a,b,c:min(a,b,c), lambda *a:True, [(MIN,MAX)]*3,
   ('return <= a','return < a'), ('__return <= a@pre','__return < a@pre'),
   ('return m;','return a;'), lambda r,a,b,c:r<a),
 'cav_clamp_int': ('clamp_int', ['x','lo','hi'], lambda x,lo,hi:min(max(x,lo),hi), lambda x,lo,hi:lo<=hi, [(MIN,MAX)]*3,
   ('return == x','return == x + 1'), ('__return == x@pre','__return == x@pre + 1'),
   ('return lo;','return hi;'), lambda r,x,lo,hi: x<lo or x>hi or r==x+1),
 'cav_double_nonnegative': ('double_nonnegative', ['n'], lambda n:2*n, lambda n:True, [(0,1073741823)],
   ('return == n + n','return == n + n + 1'), ('__return == n@pre + n@pre','__return == n@pre + n@pre + 1'),
   ('return n + n;','return n;'), lambda r,n:r==2*n+1),
 'cav_ex_resistor_color_duo_value': ('ex_resistor_color_duo_value', ['first','second'], lambda first,second:10*first+second, lambda *a:True, [(0,9)]*2,
   ('return == 10 * first + second','return == 10 * first + second + 1'), ('__return == 10 * first@pre + second@pre','__return == 10 * first@pre + second@pre + 1'),
   ('return first * 10 + second;','return first + second;'), lambda r,f,s:r==10*f+s+1),
 'cav_apple_purchase_total': ('apple_purchase_total', ['count','price'], lambda c,p:c*p, lambda c,p:c*p<=MAX, [(0,MAX)]*2,
   ('return == count * price','return == count * price + 1'), ('__return == count@pre * price@pre','__return == count@pre * price@pre + 1'),
   ('return count * price;','return count;'), lambda r,c,p:r==c*p+1),
 'cav_is_even': ('is_even', ['n'], lambda n:int(n%2==0), lambda n:True, [(MIN,MAX)],
   ('n % 2 != 0 || return == 1','n % 2 != 0 || return == 0'), ('n@pre % 2 == 0 => __return == 1','n@pre % 2 == 0 => __return == 0'),
   ('return n % 2 == 0;','return n % 2 != 0;'), lambda r,n:n%2!=0),
 'cav_is_multiple': ('is_multiple', ['a','b'], lambda a,b:int(a%b==0), lambda a,b:True, [(MIN,MAX),(1,MAX)],
   ('return == 1 && mod(a,b) == 0','return == 0 && mod(a,b) == 0'), ('__return == 1 &&','__return == 0 &&'),
   ('if (a % b == 0)','if (a % b != 0)'), lambda r,a,b:a%b!=0),
 'cav_last_digit': ('last_digit', ['n'], lambda n:n%10, lambda n:True, [(0,MAX)],
   ('return == n % 10','return == n % 9'), ('__return == n@pre % 10','__return == n@pre % 9'),
   ('return n % 10;','return n % 9;'), lambda r,n:r==n%9),
 'cav_leap_year': ('leap_year', ['year'], lambda y:int(y%400==0 or y%4==0 and y%100!=0), lambda y:True, [(1,MAX)],
   ('year % 400 != 0 || return == 1','year % 400 != 0 || return == 0'), ('year@pre % 400 == 0 => __return == 1','year@pre % 400 == 0 => __return == 0'),
   ('return 1;','return 0;'), lambda r,y:y%400!=0),
 'cav_count_odds_interval': ('count_odds_interval', ['low','high'], lambda l,h:(h+1)//2-l//2, lambda l,h:l<=h, [(0,MAX)]*2,
   ('return == (high - low) / 2 + 1','return == (high - low) / 2'), ('__return == (high@pre - low@pre) / 2 + 1','__return == (high@pre - low@pre) / 2'),
   ('low % 2 == 0 && high % 2 == 0','low % 2 == 0 || high % 2 == 0'), lambda r,l,h:l%2==0 and h%2==0),
}

def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def body(text):
    text=re.sub(r'/\*.*?\*/|//[^\n]*','',text,flags=re.S)
    return re.sub(r'\s+','',re.sub(r'^\s*#include[^\n]*','',text,flags=re.M))
def cn_syntax(text):
    # CN remainder operators are named; C bodies retain C operators.
    text=re.sub(r'\b([A-Za-z_]\w*)\s*%\s*(\d+)\b',r'rem(\1, \2)',text)
    return text
def edit_once(text,edit):
    old,new=edit
    if text.count(old)!=1: raise ValueError(f'Expected one occurrence of {old!r}, found {text.count(old)}')
    return text.replace(old,new)
def edit_code_once(text,edit):
    parts=re.split(r'(/\*.*?\*/|//[^\n]*)',text,flags=re.S)
    old,new=edit
    found=sum(part.count(old) for part in parts[::2])
    if found!=1:raise ValueError(f'Expected one executable occurrence of {old!r}, found {found}')
    for i in range(0,len(parts),2):parts[i]=parts[i].replace(old,new)
    return ''.join(parts)
def samples(ranges,admit,count,seed):
    selected=set()
    edges=[]
    for lo,hi in ranges:
        edges.append(sorted({v for v in [lo,lo+1,hi-1,hi,-400,-100,-10,-2,-1,0,1,2,4,9,10,100,399,400,401,800,1600,1900,2000,2004,2100,2400] if lo<=v<=hi}))
    for values in itertools.product(*edges):
        if admit(*values): selected.add(values)
    # Retain representative boundaries within a finite budget.
    ordered=sorted(selected)
    boundary_budget=count//2
    if len(ordered)>boundary_budget:
        ordered=[ordered[i*(len(ordered)-1)//(boundary_budget-1)] for i in range(boundary_budget)]
    selected=set(ordered)
    size=1
    for lo,hi in ranges:size*=hi-lo+1
    if size<=count:
        return [v for v in itertools.product(*(range(lo,hi+1) for lo,hi in ranges)) if admit(*v)]
    rng=random.Random(seed)
    attempts=0
    while len(selected)<count:
        values=tuple(rng.randint(lo,min(hi,4096) if attempts%2 else hi) for lo,hi in ranges)
        if admit(*values):selected.add(values)
        attempts+=1
        if attempts>100000:raise ValueError('Input admission exhausted budget')
    return sorted(selected)

def native_library(source,path,function,arity):
    src=path.with_suffix('.c');src.write_text(re.sub(r'^\s*#include[^\n]*','',source,flags=re.M))
    subprocess.run(['gcc','-std=c11','-O1','-Wall','-Wextra','-shared','-fPIC',str(src),'-o',str(path)],check=True,capture_output=True,text=True)
    library=ctypes.CDLL(str(path)); fn=getattr(library,function);fn.argtypes=[ctypes.c_int]*arity;fn.restype=ctypes.c_int
    return fn

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES))
    parser.add_argument('--count',type=int,default=128)
    parser.add_argument('--seed',type=int,default=20261012)
    args=parser.parse_args()
    if args.count<128:parser.error('At least 128 inputs, except complete smaller finite domains')
    summaries=[]
    with tempfile.TemporaryDirectory(prefix='paired-scalar-native-') as tmp:
        for ident in args.cases:
            function,names,model,admit,ranges,cn_edit,qcp_edit,impl_edit,spec_holds=CASES[ident]
            cn_edit=tuple(cn_syntax(t) for t in cn_edit)
            draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text()
            assert body(cn)==body(qcp),ident
            spec_cn=edit_once(cn,cn_edit);spec_qcp=edit_once(qcp,qcp_edit)
            impl_cn=edit_code_once(cn,impl_edit);impl_qcp=edit_code_once(qcp,impl_edit)
            assert body(spec_cn)==body(cn)==body(spec_qcp)
            assert body(impl_cn)==body(impl_qcp)!=body(cn)
            folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
            for variant,c,q in [('reference',cn,qcp),('spec_mutation',spec_cn,spec_qcp),('impl_mutation',impl_cn,impl_qcp)]:
                (folder/f'{variant}.cn.c').write_text(c);(folder/f'{variant}.qcp.c').write_text(q)
            original=native_library(cn,Path(tmp)/f'{ident}-ref.so',function,len(names))
            mutant=native_library(impl_cn,Path(tmp)/f'{ident}-mut.so',function,len(names))
            inputs=[]
            for index,values in enumerate(samples(ranges,admit,args.count,args.seed)):
                expected=model(*values);observed=original(*values)
                assert expected==observed,(ident,values,expected,observed)
                actual=mutant(*values)
                inputs.append({'id':f'input_{index:03d}','args':dict(zip(names,values)),'qcp_bind':{'id':f'input_{index:03d}','args':dict(zip(names,values)),'values':{}},'expected_return':expected,'native_reference_return':observed,'native_mutant_return':actual,'spec_mutation_violated':not spec_holds(observed,*values),'impl_mutation_violated':actual!=expected})
            report={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'seed':args.seed,'input_count':len(inputs),'domain_ranges':dict(zip(names,ranges)),'domain_complete':len(inputs)<args.count,'admission':'Parameters in recorded ranges plus original source precondition; checked in generator','review_scope':'Manual equivalence of scalar pre/post contracts; concrete independent functional oracle','reviewed_cn_sha256':sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':sha(draft/'subject.qcp.c'),'generator_sha256':sha(Path(__file__)),'tool_runs_checked':False,'native_abi':'host signed int32; paired native32/native64 replay pending','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':cn_edit,'qcp_edit':qcp_edit},'impl_mutation':{'kind':'impl','shared_c_edit':impl_edit}},'inputs':inputs}
            for kind in ('spec','impl'):
                assert any(i[f'{kind}_mutation_violated'] for i in inputs),(ident,kind,'no witness')
            report['files']={p.name:sha(p) for p in sorted(folder.glob('*.c'))}
            (folder/'suite.json').write_text(json.dumps(report,indent=2)+'\n')
            summary={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(i['spec_mutation_violated'] for i in inputs),'impl_negative_witnesses':sum(i['impl_mutation_violated'] for i in inputs)}
            summaries.append(summary);print(json.dumps(summary),flush=True)
    (HERE/'suites/preparation-summary.json').write_text(json.dumps({'scope':'native-oracle-input-and-mutation-preparation; not CN/QCP tool verdicts','cases':summaries},indent=2)+'\n')

if __name__=='__main__':main()
