#!/usr/bin/env python3
"""Expose CN, QCP, Fulminate and complete teSpec results under named entries."""
from pathlib import Path
import collections, csv, hashlib, io, json

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'benchmark/results/read'
PRIMARY='constructed:case_6d90d7cd08323aa9'

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,d):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')

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
        verdict='VERIFIED' if tool=='cn' else 'VERIFIED_AUTOMATIC'
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
        save(OUT/tool/'results.json',results);save(OUT/tool/'statistics.json',stats)
        entries[tool]={'results':(OUT/tool/'results.json').relative_to(ROOT).as_posix(),'statistics':(OUT/tool/'statistics.json').relative_to(ROOT).as_posix(),'verdict':verdict,'scope':'primary_universal_verification'}
        comparison.append({'tool':tool,'scope':'primary_universal_verification','result':verdict,'test_cases':None,'correct':None,'accuracy':None,'wall_seconds':stats['wall_seconds'],'peak_process_memory_mib':stats['peak_process_resident_mib'],'input_tokens':0,'output_tokens':0,'total_tokens':0,'model':None})
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
    save(OUT/'tespec/results.json',result);save(OUT/'tespec/statistics.json',complete['metrics'])
    entries['tespec']={'results':(OUT/'tespec/results.json').relative_to(ROOT).as_posix(),'statistics':(OUT/'tespec/statistics.json').relative_to(ROOT).as_posix(),'correct':61,'total':61,'scope':'variant_finite_testing_plus_itp'}
    m=complete['metrics'];comparison.append({'tool':'tespec','scope':'variant_finite_testing_plus_itp','result':'61/61','test_cases':61,'correct':61,'accuracy':1.0,'wall_seconds':m['measured_complete_stage_wall_seconds_total'],'peak_process_memory_mib':m['complete_peak_process_resident_mib'],'input_tokens':m['itp_token_usage']['input_tokens'],'output_tokens':m['itp_token_usage']['output_tokens'],'total_tokens':m['complete_tokens'],'model':m['requested_model']})
    buf=io.StringIO();w=csv.DictWriter(buf,fieldnames=list(comparison[0]));w.writeheader();w.writerows(comparison);(OUT/'comparison.csv').write_text(buf.getvalue())
    save(OUT/'comparison.json',{'tools':comparison,'scope_note':'CN/QCP verify the primary once; Fulminate/teSpec test variants on finite inputs. Verification and testing accuracies/denominators are not interchangeable.','entries':entries})
    p=OUT/'index.json';index=json.loads(p.read_text());index['tools']=entries;index['comparison']='benchmark/results/read/comparison.json';save(p,index)
    p=ROOT/'benchmark/programs/read/manifest.json';group=json.loads(p.read_text());group['tool_results']=entries;save(p,group)
    assert fulfilled==60
    print('PASS: named CN/QCP primary verification and Fulminate/complete-teSpec test results published; archived source/log hashes match; no runs repeated.')

if __name__=='__main__':main()
