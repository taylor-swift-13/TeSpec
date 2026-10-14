#!/usr/bin/env python3
"""Freeze additional upstream CN memory examples and same-body QCP translations."""
import hashlib,json,re
from pathlib import Path
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
SRC=HERE.parent/'sources/cn-tutorial/src/exercises'
HEADER='#include "verification_stdlib.h"\n'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,x):p.write_text(json.dumps(x,indent=2)+'\n')
def strip(s):return re.sub(r'/\*@.*?\*/','',s,flags=re.S)
def replace_contracts(text,contracts):
 matches=list(re.finditer(r'/\*@.*?\*/',text,re.S));assert len(matches)==len(contracts)
 for m,c in reversed(list(zip(matches,contracts))):text=text[:m.start()]+'/*@ '+c+' */'+text[m.end():]
 return HEADER+text
ABS='With (x : Z) Require INT_MIN < x && data_at(p, int, x) Ensure ((x >= 0 && __return == x) || (x < 0 && __return == -x)) && data_at(p, int, x)'
ZERO='With (Coord : Z) Require data_at(coord, unsigned int, Coord) Ensure data_at(coord, unsigned int, 0)'
SWAP='With (P : Z) (Q : Z) Require data_at(p,unsigned int,P) * data_at(q,unsigned int,Q) Ensure data_at(p,unsigned int,Q) * data_at(q,unsigned int,P)'
CASES=[
 dict(id='cn_abs_mem',source='abs_mem.c',function='abs_mem',contracts=[ABS],kind='cell',ctype='int',ret='int',spec_cn=('x == x_post;','x_post == x + 1;'),spec_qcp=('Ensure ((x','Ensure x == 0 && ((x'),impl=('return x;','return 0;'),memory='owned signed cell; conditional read'),
 dict(id='cn_abs_struct_field',source='abs_mem_struct.c',function='abs_y',contracts=[ABS,'With (X : Z) (Y : Z) Require INT_MIN < Y && data_at(&(p->x),int,X) * data_at(&(p->y),int,Y) Ensure ((Y >= 0 && __return == Y) || (Y < 0 && __return == -Y)) && data_at(&(p->x),int,X) * data_at(&(p->y),int,Y)'],kind='struct',struct='struct tuple',ctype='int',ret='int',spec_cn=('s == s2;','s2.y == s.y + 1;'),spec_qcp=('Ensure ((Y','Ensure Y == 0 && ((Y'),impl=('return abs_mem(&p->y);','return abs_mem(&p->x);'),memory='struct interior field passed to a callee'),
 dict(id='cn_init_point',source='init_point.c',function='init_point',contracts=[ZERO,'With (X : Z) (Y : Z) Require data_at(&(p->x),unsigned int,X) * data_at(&(p->y),unsigned int,Y) Ensure data_at(&(p->x),unsigned int,0) * data_at(&(p->y),unsigned int,0)'],kind='struct',struct='struct point',ctype='unsigned int',ret='void',spec_cn=('P_post.x == 0;','P_post.x == 1;'),spec_qcp=('Ensure data_at(&(p->x),unsigned int,0)','Ensure data_at(&(p->x),unsigned int,1)'),impl=('*coord = 0;','*coord = 1;'),memory='two struct fields initialized by nested calls'),
 dict(id='cn_transpose_via_call',source='transpose2.c',function='transpose2',contracts=[SWAP,'With (X : Z) (Y : Z) Require data_at(&(p->x),unsigned int,X) * data_at(&(p->y),unsigned int,Y) Ensure data_at(&(p->x),unsigned int,Y) * data_at(&(p->y),unsigned int,X)'],kind='struct',struct='struct point',ctype='unsigned int',ret='void',spec_cn=('P_post.x == P.y;','P_post.x == P.y + 1;'),spec_qcp=('Ensure data_at(&(p->x),unsigned int,Y)','Ensure data_at(&(p->x),unsigned int,Y + 1)'),impl=('*q = m;','*q = n;'),memory='disjoint interior fields passed to swap'),
 dict(id='cn_transfer_disjoint',source='slf8_basic_transfer.c',function='transfer',contracts=['With (P : Z) (Q : Z) Require P + Q <= 4294967295 && data_at(p,unsigned int,P) * data_at(q,unsigned int,Q) Ensure data_at(p,unsigned int,P + Q) * data_at(q,unsigned int,0)'],kind='cells',ctype='unsigned int',ret='void',spec_cn=('Q_post == 0;','Q_post == 1;'),spec_qcp=('data_at(q,unsigned int,0)','data_at(q,unsigned int,1)'),impl=('*q = 0;','*q = 1;'),memory='ownership transfer between separate cells'),
 dict(id='cn_incr_first_frame',source='slf7_basic_incr_first.c',function='incr_first',contracts=['With (P : Z) Require P < 4294967295 && data_at(p,unsigned int,P) Ensure data_at(p,unsigned int,P + 1)','With (P : Z) (Q : Z) Require P < 4294967295 && data_at(p,unsigned int,P) * data_at(q,unsigned int,Q) Ensure data_at(p,unsigned int,P + 1) * data_at(q,unsigned int,Q)','With (P : Z) Require P < 4294967295 && data_at(p,unsigned int,P) Ensure data_at(p,unsigned int,P + 1)'],kind='cells',ctype='unsigned int',ret='void',spec_cn=('m2 == m1;','m2 == m1 + 1;'),spec_qcp=('Ensure data_at(p,unsigned int,P + 1) * data_at(q,unsigned int,Q)','Ensure data_at(p,unsigned int,P + 1) * data_at(q,unsigned int,Q + 1)'),impl=('unsigned int m = n+1;','unsigned int m = n;'),memory='callee modifies one owned cell while framing another')]
def main():
 catalog=[]
 for c in CASES:
  original=SRC/c['source'];cn=original.read_text();deps={}
  if '#include "slf0_basic_incr.c"' in cn:
   dep=SRC/'slf0_basic_incr.c';deps[str(dep.relative_to(ROOT))]=sha(dep)
   cn=cn.replace('#include "slf0_basic_incr.c"',dep.read_text())
  qcp=replace_contracts(cn,c['contracts'])
  assert strip(cn)==strip(qcp.removeprefix(HEADER))
  folder=HERE/'suites'/c['id'];folder.mkdir(parents=True,exist_ok=True)
  for lang,text in [('cn',cn),('qcp',qcp)]:
   (folder/f'reference.{lang}.c').write_text(text)
   old,new=c['spec_'+lang];assert text.count(old)==1,(c['id'],old)
   (folder/f'spec_mutation.{lang}.c').write_text(text.replace(old,new))
   old,new=c['impl'];assert text.count(old)==1,(c['id'],old)
   (folder/f'impl_mutation.{lang}.c').write_text(text.replace(old,new))
  # Small fixed boundary/branch grid. No runtime RNG or LLM input generation.
  vals=[0,1,2,7,31,99] if c['ctype']=='unsigned int' else [-2147483647,-7,-1,0,1,7,2147483647]
  pairs=[(x,y) for x in vals for y in vals] if c['kind']!='cell' else [(x,x) for x in vals]
  rows=[]
  for index,(x,y) in enumerate(pairs):
   ident=f'input_{index:03d}';args={'p':4096};ret=None
   if c['kind']=='cell':heap={'p':x};logical={'x':x};ret=abs(x);final=heap;implbad=x>0;specbad=x!=0
   elif c['kind']=='struct':
    heap={'p':{'x':x,'y':y}};logical={'X':x,'Y':y};final=heap
    if c['function']=='abs_y':ret=abs(y);implbad=abs(x)!=abs(y);specbad=y!=0
    elif c['function']=='init_point':final={'p':{'x':0,'y':0}};implbad=True;specbad=True
    else:final={'p':{'x':y,'y':x}};implbad=x!=y;specbad=True
   else:
    args['q']=8192;heap={'p':x,'q':y};logical={'P':x,'Q':y};implbad=True;specbad=True
    final={'p':x+y,'q':0} if c['function']=='transfer' else {'p':x+1,'q':y}
   # Both languages use the same wrong postcondition (zero-only restriction for abs).
   rows.append({'id':ident,'args':args,'structs' if c['kind']=='struct' else 'cells':heap,'qcp_bind':{'id':ident,'args':args,'values':logical},'expected_return':ret,'expected_heap':final,'spec_mutation_violated':specbad,'impl_mutation_violated':implbad})
  # Align the abs CN mutant to the zero-only restriction without changing reference.
  if c['function'] in ('abs_mem','abs_y'):
   old,new=c['spec_cn'];new=('x == 0;\n             x == x_post;' if c['function']=='abs_mem' else 's.y == 0;\n             s == s2;')
   (folder/'spec_mutation.cn.c').write_text(cn.replace(old,new))
  suite={'schema':'tespec-paired-input-suite/v1','id':c['id'],'function':c['function'],'origin':'CN tutorial / Fulminate exercise source','source':str(original.relative_to(ROOT)),'source_sha256':sha(original),'source_dependencies':deps,'source_revision':'5d858ae39ef3da80c66a09f723f64c01a28b4c17','reference_cn_preservation':'byte-identical except recorded local include expansion','reference_c_body_equal':True,'memory_class':c['memory'],'parameter_order':list(rows[0]['args']),'element_c_type':c['ctype'],'return_kind':c['ret'],'input_count':len(rows),'inputs':rows,'binding_policy':'instantiate only free input variables of original Pre; preserve existential witnesses','pre_free_variables':{'args':list(rows[0]['args']),'values':list(rows[0]['qcp_bind']['values'])},'admission':'typed cell/field ownership, disjoint aligned entry regions, arithmetic guards checked; translation review is local, not formal equivalence proof','variants':{v:{'kind':v} for v in ('reference','spec_mutation','impl_mutation')},'generator_sha256':sha(Path(__file__)),'files':{p.name:sha(p) for p in sorted(folder.glob('*.c'))}}
  if c['kind']=='struct':suite.update(struct_types={'p':c['struct']},struct_field_order={'p':['x','y']})
  save(folder/'suite.json',suite);catalog.append({'id':c['id'],'path':'suites/'+c['id'],'inputs':len(rows),'memory':c['memory'],'source':suite['source']})
 save(HERE/'catalog.json',{'schema':'upstream-memory/v1','programs':catalog,'paired_subjects':len(catalog),'fixed_inputs':sum(r['inputs'] for r in catalog)})
 print(json.dumps({'paired_subjects':len(catalog),'fixed_inputs':sum(r['inputs'] for r in catalog)}))
if __name__=='__main__':main()
