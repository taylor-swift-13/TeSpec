#!/usr/bin/env python3
"""Publish reviewed group tests and complete primary verification receipts."""
import argparse,collections,csv,io,json,statistics
from test_read_variants import ROOT,save,sha
from publish_abs_tool_results import stage
from evidence_paths import same_bindings_allow_explicit_empty_values
from evaluation_expectations import expected as expected_status,matches as matches_expected,summary as evaluation_summary
from attach_cell_leak_itp import validate_receipt,mode_costs,statistics_for_off

def main():
    p=argparse.ArgumentParser();p.add_argument('--group',required=True);a=p.parse_args();name=a.group
    group=ROOT/'benchmark/programs'/name;planpath=group/'evaluation-plan.json';plan=json.loads(planpath.read_text());base=ROOT/'benchmark/results'/name;run=base/plan['run_id'];proof=base/'20261016-qcp-verify-complete';nativepath=base/'20261016-primary-native/receipt.json'
    data=json.loads((run/'results.json').read_text());runs=data['runs'];assert len(runs)==sum(len(x['cases']) for x in plan['pairings']);assert data['plan_sha256']==sha(planpath) or data.get('evaluation_plan_snapshot') and sha(ROOT/data['evaluation_plan_snapshot'])==data['plan_sha256']
    if data['plan_sha256']!=sha(planpath):
        frozen=json.loads((ROOT/data['evaluation_plan_snapshot']).read_text())
        assert all(frozen[k]==plan[k] for k in ['program_group','function','run_id','primary_cn_variant','primary_qcp_variant','pairings']), 'Executed cases changed after measurement'
    variants={json.loads(p.read_text())['id']:(p,json.loads(p.read_text())) for p in (group/'variants').glob('*/manifest.json')}
    for r in runs:
        for key in ['harness','binds']:assert sha(ROOT/r[key])==r[key+'_sha256']
        for lang,vid in [('cn',r['variant']),('qcp',r['paired_qcp_variant'])]:assert sha(ROOT/variants[vid][1]['files'][lang]['path'])==r[lang+'_source_sha256']
        for tool in ['fulminate_pipeline','fulminate_test','tespec_off','tespec_on']:
            m=r[tool];assert m['resources'] and m['wall_seconds']>=0
            for k in ['stdout','stderr']:m[k+'_sha256']=sha(ROOT/m[k])
        for mode in ['off','on']:
            m=r['tespec_'+mode];report=json.loads((ROOT/m['report']).read_text());assert len(report['results'])==1 and report['results'][0]['status']==m['status'];m['report_sha256']=sha(ROOT/m['report'])
            if m['status']=='UNKNOWN':
                assert m.get('itp') and m.get('final_status')=='FAIL','Independently checked per-execution ITP required'
                assert sha(ROOT/m['itp']['receipt'])==m['itp']['receipt_sha256'];validate_receipt(ROOT/m['itp']['receipt'],r,mode)
            elif m['status']=='ERROR':assert matches_expected(r,'tespec_'+mode), 'Unexpected ERROR cannot be published as complete'
            else:assert m['status'] in ['PASS','FAIL']
    data.setdefault('native_summary_before_final_publication',data['summary']);data['summary']=evaluation_summary(runs,plan);save(run/'results.json',data)
    rel=lambda p:str(p.relative_to(ROOT))
    native=json.loads(nativepath.read_text());cv=variants[plan['primary_cn_variant']][1];qv=variants[plan['primary_qcp_variant']][1];cn=native['cn']
    for lang,v in [('cn',cv),('qcp',qv)]:assert sha(ROOT/v['files'][lang]['path'])==native[lang+'_source_sha256']
    assert cn['exit_code']==0
    save(base/'cn/results.json',{'schema':'tespec-group-tool-result/v1','program_group':name,'tool':'cn','scope':'Universal verification of all non-trusted functions in the designated original CN translation unit, including main if not marked trusted. QCP source can omit original main; compare scopes explicitly.','primary_variant':plan['primary_cn_variant'],'source':cv['files']['cn'],'verdict':'VERIFIED','evidence':rel(nativepath),'original_measurement':cn})
    save(base/'cn/statistics.json',{'wall_seconds':cn['wall_seconds'],'peak_process_resident_mib':cn['resources']['max_process_rss_kib']/1024,'tokens':0,'model_calls':0,'verification_runs_counted':1})
    receipt=json.loads((proof/'receipt.json').read_text());assert receipt['kernel_check']['exit_code']==0 and receipt['original_goal_sha256']==native['goal_sha256'];qstat=dict(receipt['metrics'])
    qstat['stages']=[stage('vc_generation_and_automatic_processing',qstat['native_auto_wall_seconds'],qstat['native_peak_process_rss_kib']/1024),stage('agent_proof_filling',qstat['model_wall_seconds'],qstat['model_client_peak_working_set_bytes']/1048576,qstat['tokens']),stage('coq_compilation_and_assumption_audit',qstat['coq_compile_audit_wall_seconds'],max(r['resources']['max_process_rss_kib'] for r in receipt['compilation'])/1024),stage('independent_kernel_check',qstat['kernel_wall_seconds'],receipt['kernel_check']['resources']['max_process_rss_kib']/1024)];qstat['full_verification_complete']=True
    save(base/'qcp/results.json',{'schema':'tespec-group-tool-result/v1','program_group':name,'tool':'qcp','primary_variant':plan['primary_qcp_variant'],'paired_cn_primary':plan['primary_cn_variant'],'source':qv['files']['qcp'],'verdict':receipt.get('verdict','VERIFIED_KERNEL_CHECKED'),'obligations':len(receipt['obligations']),'receipt':rel(proof/'receipt.json'),'assumptions':receipt['assumptions'],'scope':receipt['scope']});save(base/'qcp/statistics.json',qstat)
    modes={}
    prior_attempts=[json.loads((ROOT/p).read_text()) for p in plan.get('prior_tespec_attempt_reports',[])]
    for mode in ['off','on']:
        ms=[r['tespec_'+mode] for r in runs];counts=dict(collections.Counter(m['status'] for m in ms));times=[m['wall_seconds'] for m in ms];peaks=[m['resources']['max_process_rss_kib']/1024 for m in ms]
        prior_by_case={}
        for previous in prior_attempts:
            for old in previous['runs']:
                new=next(r for r in runs if r['variant']==old['variant'] and r['case']==old['case'])
                assert new['qcp_source_sha256']==old['qcp_source_sha256'] and same_bindings_allow_explicit_empty_values(old,new)
                prior_by_case.setdefault((old['variant'],old['case']),[]).append(old['tespec_'+mode])
        logical_times=[];logical_peaks=[];old_ms=[]
        for row in runs:
            earlier=prior_by_case.get((row['variant'],row['case']),[]);current=row['tespec_'+mode];old_ms.extend(earlier)
            logical_times.append(current['wall_seconds']+sum(m['wall_seconds'] for m in earlier))
            logical_peaks.append(max([current['resources']['max_process_rss_kib']/1024]+[m['resources']['max_process_rss_kib']/1024 for m in earlier]))
        successful_times=times[:];times=logical_times;peaks=logical_peaks
        modes[mode]={'execution_attempts_count':len(ms)+len(old_ms),'prior_attempt_status_counts':dict(collections.Counter(m['status'] for m in old_ms)),'mean_successful_attempt_wall_seconds':statistics.mean(successful_times),'prior_attempt_reports':plan.get('prior_tespec_attempt_reports',[]),'native_status_counts':counts,'final_status_counts':dict(collections.Counter(m.get('final_status',m['status']) for m in ms)),'expected_matches':sum(matches_expected(r,'tespec_'+mode) for r in runs),'execution_wall_seconds_total':sum(times),'mean_execution_wall_seconds':statistics.mean(times),'mean_execution_peak_rss_mib':statistics.mean(peaks),'maximum_execution_peak_rss_mib':max(peaks),'executions_requiring_itp_for_verdict':0,'itp_wall_seconds_counted':0,'itp_tokens_counted':0,'mean_itp_seconds_when_required':None,'complete_measured_stage_seconds':sum(times),'mean_complete_seconds_per_test':statistics.mean(times),'model_calls_newly_executed':0,'tokens_newly_consumed':0}
    for mode in ['off','on']:
        modes[mode].update(mode_costs(runs,mode));modes[mode]['complete_measured_stage_seconds']+=modes[mode]['itp_wall_seconds_counted'];modes[mode]['mean_complete_seconds_per_test']=modes[mode]['complete_measured_stage_seconds']/len(runs)
    for mode in ['off','on']:
        modes[mode]['spatial_smt_queries_attempted']=sum(json.loads((ROOT/r['tespec_'+mode]['report']).read_text())['results'][0].get('spatial_smt',{}).get('attempted',0) for r in runs)
    save(run/'statistics.json',{'schema':'tespec-group-spatial-smt-comparison/v1','program_group':name,'case_pairs':len(runs),'results_sha256':sha(run/'results.json'),'implementation_provenance':data['toolchain'],'modes':modes,'certificate':'NOT_CHECKED','ordering':'OFF then ON for every input; single run, no speedup inference.'})
    (run/'comparison.md').write_text(f'# {name} 空间 SMT 对照\n\n相同 {len(runs)} 个合法输入，逐次关闭／开启空间 SMT。完整分类、逐输入预期、时间和 RSS 见 results.json；模式均值见 statistics.json。OFF 需要 ITP 的执行数为 {modes["off"]["executions_requiring_itp_for_verdict"]}，ON 为 {modes["on"]["executions_requiring_itp_for_verdict"]}；仅对实际需要 ITP 的独立执行统计均值和逐次峰值均值，所有修复尝试计入。单轮顺序运行不支持加速结论。\n')
    fstat={'instrument_compile_initial_execution_wall_seconds_total':sum(r['fulminate_pipeline']['wall_seconds'] for r in runs),'test_execution_wall_seconds_total':sum(r['fulminate_test']['wall_seconds'] for r in runs),'pipeline_peak_process_rss_kib':max(r['fulminate_pipeline']['resources']['max_process_rss_kib'] for r in runs),'test_peak_process_rss_kib':max(r['fulminate_test']['resources']['max_process_rss_kib'] for r in runs),'tokens':0,'model_calls':0,'compiler_policy':'GCC -fno-builtin; preserve instrumented source and binary digest.'}
    for tool,key in [('fulminate','fulminate_test'),('tespec','tespec_off')]:
        save(base/tool/'results.json',{'schema':'tespec-group-tool-result/v1','tool':tool,'summary':{'case_pairs':len(runs),'correct':sum(matches_expected(r,key) for r in runs),'native_status_counts':dict(collections.Counter(r[key]['status'] for r in runs))},'evidence':rel(run/'results.json'),'cases':[{'variant':r['variant'],'paired_qcp_variant':r['paired_qcp_variant'],'case':r['case'],'initial':r['initial'],'expected':expected_status(r,key),'logical_case_expectation':r['expected'],'raw_actual':r[key]['status'],'actual':r[key].get('final_status',r[key]['status']),'itp':r[key].get('itp'),'matches_expected':matches_expected(r,key)} for r in runs]})
    save(base/'fulminate/statistics.json',fstat);off=modes['off'];save(base/'tespec/statistics.json',{'execution_wall_seconds_total':off['execution_wall_seconds_total'],'execution_peak_process_rss_kib':int(off['maximum_execution_peak_rss_mib']*1024),'tokens':0,'model_calls':0,'itp_required_executions':0,'stages':[stage('test_execution_and_vc_generation',off['execution_wall_seconds_total'],off['maximum_execution_peak_rss_mib'])]+[stage(n,0,None,required=False) for n in ['agent_proof_filling','coq_compilation_and_assumption_audit','independent_kernel_check']]})
    off_itp=statistics_for_off(runs,base/'tespec/itp-average.json')
    if off_itp:
        ts=json.loads((base/'tespec/statistics.json').read_text());ts['tokens']=sum(m['tokens'] for m in off_itp);ts['model_calls']=sum(m['model_calls'] for m in off_itp);ts['itp_required_executions']=len(off_itp)
        ts['stages']=ts['stages'][:1]+[stage(n,sum(m[k] for m in off_itp),max(m['peak_process_memory_mib'][n] for m in off_itp),sum(m['tokens'] for m in off_itp) if n=='agent_proof_filling' else 0) for n,k in [('agent_proof_filling','agent_proof_filling_seconds'),('coq_compilation_and_assumption_audit','coq_compile_audit_seconds'),('independent_kernel_check','independent_kernel_check_seconds')]];save(base/'tespec/statistics.json',ts)
    manifest=json.loads((group/'manifest.json').read_text());manifest.update(primary_variant=plan['primary_cn_variant'],primary_selection_status='BOUND_TO_PAIRED_VERIFICATION',primary_verification={'mode':native.get('mode','MEASURED_MISSING_NATIVE_AND_COMPLETED_QCP_PROOF'),'paired_qcp_variant':plan['primary_qcp_variant'],'cn_status':'VERIFIED','qcp_status':receipt.get('verdict','VERIFIED_KERNEL_CHECKED'),'qcp_complete_proof_receipt':rel(proof/'receipt.json'),'assumptions':receipt['assumptions']},test_modes_statistics=rel(run/'statistics.json'));manifest['tool_results']={t:{'results':rel(base/t/'results.json'),'statistics':rel(base/t/'statistics.json')} for t in ['cn','qcp','fulminate','tespec']};save(group/'manifest.json',manifest)
    for variant_manifest in (group/'variants').glob('*/manifest.json'):
        vv=json.loads(variant_manifest.read_text());vv['current_tests_index']=rel(base/'index.json');save(variant_manifest,vv)
    save(base/'index.json',{'program_group':name,'primary_variant':plan['primary_cn_variant'],'paired_qcp_primary':plan['primary_qcp_variant'],'evaluation_plan':rel(planpath),'evaluation':rel(run/'results.json'),'qcp_receipt':rel(proof/'receipt.json'),'cost_table':rel(base/'result-cost.md'),'summary':data['summary']})
    buf=io.StringIO();fields=['variant','case','initial','expected','fulminate','tespec_off','tespec_on','fulminate_expected','tespec_expected','tespec_off_final','tespec_on_final'];w=csv.DictWriter(buf,fieldnames=fields);w.writeheader()
    for r in runs:w.writerow({**{k:r[k] for k in fields[:4]},**{k:r[k if k!='fulminate' else 'fulminate_test']['status'] for k in ['fulminate','tespec_off','tespec_on']},'fulminate_expected':expected_status(r,'fulminate_test'),'tespec_expected':expected_status(r,'tespec_off'),'tespec_off_final':r['tespec_off'].get('final_status',r['tespec_off']['status']),'tespec_on_final':r['tespec_on'].get('final_status',r['tespec_on']['status'])})
    (base/'cases.csv').write_text(buf.getvalue());print('Published',name,json.dumps(data['summary']),flush=True)
if __name__=='__main__':
    main()
    from collect_tespec_unexpected import collect
    collect()
    from build_group_cost_tables import main as rebuild_cost_tables
    rebuild_cost_tables()
    from refresh_benchmark_progress import refresh
    refresh()
