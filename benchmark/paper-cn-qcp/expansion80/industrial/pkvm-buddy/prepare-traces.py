#!/usr/bin/env python3
"""Prepare industrial operation inputs and independent buddy-state expectations.

This runs a Python model, not the original industrial C program. Model validation
is separate from CN/QCP admission and from confirming the original C mutations.
"""
import argparse,hashlib,json,random
from pathlib import Path
HERE=Path(__file__).resolve().parent

class Buddy:
 def __init__(self,omit_min=False,base_pfn=4096):
  self.base_pfn=base_pfn
  self.free={i:set() for i in range(10)};self.live={};self.omit_min=omit_min
  start=0
  while start<8:
   order=0
   while order+1<10 and (base_pfn+start)%(1<<(order+1))==0 and start+(1<<(order+1))<=8:order+=1
   self.free[order].add(start);start+=1<<order
  self.initial_free={k:set(v) for k,v in self.free.items()}
 def check(self):
  seen=set()
  for order,blocks in self.free.items():
   for start in blocks:
    assert (self.base_pfn+start)%(1<<order)==0,('unaligned free block',start,order)
    assert 0<=start and start+(1<<order)<=8
    pages=set(range(start,start+(1<<order)));assert not seen&pages;seen|=pages
  for handle,block in self.live.items():
   start,order,refs=block
   assert refs>0 and refs<=65535
   assert (self.base_pfn+start)%(1<<order)==0 and 0<=start and start+(1<<order)<=8
   pages=set(range(start,start+(1<<order)));assert not seen&pages;seen|=pages
  assert seen==set(range(8)),('lost or duplicated pages',seen)
 def apply(self,op):
  kind=op['op'];handle=op['handle'];details={}
  if kind=='alloc':
   assert handle not in self.live
   order=op['order'];assert 0<=order<10
   level=next((k for k in range(order,10) if self.free[k]),None)
   if level is None:details={'success':False}
   else:
    start=min(self.free[level]);self.free[level].remove(start)
    while level>order:
     level-=1;self.free[level].add(start+(1<<level))
    self.live[handle]=(start,order,1);details={'success':True,'model_start_page':start,'order':order,'refs':1}
  elif handle not in self.live:
   assert op.get('if_live') is True
   details={'guard_skipped':True}
  elif kind=='put_all':
   # A client macro releases the actual outstanding references. Cleanup must
   # also cover handles whose allocation outcome differs from preparation.
   while handle in self.live:self.apply({'op':'put','handle':handle,'if_live':True})
   details={'refs':0,'all_client_references_released':True}
  elif kind=='get':
   start,order,refs=self.live[handle];assert refs<65535
   self.live[handle]=(start,order,refs+1);details={'refs':refs+1}
  elif kind=='put':
   start,order,refs=self.live[handle]
   if refs>1:self.live[handle]=(start,order,refs-1);details={'refs':refs-1}
   else:
    del self.live[handle]
    while order+1<10:
     buddy=((self.base_pfn+start)^(1<<order))-self.base_pfn
     if buddy not in self.free[order]:break
     self.free[order].remove(buddy)
     if not self.omit_min:start=min(start,buddy)
     order+=1
    self.free[order].add(start);details={'refs':0,'freed':True}
  else:raise ValueError(kind)
  self.check()
  return details
 def state(self):
  return {'free_blocks':{str(k):sorted(v) for k,v in self.free.items() if v},'live':{p:{'start_page':b[0],'order':b[1],'refs':b[2]} for p,b in sorted(self.live.items())}}

def replay(ops,omit_min=False,base_pfn=4096):
 model=Buddy(omit_min,base_pfn);model.check();states=[]
 for i,op in enumerate(ops):
  result=model.apply(op);states.append({'step':i,'operation':op,'model_result':result,'model_state':model.state()})
 return model,states

def random_trace(rng,index,base_pfn):
 model=Buddy(base_pfn=base_pfn);ops=[];next_handle=0
 for step in range(rng.randint(24,64)):
  choice=rng.random()
  if not model.live or choice<0.5:
   op={'op':'alloc','order':rng.choice([0,0,1,2,3,4,9]),'handle':f'p{next_handle}'};next_handle+=1
  else:
   h=rng.choice(sorted(model.live));refs=model.live[h][2]
   op={'op':'get' if choice<0.7 and refs<4 else 'put','handle':h,'if_live':True}
  ops.append(op);model.apply(op)
 # Complete releases allow checking conservation and recovery, not just outputs.
 for h in [op['handle'] for op in ops if op['op']=='alloc']:
  op={'op':'put_all','handle':h,'if_live':True};ops.append(op);model.apply(op)
 assert not model.live and model.free==model.initial_free
 ops += [{'op':'alloc','order':3,'handle':f'p{next_handle}'},{'op':'put','handle':f'p{next_handle}','if_live':True}]
 return ops

def main():
 parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--count',type=int,default=128);parser.add_argument('--seed',type=int,default=20261013);a=parser.parse_args()
 if a.count<128:parser.error('At least 128 distinct complete traces')
 paper=[{'op':'alloc','order':0,'handle':'p0'},{'op':'alloc','order':0,'handle':'p1'},{'op':'put','handle':'p0','if_live':True},{'op':'put','handle':'p1','if_live':True}]
 exhaustion=[{'op':'alloc','order':0,'handle':f'p{i}'} for i in range(9)]+[{'op':'put','handle':f'p{i}','if_live':True} for i in range(8)]+[{'op':'alloc','order':3,'handle':'whole'},{'op':'put','handle':'whole','if_live':True}]
 references=[{'op':'alloc','order':2,'handle':'block'},{'op':'get','handle':'block','if_live':True},{'op':'get','handle':'block','if_live':True}]+[{'op':'put','handle':'block','if_live':True}]*3
 traces=[(paper,4096),(exhaustion,4096),(references,4096)];seen={json.dumps(t,sort_keys=True) for t in traces};rng=random.Random(a.seed)
 while len(traces)<a.count:
  base=4096+len(traces)%8
  ops=random_trace(rng,len(traces),base);key=json.dumps([ops,base],sort_keys=True)
  if key not in seen:seen.add(key);traces.append((ops,base))
 cases=[]
 for index,(ops,base) in enumerate(traces):
  model,states=replay(ops,base_pfn=base);assert not model.live and model.free==model.initial_free
  cases.append({'id':['paper_2_plus_2','exhaustion_and_recovery','reference_lifecycle'][index] if index<3 else f'random_{index:03d}','initial_state':{'pool_pages':8,'page_size_bytes':4096,'model_start_pfn':base,'start_alignment_pages_mod8':base%8,'reserved_pages':0,'max_order':10},'operations':ops,'independent_model_states':states,'expected_final_free_blocks':model.state()['free_blocks'],'cn_qcp_replay_checked':False})
 try:
  replay(paper,omit_min=True);raise RuntimeError('Missing-min model mutant survived paper trace')
 except AssertionError as error:model_mutant_diagnostic=str(error)
 report={'schema':'tespec-industrial-model-inputs/v1','scope':'independent model preparation; not native production-C or CN/QCP tool results','source_revision':'66afeefe9556bc32b8b027d5b7f62bc3a7069703','seed':a.seed,'trace_count':len(cases),'generator_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'allocation_policy':'Preparation chooses the lowest free root at the smallest available order. Production replay must co-simulate actual allocation choices; exact model addresses are not ground truth.','guards':'get/put are guarded by actual handle liveness; put_all releases the actual client reference count for every allocated handle, including any whose result differs from preparation','specification_scope':'Allocation success/exhaustion expectations are supplemental functional-model checks. The original hyp_alloc_pages postcondition permits NULL and does not state allocation completeness; a stronger shared CN/QCP contract is needed to classify completeness mutants as specification violations.','model_checks':['block alignment and pool containment','disjoint live and free blocks','reference-count bounds','conservation of all eight pages after each operation','full recovery after final releases'],'production_admission_checked':False,'qcp_translation_status':'pending','original_spec_mutants_local_verdicts_checked':False,'original_impl_mutant_local_verdict_checked':False,'illustrative_missing_min_model_mutant':{'paper_trace_rejected':True,'diagnostic':model_mutant_diagnostic,'scope':'Python model mutation only; not an original C mutant verdict'},'traces':cases}
 (HERE/'model-traces.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({k:report[k] for k in ['trace_count','production_admission_checked','qcp_translation_status','illustrative_missing_min_model_mutant']},indent=2))
if __name__=='__main__':main()
