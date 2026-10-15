#!/usr/bin/env python3
"""Complete the primary's original universal QCP VC and meter every stage."""
from pathlib import Path
import hashlib, json, re, shlex, shutil, subprocess
from meter_read_itp_coq import measure, sha, save, ROOT, COQ, RUNTIME

TASK=Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/abs-qcp-metered')
OUT=ROOT/'benchmark/results/abs/20261016-qcp-verify-complete'

def main():
    src=OUT/'proofs';src.mkdir(parents=True,exist_ok=True)
    assert not (OUT/'receipt.json').exists(),'Do not overwrite a recorded run'
    model=json.loads((TASK/'attempt-1/model-receipt.json').read_text())
    assert model['exit_code']==0 and model['requested_model']=='gpt-6.1-sol' and model['token_usage']
    for name in ['model-receipt.json','usage-events.json','agent.stdout.jsonl','agent.stderr.log']:
        shutil.copyfile(TASK/'attempt-1'/name,OUT/name)
    shutil.copyfile(TASK/'prompt.txt',OUT/'prompt.txt')
    shutil.copyfile(TASK/'attempt-1/Candidate.v',src/'Candidate.v')
    shutil.copyfile(TASK/'PrimaryQcpGoal.v',src/'PrimaryQcpGoal.v')
    assert sha(src/'Candidate.v')==model['candidate_sha256']
    assert sha(src/'PrimaryQcpGoal.v')==model['locked_goal_and_helper_sha256']['PrimaryQcpGoal.v']
    candidate=(src/'Candidate.v').read_text()
    assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',candidate)
    assert re.search(r'Theorem\s+primary_abs_return_wit_1\s*:\s*PrimaryQcpGoal\.abs_return_wit_1\.',candidate)
    assert 'Module PrimaryAbsCertificate : PrimaryQcpGoal.VC_Correct.' in candidate
    assert 'Print Assumptions primary_abs_return_wit_1.' in candidate
    for name in ['abs_safety_wit_1','abs_safety_wit_2','abs_return_wit_1','abs_return_wit_2']:
        assert re.search(r'Theorem\s+primary_'+name+r'\s*:\s*PrimaryQcpGoal\.'+name+r'\.',candidate)
        assert 'Print Assumptions primary_'+name+'.' in candidate
    old=ROOT/'benchmark/results/historical/selection/paired-mutations/performance/20261015-positive18/automatic-final/abs/repeat-1/qcp/native/vc/qcp_goal.v'
    assert sha(old)==sha(src/'PrimaryQcpGoal.v')
    tokens=shlex.split((RUNTIME/'_CoqProject').read_text());flags=[str(RUNTIME/t) if i%3==1 else t for i,t in enumerate(tokens)]+['-Q',str(src),'']
    receipt={'schema':'tespec-qcp-complete-primary-verification/v1','model':model,'scope':'Original universal QCP abs VCs; no concrete input bindings; native generation reused, proof artifact generation and kernel checking freshly metered.',
             'original_goal':old.relative_to(ROOT).as_posix(),'original_goal_sha256':sha(old),'goal':(src/'PrimaryQcpGoal.v').relative_to(ROOT).as_posix(),
             'proof':(src/'Candidate.v').relative_to(ROOT).as_posix(),'proof_sha256':sha(src/'Candidate.v'),'compilation':[]}
    prior=OUT/'initial-audit-compilation.json'
    if not prior.exists():
        prior_stages=[]
        for name in ['PrimaryQcpGoal','Candidate']:
            folder=OUT/'compilation'/name
            if (folder/'resources.json').exists():
                prior_stages.append({'stage':name,'resources':json.loads((folder/'resources.json').read_text()),'stdout':str((folder/'stdout.log').relative_to(ROOT)),'stderr':str((folder/'stderr.log').relative_to(ROOT))})
        save(prior,{'note':'Initial compilation succeeded, controller expected all four assumption audits closed. Two original statements contain runtime eval_addr_expr parameter. Raw initial process resources retained; follow-up compilation counted below.','stages':prior_stages})
    for p in [src/'PrimaryQcpGoal.v',src/'Candidate.v']:
        stage=measure([COQ/'coqc',*flags,p],OUT/'compilation-confirmed'/p.stem,src);receipt['compilation'].append(stage)
        assert stage['exit_code']==0,(ROOT/stage['stderr']).read_text()
        print(p.name,'compiled','RSS KiB',stage['resources']['max_process_rss_kib'],flush=True)
    audit=(ROOT/receipt['compilation'][-1]['stdout']).read_text()
    assert audit.count('Closed under the global context')==2,audit
    assert audit.count('Axioms:\neval_addr_expr : rvalue_expr -> addr')==2,audit
    assert audit.replace('Closed under the global context','').replace('Axioms:\neval_addr_expr : rvalue_expr -> addr','').strip()=='',audit
    receipt['assumptions']={'return_obligations':'Closed under the global context','safety_obligations':['eval_addr_expr : rvalue_expr -> addr'],'interpretation':'The unchanged original safety VC statements reference the runtime abstract address interpretation parameter. No new proof axioms; original VC and runtime parameter retained. This is not a globally closed certificate.','parameter_source':'runtime/qcip/SeparationLogic/SeparationLogic/CNotation.v:46'}
    save(OUT/'pending-receipt.json',receipt)
    receipt['kernel_check']=measure([COQ/'coqchk','-silent',*flags,'Candidate'],OUT/'kernel-check',src)
    assert receipt['kernel_check']['exit_code']==0
    receipt['status']='VERIFIED_KERNEL_CHECKED'
    perf=ROOT/'benchmark/results/historical/selection/paired-mutations/performance/20261015-positive18/automatic-final/raw-results.json'
    data=json.loads(perf.read_text());ri,row=next((i,r) for i,r in enumerate(data['runs']) if r['source']=='abs' and r['repeat']==1)
    native=row['qcp_auto'];assert native['native_result']=='success' and native['manual']==0
    receipt['native']={'report':perf.relative_to(ROOT).as_posix(),'pointer':f'/runs/{ri}/qcp_auto','measurement':native}
    usage={}
    for event in model['token_usage']:
        for k,v in event.items():usage[k]=usage.get(k,0)+v
    usage['total_tokens']=usage['input_tokens']+usage['output_tokens']
    coq_peak=max(s['resources']['max_process_rss_kib'] for s in receipt['compilation']+[receipt['kernel_check']])
    peak=max(coq_peak*1024,model['resources']['max_process_peak_working_set_bytes'],native['resources']['max_process_rss_kib']*1024)
    metrics={'tool':'qcp','scope':'Complete primary universal verification: reused native VC generation + metered gpt-6.1-sol proof generation + Coq compilation/audit + independent kernel replay.',
             'native_auto_wall_seconds':native['wall_seconds'],'model_wall_seconds':model['wall_seconds'],
             'coq_compile_audit_wall_seconds':sum(s['wall_seconds'] for s in receipt['compilation']),
             'kernel_wall_seconds':receipt['kernel_check']['wall_seconds'],
             'wall_seconds':native['wall_seconds']+model['wall_seconds']+sum(s['wall_seconds'] for s in receipt['compilation'])+receipt['kernel_check']['wall_seconds'],
             'native_peak_process_rss_kib':native['resources']['max_process_rss_kib'],'coq_peak_process_rss_kib':coq_peak,
             'model_client_peak_working_set_bytes':model['resources']['max_process_peak_working_set_bytes'],
             'peak_process_resident_bytes':peak,'peak_process_resident_mib':peak/1048576,
             'requested_model':'gpt-6.1-sol','model_calls':1,'token_usage':usage,'tokens':usage['total_tokens'],'verification_runs_counted':1,
             'memory_definition':'Maximum local process resident memory across sequential native, Windows model-client and Coq stages; excludes remote model service/GPU memory; not aggregate concurrent tree memory.'}
    receipt['metrics']=metrics;save(OUT/'receipt.json',receipt);save(OUT/'statistics.json',metrics)
    (OUT/'pending-receipt.json').unlink(missing_ok=True)
    print(json.dumps(metrics),flush=True)

if __name__=='__main__':main()
