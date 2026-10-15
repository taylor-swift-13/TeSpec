#!/usr/bin/env python3
"""Meter complete universal QCP proof for a group with exact source and VC locks."""
from pathlib import Path
import argparse,json,re,shlex,shutil
from meter_read_itp_coq import ROOT,COQ,RUNTIME,measure,save,sha

def main():
    p=argparse.ArgumentParser();p.add_argument('--group',required=True);p.add_argument('--task-dir',type=Path,required=True);p.add_argument('--attempt',type=int,default=1);a=p.parse_args()
    out=ROOT/'benchmark/results'/a.group/'20261016-qcp-verify-complete';assert not(out/'receipt.json').exists(),'Never overwrite recorded verification'
    nativepath=ROOT/'benchmark/results'/a.group/'20261016-primary-native/receipt.json';native=json.loads(nativepath.read_text());native_attempts=[native['qcp']]+([native['initial_configuration_attempt']] if native.get('initial_configuration_attempt') else []);native_wall=sum(m['wall_seconds'] for m in native_attempts);native_rss=max(m['resources']['max_process_rss_kib'] for m in native_attempts);task=a.task_dir;model=json.loads((task/f'attempt-{a.attempt}/model-receipt.json').read_text());assert model['exit_code']==0 and model['requested_model']=='gpt-6.1-sol'
    actual_prompt=task/f'attempt-{a.attempt}/prompt.txt';actual_prompt=actual_prompt if actual_prompt.exists() else task/'prompt.txt';assert sha(actual_prompt)==model['prompt_sha256'],'Model prompt changed after invocation; restore original metered prompt before publication'
    src=out/'proofs';src.mkdir(parents=True,exist_ok=True)
    previous=json.loads((out/'pending-receipt.json').read_text()) if (out/'pending-receipt.json').exists() else None
    if previous:
        archive=out/'model-attempts'/('attempt-'+str(a.attempt-1));archive.mkdir(parents=True,exist_ok=True)
        for oldname in ['model-receipt.json','usage-events.json','agent.stdout.jsonl','agent.stderr.log','prompt.txt']:
            if (out/oldname).exists():shutil.copyfile(out/oldname,archive/oldname)
        shutil.copyfile(src/'Candidate.v',archive/'Candidate.v')
        save(archive/'controller-receipt.json',previous)
    for name in ['model-receipt.json','usage-events.json','agent.stdout.jsonl','agent.stderr.log']:shutil.copyfile(task/f'attempt-{a.attempt}'/name,out/name)
    shutil.copyfile(actual_prompt,out/'prompt.txt');shutil.copyfile(task/f'attempt-{a.attempt}/Candidate.v',src/'Candidate.v');shutil.copyfile(task/'PrimaryQcpGoal.v',src/'PrimaryQcpGoal.v')
    assert sha(src/'Candidate.v')==model['candidate_sha256'];assert sha(src/'PrimaryQcpGoal.v')==model['locked_goal_and_helper_sha256']['PrimaryQcpGoal.v']==native['goal_sha256']==sha(ROOT/native['goal'])
    text=(src/'Candidate.v').read_text()
    if re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',text):
        save(out/'pending-receipt.json',{'schema':'tespec-qcp-complete-primary-verification/v1','status':'REJECTED_UNFILLED_OR_INVALID_CANDIDATE','model':model,'models':(previous.get('models',[previous['model']]) if previous else [])+[model],'compilation':previous['compilation'] if previous else []})
        raise AssertionError('Unfilled or invalid Candidate; actual model attempt retained, no proof accepted')
    interface=(src/'PrimaryQcpGoal.v').read_text().split('Module Type VC_Correct.')[1].split('End VC_Correct.')[0];names=re.findall(r'Axiom \w+\s*:\s*(\w+)\.',interface);assert names
    for name in names:
        assert re.search(r'Theorem\s+primary_'+name+r'\s*:\s*PrimaryQcpGoal\.'+name+r'\.',text)
        assert 'Print Assumptions primary_'+name+'.' in text
        assert 'Definition proof_of_'+name+' := primary_'+name+'.' in text
    assert 'Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.' in text
    tokens=shlex.split((RUNTIME/'_CoqProject').read_text());flags=[str(RUNTIME/t) if i%3==1 else t for i,t in enumerate(tokens)]+['-Q',str(src),'']
    receipt={'schema':'tespec-qcp-complete-primary-verification/v1','program_group':a.group,'scope':'Original unbound universal VC_Correct implemented, all emitted obligations proved. No concrete input bindings.','native_receipt':str(nativepath.relative_to(ROOT)),'native':native['qcp'],'native_attempts':native_attempts,'goal':str((src/'PrimaryQcpGoal.v').relative_to(ROOT)),'original_goal':native['goal'],'original_goal_sha256':native['goal_sha256'],'proof':str((src/'Candidate.v').relative_to(ROOT)),'proof_sha256':sha(src/'Candidate.v'),'model':model,'obligations':names,'compilation':previous['compilation'] if previous else [],'models':(previous.get('models',[previous['model']]) if previous else [])+[model]}
    context_files=[]
    context_path=task/'proof-context.json'
    if context_path.exists():
        context=json.loads(context_path.read_text());receipt['proof_context']=context
        for item in context['files']:
            original=ROOT/item['original_source'];assert sha(original)==item['sha256']
            assert item['name']==Path(item['name']).name and item['name'].endswith('.v')
            supplied=task/item['name'];assert sha(supplied)==item['sha256']
            assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',supplied.read_text()),'Context must be definitions/proofs without new axioms'
            shutil.copyfile(supplied,src/item['name']);context_files.append(src/item['name'])
    for path in context_files+[src/'PrimaryQcpGoal.v',src/'Candidate.v']:
        m=measure([COQ/'coqc',*flags,path],out/'compilation'/('attempt-'+str(a.attempt))/path.stem,src);receipt['compilation'].append(m);save(out/'pending-receipt.json',receipt);assert m['exit_code']==0,(ROOT/m['stderr']).read_text();print(path.name,'compiled',flush=True)
    audit=(ROOT/receipt['compilation'][-1]['stdout']).read_text();closed=audit.count('Closed under the global context');addr=audit.count('Axioms:\neval_addr_expr : rvalue_expr -> addr');assert closed+addr==len(names),audit
    assert not audit.replace('Closed under the global context','').replace('Axioms:\neval_addr_expr : rvalue_expr -> addr','').strip(),audit
    receipt['assumptions']={'globally_closed_obligations':closed,'obligations_with_runtime_address_parameter':addr,'allowed_runtime_parameters':['eval_addr_expr : rvalue_expr -> addr'] if addr else [],'new_proof_axioms':[],'parameter_source':'runtime/qcip/SeparationLogic/SeparationLogic/CNotation.v:46' if addr else None,'raw_audit':receipt['compilation'][-1]['stdout']}
    receipt['kernel_check']=measure([COQ/'coqchk','-silent',*flags,'Candidate'],out/'kernel-check',src);assert receipt['kernel_check']['exit_code']==0
    usage={}
    for attempt_model in receipt['models']:
        for event in attempt_model['token_usage']:
            for k,v in event.items():usage[k]=usage.get(k,0)+v
    usage['total_tokens']=usage['input_tokens']+usage['output_tokens'];peak=max([max(m['resources']['max_process_peak_working_set_bytes'] for m in receipt['models']),native_rss*1024]+[s['resources']['max_process_rss_kib']*1024 for s in receipt['compilation']+[receipt['kernel_check']]])
    metrics={'tool':'qcp','scope':receipt['scope'],'native_auto_wall_seconds':native_wall,'native_attempts_count':len(native_attempts),'model_wall_seconds':sum(m['wall_seconds'] for m in receipt['models']),'coq_compile_audit_wall_seconds':sum(s['wall_seconds'] for s in receipt['compilation']),'kernel_wall_seconds':receipt['kernel_check']['wall_seconds'],'wall_seconds':native_wall+sum(m['wall_seconds'] for m in receipt['models'])+sum(s['wall_seconds'] for s in receipt['compilation'])+receipt['kernel_check']['wall_seconds'],'native_peak_process_rss_kib':native_rss,'model_client_peak_working_set_bytes':max(m['resources']['max_process_peak_working_set_bytes'] for m in receipt['models']),'peak_process_resident_bytes':peak,'peak_process_resident_mib':peak/1048576,'requested_model':'gpt-6.1-sol','model_calls':len(receipt['models']),'token_usage':usage,'tokens':usage['total_tokens'],'verification_runs_counted':1,'memory_definition':'Largest local process RSS or Windows client PeakWorkingSet across disjoint stages; excludes remote model/GPU memory.'}
    receipt['metrics']=metrics;receipt['status']='VERIFIED_KERNEL_CHECKED';save(out/'receipt.json',receipt);save(out/'statistics.json',metrics);(out/'pending-receipt.json').unlink();print(json.dumps(metrics),flush=True)
if __name__=='__main__':main()
