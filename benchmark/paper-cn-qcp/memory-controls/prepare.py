#!/usr/bin/env python3
"""Deterministic memory-mechanism controls, separate from the original 80.
No LLM or random generation is used during evaluation. Cases are not claimed
as unchanged upstream CN/QCP examples or independently reviewed translations.
"""
import hashlib
import json
from pathlib import Path
HERE=Path(__file__).resolve().parent
HEADER='#include "verification_stdlib.h"\n#include "verification_list.h"\n#include "int_array_def.h"\n'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,x):p.write_text(json.dumps(x,indent=2)+'\n')
def build(ident,signature,cn,qcp,body,rows,metadata,cn_edit,qcp_edit,impl_edit,struct=''):
    folder=HERE/'suites'/ident;folder.mkdir(parents=True,exist_ok=True)
    sources={'cn':struct+signature+'\n/*@ '+cn+' @*/\n'+body+'\n', 'qcp':HEADER+struct+signature+'\n/*@ '+qcp+' */\n'+body+'\n'}
    for language,text in sources.items():
        (folder/('reference.'+language+'.c')).write_text(text)
        old,new=cn_edit if language=='cn' else qcp_edit
        assert text.count(old)==1
        (folder/('spec_mutation.'+language+'.c')).write_text(text.replace(old,new))
        old,new=impl_edit;assert text.count(old)==1
        (folder/('impl_mutation.'+language+'.c')).write_text(text.replace(old,new))
    for index,row in enumerate(rows):
        row['id']=f'input_{index:03d}'
        row['qcp_bind']={'id':row['id'],'args':row['args'],'values':row.pop('logical')}
        row['expected_return']=None
    suite={'schema':'tespec-paired-input-suite/v1','id':ident,'function':ident,'input_count':len(rows),'inputs':rows,'memory_control':True,'domain_complete':False,'return_kind':'void','origin':'new synthetic memory mechanism control, outside original expansion80','generator_path':'prepare.py','generator_sha256':sha(Path(__file__)),'variants':{'reference':{'kind':'reference'},'spec_mutation':{'kind':'spec','cn_edit':cn_edit,'qcp_edit':qcp_edit},'impl_mutation':{'kind':'impl','shared_c_edit':impl_edit}},**metadata,'files':{p.name:sha(p) for p in sorted(folder.glob('*.c'))}}
    save(folder/'suite.json',suite)
    return {'id':ident,'inputs':len(rows),'suite_sha256':sha(folder/'suite.json'),'path':'suites/'+ident}

def main():
    catalog=[]
    rows=[]
    for r in range(5):
      for c in range(5):
       for v in (-7,0,9,37,81,99):
        a=[(i%7)-3 for i in range(r*c)]
        rows.append({'args':{'a':4096,'rows':r,'cols':c,'value':v},'arrays':{'a':a},'logical':{'l':a},'expected_heap':{'a':[v]*(r*c)},'spec_mutation_violated':r*c>0,'impl_mutation_violated':r*c>0 and v!=0})
    # Keep every shape (including empty dimensions), then freeze 128 rows.
    rows=rows[::2]+rows[1::2][:53]
    cn='requires 0 <= rows; rows <= 4; 0 <= cols; cols <= 4; take A = each(integer i; 0 <= i && i < rows*cols) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < rows*cols) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < rows*cols) {B[i] == value};'
    qcp='With (l : list Z) Require 0 <= rows && rows <= 4 && 0 <= cols && cols <= 4 && Zlength(l) == rows*cols && IntArray::full(a,rows*cols,l) Ensure IntArray::full(a,rows*cols,repeat_Z(value,rows*cols))'
    catalog.append(build('flat_matrix_fill','void flat_matrix_fill(int *a, int rows, int cols, int value)',cn,qcp,'{ int r; int c; for (r=0; r<rows; r++) { for (c=0; c<cols; c++) { a[r*cols+c] = value; } } }',rows,{'parameter_order':['a','rows','cols','value'],'pointer_lists':{'a':'l'},'memory_class':'row-major contiguous matrix; nested loops','admission':'0<=rows,cols<=4; logical list has rows*cols int cells'},('B[i] == value','B[i] == value + 1'),('repeat_Z(value,rows*cols)','repeat_Z(value + 1,rows*cols)'),('a[r*cols+c] = value;','a[r*cols+c] = 0;')))
    rows=[]
    for n in range(1,17):
     for k in sorted(set((0,n//2,n-1))):
      for v in (-7,0,9):
       a=[i-4 for i in range(n)];out=a.copy();out[k]=v
       rows.append({'args':{'a':4096,'cursor':4096+4*k,'n':n,'k':k,'value':v},'arrays':{'a':a},'logical':{'l':a},'expected_heap':{'a':out},'spec_mutation_violated':True,'impl_mutation_violated':v!=0})
    rows=rows[:127]+[rows[-1]]
    cn='requires 1 <= n; n <= 16; 0 <= k; k < n; cursor == array_shift<int>(a,k); take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < n) {B[i] == (i == k ? value : A[i])};'
    qcp='With (l : list Z) Require 1 <= n && n <= 16 && 0 <= k && k < n && cursor == a + k && Zlength(l) == n && IntArray::full(a,n,l) Ensure IntArray::full(a,n,replace_Znth(k,value,l))'
    catalog.append(build('interior_store','void interior_store(int *a, int *cursor, int n, int k, int value)',cn,qcp,'{ *cursor = value; }',rows,{'parameter_order':['a','cursor','n','k','value'],'pointer_lists':{'a':'l'},'pointer_offsets':{'cursor':{'base':'a','index_arg':'k'}},'memory_class':'interior pointer alias into one owned array','admission':'1<=n<=16; 0<=k<n; cursor=a+4*k bytes under int32 layout, no second ownership block'},('i == k ? value : A[i]','i == k ? value + 1 : A[i]'),('replace_Znth(k,value,l)','replace_Znth(k,value + 1,l)'),('*cursor = value;','*cursor = 0;')))
    rows=[]
    for index in range(128):
     old=index-64;v=(-7,0,9,37)[index%4]
     rows.append({'args':{'box':4096,'target':8192,'value':v},'cells':{'target':old},'logical':{'old':old},'expected_heap':{'target':v},'spec_mutation_violated':True,'impl_mutation_violated':v!=0})
    cn='requires take B = RW<struct pointer_box>(box); B.ptr == target; take T = RW<int>(target); ensures take B2 = RW<struct pointer_box>(box); B2 == B; take T2 = RW<int>(target); T2 == value;'
    qcp='With (old : Z) Require data_at(&(box->ptr), int *, target) * data_at(target, int, old) Ensure data_at(&(box->ptr), int *, target) * data_at(target, int, value)'
    catalog.append(build('pointer_box_store','void pointer_box_store(struct pointer_box *box, int *target, int value)',cn,qcp,'{ *(box->ptr) = value; }',rows,{'parameter_order':['box','target','value'],'cell_logical_values':{'target':'old'},'pointer_boxes':{'box':'target'},'memory_class':'struct with pointer field to separately owned cell','admission':'box and target own disjoint aligned storage; box.ptr equals the input target address'},('T2 == value;','T2 == value + 1;'),('data_at(target, int, value)','data_at(target, int, value + 1)'),('*(box->ptr) = value;','*(box->ptr) = 0;'),struct='struct pointer_box { int *ptr; };\n'))
    save(HERE/'catalog.json',{'schema':'tespec-memory-controls/v1','scope':'supplemental controls, not part of original 80; equivalence admission pending independent review','programs':catalog,'input_count':sum(c['inputs'] for c in catalog)})
    print(json.dumps(catalog))
if __name__=='__main__':main()
