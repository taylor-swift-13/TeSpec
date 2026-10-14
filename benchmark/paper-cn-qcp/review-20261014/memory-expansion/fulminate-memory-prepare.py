#!/usr/bin/env python3
"""Freeze original Fulminate test exercises, mutations, and deterministic heap fixtures."""
import hashlib,json
from pathlib import Path
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
SRC=HERE.parent/'sources/cn-tutorial/src/exercises'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,x):p.write_text(json.dumps(x,indent=2)+'\n')
CASES=[('fulminate_queue_pop','queue/pop.test.c','pop_queue','sentinel-free queue with front/back, free of head node',('return == Hd(Q);','return == Hd(Q) + 1;'),('return x;','return x + 1;')),('fulminate_dll_remove','dllist/remove.test.c','remove_current','doubly linked list: remove head/middle/tail; allocate result record; free current node',('Ret.data == Del.data;','Ret.data == Del.data + 1;'),('pair->data = n->data;','pair->data = n->data + 1;')),('fulminate_list_mergesort','list/mergesort.test.c','merge_sort','recursive splitting and merging with a struct holding two list roots',('Ys == Merge_sort(Xs);','Ys == Xs;'),('return merge(p.fst, p.snd);','return p.fst;'))]
def main():
 catalog=[]
 for ident,source,fn,memory,spec,impl in CASES:
  origin=SRC/source;folder=HERE/'cases'/ident;folder.mkdir(parents=True,exist_ok=True);text=origin.read_text()
  (folder/'reference.cn.c').write_bytes(origin.read_bytes())
  for variant,(old,new) in [('spec_mutation',spec),('impl_mutation',impl)]:
   assert text.count(old)>0;(folder/(variant+'.cn.c')).write_text(text.replace(old,new))
  rows=[]
  for index,vals in enumerate([[7],[1,2],[3,-1,2,0],[5,4,3,2,1]]):
   names=['n'+str(i) for i in range(len(vals))];ptr=lambda i:names[i] if 0<=i<len(vals) else '0'
   if fn=='pop_queue':
    setup='struct queue *q=malloc__queue();'+''.join('struct queue_cell *'+n+'=malloc__queue_cell();' for n in names)
    setup+=''.join(f'{n}->first={v}; {n}->next={ptr(i+1)};' for i,(n,v) in enumerate(zip(names,vals)))
    setup+=f'q->front={names[0]}; q->back={names[-1]};'
    call='int observed=pop_queue(q);'
    checks=f'if(observed!={vals[0]})return 12; struct queue_cell *cursor=q->front;'
    for v in vals[1:]:checks+=f'if(!cursor || cursor->first!={v})return 14; cursor=cursor->next;'
    checks+='if(cursor)return 14;'+('if(q->front || q->back)return 14;' if len(vals)==1 else f'if(q->back!={names[-1]} || q->back->next)return 14;')
    bind={'args':{'q':4096},'values':{'Q':vals}};specbad=True;implbad=True
   elif fn=='remove_current':
    current=[0,0,1,4][index]
    setup=''.join('struct dllist *'+n+'=malloc__dllist();' for n in names)
    setup+=''.join(f'{n}->data={v}; {n}->prev={ptr(i-1)}; {n}->next={ptr(i+1)};' for i,(n,v) in enumerate(zip(names,vals)))
    call=f'struct dllist_and_int *observed=remove_current({names[current]});'
    target=current+1 if current+1<len(vals) else current-1
    checks=f'if(!observed || observed->data!={vals[current]} || observed->dllist!={ptr(target)})return 12;'
    remain=[i for i in range(len(vals)) if i!=current]
    for j,i in enumerate(remain):checks+=f'if({names[i]}->data!={vals[i]} || {names[i]}->prev!={ptr(remain[j-1]) if j else "0"} || {names[i]}->next!={ptr(remain[j+1]) if j+1<len(remain) else "0"})return 14;'
    # DlList contains curr struct including prev/next addresses; instantiate that complete value.
    addr=lambda i:8192+32*i if 0<=i<len(vals) else 0
    bind={'args':{'n':addr(current)},'values':{'Before':{'left':list(reversed(vals[:current])),'curr':{'data':vals[current],'prev':addr(current-1),'next':addr(current+1)},'right':vals[current+1:]}}};specbad=True;implbad=True
   else:
    setup=''.join('struct sllist *'+n+'=malloc__sllist();' for n in names)
    setup+=''.join(f'{n}->head={v}; {n}->tail={ptr(i+1)};' for i,(n,v) in enumerate(zip(names,vals)))
    call=f'struct sllist *observed=merge_sort({names[0]});';checks='struct sllist *cursor=observed;'
    for v in sorted(vals):checks+=f'if(!cursor || cursor->head!={v})return 14; cursor=cursor->tail;'
    checks+='if(cursor)return 14;';bind={'args':{'xs':8192},'values':{'Xs':vals}};specbad=vals!=sorted(vals);implbad=len(vals)>1
   rows.append({'id':f'input_{index:03d}','pre_instance':bind,'native_setup':setup,'native_call':call,'native_checks':checks,'spec_mutation_violated':specbad,'impl_mutation_violated':implbad})
  save(folder/'inputs.json',rows)
  c={'id':ident,'function':fn,'source':str(origin.relative_to(ROOT)),'source_sha256':sha(origin),'revision':'5d858ae39ef3da80c66a09f723f64c01a28b4c17','memory':memory,'input_count':len(rows),'qcp_status':'translation_pending','binding_policy':'only original requires input parameters and take-result logical values; addresses normalized for native allocation','pre_free_variables':{k:list(v) for k,v in rows[0]['pre_instance'].items()},'generator_sha256':sha(Path(__file__)),'files':{f.name:sha(f) for f in folder.iterdir() if f.suffix=='.c' or f.name=='inputs.json'},'scope':'CN-specific pre_instance records, not QCP JSON bindings; native fixtures realize a selected model of original predicate'}
  save(folder/'case.json',c);catalog.append({'id':ident,'path':'cases/'+ident,'memory':memory,'inputs':len(rows)})
 save(HERE/'catalog.json',{'programs':catalog,'subjects':len(catalog),'fixed_inputs':sum(c['inputs'] for c in catalog),'paired_qcp_subjects':0})
 print(json.dumps({'subjects':len(catalog),'fixed_inputs':sum(c['inputs'] for c in catalog)}))
if __name__=='__main__':main()
