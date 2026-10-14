#!/usr/bin/env python3
"""Prepare further paired scalar subjects with independent contract witnesses."""
import argparse
import ctypes
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile

HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('scalar_helpers',HERE/'prepare-scalar.py')
helpers=importlib.util.module_from_spec(spec);spec.loader.exec_module(helpers)
MIN,MAX=helpers.MIN,helpers.MAX
U32=2**32-1
# Models describe the original execution. Mutation verdicts use the actual
# postcondition, which may deliberately be weaker than exact output equality.
CASES={
 'cn_add_1':('add',['x','y'],[(MIN,MAX)]*2,lambda x,y:MIN<=x+y<=MAX,lambda x,y:x+y,
 ('return == Sum','return == Sum + 1'),('__return == x + y','__return == x + y + 1'),('return x+y;','return x;'),lambda r,x,y:r==x+y+1,lambda r,x,y:r==x+y,'int'),
 'qcp_simple_arith_add':('add',['x','y'],[(0,100)]*2,lambda *v:True,lambda x,y:x+y,
 ('return == x + y','return == x + y + 1'),('__return == x + y','__return == x + y + 1'),('z = x + y;','z = x;'),lambda r,x,y:r==x+y+1,lambda r,x,y:r==x+y,'int'),
 'cav_add_two':('add_two',['a','b'],[(MIN,MAX)]*2,lambda a,b:MIN<=a+b<=MAX,lambda a,b:a+b,
 ('return == a + b','return == a + b + 1'),('__return == a@pre + b@pre','__return == a@pre + b@pre + 1'),('return a + b;','return a;'),lambda r,a,b:r==a+b+1,lambda r,a,b:r==a+b,'int'),
 'qcp_simple_arith_max3':('max3',['x','y','z'],[(MIN,MAX)]*3,lambda *v:True,lambda *v:max(v),
 ('return >= x','return > x'),('__return >= x','__return > x'),('return z;', 'return x;'),lambda r,x,y,z:r>x and r>=y and r>=z,lambda r,x,y,z:r>=x and r>=y and r>=z,'int'),
 'qcp_branch_destruct':('example',['x','y'],[(MIN,49),(MIN,MAX)],lambda *v:True,lambda x,y:int(x==y),
 ('return == 1','return == 0'),('__return == 1','__return == 0'),('return x == y;','return x != y;'),lambda r,x,y:(x==y and r==0) or (x!=y and r==0),lambda r,x,y:r==int(x==y),'int'),
 'cav_sum_to_n':('sum_to_n',['n'],[(0,65535)],lambda *v:True,lambda n:n*(n+1)//2,
 ('return == n * (n + 1) / 2','return == n * (n + 1) / 2 + 1'),('__return == n@pre * (n@pre + 1) / 2','__return == n@pre * (n@pre + 1) / 2 + 1'),('ret += i;','ret += i - 1;'),lambda r,n:r==n*(n+1)//2+1,lambda r,n:r==n*(n+1)//2,'int'),
 'cn_between':('between',['p','q'],[(0,U32)]*2,lambda p,q:p<=q,lambda p,q:q,
 ('return >= p','return > p'),('__return >= p','__return > p'),('return q;','return 0;'),lambda r,p,q:p<r<=q,lambda r,p,q:p<=r<=q,'unsigned int'),
 'cn_slf2_basic_quadruple':('quadruple',['n'],[(0,U32//4)],lambda *v:True,lambda n:4*n,
 ('return == 4 * n','return == 4 * n + 1'),('__return == 4 * n','__return == 4 * n + 1'),('return m + m;','return m;'),lambda r,n:r==4*n+1,lambda r,n:r==4*n,'unsigned int'),
}

def native(source,path,function,arity,c_type):
 fn=helpers.native_library(source,path,function,arity)
 typ=ctypes.c_uint if c_type=='unsigned int' else ctypes.c_int
 fn.argtypes=[typ]*arity;fn.restype=typ
 return fn

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES))
 parser.add_argument('--count',type=int,default=128)
 parser.add_argument('--seed',type=int,default=20261013)
 args=parser.parse_args()
 if args.count<128:parser.error('At least 128 distinct admitted inputs required')
 summaries=[]
 with tempfile.TemporaryDirectory(prefix='more-scalar-native-') as tmp:
  for ident in args.cases:
   function,names,ranges,admit,model,cn_edit,qcp_edit,impl_edit,spec_holds,original_holds,c_type=CASES[ident]
   draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text()
   assert helpers.body(cn)==helpers.body(qcp),ident
   # max3 has two executable return-z sites. Both are the same mutation.
   def mutate(code):
    if ident!='qcp_simple_arith_max3':return helpers.edit_code_once(code,impl_edit)
    import re
    parts=re.split(r'(/\*.*?\*/|//[^\n]*)',code,flags=re.S)
    assert sum(x.count(impl_edit[0]) for x in parts[::2])==2
    for i in range(0,len(parts),2):parts[i]=parts[i].replace(*impl_edit)
    return ''.join(parts)
   variants={'reference':(cn,qcp),'spec_mutation':(helpers.edit_once(cn,cn_edit),helpers.edit_once(qcp,qcp_edit)),'impl_mutation':(mutate(cn),mutate(qcp))}
   folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,(c,q) in variants.items():
    assert helpers.body(c)==helpers.body(q)
    (folder/f'{variant}.cn.c').write_text(c);(folder/f'{variant}.qcp.c').write_text(q)
   assert helpers.body(variants['spec_mutation'][0])==helpers.body(cn)
   assert helpers.body(variants['impl_mutation'][0])!=helpers.body(cn)
   reference=native(cn,Path(tmp)/f'{ident}-ref.so',function,len(names),c_type)
   mutant=native(variants['impl_mutation'][0],Path(tmp)/f'{ident}-mut.so',function,len(names),c_type)
   inputs=[]
   for i,values in enumerate(helpers.samples(ranges,admit,args.count,args.seed)):
    expected=model(*values);observed=reference(*values);actual=mutant(*values)
    assert expected==observed and original_holds(observed,*values),(ident,values,expected,observed)
    input_id=f'input_{i:03d}';arguments=dict(zip(names,values))
    inputs.append({'id':input_id,'args':arguments,'qcp_bind':{'id':input_id,'args':arguments,'values':{}},'expected_return':expected,'native_reference_return':observed,'native_mutant_return':actual,'spec_mutation_violated':not spec_holds(observed,*values),'impl_mutation_violated':not original_holds(actual,*values)})
   for kind in ['spec','impl']:assert any(v[f'{kind}_mutation_violated'] for v in inputs),(ident,kind)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':function,'seed':args.seed,'input_count':len(inputs),'domain_ranges':dict(zip(names,ranges)),'domain_complete':len(inputs)<args.count,'element_c_type':c_type,'parameter_order':names,'admission':'Recorded machine-integer ranges and original precondition; mathematical sum bound for signed additions and triangular sum; quadruple bounded by UINT_MAX','review_scope':'Matched scalar contract formulas; native exact-output control and independent actual-postcondition witnesses for weak contracts','reviewed_cn_sha256':helpers.sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':helpers.sha(draft/'subject.qcp.c'),'generator_path':Path(__file__).name,'generator_sha256':helpers.sha(Path(__file__)),'generator_dependencies':{'prepare-scalar.py':helpers.sha(HERE/'prepare-scalar.py')},'tool_runs_checked':False,'native_abi':'host int32/uint32 control; two ABI replay recorded separately','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':cn_edit,'qcp_edit':qcp_edit},'impl_mutation':{'kind':'impl','shared_c_edit':impl_edit}},'inputs':inputs,'files':{p.name:helpers.sha(p) for p in sorted(folder.glob('*.c'))}}
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n')
   summary={'id':ident,'positive_inputs':len(inputs),'spec_negative_witnesses':sum(v['spec_mutation_violated'] for v in inputs),'impl_negative_witnesses':sum(v['impl_mutation_violated'] for v in inputs)}
   summaries.append(summary);print(json.dumps(summary),flush=True)
 (HERE/'suites/more-scalar-preparation-summary.json').write_text(json.dumps({'scope':'independent input and actual-postcondition mutation witnesses; tool verdicts separate','cases':summaries},indent=2)+'\n')
if __name__=='__main__':main()
