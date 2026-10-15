#!/usr/bin/env python3
"""Isolated read ITP per execution; fresh model call and full Coq replay per case."""
from pathlib import Path
import argparse,collections,csv,hashlib,io,json,re,shlex,shutil,subprocess
from meter_read_itp_coq import measure,statements,COQ,RUNTIME,ROOT
OUT=ROOT/'benchmark/results/read/20261015-itp-per-execution'
TASK=Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/read-itp-per-execution')
OLD=ROOT/'benchmark/results/read/20261015-itp-refutations'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,d):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
def prepare():
    cases=json.loads((OLD/'receipt.json').read_text())['cases']
    helper=(OLD/'proofs/ReadCounterHeap.v').read_text();header=helper.split('Definition st ')[0]
    for i,row in enumerate(cases):
        task=TASK/f'execution-{i:02d}'
        if (task/'binding.json').exists():continue
        task.mkdir(parents=True,exist_ok=True)
        goal=ROOT/row['goal_copy'];assert sha(goal)==row['original_goal_sha256']
        shutil.copyfile(goal,task/goal.name);(task/'ReadCounterHeap.v').write_text(helper)
        mod=goal.stem;candidate='Require Import ReadCounterHeap '+mod+'.\n'+header
        for label,target in [('return_refuted','~ '+mod+'.read_return_wit_1'),('spatial_refuted','~ '+mod+'.read_return_wit_1_split_goal_spatial'),('entry_sat',mod+'.read_precondition_wit_1')]:
            candidate+=f'\nTheorem case_{i:02d}_{label} : {target}.\nProof. Admitted.\n'
        for label in ['return_refuted','spatial_refuted','entry_sat']:candidate+=f'Print Assumptions case_{i:02d}_{label}.\n'
        (task/'Candidate.v').write_text(candidate);(task/'template.txt').write_text(candidate)
        prompt='Construct Coq 8.20 proofs in Candidate.v for this ONE test execution, including all its supplied obligations. Preserve every statement, import and Print Assumptions. Refute return/spatial VCs and prove entry satisfiability. The checked concrete heap helper is reusable; original goal is immutable. No Admitted, admit, new axioms/parameters, changed definitions or imported refutation solutions. Only edit Candidate.v. Do not inspect outside this task, call models, delegate, compile or run shell commands. External compilation and kernel replay are controller-owned and separately measured. For reduced boolean/comparison equalities use appropriate computation/reflexivity or arithmetic tactics.\n\nImmutable helper:\n'+helper+'\n\nImmutable goal module '+goal.name+':\n'+goal.read_text()+'\n\nCandidate template:\n'+candidate
        (task/'prompt.txt').write_text(prompt);save(task/'binding.json',{'execution_index':i,'original':row})
    print('Prepared 12 isolated execution tasks, one original goal module and three obligations each.',flush=True)
def compile_one(i,attempt):
    task=TASK/f'execution-{i:02d}';folder=OUT/f'execution-{i:02d}'/f'attempt-{attempt}';src=folder/'proofs'
    assert not (folder/'coq-receipt.json').exists(),'Never overwrite measured attempt'
    src.mkdir(parents=True,exist_ok=True);modeldir=task/f'attempt-{attempt}'
    model=json.loads((modeldir/'model-receipt.json').read_text());assert model['exit_code']==0 and model['token_usage'] and model['requested_model']=='gpt-6.1-sol'
    for name in ['model-receipt.json','usage-events.json']:shutil.copyfile(modeldir/name,folder/name)
    shutil.copyfile(modeldir/'agent.stdout.jsonl',folder/'agent.stdout.log')
    shutil.copyfile(modeldir/'agent.stderr.log',folder/'agent.stderr.log')
    shutil.copyfile(task/'prompt.txt',folder/'prompt.txt');shutil.copyfile(task/'binding.json',folder/'binding.json')
    candidate=(modeldir/'Candidate.v').read_text();template=(task/'template.txt').read_text()
    assert statements(candidate)==statements(template) and len(statements(candidate))==3
    assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',candidate)
    for name,digest in model['locked_goal_and_helper_sha256'].items():
        assert sha(task/name)==digest;shutil.copyfile(task/name,src/name)
    shutil.copyfile(modeldir/'Candidate.v',src/'Candidate.v');assert sha(src/'Candidate.v')==model['candidate_sha256']
    parts=shlex.split((RUNTIME/'_CoqProject').read_text());flags=[str(RUNTIME/t) if k%3==1 else t for k,t in enumerate(parts)]+['-Q',str(src),'']
    report={'schema':'tespec-per-execution-coq/v1','execution_index':i,'attempt':attempt,'model_receipt':(folder/'model-receipt.json').relative_to(ROOT).as_posix(),'candidate':(src/'Candidate.v').relative_to(ROOT).as_posix(),'candidate_sha256':sha(src/'Candidate.v'),'compilation':[],'status':'COMPILING'}
    for p in [src/'ReadCounterHeap.v',*sorted(src.glob('ReadUnknown*Goal.v')),src/'Candidate.v']:
        stage=measure([COQ/'coqc',*flags,p],folder/'compilation'/p.stem,src);stage.update(source=p.relative_to(ROOT).as_posix(),source_sha256=sha(p));report['compilation'].append(stage);save(folder/'coq-receipt.json',report)
        print(f'execution {i:02d} {p.name}: exit {stage["exit_code"]}',flush=True)
        if stage['exit_code']:
            report['status']='COMPILE_FAILED';save(folder/'coq-receipt.json',report)
            (task/'repair-diagnostic.txt').write_text((ROOT/stage['stderr']).read_text());return 1
    assert (ROOT/report['compilation'][-1]['stdout']).read_text().count('Closed under the global context')==3
    report['assumption_audit']='3 Closed under the global context'
    report['kernel_check']=measure([COQ/'coqchk','-silent',*flags,'Candidate'],folder/'kernel-check',src)
    report['status']='KERNEL_CHECKED' if report['kernel_check']['exit_code']==0 else 'KERNEL_CHECK_FAILED';save(folder/'coq-receipt.json',report)
    print(f'execution {i:02d}: {report["status"]}, kernel {report["kernel_check"]["wall_seconds"]:.3f}s',flush=True)
    # Delete only generated Coq binaries/caches after capturing all proof evidence.
    for p in src.iterdir():
        if p.suffix in ['.vo','.vos','.vok','.glob'] or p.name.endswith('.aux') or p.name in ['.lia.cache','.nia.cache']:p.unlink()
    return 0 if report['status']=='KERNEL_CHECKED' else 1

def status(i):
    attempts=[json.loads(p.read_text()) for p in sorted((OUT/f'execution-{i:02d}').glob('attempt-*/coq-receipt.json'))]
    print(json.dumps({'accepted':bool(attempts and attempts[-1]['status']=='KERNEL_CHECKED'),'next_attempt':max((a['attempt'] for a in attempts),default=0)+1}),flush=True)

def summarize():
    previous=json.loads((OLD/'receipt.json').read_text());cases=[];attempts=[];models=[];executions=[]
    for i,old in enumerate(previous['cases']):
        aa=[json.loads(p.read_text()) for p in sorted((OUT/f'execution-{i:02d}').glob('attempt-*/coq-receipt.json'))]
        assert aa and aa[-1]['status']=='KERNEL_CHECKED'
        mm=[json.loads((ROOT/a['model_receipt']).read_text()) for a in aa];attempts.extend(aa);models.extend(mm)
        comp=[s for a in aa for s in a['compilation']];kern=[a['kernel_check'] for a in aa if 'kernel_check' in a]
        usage=collections.Counter()
        for m in mm:
            for turn in m['token_usage']:usage.update(turn)
        usage['total_tokens']=usage['input_tokens']+usage['output_tokens']
        mt=sum(m['wall_seconds'] for m in mm);ct=sum(s['wall_seconds'] for s in comp);kt=sum(s['wall_seconds'] for s in kern)
        coqpeak=max(s['resources']['max_process_rss_kib'] for s in comp+kern);mp=max(m['resources']['max_process_peak_working_set_bytes'] for m in mm)
        metrics={'model_wall_seconds':mt,'coq_compile_audit_wall_seconds':ct,'kernel_wall_seconds':kt,'total_itp_wall_seconds':mt+ct+kt,'model_calls':len(mm),'token_usage':dict(usage),'coq_peak_process_rss_kib':coqpeak,'model_client_peak_working_set_bytes':mp,'local_peak_process_resident_bytes':max(coqpeak*1024,mp)}
        accepted=aa[-1];goal=accepted['compilation'][1];row=dict(old);row.update(goal_copy=goal['source'],goal_copy_sha256=goal['source_sha256'],proof=accepted['candidate'],proof_sha256=accepted['candidate_sha256'],goal_compile=goal,refutation_compile=accepted['compilation'][-1],theorems=[f'case_{i:02d}_{kind}' for kind in ['return_refuted','spatial_refuted','entry_sat']],assumptions='3 Closed under the global context',itp_status='REFUTED_KERNEL_CHECKED',resolved_test_status='FAIL',execution_index=i,itp_metrics=metrics,itp_receipt=(OUT/f'execution-{i:02d}/receipt.json').relative_to(ROOT).as_posix())
        per={'execution_index':i,'variant':row['variant'],'case':row['case'],'original_test_report':row['original_test_report'],'attempts':aa,'models':mm,'metrics':metrics,'status':'REFUTED_KERNEL_CHECKED','case_binding':row}
        save(OUT/f'execution-{i:02d}/receipt.json',per);executions.append(per);cases.append(row)
    usage=collections.Counter()
    for e in executions:usage.update(e['metrics']['token_usage'])
    metrics={k:sum(e['metrics'][k] for e in executions) for k in ['model_wall_seconds','coq_compile_audit_wall_seconds','kernel_wall_seconds','total_itp_wall_seconds','model_calls']}
    metrics.update(requested_model='gpt-6.1-sol',token_usage=dict(usage),coq_peak_process_rss_kib=max(e['metrics']['coq_peak_process_rss_kib'] for e in executions),model_client_peak_working_set_bytes=max(e['metrics']['model_client_peak_working_set_bytes'] for e in executions),local_peak_process_resident_bytes=max(e['metrics']['local_peak_process_resident_bytes'] for e in executions),execution_count=12,measurement_mode='INDEPENDENT_PER_TEST_EXECUTION',memory_definition='Largest measured local process resident memory across independent execution ITP runs; not a sum or divided batch peak.',reuse_definition='Only the checked concrete-heap helper is reused; separately recompiled within each execution. One isolated model proof task and independent kernel replay per execution; all attempts counted.')
    metrics['local_peak_process_resident_mib']=metrics['local_peak_process_resident_bytes']/1048576
    metrics['per_execution_mean']={k:metrics[k]/12 for k in ['model_wall_seconds','coq_compile_audit_wall_seconds','kernel_wall_seconds','total_itp_wall_seconds']}
    metrics['per_execution_mean']['token_usage']={k:v/12 for k,v in metrics['token_usage'].items()}
    report={'schema':'tespec-read-per-execution-itp/v1','cases':cases,'attempts':attempts,'models':models,'executions':executions,'metrics':metrics,'summary':{'formally_refuted':12,'entry_satisfiable_proved':12,'spatial_splits_refuted':12,'assumption_audits_closed':36,'kernel_check_exit':0,'independent_execution_itp_tasks':12,'model_calls_including_repairs':len(models),'failed_attempts':sum(a['status']!='KERNEL_CHECKED' for a in attempts),'successful_independent_kernel_replays':12}}
    save(OUT/'receipt.json',report);save(OUT/'statistics.json',metrics)
    rows=[{'execution_index':e['execution_index'],'variant':e['variant'],'case':e['case'],'attempts':len(e['attempts']),'agent_proof_seconds':e['metrics']['model_wall_seconds'],'coq_compile_audit_seconds':e['metrics']['coq_compile_audit_wall_seconds'],'kernel_check_seconds':e['metrics']['kernel_wall_seconds'],'itp_seconds':e['metrics']['total_itp_wall_seconds'],'input_tokens':e['metrics']['token_usage']['input_tokens'],'output_tokens':e['metrics']['token_usage']['output_tokens'],'total_tokens':e['metrics']['token_usage']['total_tokens'],'peak_process_memory_mib':e['metrics']['local_peak_process_resident_bytes']/1048576,'receipt':e['case_binding']['itp_receipt']} for e in executions]
    buf=io.StringIO();writer=csv.DictWriter(buf,fieldnames=list(rows[0]),lineterminator='\n');writer.writeheader();writer.writerows(rows);(OUT/'executions.csv').write_text(buf.getvalue())

    for attempt in attempts:
        for p in (ROOT/attempt['candidate']).parent.iterdir():
            if p.suffix in ['.vo','.vos','.vok','.glob'] or p.name.endswith('.aux') or p.name in ['.lia.cache','.nia.cache']:p.unlink()
    resolved=json.loads((OLD/'resolved-results.json').read_text())
    for key in ['helper_compile_wall_seconds','goal_and_refutation_compile_wall_seconds','kernel_check_wall_seconds','unsuccessful_authoring_attempts','measured_compile_and_kernel_wall_seconds_including_failed_attempts','measured_full_itp_wall_seconds_including_model_and_failed_attempts']:
        resolved.pop(key,None)
    resolved.update(schema='tespec-per-execution-read-itp-adjudication/v1',peak_rss=metrics['local_peak_process_resident_bytes'],peak_rss_note=metrics['memory_definition'],proof_authoring_chat_tokens=None,token_note='Actual CLI usage summed across independent execution tasks and every repair attempt.',coq_kernel_exit=0)
    resolved['metrics']=metrics;resolved['external_model_api_calls']=None;resolved['model_cli_invocations_including_repairs']=metrics['model_calls'];resolved['proof_authoring_model_tokens']=usage['total_tokens']
    for c in resolved['cases']:
        match=next((x for x in cases if x['variant']==c['variant'] and x['case']==c['case']),None)
        if match:c.update(itp_proof=match['proof'],itp_theorems=match['theorems'],itp_receipt=match['itp_receipt'])
    save(OUT/'resolved-results.json',resolved)
    p=ROOT/'benchmark/results/read/index.json';index=json.loads(p.read_text());index.setdefault('adjudications',[]).append({'kind':'INDEPENDENT_PER_EXECUTION_GPT61_COQ_KERNEL_CHECKED_REFUTATION','receipt':(OUT/'receipt.json').relative_to(ROOT).as_posix(),'resolved_results':(OUT/'resolved-results.json').relative_to(ROOT).as_posix()});index['adjudications']=list({x['receipt']:x for x in index['adjudications']}.values());index['active_itp_receipt']=(OUT/'receipt.json').relative_to(ROOT).as_posix();save(p,index)
    print(json.dumps(metrics),flush=True)

def validate():
    report=json.loads((OUT/'receipt.json').read_text());assert len(report['executions'])==12
    for i,e in enumerate(report['executions']):
        assert e['execution_index']==i and e['status']=='REFUTED_KERNEL_CHECKED'
        assert len(e['attempts'])==len(e['models'])>=1
        c=e['case_binding'];assert sha(ROOT/c['original_goal'])==c['original_goal_sha256']==sha(ROOT/c['goal_copy'])
        for a,m in zip(e['attempts'],e['models']):
            assert m['requested_model']=='gpt-6.1-sol' and [n for n in m['locked_goal_and_helper_sha256'] if n.startswith('ReadUnknown')]==[f'ReadUnknown{i:02d}Goal.v']
            assert m['command'][m['command'].index('--model')+1]=='gpt-6.1-sol'
            assert m['wall_seconds']>0 and m['resources']['max_process_peak_working_set_bytes']>0
            events=json.loads((ROOT/a['model_receipt']).with_name('usage-events.json').read_text());assert [x['usage'] for x in events if x['type']=='turn.completed']==m['token_usage']
            assert sha((ROOT/a['model_receipt']).with_name('agent.stdout.log'))==m['raw_event_log_sha256']
            candidate=ROOT/a['candidate'];assert sha(candidate)==a['candidate_sha256']==m['candidate_sha256']
            text=candidate.read_text();assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',text)
            assert re.findall(r'Print Assumptions\s+(case_\w+)\.',text)==[f'case_{i:02d}_{k}' for k in ['return_refuted','spatial_refuted','entry_sat']]
            for name,h in m['locked_goal_and_helper_sha256'].items():assert sha(candidate.parent/name)==h
            for s in a['compilation']+([a['kernel_check']] if 'kernel_check' in a else []):
                assert s['resources']==json.loads((ROOT/s['stdout']).with_name('resources.json').read_text())
                assert s['wall_seconds']>0 and s['resources']['max_process_rss_kib']>0
                for key in ['stdout','stderr']:assert sha(ROOT/s[key])==s[key+'_sha256']
        a=e['attempts'][-1];assert a['kernel_check']['exit_code']==0
        assert (ROOT/a['compilation'][-1]['stdout']).read_text().count('Closed under the global context')==3
        assert abs(e['metrics']['total_itp_wall_seconds']-sum(m['wall_seconds'] for m in e['models'])-sum(s['wall_seconds'] for a in e['attempts'] for s in a['compilation']+([a['kernel_check']] if 'kernel_check' in a else [])))<1e-7
    m=report['metrics'];assert m['model_calls']==len(report['models'])>=12
    assert len(report['attempts'])==len(report['models'])
    assert abs(m['total_itp_wall_seconds']-sum(e['metrics']['total_itp_wall_seconds'] for e in report['executions']))<1e-7
    assert m['token_usage']['total_tokens']==sum(e['metrics']['token_usage']['total_tokens'] for e in report['executions'])
    assert m['local_peak_process_resident_bytes']==max(e['metrics']['local_peak_process_resident_bytes'] for e in report['executions'])
    raw=json.loads((ROOT/'benchmark/results/read/20261015-variants/results.json').read_text())
    unknown={(x['variant'],x['case']):x for x in raw['runs'] if x['tespec']['statuses']==['UNKNOWN']}
    assert {(c['variant'],c['case']) for c in report['cases']}==set(unknown)
    assert sha(ROOT/'bin/tespec-symexec')==raw['toolchain']['tespec_executor_sha256']
    for c in report['cases']:
        assert unknown[c['variant'],c['case']]['tespec']['report']==c['original_test_report']
    for key in ['model_wall_seconds','coq_compile_audit_wall_seconds','kernel_wall_seconds','total_itp_wall_seconds']:
        assert abs(m['per_execution_mean'][key]-sum(e['metrics'][key] for e in report['executions'])/12)<1e-8
    print('PASS: 12 independently metered execution ITP tasks, exact VC hashes, actual model telemetry, 36 closed proofs and 12 independent kernel replays.',flush=True)
if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('mode',choices=['prepare','compile','summarize','validate','status']);p.add_argument('--execution',type=int);p.add_argument('--attempt',type=int,default=1);a=p.parse_args()
    if a.mode=='compile':raise SystemExit(compile_one(a.execution,a.attempt))
    elif a.mode=='status':status(a.execution)
    else:globals()[a.mode]()
