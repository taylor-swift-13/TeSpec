#!/usr/bin/env python3
"""Expose CN, QCP, Fulminate and complete teSpec results under named entries."""
from pathlib import Path
import collections, csv, hashlib, io, json

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'benchmark/results/read'
PRIMARY='constructed:case_6d90d7cd08323aa9'

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,d):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')

def split_proof_stages(tool, metrics, receipt):
    """Derive disjoint measured stages; never attribute agent/Coq cost to VC generation."""
    qcp=tool=='qcp'
    compilation=receipt['compilation']
    kernel=receipt['kernel_check']
    usage=metrics['token_usage'] if qcp else metrics['itp_token_usage']
    rows=[]
    def add(stage, seconds, memory_bytes, tokens=0, model=None):
        rows.append({'tool':tool,'stage':stage,'wall_seconds':seconds,
                     'peak_process_resident_bytes':memory_bytes,'peak_process_memory_mib':memory_bytes/1024**2,
                     'input_tokens':usage['input_tokens'] if tokens else 0,
                     'output_tokens':usage['output_tokens'] if tokens else 0,
                     'total_tokens':tokens,'model':model})
    add('vc_generation_and_automatic_processing' if qcp else 'test_execution_and_vc_generation',
        metrics['native_auto_wall_seconds'] if qcp else metrics['execution_wall_seconds_total'],
        (metrics['native_peak_process_rss_kib'] if qcp else metrics['execution_peak_process_rss_kib'])*1024)
    add('agent_proof_filling',metrics['model_wall_seconds'] if qcp else metrics['itp_model_generation_wall_seconds'],
        metrics['model_client_peak_working_set_bytes'] if qcp else metrics['itp_model_client_peak_working_set_bytes'],
        usage['total_tokens'],metrics['requested_model'])
    add('coq_compilation_and_assumption_audit',sum(r['wall_seconds'] for r in compilation),
        max(r['resources']['max_process_rss_kib'] for r in compilation)*1024)
    add('independent_kernel_check',kernel['wall_seconds'],kernel['resources']['max_process_rss_kib']*1024)
    total=metrics['wall_seconds'] if qcp else metrics['measured_complete_stage_wall_seconds_total']
    assert abs(sum(r['wall_seconds'] for r in rows)-total)<1e-8
    assert sum(r['total_tokens'] for r in rows)==usage['total_tokens']
    peak=metrics['peak_process_resident_bytes'] if qcp else metrics['complete_peak_process_resident_bytes']
    assert max(r['peak_process_resident_bytes'] for r in rows)==peak
    metrics['stages']=rows
    metrics['stage_accounting_note']='Disjoint measured stages: generation/execution, agent proof filling, Coq compilation/audit, independent kernel check. Generation includes native automatic processing; no finer timing was collected. Agent wall time is the measured CLI invocation, not remote inference alone. Shared batch work counted once.'
    return rows

def main():
    main_manifest=ROOT/'benchmark/programs/read/variants/constructed_case_6d90d7cd08323aa9/manifest.json'
    primary=json.loads(main_manifest.read_text())
    assert json.loads((ROOT/'benchmark/programs/read/manifest.json').read_text())['primary_variant']==PRIMARY
    perf=ROOT/'benchmark/results/historical/selection/paired-mutations/performance/20261015-positive18'
    frozen=perf/'automatic-final/raw-results.json';data=json.loads(frozen.read_text())
    ri,run=next((i,r) for i,r in enumerate(data['runs']) if r['source']=='read2' and r['repeat']==1)
    for lang in ['cn','qcp']:
        assert sha(perf/'inputs/read2'/(lang+'.c'))==primary['files'][lang]['sha256']==sha(ROOT/primary['files'][lang]['path'])
    entries={};comparison=[]
    for tool,key in [('cn','cn'),('qcp','qcp_auto')]:
        stage=run[key]
        folder=frozen.parent/stage['folder']
        for name in ['stdout','stderr']:assert sha(folder/(name+'.log'))==stage[name+'_sha256']
        assert stage['exit_code']==0
        verdict='VERIFIED' if tool=='cn' else 'AUTOMATIC_STAGE_ONLY'
        facts={}
        if tool=='qcp':
            native=json.loads((folder/'stdout.log').read_text());counts=native['WitnessList'][0]['Witness']['total_witness_count']
            assert native['verificationStatus']=='proved' and counts['auto_solved']==1 and counts['manual']==0
            facts={'auto_solved_vcs':1,'manual_remaining':0,'itp_required':False}
        results={'schema':'tespec-read-tool-result/v1','tool':tool,'scope':'Universal verification of the designated primary read function; original trusted main excluded. Other variants require testing only.',
                 'primary_variant':PRIMARY,'source':primary['files'][tool], 'verdict':verdict,'mode':'REUSED_MATCHING_ARCHIVED_VERIFICATION_NO_RERUN',
                 'evidence':{'report':frozen.relative_to(ROOT).as_posix(),'pointer':f'/runs/{ri}/{key}','stdout':(folder/'stdout.log').relative_to(ROOT).as_posix(),'stderr':(folder/'stderr.log').relative_to(ROOT).as_posix()},
                 'original_measurement':stage,'facts':facts}
        stats={'tool':tool,'measurement_unit':'One selected archived primary verification run (read2 repeat 1); other historical repetitions are not added or averaged.',
               'wall_seconds':stage['wall_seconds'],'peak_process_rss_kib':stage['resources']['max_process_rss_kib'],
               'peak_process_resident_mib':stage['resources']['max_process_rss_kib']/1024,'tokens':0,'model_calls':0,'verification_runs_counted':1}
        if tool=='qcp' and (OUT/'20261015-qcp-verify-complete/receipt.json').is_file():
            cert_path=OUT/'20261015-qcp-verify-complete/receipt.json'
            cert=json.loads(cert_path.read_text())
            assert cert['status']=='VERIFIED_KERNEL_CHECKED' and cert['kernel_check']['exit_code']==0
            assert sha(ROOT/cert['original_goal'])==cert['original_goal_sha256']==sha(ROOT/cert['goal'])
            assert sha(ROOT/cert['proof'])==cert['proof_sha256']
            assert (ROOT/cert['compilation'][-1]['stdout']).read_text().strip()=='Closed under the global context'
            assert all(stage['exit_code']==0 for stage in cert['compilation'])
            verdict='VERIFIED_KERNEL_CHECKED'
            results.update(verdict=verdict,mode='REUSED_NATIVE_VC_GENERATION_PLUS_METERED_COMPLETE_PROOF',complete_proof_receipt=cert_path.relative_to(ROOT).as_posix())
            results['facts'].pop('itp_required',None)
            results['facts'].update(proof_pipeline_completed=True,kernel_checked=True,assumptions='Closed under the global context',proof_generation_model=cert['metrics']['requested_model'])
            stats=dict(cert['metrics'])
            split_proof_stages('qcp',stats,cert)
            stats['full_verification_complete']=True
            stats['automatic_stage_only']=run[key]
        save(OUT/tool/'results.json',results);save(OUT/tool/'statistics.json',stats)
        entries[tool]={'results':(OUT/tool/'results.json').relative_to(ROOT).as_posix(),'statistics':(OUT/tool/'statistics.json').relative_to(ROOT).as_posix(),'verdict':verdict,'scope':'primary_universal_verification'}
        comparison.append({'tool':tool,'scope':'primary_universal_verification','result':verdict,'test_cases':None,'correct':None,'accuracy':None,'wall_seconds':stats['wall_seconds'],'peak_process_memory_mib':stats['peak_process_resident_mib'],'input_tokens':stats.get('token_usage',{}).get('input_tokens',0),'output_tokens':stats.get('token_usage',{}).get('output_tokens',0),'total_tokens':stats['tokens'],'model':stats.get('requested_model')})
    raw_path=OUT/'20261015-variants/results.json';raw=json.loads(raw_path.read_text());runs=raw['runs']
    complete=json.loads((OUT/'complete/results.json').read_text());bykey={(c['variant'],c['case']):c for c in complete['cases']}
    fulfilled=sum(bykey[r['variant'],r['case']]['fulminate_expected_result_matched'] for r in runs)
    results={'schema':'tespec-read-tool-result/v1','tool':'fulminate','scope':'61 finite variant/input pairs across 10 paired configurations; all 13 related language-version records covered.',
             'summary':{'case_pairs':61,'status_counts':dict(collections.Counter(r['fulminate_test']['status'] for r in runs)),'correct':fulfilled,'accuracy':fulfilled/61},
             'cases':[{'variant':r['variant'],'case':r['case'],'initial':r['initial'],'expected':bykey[r['variant'],r['case']]['expected_result'],
                       'correct':bykey[r['variant'],r['case']]['fulminate_expected_result_matched'],
                       'instrument_compile_initial_execution':r['fulminate_pipeline'],'runtime_test':r['fulminate_test'],
                       'harness':r['harness'],'harness_sha256':r['harness_sha256'],'raw_report':raw_path.relative_to(ROOT).as_posix(),'raw_pointer':'/runs/'+str(i)} for i,r in enumerate(runs)]}
    pipeline_time=sum(r['fulminate_pipeline']['wall_seconds'] for r in runs)
    runtime_time=sum(r['fulminate_test']['wall_seconds'] for r in runs)
    stats={'tool':'fulminate','test_execution_wall_seconds_total':runtime_time,'instrument_compile_initial_execution_wall_seconds_total':pipeline_time,
           'all_measured_work_wall_seconds_total':pipeline_time+runtime_time,
           'test_peak_process_rss_kib':max(r['fulminate_test']['resources']['max_process_rss_kib'] for r in runs),
           'pipeline_peak_process_rss_kib':max(r['fulminate_pipeline']['resources']['max_process_rss_kib'] for r in runs),
           'tokens':0,'model_calls':0,'case_pairs':61,
           'timing_note':'Instrumentation command includes compilation and an initial execution; standalone executable is run again to isolate runtime costs. Both measured stages remain explicit.'}
    save(OUT/'fulminate/results.json',results);save(OUT/'fulminate/statistics.json',stats)
    entries['fulminate']={'results':(OUT/'fulminate/results.json').relative_to(ROOT).as_posix(),'statistics':(OUT/'fulminate/statistics.json').relative_to(ROOT).as_posix(),'correct':fulfilled,'total':61,'scope':'variant_finite_testing'}
    comparison.append({'tool':'fulminate','scope':'variant_finite_testing','result':f'{fulfilled}/61','test_cases':61,'correct':fulfilled,'accuracy':fulfilled/61,'wall_seconds':stats['all_measured_work_wall_seconds_total'],'peak_process_memory_mib':max(stats['test_peak_process_rss_kib'],stats['pipeline_peak_process_rss_kib'])/1024,'input_tokens':0,'output_tokens':0,'total_tokens':0,'model':None})
    # Publish the complete test (including ITP), not just the native execution stage.
    result={'schema':'tespec-read-tool-result/v1','tool':'tespec','scope':'Complete finite testing: execution plus required ITP generation, compilation/audit and independent kernel replay.',
            'complete_result':'benchmark/results/read/complete/results.json','summary':complete['summary'],'cases':complete['cases']}
    split_proof_stages('tespec',complete['metrics'],json.loads((OUT/'20261015-itp-metered/attempt-1/coq-receipt.json').read_text()))
    save(OUT/'complete/statistics.json',{'summary':complete['summary'],'metrics':complete['metrics']})
    save(OUT/'complete/results.json',complete)
    save(OUT/'tespec/results.json',result);save(OUT/'tespec/statistics.json',complete['metrics'])
    entries['tespec']={'results':(OUT/'tespec/results.json').relative_to(ROOT).as_posix(),'statistics':(OUT/'tespec/statistics.json').relative_to(ROOT).as_posix(),'correct':61,'total':61,'scope':'variant_finite_testing_plus_itp'}
    # User-requested read presentation: mean ITP cost per execution requiring ITP.
    m=complete['metrics'];n=complete['summary']['itp_required']
    mean={'schema':'tespec-itp-per-execution-mean/v1','tool':'tespec','group':'read',
          'unit':'One test execution requiring ITP, including all its unresolved VCs and proof repairs/checks',
          'estimation':'Shared batch measurement divided by 12 executions; estimated allocation, not independently measured per execution.',
          'executions_requiring_itp':n,'display_policy':'Show mean ITP costs only; preserve raw batch totals in source receipts.',
          'mean_agent_proof_filling_seconds':m['itp_model_generation_wall_seconds']/n,
          'mean_coq_compile_audit_seconds':m['itp_compile_audit_wall_seconds']/n,
          'mean_independent_kernel_check_seconds':m['itp_kernel_wall_seconds']/n,
          'mean_itp_seconds':m['itp_wall_seconds_total']/n,
          'mean_input_tokens':m['itp_token_usage']['input_tokens']/n,
          'mean_output_tokens':m['itp_token_usage']['output_tokens']/n,
          'mean_total_tokens':m['complete_tokens']/n,
          'model':m['requested_model'],
          'memory_note':'Batch process peak is not divided or described as mean per-execution memory.',
          'source':'benchmark/results/read/20261015-itp-metered/receipt.json'}
    save(OUT/'tespec/itp-average.json',mean)
    (OUT/'tespec/itp-average.md').write_text(
        '# read ITP 平均开销\n\n'
        '以需要 ITP 的 12 次测试执行为分母；同次执行的所有待处理 VC 合计为一次 ITP。以下是共享批次均摊估算，不是逐次独立实测；不按定理数计数。\n\n'
        '| 项目 | 每次测试执行的平均值 |\n|---|---:|\n'
        f"| agent 填写证明 | {mean['mean_agent_proof_filling_seconds']:.4f} 秒 |\n"
        f"| Coq 编译与审计 | {mean['mean_coq_compile_audit_seconds']:.4f} 秒 |\n"
        f"| 独立内核检查 | {mean['mean_independent_kernel_check_seconds']:.4f} 秒 |\n"
        f"| ITP 合计 | {mean['mean_itp_seconds']:.4f} 秒 |\n"
        f"| 输入 token | {mean['mean_input_tokens']:.2f} |\n"
        f"| 输出 token | {mean['mean_output_tokens']:.2f} |\n"
        f"| 总 token | {mean['mean_total_tokens']:.2f} |\n\n"
        '模型 gpt-6.1-sol。峰值内存不能按次数相除，不展示为每次平均内存；原始峰值和批次总量仍保留在审计数据中。\n')
    m=complete['metrics'];comparison.append({'tool':'tespec','scope':'variant_finite_testing_plus_itp','result':'61/61','test_cases':61,'correct':61,'accuracy':1.0,'wall_seconds':m['measured_complete_stage_wall_seconds_total'],'peak_process_memory_mib':m['complete_peak_process_resident_mib'],'input_tokens':m['itp_token_usage']['input_tokens'],'output_tokens':m['itp_token_usage']['output_tokens'],'total_tokens':m['complete_tokens'],'model':m['requested_model']})
    stage_rows=[]
    for row in comparison:
        stats=json.loads((OUT/row['tool']/'statistics.json').read_text())
        stages=stats.get('stages',[])
        for name,key in [('generation','wall_seconds'),('agent_proof_filling','wall_seconds'),('coq_compilation_and_assumption_audit','wall_seconds'),('independent_kernel_check','wall_seconds')]:
            stage=next((r for r in stages if r['stage']==name or (name=='generation' and r['stage'] in ['vc_generation_and_automatic_processing','test_execution_and_vc_generation'])),None)
            row[name+'_wall_seconds']=stage[key] if stage else None
        stage_rows.extend(stages)
    save(OUT/'stages.json',{'schema':'tespec-read-stage-comparison/v1','stages':stage_rows,'note':'QCP verifies one primary; teSpec tests 61 variant/input pairs. Stage timings sum measured work from reused and fresh receipts, not a single continuous run.'})
    stagebuf=io.StringIO();stagewriter=csv.DictWriter(stagebuf,fieldnames=list(stage_rows[0]),lineterminator="\n");stagewriter.writeheader();stagewriter.writerows(stage_rows)
    (OUT/'stages.csv').write_text(stagebuf.getvalue())
    buf=io.StringIO();w=csv.DictWriter(buf,fieldnames=list(comparison[0]),lineterminator="\n");w.writeheader();w.writerows(comparison);(OUT/'comparison.csv').write_text(buf.getvalue())
    save(OUT/'comparison.json',{'tools':comparison,'scope_note':'CN/QCP verify the primary once; Fulminate/teSpec test variants on finite inputs. Verification and testing accuracies/denominators are not interchangeable.','entries':entries,'stage_comparison':'benchmark/results/read/stages.json'})
    p=OUT/'index.json';index=json.loads(p.read_text());index['tools']=entries;index['comparison']='benchmark/results/read/comparison.json';index['stage_comparison']='benchmark/results/read/stages.json';save(p,index)
    p=ROOT/'benchmark/programs/read/manifest.json';group=json.loads(p.read_text());group['tool_results']=entries
    if entries['qcp']['verdict']=='VERIFIED_KERNEL_CHECKED':
        group['primary_verification']['mode']='REUSED_NATIVE_VERIFICATION_PLUS_COMPLETED_QCP_PROOF'
        group['primary_verification']['qcp_status']='VERIFIED_KERNEL_CHECKED'
        group['primary_verification']['qcp_complete_proof_receipt']='benchmark/results/read/20261015-qcp-verify-complete/receipt.json'
    save(p,group)
    assert fulfilled==60
    print('PASS: named CN/QCP primary verification and Fulminate/complete-teSpec test results published; archived source/log hashes match; no runs repeated.')

if __name__=='__main__':main()
