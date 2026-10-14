#!/usr/bin/env python3
"""Freeze original local QCP examples, their original specs, and explicit binds.
No CN admission is inferred from a QCP replay. Mutation expectations describe
the original contract, not a stronger intended problem statement.
"""
import hashlib
import json
from pathlib import Path
import sys
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
sys.path.insert(0,str(ROOT))
from spectest.core import _find_function_spec, analyze_source
QCP=ROOT/'runtime/qcip/QCP_examples'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,v):p.write_text(json.dumps(v,indent=2,ensure_ascii=False)+'\n')
def row(args,values,impl_violated,**extra):return {'args':args,'values':values,'impl_mutation_violated':impl_violated,**extra}
def main():
    matrices=[[],[[1]],[[0,1],[1,0]],[[1,1,0],[0,1,1]]]
    cases=[]
    for ident,file,function,predicate,body_old,body_new in [
      ('qcp_original_matrix_flat','QCP_demos_LLM/2DIntArray.c','max_fill_array2','IntArray2::full(grid, grid_rows, grid_cols, rows)','return out;','if (grid_rows > 0 && grid_cols > 0) grid[0] = 0; return out;'),
      ('qcp_original_matrix_pointers','QCP_demos_LLM/2DIntPtrArray.c','max_fill','IntPtrArray2::full(grid, grid_rows, rows)','return out;','if (grid_rows > 0 && grid_cols > 0) grid[0][0] = 0; return out;')]:
        inputs=[row({'grid':4096,'grid_rows':len(m),'grid_cols':len(m[0]) if m else 0,'capacity':2},{'rows':{'type':'list (list Z)','value':m}},bool(m and m[0][0]!=0)) for m in matrices]
        cases.append(dict(id=ident,source=file,function=function,memory='contiguous 2D int matrix' if 'flat' in ident else 'int** pointer table and separate row arrays',heap_predicate=predicate,inputs=inputs,spec_edit=(predicate,'__return == -1 && '+predicate),impl_edit=(body_old,body_new)))
    strings=[[],[[97,0]],[[97,98,0],[66,0]],[[0],[120,121,0]]]
    cases.append(dict(id='qcp_original_string_table',source='QCP_demos_LLM/2DCharPtrArray.c',function='check_dict_case',memory='const char** table with separately owned null-terminated strings',heap_predicate='CharPtrArray2::full(keys, dict_size, rows)',inputs=[row({'keys':4096,'dict_size':len(m)},{'rows':{'type':'list (list Z)','value':m}},bool(m)) for m in strings],spec_edit=('CharPtrArray2::full(keys, dict_size, rows)','__return == -1 && CharPtrArray2::full(keys, dict_size, rows)'),impl_edit=('int islower=0,isupper=0;','int islower=0,isupper=0; if (dict_size > 0) keys[0] = 0;')))
    for ident,file,memory,edit in [
      ('qcp_original_dll_queue','dll_queue.c','queue head/tail plus doubly linked nodes',('return x0;','return x0 + 1;')),
      ('qcp_original_functional_queue','functional_queue.c','queue represented by two singly linked lists and reversal',('return pop(&(q -> l1));','return pop(&(q -> l1)) + 1;'))]:
        cases.append(dict(id=ident,source='QCP_demos_human/'+file,function='dequeue',memory=memory,heap_predicate='store_queue(q, cons(x, l))',inputs=[row({'q':4096},{'x':x,'l':tail},True) for x,tail in [(0,[]),(3,[4]),(-2,[0,7]),(9,[1,2,3])]],spec_edit=('__return == x &&','__return == x + 1 &&'),impl_edit=edit,limitations=['Original free_list_cell has no C body; retain missing-body outcome.', 'Logical queue sequence is fixed; representation existential choices remain exactly as in store_queue.'] ))
    trees=[('empty',2,20),('make_tree(empty,2,10,empty)',2,20),('make_tree(empty,2,10,empty)',1,30),('make_tree(make_tree(empty,1,11,empty),2,22,empty)',1,33)]
    cases.append(dict(id='qcp_original_bst_insert',source='QCP_demos_human/bst_insert.c',function='insert',spec='low_level_spec',memory='binary tree reached through struct tree** root cell',heap_predicate='store_tree(*b,tr)',inputs=[row({'b':4096,'x':x,'value':v},{'tr':{'type':'tree','qcp':t}},True) for t,x,v in trees],spec_edit=('store_tree(* b, tree_insert(x, value, tr))','store_tree(* b, tree_insert(x, value + 1, tr))'),impl_edit=('p->value = value;','p->value = value + 1;'),limitations=['New-key cases call original declaration-only allocator; no invented allocator body.']))
    expressions=[('EConst(0)',True),('EConst(7)',True),('EVar(0)',False),('EVar(99)',False)]
    cases.append(dict(id='qcp_original_expr_union',source='QCP_demos_human/eval.c',function='eval',memory='tagged union expression nodes and an environment array',heap_predicate='store_expr(e,e0) * IntArray::full(var_value,100,l)',inputs=[row({'e':4096,'var_value':8192},{'e0':{'type':'expr','qcp':term},'l':[i-50 for i in range(100)]},violated) for term,violated in expressions],spec_edit=('__return == expr_eval(e0, l)','__return == expr_eval(e0, l) + 1'),impl_edit=('return e -> d.CONST.value;','return e -> d.CONST.value + 1;'),limitations=['Initial cases exercise CONST and VAR union arms; recursive operator constructors still need bindings.']))
    catalog=[]
    for c in cases:
        folder=HERE/'cases'/c['id'];folder.mkdir(parents=True,exist_ok=True)
        origin=QCP/c['source'];text=origin.read_text();(folder/'reference.qcp.c').write_bytes(origin.read_bytes())
        candidate=_find_function_spec(text,c['function'],c.get('spec'))
        contract=text[candidate.start:candidate.end]
        ensure=contract.index('Ensure');before=contract[:ensure];after=contract[ensure:]
        old,new=c['spec_edit'];assert after.count(old)==1,(c['id'],old)
        mutated=text[:candidate.start]+before+after.replace(old,new)+text[candidate.end:]
        (folder/'spec_mutation.qcp.c').write_text(mutated)
        old,new=c['impl_edit'];assert text.count(old)>=1
        (folder/'impl_mutation.qcp.c').write_text(text.replace(old,new))
        bindings=[];expectations=[]
        for index,r in enumerate(c.pop('inputs')):
            ident=f'input_{index:03d}';bindings.append({'id':ident,'args':r['args'],'values':r['values']})
            expectations.append({'id':ident,'reference':'PASS','spec_mutation':'FAIL','impl_mutation':'FAIL' if r['impl_mutation_violated'] else 'PASS','basis':'manual evaluation of original contract and selected edit; no native/independent CN admission claimed'})
        save(folder/'binds.json',bindings)
        metadata={**c,'schema':'tespec-original-qcp-case/v1','source':str(origin.relative_to(ROOT)),'source_sha256':sha(origin),'input_count':len(bindings),'original_contract_preserved':True,'cn_status':'translation_pending','input_admission':'fixed logical values and entry args; runtime SAT/proof status recorded separately','expectations':expectations,'include_dirs':list(dict.fromkeys([str(origin.parent.relative_to(ROOT)),'runtime/qcip/QCP_examples/QCP_demos_human','runtime/qcip/QCP_examples/QCP_demos_LLM','runtime/qcip/QCP_examples/stdlib'])),'generator_sha256':sha(Path(__file__)),'files':{f.name:sha(f) for f in folder.iterdir() if f.name in ['reference.qcp.c','spec_mutation.qcp.c','impl_mutation.qcp.c','binds.json']}}
        save(folder/'case.json',metadata);catalog.append({'id':c['id'],'memory':c['memory'],'heap_predicate':c['heap_predicate'],'path':'cases/'+c['id'],'inputs':len(bindings),'cn_status':'translation_pending'})
    candidates=[{'source':'QCP_demos_human/bst_fp_insert.c','memory':'tree with father pointers','pending':'bst_fp_def.h does not declare empty constructor; typed tree fixture environment must be resolved without altering Require'}, {'source':'QCP_demos_human/poly_sll.c','memory':'polymorphic list with separately owned payloads','pending':'instantiate type A and higher-order storeA using declared predicates'}, {'source':'Applications_human/LiteOS/LOS_ListEmpty.c','memory':'circular intrusive doubly linked list with sentinel','pending':'instantiate list(DL_Node A), node addresses and payload predicate'}, {'source':'QCP_demos_human/avl_insert.c','memory':'AVL rotations with node heights','pending':'shape-only store_non_empty_tree does not bind a finite tree; do not pretend fixing root address fixes every node'}]
    save(HERE/'catalog.json',{'schema':'tespec-original-qcp-expansion/v1','origin':'byte-identical reference copies from bundled QCP_examples','paired_cn_count':0,'prepared_qcp_subjects':len(catalog),'fixed_bindings':sum(c['inputs'] for c in catalog),'programs':catalog,'next_candidates':candidates,'scope':'separate QCP native-example track; not yet included in admitted CN/QCP comparison denominator'})
    print(json.dumps(catalog,ensure_ascii=False))
if __name__=='__main__':main()
