#!/usr/bin/env python3
"""Prepare and check positive original residual VCs, separately for each execution."""
import argparse,json,re,shlex,shutil
from pathlib import Path
from meter_read_itp_coq import ROOT,COQ,RUNTIME,measure,save,sha

def statements(text):
 return [(m[1],re.sub(r"\s+"," ",m[2]).strip()) for m in re.finditer(r"Theorem\s+(\w+)\s*:\s*(.*?)\.\s*Proof\.",text,re.S)]

def prepare(group,taskroot):
 plan=json.loads((ROOT/'benchmark/programs'/group/'evaluation-plan.json').read_text());rp=ROOT/'benchmark/results'/group/plan['run_id']/'results.json';data=json.loads(rp.read_text());tasks=[];out=ROOT/'benchmark/results'/group/'20261016-positive-itp-per-execution'
 for row in data['runs']:
  for mode in ['off','on']:
   m=row['tespec_'+mode]
   if m['status']!='UNKNOWN' or row['expected']!='PASS':continue
   raw=ROOT/m['report'];j=json.loads(raw.read_text())['results'][0]
   assert j['precondition_result']=='SAT' and j['execution_completed'] and j['residual_vcs']
   goals=list(raw.parent.rglob('*_goal.v'));assert len(goals)==1
   names=[n.removeprefix('proof_of_') for n in j['residual_vcs']];assert len(names)==len(set(names));text=goals[0].read_text()
   for n in names:assert re.search(r'Definition\s+'+re.escape(n)+r'\s*:=',text)
   idx=len(tasks);binding={'group':group,'execution_index':idx,'variant':row['variant'],'paired_qcp_variant':row['paired_qcp_variant'],'case':row['case'],'mode':mode,'expected':'PASS','report':str(raw.relative_to(ROOT)),'report_sha256':sha(raw),'goal':str(goals[0].relative_to(ROOT)),'goal_sha256':sha(goals[0]),'binds':row['binds'],'binds_sha256':row['binds_sha256'],'qcp_source_sha256':row['qcp_source_sha256'],'residual_vcs':names,'proof_kind':'POSITIVE_ORIGINAL_RESIDUAL_VCS'};tasks.append(binding);task=taskroot/f'execution-{idx:02d}'
   if (task/'binding.json').exists():assert json.loads((task/'binding.json').read_text())==binding;continue
   task.mkdir(parents=True,exist_ok=True);save(task/'binding.json',binding);(task/'ExecutionGoal.v').write_bytes(goals[0].read_bytes());header=text.split('(*----- Function ')[0]
   candidate='Require Import ExecutionGoal.\n'+header+'\n'+''.join(f'Theorem resolved_{n} : ExecutionGoal.{n}.\nProof. Admitted.\n' for n in names)+''.join(f'Print Assumptions resolved_{n}.\n' for n in names)
   (task/'Candidate.v').write_text(candidate);(task/'template.txt').write_text(candidate)
   (task/'prompt.txt').write_text('Fill Candidate.v for this ONE positive finite test execution. Prove ALL listed original residual VCs together, preserving every theorem statement/import and Print Assumptions. ExecutionGoal.v is immutable actual emitted finite output. Native entry was SAT and execution completed; do not refute a correct case, invent a heap, or substitute universal verification. No admit, new axioms/parameters, changed definitions, unchecked casts, models, delegation, prior solutions or compiler/shell calls. Edit Candidate.v only. Controller separately compiles and independently kernel-checks with 90-second/4-GiB compile guard. Pure list equalities may need unfolding repeat_Z and arithmetic reduction. In a disjunction, a valid pure reduction alternative can be used directly without proving an array predicate. Preserve heap witnesses; do not use unbounded firstorder on heaps or generic spatial lemmas that introduce functional extensionality. Every proof must introduce no assumptions beyond original statement type parameters.\n\nOriginal immutable finite goal:\n'+text+'\nCandidate:\n'+candidate)
 save(out/'tasks.json',{'schema':'tespec-positive-execution-itp-tasks/v1','group':group,'evaluation_report':str(rp.relative_to(ROOT)),'evaluation_report_sha256':sha(rp),'tasks':tasks});print('Prepared',len(tasks),'positive tasks: one execution and all its residual VCs each',flush=True)

def compile_one(group,root,index,attempt):
 task=root/f'execution-{index:02d}';out=ROOT/'benchmark/results'/group/'20261016-positive-itp-per-execution'/f'execution-{index:02d}'/f'attempt-{attempt}';assert not(out/'coq-receipt.json').exists();src=out/'proofs';src.mkdir(parents=True,exist_ok=True);md=task/f'attempt-{attempt}';model=json.loads((md/'model-receipt.json').read_text());assert model['exit_code']==0 and model['requested_model']=='gpt-6.1-sol' and model['token_usage'];assert sha(md/'prompt.txt')==model['prompt_sha256'];binding=json.loads((task/'binding.json').read_text());assert sha(ROOT/binding['goal'])==binding['goal_sha256']==sha(task/'ExecutionGoal.v');assert sha(ROOT/binding['report'])==binding['report_sha256'] and sha(ROOT/binding['binds'])==binding['binds_sha256']
 for name in ['model-receipt.json','usage-events.json','agent.stdout.jsonl','agent.stderr.log','prompt.txt']:shutil.copyfile(md/name,out/name)
 save(out/'binding.json',binding)
 for name,h in model['locked_goal_and_helper_sha256'].items():assert sha(task/name)==h;shutil.copyfile(task/name,src/name)
 candidate=(md/'Candidate.v').read_text();template=(task/'template.txt').read_text();names=[n for n,_ in statements(template)];assert statements(candidate)==statements(template) and len(names)==len(binding['residual_vcs'])
 assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b',candidate)
 for n in names:assert 'Print Assumptions '+n+'.' in candidate
 shutil.copyfile(md/'Candidate.v',src/'Candidate.v');assert sha(src/'Candidate.v')==model['candidate_sha256']
 parts=shlex.split((RUNTIME/'_CoqProject').read_text());flags=[str(RUNTIME/t) if i%3==1 else t for i,t in enumerate(parts)]+['-Q',str(src),''];receipt={'schema':'tespec-positive-execution-itp-receipt/v1','group':group,'execution_index':index,'attempt':attempt,'binding':binding,'model':model,'candidate':str((src/'Candidate.v').relative_to(ROOT)),'candidate_sha256':sha(src/'Candidate.v'),'goals':[{'name':n,'statement':t} for n,t in statements(template)],'compilation':[],'status':'COMPILING'}
 for name in ['ExecutionGoal.v','Candidate.v']:
  m=measure([COQ/'coqc',*flags,src/name],out/'compilation'/Path(name).stem,src);receipt['compilation'].append(m);save(out/'coq-receipt.json',receipt)
  if m['exit_code']:receipt['status']='COMPILE_FAILED';save(out/'coq-receipt.json',receipt);print((ROOT/m['stderr']).read_text(),flush=True);return 1
 return finish_audit(out,src,receipt,flags)

def symbols(text):return {n.removeprefix('CNotation.') for n in re.findall(r'^([A-Za-z_][A-Za-z0-9_.]*)\s*:',text,re.M)}-{'Axioms'}

def finish_audit(out,src,receipt,flags):
 names=[g['name'] for g in receipt['goals']];candidate_compile=next(m for m in reversed(receipt['compilation']) if m['exit_code']==0 and '/Candidate/' in m['stdout']);audit=(ROOT/candidate_compile['stdout']).read_text();stmt=src/'StatementAudit.v';stmt.write_text('Require Import ExecutionGoal.\n'+''.join('Print Assumptions ExecutionGoal.'+n+'.\n' for n in receipt['binding']['residual_vcs']))
 m=measure([COQ/'coqc',*flags,stmt],out/'compilation'/('StatementAudit-'+str(len(receipt['compilation']))),src);receipt['compilation'].append(m);save(out/'coq-receipt.json',receipt)
 if m['exit_code']:receipt['status']='STATEMENT_AUDIT_FAILED';save(out/'coq-receipt.json',receipt);return 1
 baseline=(ROOT/m['stdout']).read_text();allowed={'sizeof_union_type','sizeof_struct_type','sizeof_enum_type','sizeof_alias_type','eval_addr_expr'};bs=symbols(baseline);ps=symbols(audit)
 if not(bs<=allowed and ps<=bs) or audit.count('Closed under the global context')+audit.count('Axioms:')!=len(names):receipt['status']='ASSUMPTION_AUDIT_REJECTED';save(out/'coq-receipt.json',receipt);print(audit,flush=True);return 1
 receipt['assumptions']={'globally_closed_theorems':audit.count('Closed under the global context'),'runtime_parameters':sorted(ps),'original_statement_parameters':sorted(bs),'new_axioms':[],'raw_audit':candidate_compile['stdout'],'original_statement_audit':m['stdout'],'qualification':'All positive original residual VCs checked relative only to original statement type parameters; no additional library/proof axioms.'};receipt['kernel_check']=measure([COQ/'coqchk','-silent',*flags,'Candidate'],out/'kernel-check',src);receipt['status']='KERNEL_CHECKED' if receipt['kernel_check']['exit_code']==0 else 'KERNEL_FAILED';receipt['final_status']='PASS' if receipt['status']=='KERNEL_CHECKED' else None;save(out/'coq-receipt.json',receipt)
 for p in src.iterdir():
  if p.suffix in ['.vo','.vos','.vok','.glob','.aux'] or p.name in ['.lia.cache','.nia.cache']:p.unlink()
 print(receipt['status'],receipt['group'],receipt['execution_index'],receipt['attempt'],flush=True);return int(receipt['status']!='KERNEL_CHECKED')

def audit_existing(group,index,attempt):
 out=ROOT/'benchmark/results'/group/'20261016-positive-itp-per-execution'/f'execution-{index:02d}'/f'attempt-{attempt}';receipt=json.loads((out/'coq-receipt.json').read_text());assert receipt['status']=='ASSUMPTION_AUDIT_REJECTED';src=out/'proofs';assert sha(src/'Candidate.v')==receipt['candidate_sha256'];parts=shlex.split((RUNTIME/'_CoqProject').read_text());flags=[str(RUNTIME/t) if i%3==1 else t for i,t in enumerate(parts)]+['-Q',str(src),''];return finish_audit(out,src,receipt,flags)

def main():
 p=argparse.ArgumentParser();p.add_argument('action',choices=['prepare','compile','audit']);p.add_argument('--group',required=True);p.add_argument('--task-root',type=Path,required=True);p.add_argument('--execution',type=int);p.add_argument('--attempt',type=int,default=1);a=p.parse_args()
 if a.action=='prepare':prepare(a.group,a.task_root)
 elif a.action=='audit':raise SystemExit(audit_existing(a.group,a.execution,a.attempt))
 else:raise SystemExit(compile_one(a.group,a.task_root,a.execution,a.attempt))
if __name__=='__main__':main()
