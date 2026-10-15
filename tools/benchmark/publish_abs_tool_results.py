#!/usr/bin/env python3
"""Publish abs with exact reused primary evidence and fully metered QCP proof."""
from pathlib import Path
import collections,csv,io,json,statistics,hashlib
from test_read_variants import ROOT,save,sha
from evidence_paths import evidence_path
BASE=ROOT/'benchmark/results/abs';RUN=BASE/'20261016-evaluation';PROOF=BASE/'20261016-qcp-verify-complete';GROUP=ROOT/'benchmark/programs/abs'
def rel(p): return str(p.relative_to(ROOT))
def stage(name,seconds,peak,tokens=0,required=True):
    return {'stage':name,'wall_seconds':seconds,'peak_process_memory_mib':peak,'total_tokens':tokens,'required':required}
def main():
    data=json.loads((RUN/'results.json').read_text());runs=data['runs'];assert len(runs)==57
    for r in runs:
        for field in ['harness','binds']: assert sha(ROOT/r[field])==r[field+'_sha256']
        for tool in ['fulminate_pipeline','fulminate_test','tespec_off','tespec_on']:
            m=r[tool]; assert m['resources'] and m['wall_seconds']>=0
            for k in ['stdout','stderr']: m[k+'_sha256']=sha(ROOT/m[k])
        for mode in ['off','on']:
            m=r['tespec_'+mode];report=json.loads((ROOT/m['report']).read_text());assert len(report['results'])==1
            m['report_sha256']=sha(ROOT/m['report']);assert report['results'][0]['status']==m['status']
            assert m['status'] in ['PASS','FAIL'],r
    save(RUN/'results.json',data)
    perf=ROOT/'benchmark/results/historical/selection/paired-mutations/performance/20261015-positive18/automatic-final/raw-results.json'
    archive=json.loads(perf.read_text());ri,row=next((i,r) for i,r in enumerate(archive['runs']) if r['source']=='abs' and r['repeat']==1)
    vp=GROUP/'variants/constructed_case_64495bb50536f9f9/manifest.json';v=json.loads(vp.read_text());primary=v['id']
    inp=perf.parent.parent/'inputs/abs'
    for lang in ['cn','qcp']:
        assert sha(ROOT/v['files'][lang]['path'])==sha(inp/(lang+'.c'))==v['files'][lang]['sha256']
    cn=row['cn'];assert cn['exit_code']==0
    for k in ['stdout','stderr']: assert sha(perf.parent/cn['folder']/(k+'.log'))==cn[k+'_sha256']
    save(BASE/'cn/results.json',{'schema':'tespec-group-tool-result/v1','program_group':'abs','tool':'cn','primary_variant':primary,'source':v['files']['cn'],'verdict':'VERIFIED','mode':'REUSED_MATCHING_ARCHIVED_VERIFICATION_NO_RERUN','evidence':{'report':rel(perf),'pointer':f'/runs/{ri}/cn'},'original_measurement':cn})
    save(BASE/'cn/statistics.json',{'wall_seconds':cn['wall_seconds'],'peak_process_resident_mib':cn['resources']['max_process_rss_kib']/1024,'tokens':0,'model_calls':0,'verification_runs_counted':1})
    receipt=json.loads((PROOF/'receipt.json').read_text());assert receipt['kernel_check']['exit_code']==0
    qstat=dict(receipt['metrics'])
    # Initial successful compiler processes are real costs, including controller audit retry.
    prior=json.loads((PROOF/'initial-audit-compilation.json').read_text())
    initial_seconds=sum(r['resources']['wall_seconds_gnu'] for r in prior['stages'])
    qstat['initial_compile_audit_seconds_gnu']=initial_seconds
    if 'initial_compile_audit_seconds_gnu' not in receipt['metrics']:
        qstat['coq_compile_audit_wall_seconds']+=initial_seconds;qstat['wall_seconds']+=initial_seconds
    qstat['retry_cost_note']='Includes initial successful compile/audit and confirmed compile/audit; initial GNU time wall measurements have 0.01-second resolution.'
    qstat['stages']=[stage('vc_generation_and_automatic_processing',qstat['native_auto_wall_seconds'],qstat['native_peak_process_rss_kib']/1024),stage('agent_proof_filling',qstat['model_wall_seconds'],qstat['model_client_peak_working_set_bytes']/1048576,qstat['tokens']),stage('coq_compilation_and_assumption_audit',qstat['coq_compile_audit_wall_seconds'],max(r['resources']['max_process_rss_kib'] for r in receipt['compilation'])/1024),stage('independent_kernel_check',qstat['kernel_wall_seconds'],receipt['kernel_check']['resources']['max_process_rss_kib']/1024)]
    qstat['full_verification_complete']=True
    save(BASE/'qcp/results.json',{'schema':'tespec-group-tool-result/v1','program_group':'abs','tool':'qcp','primary_variant':primary,'source':v['files']['qcp'],'verdict':'VERIFIED_KERNEL_CHECKED','obligations':4,'receipt':rel(PROOF/'receipt.json'),'assumptions':receipt['assumptions'],'scope':'Original universal VC_Correct implemented; runtime abstract address interpretation parameter retained. No concrete test bindings or new proof axioms.'})
    save(BASE/'qcp/statistics.json',qstat)
    modes={}
    for mode in ['off','on']:
        ms=[r['tespec_'+mode] for r in runs];counts=dict(collections.Counter(m['status'] for m in ms));times=[m['wall_seconds'] for m in ms];peaks=[m['resources']['max_process_rss_kib']/1024 for m in ms]
        modes[mode]={'native_status_counts':counts,'final_status_counts':counts,'expected_matches':sum(r['tespec_'+mode]['status']==r['expected'] for r in runs),'execution_wall_seconds_total':sum(times),'mean_execution_wall_seconds':statistics.mean(times),'mean_execution_peak_rss_mib':statistics.mean(peaks),'maximum_execution_peak_rss_mib':max(peaks),'executions_requiring_itp_for_verdict':0,'itp_wall_seconds_counted':0,'itp_tokens_counted':0,'mean_itp_seconds_when_required':None,'complete_measured_stage_seconds':sum(times),'mean_complete_seconds_per_test':statistics.mean(times),'model_calls_newly_executed':0,'tokens_newly_consumed':0}
    mode_stats={'schema':'tespec-group-spatial-smt-comparison/v1','program_group':'abs','case_pairs':len(runs),'results_sha256':sha(RUN/'results.json'),'modes':modes,'certificate':'NOT_CHECKED','ordering':'Sequential OFF then ON per input; single paired run, no speedup inference.'}
    save(RUN/'statistics.json',mode_stats)
    (RUN/'comparison.md').write_text('# abs 空间 SMT 对照\n\n57 个相同输入依次关闭／开启空间 SMT。两种模式均为 38 PASS、19 FAIL，57/57 符合逐输入预期；无需 ITP，模型调用及 token 为 0。逐次时间、峰值 RSS 和执行器哈希见 results.json，模式均值见 statistics.json。单轮顺序运行不支持性能加速结论。\n')
    fstat={'instrument_compile_initial_execution_wall_seconds_total':sum(r['fulminate_pipeline']['wall_seconds'] for r in runs),'test_execution_wall_seconds_total':sum(r['fulminate_test']['wall_seconds'] for r in runs),'pipeline_peak_process_rss_kib':max(r['fulminate_pipeline']['resources']['max_process_rss_kib'] for r in runs),'test_peak_process_rss_kib':max(r['fulminate_test']['resources']['max_process_rss_kib'] for r in runs),'tokens':0,'model_calls':0,'compiler_policy':'GCC -fno-builtin prevents abs call elimination. Prior unsuitable default-builtins diagnostic run excluded.'}
    for tool,key in [('fulminate','fulminate_test'),('tespec','tespec_off')]:
        save(BASE/tool/'results.json',{'schema':'tespec-group-tool-result/v1','tool':tool,'summary':{'case_pairs':len(runs),'correct':sum(r[key]['status']==r['expected'] for r in runs),'native_status_counts':dict(collections.Counter(r[key]['status'] for r in runs))},'evidence':rel(RUN/'results.json'),'cases':[{'variant':r['variant'],'paired_qcp_variant':r['paired_qcp_variant'],'case':r['case'],'initial':r['initial'],'expected':r['expected'],'actual':r[key]['status'],'matches_expected':r[key]['status']==r['expected']} for r in runs]})
    save(BASE/'fulminate/statistics.json',fstat)
    off=modes['off'];save(BASE/'tespec/statistics.json',{'execution_wall_seconds_total':off['execution_wall_seconds_total'],'execution_peak_process_rss_kib':int(off['maximum_execution_peak_rss_mib']*1024),'tokens':0,'model_calls':0,'itp_required_executions':0,'stages':[stage('test_execution_and_vc_generation',off['execution_wall_seconds_total'],off['maximum_execution_peak_rss_mib'])]+[stage(n,0,None,required=False) for n in ['agent_proof_filling','coq_compilation_and_assumption_audit','independent_kernel_check']]})
    manifest=json.loads((GROUP/'manifest.json').read_text());manifest.update(primary_variant=primary,primary_selection_status='BOUND_TO_EXISTING_VERIFIED_BASELINE',primary_verification={'mode':'REUSED_NATIVE_VERIFICATION_PLUS_COMPLETED_QCP_PROOF','source_alias':'abs','cn_status':'VERIFIED','qcp_status':'VERIFIED_KERNEL_CHECKED','qcp_complete_proof_receipt':rel(PROOF/'receipt.json'),'assumptions':receipt['assumptions']},test_modes_statistics=rel(RUN/'statistics.json'))
    manifest['tool_results']={t:{'results':rel(BASE/t/'results.json'),'statistics':rel(BASE/t/'statistics.json')} for t in ['cn','qcp','fulminate','tespec']};save(GROUP/'manifest.json',manifest)
    for variant_manifest in (GROUP/'variants').glob('*/manifest.json'):
        vv=json.loads(variant_manifest.read_text());vv['current_tests_index']=rel(BASE/'index.json');save(variant_manifest,vv)
    save(BASE/'index.json',{'program_group':'abs','primary_variant':primary,'evaluation':rel(RUN/'results.json'),'qcp_receipt':rel(PROOF/'receipt.json'),'cost_table':rel(BASE/'result-cost.md'),'diagnostic_excluded':rel(BASE/'20261016-diagnostic-builtin'),'exception':'Fulminate missed signed INT_MIN negation overflow: spec_3 permits all int inputs, instrumented modular arithmetic accepts wrapped result.'})
    buf=io.StringIO();fields=['variant','case','initial','expected','fulminate','tespec_off','tespec_on'];w=csv.DictWriter(buf,fieldnames=fields);w.writeheader()
    for r in runs:w.writerow({**{k:r[k] for k in fields[:4]},**{k:r[k if k!='fulminate' else 'fulminate_test']['status'] for k in fields[4:]}})
    (BASE/'cases.csv').write_text(buf.getvalue())
    print('Published abs: primary CN + universal QCP; Fulminate 56/57, teSpec OFF/ON 57/57; all cost stages.')
if __name__=='__main__':main()
