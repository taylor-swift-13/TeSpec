#!/usr/bin/env python3
"""Publish the complete test result, including checked ITP resolution stages."""
from pathlib import Path
import collections, csv, hashlib, io, json, subprocess, sys

ROOT = Path(__file__).resolve().parents[2]
RESULTS = ROOT / 'benchmark/results'
RAW = RESULTS / 'read/20261015-variants/results.json'
ITP = RESULTS / 'read/20261015-itp-refutations'
OUT = RESULTS / 'read/complete'

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def save(p, data):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')

def main():
    # Audit existing observations and proof receipts; no execution or proof rerun.
    subprocess.run([sys.executable, str(ROOT/'tools/benchmark/validate_read_results.py')], check=True)
    subprocess.run([sys.executable, str(ROOT/'tools/benchmark/validate_read_itp.py')], check=True)
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
                         shared_stages='Shared helper compilation, failed authoring attempts and independent kernel replay are counted once in aggregate metrics.')
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
    measured_itp = adjudication['measured_compile_and_kernel_wall_seconds_including_failed_attempts']
    execution_time = sum(c['execution_stage']['wall_seconds'] for c in cases)
    metrics = {
        'execution_wall_seconds_total':execution_time,
        'itp_compile_and_kernel_wall_seconds_including_failed_attempts':measured_itp,
        'measured_complete_stage_wall_seconds_total':execution_time+measured_itp,
        'timing_scope':'Sum of measured sequential stage work, including failed proof compilation attempts. Human/chat proof authoring time was not measured; this is not a full elapsed authoring-to-completion measurement.',
        'kernel_wall_seconds':receipt['kernel_check']['wall_seconds'],
        'execution_peak_process_rss_kib':max(c['execution_stage']['resources']['max_process_rss_kib'] for c in cases),
        'itp_peak_rss_kib':None,'complete_peak_rss_kib':None,
        'execution_model_api_calls':0,'execution_tokens':0,'itp_external_model_api_calls':0,
        'itp_authoring_tokens':None,'complete_tokens':None,
        'missing_metrics':['ITP peak RSS','proof authoring elapsed time','proof authoring conversation tokens'],
        'sharing_policy':'Shared ITP helper/kernel work counted once, not multiplied by 12 cases; no artificial per-case allocation.'}
    summary = {'paired_configurations':10,'variant_records_covered':13,'case_pairs':61,
               'execution_stage_counts':dict(collections.Counter(c['execution_stage']['statuses'][0] for c in cases)),
               'itp_required':12,'itp_kernel_checked':12,'final_counts':dict(collections.Counter(c['final_result'] for c in cases)),
               'final_correct':61,'final_total':61,'final_accuracy':1.0,'verdict_complete':True,'resource_metrics_complete':False,
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
        if path == RESULTS/'read/index.json':
            index['complete_variant_results'] = {vid:[{'report':(OUT/'results.json').relative_to(ROOT).as_posix(),'pointer':'/cases/'+str(i)} for i,c in enumerate(cases) if vid in c['related_variant_records']] for vid in sorted({v for c in cases for v in c['related_variant_records']})}
        save(path,index)
    print(json.dumps(summary,ensure_ascii=False),flush=True)

if __name__=='__main__':
    main()
