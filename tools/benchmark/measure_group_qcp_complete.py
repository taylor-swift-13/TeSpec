#!/usr/bin/env python3
"""Meter complete universal QCP proof for a group with exact source and VC locks."""
from pathlib import Path
import argparse,json,re,shlex,shutil
from meter_read_itp_coq import ROOT,COQ,RUNTIME,measure,save,sha

def main():
    p=argparse.ArgumentParser();p.add_argument('--group',required=True);p.add_argument('--task-dir',type=Path,required=True);a=p.parse_args()
    out=ROOT/'benchmark/results'/a.group/'20261016-qcp-verify-complete';assert not(out/'receipt.json').exists(),'Never overwrite recorded verification'
    nativepath=ROOT/'benchmark/results'/a.group/'20261016-primary-native/receipt.json';native=json.loads(nativepath.read_text());task=a.task_dir;model=json.loads((task/'attempt-1/model-receipt.json').read_text());assert model['exit_code']==0 and model['requested_model']=='gpt-6.1-sol'
    src=out/'proofs';src.mkdir(parents=True,exist_ok=True)
    for name in ['model-receipt.json','usage-events.json','agent.stdout.jsonl','agent.stderr.log']:shutil.copyfile(task/'attempt-1'/name,out/name)
    shutil.copyfile(task/'prompt.txt',out/'prompt.txt');shutil.copyfile(task/'attempt-1/Candidate.v',src/'Candidate.v');shutil.copyfile(task/'PrimaryQcpGoal.v',src/'PrimaryQcpGoal.v')
    assert sha(src/'Candidate.v')==model['candidate_sha256'];assert sha(src/'PrimaryQcpGoal.v')==model['locked_goal_and_helper_sha256']['PrimaryQcpGoal.v']==native['goal_sha256']==sha(ROOT/native['goal'])
    text=(src/'Candidate.v').read_text();assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',text)
    names=re.findall(r'Definition (\w+) :=',(src/'PrimaryQcpGoal.v').read_text());assert names
    for name in names:
        assert re.search(r'Theorem\s+primary_'+name+r'\s*:\s*PrimaryQcpGoal\.'+name+r'\.',text)
        assert 'Print Assumptions primary_'+name+'.' in text
        assert 'Definition proof_of_'+name+' := primary_'+name+'.' in text
    assert 'Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.' in text
    tokens=shlex.split((RUNTIME/'_CoqProject').read_text());flags=[str(RUNTIME/t) if i%3==1 else t for i,t in enumerate(tokens)]+['-Q',str(src),'']
    receipt={'schema':'tespec-qcp-complete-primary-verification/v1','program_group':a.group,'scope':'Original unbound universal VC_Correct implemented, all emitted obligations proved. No concrete input bindings.','native_receipt':str(nativepath.relative_to(ROOT)),'native':native['qcp'],'goal':str((src/'PrimaryQcpGoal.v').relative_to(ROOT)),'original_goal':native['goal'],'original_goal_sha256':native['goal_sha256'],'proof':str((src/'Candidate.v').relative_to(ROOT)),'proof_sha256':sha(src/'Candidate.v'),'model':model,'obligations':names,'compilation':[]}
    for path in [src/'PrimaryQcpGoal.v',src/'Candidate.v']:
        m=measure([COQ/'coqc',*flags,path],out/'compilation'/path.stem,src);receipt['compilation'].append(m);save(out/'pending-receipt.json',receipt);assert m['exit_code']==0,(ROOT/m['stderr']).read_text();print(path.name,'compiled',flush=True)
    audit=(ROOT/receipt['compilation'][-1]['stdout']).read_text();closed=audit.count('Closed under the global context');addr=audit.count('Axioms:\neval_addr_expr : rvalue_expr -> addr');assert closed+addr==len(names),audit
    assert not audit.replace('Closed under the global context','').replace('Axioms:\neval_addr_expr : rvalue_expr -> addr','').strip(),audit
    receipt['assumptions']={'globally_closed_obligations':closed,'obligations_with_runtime_address_parameter':addr,'allowed_runtime_parameters':['eval_addr_expr : rvalue_expr -> addr'] if addr else [],'new_proof_axioms':[],'parameter_source':'runtime/qcip/SeparationLogic/SeparationLogic/CNotation.v:46' if addr else None,'raw_audit':receipt['compilation'][-1]['stdout']}
    receipt['kernel_check']=measure([COQ/'coqchk','-silent',*flags,'Candidate'],out/'kernel-check',src);assert receipt['kernel_check']['exit_code']==0
    usage={}
    for event in model['token_usage']:
        for k,v in event.items():usage[k]=usage.get(k,0)+v
    usage['total_tokens']=usage['input_tokens']+usage['output_tokens'];peak=max([model['resources']['max_process_peak_working_set_bytes'],native['qcp']['resources']['max_process_rss_kib']*1024]+[s['resources']['max_process_rss_kib']*1024 for s in receipt['compilation']+[receipt['kernel_check']]])
    metrics={'tool':'qcp','scope':receipt['scope'],'native_auto_wall_seconds':native['qcp']['wall_seconds'],'model_wall_seconds':model['wall_seconds'],'coq_compile_audit_wall_seconds':sum(s['wall_seconds'] for s in receipt['compilation']),'kernel_wall_seconds':receipt['kernel_check']['wall_seconds'],'wall_seconds':native['qcp']['wall_seconds']+model['wall_seconds']+sum(s['wall_seconds'] for s in receipt['compilation'])+receipt['kernel_check']['wall_seconds'],'native_peak_process_rss_kib':native['qcp']['resources']['max_process_rss_kib'],'model_client_peak_working_set_bytes':model['resources']['max_process_peak_working_set_bytes'],'peak_process_resident_bytes':peak,'peak_process_resident_mib':peak/1048576,'requested_model':'gpt-6.1-sol','model_calls':1,'token_usage':usage,'tokens':usage['total_tokens'],'verification_runs_counted':1,'memory_definition':'Largest local process RSS or Windows client PeakWorkingSet across disjoint stages; excludes remote model/GPU memory.'}
    receipt['metrics']=metrics;receipt['status']='VERIFIED_KERNEL_CHECKED';save(out/'receipt.json',receipt);save(out/'statistics.json',metrics);(out/'pending-receipt.json').unlink();print(json.dumps(metrics),flush=True)
if __name__=='__main__':main()
