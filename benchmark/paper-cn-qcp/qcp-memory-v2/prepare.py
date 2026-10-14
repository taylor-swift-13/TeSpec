#!/usr/bin/env python3
"""Original QCP memory examples. Freeze only the manually audited Pre free names."""
import hashlib,json,re,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent; ROOT=HERE.parents[2]
sys.path.insert(0,str(ROOT))
from spectest.core import _find_function_spec
QCP=ROOT/'runtime/qcip/QCP_examples'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,v):p.write_text(json.dumps(v,indent=2,ensure_ascii=False)+'\n')
def row(args,values,impl,spec=True):return {'args':args,'values':values,'impl':impl,'spec':spec}
def main():
 cases=[]
 for function,params,predicate,old,new in [
 ('array_copy1',['dest','src','n'],'IntArray::full_shape(dest, n) * IntArray::full_shape(src, n)','i < n; ++i','i <= n; ++i'),
 ('array_concat',['ret','a','n','b','m'],'IntArray::full_shape(a, n) * IntArray::full_shape(b, m) * IntArray::full_shape(ret, n + m)','i < n; ++i','i <= n; ++i'),
 ('array_swap',['a','b','n'],'IntArray::full_shape(a, n) * IntArray::full_shape(b, n)','i < n; ++i','i <= n; ++i'),
 ('array_vector_sum',['ret','a','b','n'],'UIntArray::full_shape(a, n) * UIntArray::full_shape(b, n) * UIntArray::full_shape(ret, n)','i < n; ++i','i <= n; ++i')]:
  inputs=[]
  for n in [0,1,2,7]:
   roots={p:4096+4096*i for i,p in enumerate(x for x in params if x not in ['n','m'])}
   args={p:n if p=='n' else 2 if p=='m' else roots[p] for p in params}
   inputs.append(row(args,{},True,n!=0))
  cases.append(dict(id='qcp_shape_'+function,source='QCP_demos_human/array_auto.c',function=function,memory='multiple owned array regions with shape-only and uninitialized predicates',heap_predicate=predicate,inputs=inputs,spec_edit=(predicate,'n == 0 && '+predicate),impl_edit=(old,new),instance_scope='fixed roots and lengths; array contents remain existential exactly as original Pre'))
 for function,param,old,new in [('iter','l','p = p->next;','p = 0; p = p->next;'),('reverse','p','v->next = w;','v->next = v;')]:
  cases.append(dict(id='qcp_shape_dll_'+function,source='QCP_demos_human/dll_auto.c',function=function,memory='doubly linked list with forward/back links, shape-only contract',heap_predicate='dlistrep_shape('+param+', 0)',inputs=[row({param:p},{},p!=0,p!=0) for p in [0,4096,8192,12288]],spec_edit=('dlistrep_shape(__return, 0)','__return == 0 && dlistrep_shape(__return, 0)'),impl_edit=(old,new),instance_scope='non-null root instances represent arbitrary finite lengths; no nonexistent logical list is invented'))
 cases.append(dict(id='qcp_original_sll_queue',source='QCP_demos_human/sll_queue.c',function='dequeue',memory='sentinel singly linked queue with head/tail pointers',heap_predicate='store_queue(q, cons(x,l))',inputs=[row({'q':4096},{'x':x,'l':xs},True) for x,xs in [(0,[]),(3,[4]),(-2,[0,7]),(9,[1,2,3])]],spec_edit=('__return == x &&','__return == x + 1 &&'),impl_edit=('return x0;','return x0 + 1;'),instance_scope='fixed logical contents; predicate internal node addresses stay existential'))
 cases.append(dict(id='qcp_original_list_insertion',source='QCP_demos_human/sll_insert_sort.c',function='insertion',memory='pointer-to-pointer cursor and separately owned node with uninitialized next field',heap_predicate='node->data == a && sll(p,l) * undef_data_at(&(node->next),struct list*)',inputs=[row({'p':4096 if xs else 0,'node':8192},{'l':xs,'a':a},any(v>=a for v in xs)) for xs,a in [([],2),([1],2),([1,3],2),([2,4,7],0)]],spec_edit=('insert(a, l)','insert(a + 1, l)'),impl_edit=('node -> next = * p2;','node -> next = 0;'),instance_scope='fixed list and new-node data; next field stays uninitialized in Pre'))
 cases.append(dict(id='qcp_original_list_insertion_sort',source='QCP_demos_human/sll_insert_sort.c',function='insertion_sort',memory='nested list traversal, ownership rearrangement and calls',heap_predicate='sll(x,l)',inputs=[row({'x':4096 if xs else 0},{'l':xs},bad) for xs,bad in [([],False),([7],False),([2,1],True),([1,3,2],False)]],spec_edit=('Permutation(l, l0)','Permutation(cons(0, l), l0)'),impl_edit=('return res;','return x;'),instance_scope='fixed finite input list; sort postcondition keeps existential output list'))
 payload_prefix='/*@ Import Coq Require Import BenchMemoryPayload */\n/*@ Extern Coq (int_payload : Z -> Z -> Assertion) (empty_payload : Z -> Z -> Assertion) */\n'
 poly=[]
 for xs in [[],[0],[3,-1],[7,0,2]]:
  r=row({'p':4096 if xs else 0},{'storeA':{'type':'Z -> Z -> Assertion','qcp':'int_payload'},'l':{'type':'list Z','value':xs}},len(xs)>1)
  r['types']={'A':'Z'};poly.append(r)
 cases.append(dict(id='qcp_original_polymorphic_reverse',source='QCP_demos_human/poly_sll.c',function='reverse',memory='polymorphic linked nodes with separately owned integer payload cells',heap_predicate='sll(storeA,p,l)',inputs=poly,spec_edit=('rev(l)','cons(0, rev(l))'),impl_edit=('v->next = w;','v->next = 0;'),instance_scope='A=Z and storeA=int_payload; node and payload addresses remain original existential variables',fixture_prefix=payload_prefix))
 intrusive=[]
 for addresses in [[],[8192],[8192,12288],[8192,12288,16384]]:
  term='nil'
  for addr in reversed(addresses):term='cons(Build_DL_Node(0,'+str(addr)+'),'+term+')'
  r=row({'node':4096},{'storeA':{'type':'Z -> Z -> Assertion','qcp':'empty_payload'},'l':{'type':'list (DL_Node Z)','qcp':term}},True)
  r['types']={'A':'Z'};intrusive.append(r)
 cases.append(dict(id='qcp_original_liteos_list_empty',source='Applications_human/LiteOS/LOS_ListEmpty.c',function='LOS_ListEmpty',memory='intrusive circular doubly linked list with sentinel and DL_Node address records',heap_predicate='store_dll(storeA,node,l)',inputs=intrusive,spec_edit=('__return == 1','__return == 2'),impl_edit=('node->pstNext == node','node->pstNext != node'),instance_scope='A=Z; DL_Node records fix ptr and data=0; empty_payload binds storeA for link-only LOS_DL_LIST nodes',fixture_prefix=payload_prefix))
 # The spec mutant changes only the empty branch; nonempty lists survive.
 for r in intrusive[1:]:r['spec']=False
 catalog=[]
 for c in cases:
  folder=HERE/'cases'/c['id'];folder.mkdir(parents=True,exist_ok=True)
  origin=QCP/c['source'];text=origin.read_text();candidate=_find_function_spec(text,c['function'])
  contract=text[candidate.start:candidate.end];ensure=contract.index('Ensure');old,new=c['spec_edit'];assert contract[ensure:].count(old)==1
  mutated=text[:candidate.start]+contract[:ensure]+contract[ensure:].replace(old,new)+text[candidate.end:]
  # Restrict executable mutations to the selected function's body; next spec ends scope.
  start=text.index('{',candidate.end);level=1;end=start+1
  while level:
   if text[end]=='{':level+=1
   if text[end]=='}':level-=1
   end+=1
  body=text[start:end];old,new=c['impl_edit'];assert body.count(old)==1,(c['id'],old)
  impl=text[:start]+body.replace(old,new)+text[end:]
  (folder/'reference.qcp.c').write_bytes(origin.read_bytes());(folder/'spec_mutation.qcp.c').write_text(mutated);(folder/'impl_mutation.qcp.c').write_text(impl)
  bindings=[];expectations=[]
  for index,r in enumerate(c.pop('inputs')):
   ident=f'input_{index:03d}';bindings.append({'id':ident,'args':r['args'],'values':r['values'],**({'types':r['types']} if 'types' in r else {})})
   expectations.append({'id':ident,'reference':'PASS','spec_mutation':'FAIL' if r['spec'] else 'PASS','impl_mutation':'FAIL' if r['impl'] else 'PASS','basis':'manual contract model; shape-only instances are not single concrete heaps'})
  save(folder/'binds.json',bindings)
  if c.get('fixture_prefix'):
   dep=folder/'dependencies/coq/BenchMemoryPayload.v';dep.parent.mkdir(parents=True,exist_ok=True)
   dep.write_text('From Coq Require Import ZArith.\nFrom SimpleC.SL Require Import Mem SeparationLogic.\nRequire Import Logic.LogicGenerator.demo932.Interface.\nImport naive_C_Rules.\nLocal Open Scope Z_scope.\nLocal Open Scope sac.\nDefinition int_payload (p v: Z): Assertion := store_int p v.\nDefinition empty_payload (p v: Z): Assertion := “ v = 0 ” && emp.\n')
   for variant in ['reference','spec_mutation','impl_mutation']:
    (folder/('execution_'+variant+'.qcp.c')).write_text(c['fixture_prefix']+(folder/(variant+'.qcp.c')).read_text())

  metadata={**c,'schema':'tespec-original-qcp-case/v2','source':str(origin.relative_to(ROOT)),'source_sha256':sha(origin),'input_count':len(bindings),'original_contract_preserved':True,'cn_status':'translation_pending','binding_policy':'Pre free variables only','pre_free_variables':{'args':list(bindings[0]['args']),'values':list(bindings[0]['values'])},'expectations':expectations,'include_dirs':[str(origin.parent.relative_to(ROOT)),'runtime/qcip/QCP_examples/stdlib'],'generator_sha256':sha(Path(__file__)),'files':{f.name:sha(f) for f in folder.glob('*.c')}}
  metadata['files']['binds.json']=sha(folder/'binds.json');
  for dep in folder.glob('dependencies/**/*.v'):metadata['files'][str(dep.relative_to(folder))]=sha(dep)
  save(folder/'case.json',metadata)
  catalog.append({'id':c['id'],'memory':c['memory'],'path':'cases/'+c['id'],'inputs':len(bindings),'cn_status':'translation_pending'})
 save(HERE/'catalog.json',{'schema':'qcp-memory-v2','programs':catalog,'prepared_qcp_subjects':len(catalog),'fixed_bindings':sum(c['inputs'] for c in catalog),'paired_cn_count':0})
 print(json.dumps({'subjects':len(catalog),'fixed_bindings':sum(c['inputs'] for c in catalog)}))
if __name__=='__main__':main()
