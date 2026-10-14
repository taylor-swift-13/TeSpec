#!/usr/bin/env python3
"""Prepare array classification/selection suites with independent Python models."""
import argparse,hashlib,importlib.util,json,random,tempfile,shutil
from pathlib import Path
HERE=Path(__file__).resolve().parent
s=importlib.util.spec_from_file_location('array_preparation',HERE/'prepare-arrays.py');arrays=importlib.util.module_from_spec(s);s.loader.exec_module(arrays)
scalar=arrays.scalar
# CN/QCP postcondition edits, shared executable edit, and minimum input length.
CASES={
 'cav_array_all_zero':(('return == 1 && AllZero','return == 0 && AllZero'),('__return == 1 &&','__return == 0 &&'),('if (a[i] != 0)','if (a[i] == 0)'),0),
 'cav_array_any_negative':(('return == 1 && AnyNegative','return == 0 && AnyNegative'),('__return == 1 &&','__return == 0 &&'),('if (a[i] < 0)','if (a[i] >= 0)'),0),
 'cav_array_all_positive':(('return == 1 && AllPositive','return == 0 && AllPositive'),('__return == 1 &&','__return == 0 &&'),('if (a[i] <= 0)','if (a[i] < 0)'),0),
 'cav_array_contains':(('return == 1 && Contains','return == 0 && Contains'),('__return == 1 &&','__return == 0 &&'),('if (a[i] == k)','if (a[i] != k)'),0),
 'cav_array_has_adjacent_equal':(('return == 1 && AdjacentEqual','return == 0 && AdjacentEqual'),('__return == 1 &&','__return == 0 &&'),('if (a[i] == a[i - 1])','if (a[i] != a[i - 1])'),0),
 'cav_is_sorted_nondecreasing':(('return == 1 && Sorted','return == 0 && Sorted'),('__return == 1 &&','__return == 0 &&'),('if (a[i] > a[i + 1])','if (a[i] >= a[i + 1])'),0),
 'cav_array_is_strictly_increasing':(('return == 1 && Strict','return == 0 && Strict'),('__return == 1 &&','__return == 0 &&'),('if (a[i - 1] >= a[i])','if (a[i - 1] > a[i])'),0),
 'cav_array_count_nonzero':(('return == Nonzero(A,n)','return == Nonzero(A,n) + 1'),('__return == array_count_nonzero_spec(l)','__return == array_count_nonzero_spec(l) + 1'),('if (a[i] != 0)','if (a[i] == 0)'),0),
 'cav_array_min':(('return == Min(A,n)','return == Min(A,n) + 1'),(('l[i] == __return','l[i] + 1 == __return'),('__return <= l[i]','__return <= l[i] + 1')),('if (a[i] < ret)','if (a[i] > ret)'),1),
 'cav_array_index_of_min':(('A[return] <= A[j]','A[return] < A[j]'),('l[__return] <= l[j]','l[__return] < l[j]'),('if (a[i] < a[idx])','if (a[i] <= a[idx])'),1),
 'cav_array_index_of_max':(('A[j] <= A[return]','A[j] < A[return]'),('l[j] <= l[__return]','l[j] < l[__return]'),('if (a[i] > a[idx])','if (a[i] >= a[idx])'),1),
 'cav_set_zero':(('B[i] == 0','B[i] == 1'),('lr[i] == 0','lr[i] == 1'),('a[i] = 0;','a[i] = 1;'),0),
}

def model(ident,data,args):
 if ident=='cav_array_all_zero':r=int(all(x==0 for x in data))
 elif ident=='cav_array_any_negative':r=int(any(x<0 for x in data))
 elif ident=='cav_array_all_positive':r=int(all(x>0 for x in data))
 elif ident=='cav_array_contains':r=int(args['k'] in data)
 elif ident=='cav_array_has_adjacent_equal':r=int(any(x==y for x,y in zip(data,data[1:])))
 elif ident=='cav_is_sorted_nondecreasing':r=int(all(x<=y for x,y in zip(data,data[1:])))
 elif ident=='cav_array_is_strictly_increasing':r=int(all(x<y for x,y in zip(data,data[1:])))
 elif ident=='cav_array_count_nonzero':r=sum(x!=0 for x in data)
 elif ident=='cav_array_min':r=min(data)
 elif ident=='cav_array_index_of_min':r=data.index(min(data))
 elif ident=='cav_array_index_of_max':r=data.index(max(data))
 elif ident=='cav_set_zero':return None,{'a':[0]*len(data)}
 else:raise ValueError(ident)
 return r,{'a':list(data)}

def spec_holds(ident,data,ret,final):
 if ident=='cav_set_zero':return all(v==1 for v in final['a'])
 if ident=='cav_array_min':return ret==min(data)+1
 if ident=='cav_array_count_nonzero':return ret==sum(v!=0 for v in data)+1
 if ident=='cav_array_index_of_min':return 0<=ret<len(data) and all(data[ret]<v for v in data) and all(v>data[ret] for v in data[:ret])
 if ident=='cav_array_index_of_max':return 0<=ret<len(data) and all(v<data[ret] for v in data) and all(v<data[ret] for v in data[:ret])
 return ret==0

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--cases',nargs='+',choices=sorted(CASES),default=sorted(CASES));p.add_argument('--count',type=int,default=128);p.add_argument('--seed',type=int,default=20261013);a=p.parse_args()
 if a.count<128:p.error('At least 128 inputs per subject')
 summary=[]
 with tempfile.TemporaryDirectory(prefix='paired-array-query-') as tmp:
  for ident in a.cases:
   ce,qe,ie,minimum=CASES[ident];draft=HERE/'paired-drafts'/ident;cn=(draft/'subject.cn.c').read_text();qcp=(draft/'subject.qcp.c').read_text();sc=scalar.edit_once(cn,ce);sq=qcp
   for edit in (qe if isinstance(qe[0],tuple) else [qe]):sq=scalar.edit_once(sq,edit)
   ic=scalar.edit_code_once(cn,ie);iq=scalar.edit_code_once(qcp,ie)
   folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
   for variant,c,q in [('reference',cn,qcp),('spec_mutation',sc,sq),('impl_mutation',ic,iq)]:
    assert scalar.body(c)==scalar.body(q);(folder/f'{variant}.cn.c').write_text(c);(folder/f'{variant}.qcp.c').write_text(q)
   assert scalar.body(cn)==scalar.body(sc)!=scalar.body(ic)
   for dependency in draft.glob('*.v'):shutil.copy2(dependency,folder/dependency.name)
   order=['n','a','k'] if ident=='cav_array_contains' else ['n','a'];kind='void' if ident=='cav_set_zero' else 'int';functions=[]
   for variant,text in [('reference',cn),('impl_mutation',ic)]:
    d=Path(tmp)/ident/variant;d.mkdir(parents=True);functions.append(arrays.native_library(text,d,ident,order,{'a':'l'},kind))
   generated=arrays.generate('cav_array_first' if minimum else ident,{'a':'l'},a.count,a.seed);rng=random.Random(a.seed);rows=[]
   for i,(args,data) in enumerate(generated):
    if ident=='cav_array_contains':args['k']=data['a'][i%len(data['a'])] if data['a'] and i%2==0 else rng.randint(-(2**31),2**31-1)
    expected,heap=model(ident,data['a'],args);observed,actual=arrays.run_native(functions[0],order,args,data);mutant,mheap=arrays.run_native(functions[1],order,args,data);assert (expected,heap)==(observed,actual),(ident,data,args)
    bind={name:4096 if name=='a' else args[name] for name in order}
    rows.append({'id':f'input_{i:03d}','args':bind,'arrays':data,'qcp_bind':{'id':f'input_{i:03d}','args':bind,'values':{'l':data['a']}},'expected_return':expected,'expected_heap':heap,'native_reference_return':observed,'native_reference_heap':actual,'native_mutant_return':mutant,'native_mutant_heap':mheap,'spec_mutation_violated':not spec_holds(ident,data['a'],observed,actual),'impl_mutation_violated':(mutant,mheap)!=(expected,heap)})
   for mutation in ['spec','impl']:assert any(x[mutation+'_mutation_violated'] for x in rows),(ident,mutation)
   suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':ident.removeprefix('cav_'),'parameter_order':order,'pointer_lists':{'a':'l'},'return_kind':kind,'seed':a.seed,'input_count':len(rows),'domain_complete':False,'minimum_array_length':minimum,'admission':'Signed int32 cells, exact owned array length; nonempty min/index queries; all Boolean/count/write-zero tasks admit empty arrays','review_scope':'Exact CN recursion versus quantified QCP relations over the same owned array, including first-index tie semantics; preserved input heap except write-zero','reviewed_cn_sha256':arrays.sha(draft/'subject.cn.c'),'reviewed_qcp_sha256':arrays.sha(draft/'subject.qcp.c'),'generator_path':'prepare-array-queries.py','generator_sha256':arrays.sha(Path(__file__)),'generator_dependencies':{name:arrays.sha(HERE/name) for name in ['prepare-arrays.py','prepare-scalar.py']},'tool_runs_checked':False,'native_abi':'host int32 independent return/whole-array model; paired native32/native64 replay pending','variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':ce,'qcp_edit':qe},'impl_mutation':{'kind':'impl','shared_c_edit':ie}},'inputs':rows,'files':{f.name:arrays.sha(f) for f in folder.glob('*.c')}}
   suite['files'].update({f.name:arrays.sha(f) for f in folder.glob('*.v')})
   (folder/'suite.json').write_text(json.dumps(suite,indent=2)+'\n');row={'id':ident,'positive_inputs':len(rows),'spec_negative_witnesses':sum(x['spec_mutation_violated'] for x in rows),'impl_negative_witnesses':sum(x['impl_mutation_violated'] for x in rows)};summary.append(row);print(json.dumps(row),flush=True)
 (HERE/'suites/array-query-preparation-summary.json').write_text(json.dumps({'scope':'independent native oracle and witnessed mutations; no CN/QCP verdicts','cases':summary},indent=2)+'\n')
if __name__=='__main__':main()
