#!/usr/bin/env python3
"""Publish the complete test result, including checked ITP resolution stages."""
from pathlib import Path
import collections, csv, hashlib, io, json, subprocess, sys

ROOT = Path(__file__).resolve().parents[2]
RESULTS = ROOT / 'benchmark/results'
RAW = RESULTS / 'read/20261015-variants/results.json'
INDEPENDENT_ITP = RESULTS / 'read/20261015-itp-per-execution'
ITP = INDEPENDENT_ITP if (INDEPENDENT_ITP/'receipt.json').is_file() else RESULTS / 'read/20261015-itp-metered'
OUT = RESULTS / 'read/complete'

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def save(p, data):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')

def main():
    # Audit existing observations and proof receipts; no execution or proof rerun.
    subprocess.run([sys.executable, str(ROOT/'tools/benchmark/validate_read_results.py')], check=True)
    subprocess.run([sys.executable, str(ROOT/'tools/benchmark/read_itp_per_execution.py'), 'validate'] if ITP==INDEPENDENT_ITP else [sys.executable, str(ROOT/'tools/benchmark/validate_metered_read_itp.py')], check=True)
    raw = json.loads(RAW.read_text())
    receipt = json.loads((ITP/'receipt.json').read_text())
    adjudication = json.loads((ITP/'resolved-results.json').read_text())
    proofs = {(x['variant'],x['case']):x for x in receipt['cases']}
    cases = []
    for i, row in enumerate(raw['runs']):
        key = row['variant'],row['case']
        status = row['tespec']['statuses'][0]
        proof = proofs.get(key)
        stage = {'required': status == 'UNKNOWN', 'status':'NOT_REQUIRED', 'receipt':None}
        final = status
        if proof:
            assert status == 'UNKNOWN' and proof['itp_status'] == 'REFUTED_KERNEL_CHECKED'
            assert proof['original_test_report'] == row['tespec']['report']
            assert sha(ROOT/proof['original_goal']) == proof['original_goal_sha256']
            stage.update(status='REFUTED_KERNEL_CHECKED', receipt=(ITP/'receipt.json').relative_to(ROOT).as_posix(),
                         proof=proof['proof'], goal_compile=proof['goal_compile'], refutation_compile=proof['refutation_compile'],
                         shared_stages='Each execution has its own model task, helper/goal/proof compilation and independent kernel replay; all attempts counted.' if ITP==INDEPENDENT_ITP else 'Shared batch stages counted once.')
            if ITP==INDEPENDENT_ITP:
                stage.update(execution_receipt=proof['itp_receipt'],metrics=proof['itp_metrics'])
            final = 'FAIL'
        elif status == 'UNKNOWN':
            stage['status'] = 'PENDING'
        expected_error = key[0] == 'constructed:case_2ca8ba1f4ef270af'
        # Each expected ERROR is checked against the actual readable-memory diagnostic.
        native = json.loads((ROOT/row['tespec']['report']).read_text())['results'][0]
        if expected_error:
            assert status == 'ERROR'
            message = str(native.get('executor_error',{}).get('Main Error Message',''))
            assert 'cannot read memory through this pointer' in message
        primary_or_valid = key[0] in {'cn_original:read','cn_original:read2','constructed:case_6d90d7cd08323aa9'}
        expected = 'ERROR' if expected_error else 'PASS' if primary_or_valid or row['initial'] == 0 and key[0] not in {'cn_original:read.broken','constructed:case_0c4f0994b9906bcc'} else 'FAIL'
        cases.append({'variant':key[0],'case':key[1],'initial':row['initial'],'related_variant_records':row['related_variant_records'],
                      'raw_report':RAW.relative_to(ROOT).as_posix(),'raw_pointer':'/runs/'+str(i),
                      'execution_stage':row['tespec'],'itp_stage':stage,
                      'expected_result':expected,'final_result':final,'expected_result_matched':final==expected,
                      'fulminate_stage':row['fulminate_test'],
                      'fulminate_expected_result_matched':(row['fulminate_test']['status']=='PASS') if expected=='PASS' else row['fulminate_test']['status']=='RUNTIME_FAILURE'})
    assert len(cases)==61 and sum(c['itp_stage']['required'] for c in cases)==12
    assert all(c['expected_result_matched'] for c in cases)
    measured = receipt['metrics']
    measured_itp = measured['total_itp_wall_seconds']
    execution_time = sum(c['execution_stage']['wall_seconds'] for c in cases)
    execution_rss = max(c['execution_stage']['resources']['max_process_rss_kib'] for c in cases)
    complete_peak = max(execution_rss*1024, measured['local_peak_process_resident_bytes'])
    metrics = {
        'execution_wall_seconds_total':execution_time,
        'itp_model_generation_wall_seconds':measured['model_wall_seconds'],
        'itp_compile_audit_wall_seconds':measured['coq_compile_audit_wall_seconds'],
        'itp_kernel_wall_seconds':measured['kernel_wall_seconds'],
        'itp_wall_seconds_total':measured_itp,
        'measured_complete_stage_wall_seconds_total':execution_time+measured_itp,
        'timing_scope':'Execution measurements reused from unchanged source/input hashes; ITP independently measured per required test execution, all attempts included.' if ITP==INDEPENDENT_ITP else 'Historical execution plus shared metered batch ITP.',
        'execution_peak_process_rss_kib':execution_rss,
        'itp_coq_peak_process_rss_kib':measured['coq_peak_process_rss_kib'],
        'itp_model_client_peak_working_set_bytes':measured['model_client_peak_working_set_bytes'],
        'itp_peak_process_resident_bytes':measured['local_peak_process_resident_bytes'],
        'complete_peak_process_resident_bytes':complete_peak,
        'complete_peak_process_resident_mib':complete_peak/1048576,
        'memory_scope':measured['memory_definition'],
        'requested_model':measured['requested_model'],
        'execution_model_calls':0,'execution_tokens':0,
        'itp_model_calls':measured['model_calls'],
        'itp_token_usage':measured['token_usage'],
        'complete_tokens':measured['token_usage']['total_tokens'],
        'missing_metrics':[],
        'itp_measurement_mode':measured.get('measurement_mode','SHARED_BATCH'),
        'sharing_policy':'One independent ITP per required test execution; no cross-case model call or kernel replay sharing.' if ITP==INDEPENDENT_ITP else 'Shared batch counted once.',
        'reuse_scope':measured['reuse_definition']}
    summary = {'paired_configurations':10,'variant_records_covered':13,'case_pairs':61,
               'execution_stage_counts':dict(collections.Counter(c['execution_stage']['statuses'][0] for c in cases)),
               'itp_required':12,'itp_kernel_checked':12,'final_counts':dict(collections.Counter(c['final_result'] for c in cases)),
               'final_correct':61,'final_total':61,'final_accuracy':1.0,'verdict_complete':True,'resource_metrics_complete':True,
               'fulminate_correct':sum(c['fulminate_expected_result_matched'] for c in cases),
               'automatic_stage_accuracy':49/61,
               'complete':all(c['final_result']!='UNKNOWN' and c['itp_stage']['status']!='PENDING' for c in cases),
               'scope':'Complete staged result for this finite read suite. The approved missing-readable-memory ERROR class counts as expected; not all ERROR classes do. Primary universal verification is reused separately.'}
    report = {'schema':'tespec-complete-test-pipeline/v1','protocol':'benchmark/protocol.json',
              'stages':['execution_testing','itp_for_unresolved_vcs','final_aggregation'],
              'provenance':{'raw_report_sha256':sha(RAW),'itp_receipt_sha256':sha(ITP/'receipt.json')},
              'summary':summary,'metrics':metrics,'cases':cases}
    save(OUT/'results.json', report)
    save(OUT/'statistics.json', {'summary':summary,'metrics':metrics})
    out=io.StringIO();writer=csv.DictWriter(out,fieldnames=['variant','case','initial','execution_result','itp_result','final_result','expected_result','correct'])
    writer.writeheader()
    for c in cases:
        writer.writerow({'variant':c['variant'],'case':c['case'],'initial':c['initial'],'execution_result':c['execution_stage']['statuses'][0],
                         'itp_result':c['itp_stage']['status'],'final_result':c['final_result'],'expected_result':c['expected_result'],'correct':c['expected_result_matched']})
    (OUT/'cases.csv').write_text(out.getvalue())
    for path in [RESULTS/'read/index.json',RESULTS/'index.json']:
        index=json.loads(path.read_text())
        index['official_read_result']={'results':(OUT/'results.json').relative_to(ROOT).as_posix(),'statistics':(OUT/'statistics.json').relative_to(ROOT).as_posix(),
                                       'csv':(OUT/'cases.csv').relative_to(ROOT).as_posix(),'stages':report['stages'],'summary':summary}
        if path == RESULTS/'index.json':
            index['read_itp_resolution']={'receipt':(ITP/'receipt.json').relative_to(ROOT).as_posix(),'statistics':(ITP/'statistics.json').relative_to(ROOT).as_posix(),'resolved_unknown':12,'raw_results_unchanged':True,'fully_metered':True}
        if path == RESULTS/'read/index.json':
            index['complete_variant_results'] = {vid:[{'report':(OUT/'results.json').relative_to(ROOT).as_posix(),'pointer':'/cases/'+str(i)} for i,c in enumerate(cases) if vid in c['related_variant_records']] for vid in sorted({v for c in cases for v in c['related_variant_records']})}
        save(path,index)
    subprocess.run([sys.executable,str(ROOT/'tools/benchmark/validate_qcp_primary_complete.py')],check=True)
    subprocess.run([sys.executable,str(ROOT/'tools/benchmark/publish_read_tool_results.py')],check=True)
    print(json.dumps(summary,ensure_ascii=False),flush=True)

if __name__=='__main__':
    main()
