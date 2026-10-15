#!/usr/bin/env python3
"""Prepare and independently meter one-cell ownership-leak ITP per execution."""
import argparse,json,re,shlex,shutil
from pathlib import Path
from meter_read_itp_coq import ROOT,COQ,RUNTIME,measure,save,sha

def prepare(group,taskroot):
    plan=json.loads((ROOT/'benchmark/programs'/group/'evaluation-plan.json').read_text());reportpath=ROOT/'benchmark/results'/group/plan['run_id']/'results.json';data=json.loads(reportpath.read_text());out=ROOT/'benchmark/results'/group/'20261016-itp-per-execution';tasks=[]
    oldhelper=ROOT/'benchmark/results/read/20261015-itp-refutations/proofs/ReadCounterHeap.v';helper=oldhelper.read_text().split('Lemma cell_value_0')[0];header=helper.split('Definition st ')[0]
    context=(ROOT/'runtime/qcip/SeparationLogic/SeparationLogic/CommonAssertion.v').read_text();context=context[context.index('Definition store_4byte '):context.index('Definition store_int64 ')]
    for row in data['runs']:
      for mode in ['off','on']:
        m=row['tespec_'+mode]
        if m['status']!='UNKNOWN':continue
        case=row['plan_case'];oracle=case['oracle'];assert case['expected']=='FAIL' and oracle['ownership_required_at_exit'] is False
        assert case['binds']['args']=={'p':4096}
        raw=ROOT/m['report'];r=json.loads(raw.read_text())['results'][0];goals=list(raw.parent.rglob('*_goal.v'));assert len(goals)==1
        residual=[x.removeprefix('proof_of_') for x in r['residual_vcs']];assert set(residual)=={plan['function']+'_return_wit_1',plan['function']+'_return_wit_1_split_goal_spatial'}
        idx=len(tasks);name=f'execution-{idx:02d}';task=taskroot/name
        binding={'group':group,'execution_index':idx,'variant':row['variant'],'case':row['case'],'mode':mode,'expected':'FAIL','report':str(raw.relative_to(ROOT)),'report_sha256':sha(raw),'goal':str(goals[0].relative_to(ROOT)),'goal_sha256':sha(goals[0]),'binds':row['binds'],'binds_sha256':row['binds_sha256'],'qcp_source_sha256':row['qcp_source_sha256'],'residual_vcs':residual,'precondition_goal':plan['function']+'_precondition_wit_1','helper_provenance':str(oldhelper.relative_to(ROOT)),'helper_provenance_sha256':sha(oldhelper)}
        tasks.append(binding)
        if (task/'binding.json').exists():assert json.loads((task/'binding.json').read_text())==binding;continue
        task.mkdir(parents=True,exist_ok=True);save(task/'binding.json',binding);(task/'ExecutionGoal.v').write_bytes(goals[0].read_bytes());(task/'ConcreteCell.v').write_text(helper)
        old=case['binds']['values']['old'];new=oracle['body_result_if_defined'];kind='UInt' if oracle['unsigned'] else 'Int'
        def bs(v):return [(v%4294967296 >> n)&255 for n in [24,16,8,0]]
        eb,xb=bs(old),bs(new);theorems=[('entry_cell',f'(4096 # {kind} |-> ({old})) (st (cell '+ ' '.join(map(str,eb))+'))'),('exit_cell',f'(4096 # {kind} |-> ({new})) (st (cell '+' '.join(map(str,xb))+'))')]+[('refute_'+n,'~ ExecutionGoal.'+n) for n in residual]+[('entry_sat','ExecutionGoal.'+binding['precondition_goal'])]
        candidate='Require Import ConcreteCell ExecutionGoal.\n'+header+'\n'+''.join(f'Theorem {n} : {t}.\nProof. Admitted.\n' for n,t in theorems)+''.join(f'Print Assumptions {n}.\n' for n,_ in theorems)
        (task/'Candidate.v').write_text(candidate);(task/'template.txt').write_text(candidate)
        prompt='Fill Candidate.v for this ONE finite test execution, all residual VCs together, plus entry satisfiability. Preserve all theorem statements and Print Assumptions exactly. No admit, new axioms/parameters, unchecked casts, changed imported goals, or proof escapes. Edit Candidate.v only. No models, delegation, prior refutation solutions, shell or compiler calls. Controller separately compiles and independently kernel-checks. ConcreteCell.v is a previously checked generic heap construction utility; only its generic cell/state/join/byte facts are supplied, no prior input-specific refutation.\nConstruct entry_cell and exit_cell by unfolding store_int/store_uint and store_4byte: choose the supplied four big-endian bytes, prove range/merge by computation, and assemble sepcon via st_join/join0/join1/join2 and byte_at. A typed integer store includes range AND underlying four-byte store. coq_prop is a pure assertion wrapper: use change/cbn to expose it. To refute the original return disjunction, destruct it and instantiate each forall with p=4096, old='+str(old)+' and its arithmetic hypotheses, then apply to exit_cell. Its result includes emp, contradict ConcreteCell.cell_not_emp. For split spatial VC do the same. Prove entry_sat by explicit entry_cell witness. unsigned_last_nbits denotes modulo and % denotes Z.rem. Do not unfold INT_MAX/INT_MIN/UINT_MAX (notations).\n\nGeneric utility:\n'+helper+'\nRuntime typed store definitions:\n'+context+'\nImmutable ORIGINAL finite VC goal:\n'+goals[0].read_text()+'\nExact candidate:\n'+candidate
        (task/'prompt.txt').write_text(prompt)
    save(out/'tasks.json',{'schema':'tespec-cell-leak-itp-tasks/v1','group':group,'evaluation_report':str(reportpath.relative_to(ROOT)),'evaluation_report_sha256':sha(reportpath),'tasks':tasks});print('Prepared',len(tasks),'separate ITP tasks, one execution each',flush=True)

def compile_one(group,taskroot,index,attempt):
    out=ROOT/'benchmark/results'/group/'20261016-itp-per-execution';task=taskroot/f'execution-{index:02d}';folder=out/f'execution-{index:02d}'/f'attempt-{attempt}';assert not(folder/'coq-receipt.json').exists();src=folder/'proofs';src.mkdir(parents=True,exist_ok=True);md=task/f'attempt-{attempt}';model=json.loads((md/'model-receipt.json').read_text());assert model['exit_code']==0 and model['requested_model']=='gpt-6.1-sol' and model['token_usage']
    prompt=md/'prompt.txt';assert sha(prompt)==model['prompt_sha256'];binding=json.loads((task/'binding.json').read_text());assert sha(ROOT/binding['goal'])==binding['goal_sha256']==sha(task/'ExecutionGoal.v')
    for f in ['model-receipt.json','usage-events.json','agent.stdout.jsonl','agent.stderr.log','prompt.txt']:shutil.copyfile(md/f,folder/f)
    save(folder/'binding.json',binding)
    for f,h in model['locked_goal_and_helper_sha256'].items():assert sha(task/f)==h;shutil.copyfile(task/f,src/f)
    candidate=(md/'Candidate.v').read_text();template=(task/'template.txt').read_text()
    def statements(t):return [(x[1],re.sub(r'\s+',' ',x[2]).strip()) for x in re.finditer(r'Theorem\s+(\w+)\s*:\s*(.*?)\.\s*Proof\.',t,re.S)]
    assert statements(candidate)==statements(template) and len(statements(candidate))==5
    assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b',candidate)
    shutil.copyfile(md/'Candidate.v',src/'Candidate.v');assert sha(src/'Candidate.v')==model['candidate_sha256']
    parts=shlex.split((RUNTIME/'_CoqProject').read_text());flags=[str(RUNTIME/t) if i%3==1 else t for i,t in enumerate(parts)]+['-Q',str(src),'']
    receipt={'schema':'tespec-cell-leak-itp-receipt/v1','group':group,'execution_index':index,'attempt':attempt,'binding':binding,'model':model,'candidate':str((src/'Candidate.v').relative_to(ROOT)),'candidate_sha256':sha(src/'Candidate.v'),'goals':[{'name':n,'statement':t} for n,t in statements(template)],'compilation':[],'status':'COMPILING'}
    for f in ['ConcreteCell.v','ExecutionGoal.v','Candidate.v']:
      m=measure([COQ/'coqc',*flags,src/f],folder/'compilation'/Path(f).stem,src);receipt['compilation'].append(m);save(folder/'coq-receipt.json',receipt)
      if m['exit_code']:
        receipt['status']='COMPILE_FAILED';save(folder/'coq-receipt.json',receipt);diag=(ROOT/m['stderr']).read_text();print(diag,flush=True);return 1
    audit=(ROOT/receipt['compilation'][-1]['stdout']).read_text();assert audit.count('Closed under the global context')==5 and not audit.replace('Closed under the global context','').strip(),audit
    receipt['assumptions']={'globally_closed_theorems':5,'new_axioms':[],'raw_audit':receipt['compilation'][-1]['stdout']};receipt['kernel_check']=measure([COQ/'coqchk','-silent',*flags,'Candidate'],folder/'kernel-check',src);assert receipt['kernel_check']['exit_code']==0;receipt['status']='KERNEL_CHECKED';receipt['final_status']='FAIL';save(folder/'coq-receipt.json',receipt)
    for p in src.iterdir():
      if p.suffix in ['.vo','.vos','.vok','.glob','.aux'] or p.name in ['.lia.cache','.nia.cache']:p.unlink()
    print('KERNEL_CHECKED',group,index,attempt,flush=True);return 0

def main():
 p=argparse.ArgumentParser();p.add_argument('action',choices=['prepare','compile']);p.add_argument('--group',required=True);p.add_argument('--task-root',type=Path,required=True);p.add_argument('--execution',type=int);p.add_argument('--attempt',type=int,default=1);a=p.parse_args()
 if a.action=='prepare':prepare(a.group,a.task_root)
 else:raise SystemExit(compile_one(a.group,a.task_root,a.execution,a.attempt))
if __name__=='__main__':main()
