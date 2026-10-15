#!/usr/bin/env python3
"""Read-only audit of existing case evidence; writes only the paper inventory."""
import argparse
import hashlib
import json
from pathlib import Path

PAPER = Path(__file__).resolve().parents[1]
ROOT = PAPER.parent
OUT = PAPER / 'evidence/case-study-audit.json'
files = {}

def keep(path):
    p = ROOT / path
    data = p.read_bytes()
    files[str(p.relative_to(ROOT))] = hashlib.sha256(data).hexdigest()
    return data

def read(path):
    return json.loads(keep(path))

def local(path):
    for prefix in ['/home/yangfp/teSpec-benchmark-tespec/', '/home/yangfp/teSpec/']:
        if path.startswith(prefix):
            return path[len(prefix):]
    return path

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--record', action='store_true')
    args = ap.parse_args()
    raw = read('benchmark/results/read/20261015-variants/results.json')
    ful = read('benchmark/results/read/fulminate/results.json')
    comparison = read('benchmark/results/read/comparison.json')
    spatial = read('benchmark/results/read/20261015-spatial-smt/statistics.json')
    itp = read('benchmark/results/read/20261015-itp-per-execution/receipt.json')
    assert len(raw['runs']) == 61
    assert len({x['variant'] for x in raw['runs']}) == 10
    assert ful['summary']['correct'] == 60
    errors = [x for x in ful['cases'] if not x['correct']]
    assert len(errors) == 1
    assert errors[0]['variant'] == 'constructed:case_0b5de543ec816188'
    assert errors[0]['initial'] == -2147483648
    controls = []
    for run in raw['runs']:
        if run['variant'] != 'constructed:case_0b5de543ec816188':
            continue
        harness = keep(run['harness'])
        assert hashlib.sha256(harness).hexdigest() == run['harness_sha256']
        keep(run['binds'])
        for stage in ['fulminate_pipeline', 'fulminate_test', 'tespec']:
            for stream in ['stdout', 'stderr']:
                keep(run[stage][stream])
        report = read(run['tespec']['report'])
        result = report['results'][0]
        source = local(report['source'])
        assert hashlib.sha256(keep(source)).hexdigest() == run['qcp_source_sha256']
        assert result['precondition_result'] == 'SAT'
        controls.append({'input': run['initial'],
                         'fulminate_exit': run['fulminate_test']['exit_code'],
                         'tespec': result['test_result']})
        if run['initial'] == -2147483648:
            assert run['fulminate_test']['exit_code'] == 0
            assert result['test_result'] == 'FAIL'
            assert any(v['kind'] == 'safety' and v['status'] == 'INVALID'
                       for v in result['vc_results'])
            assert result['evidence']['certificate'] == 'NOT_CHECKED'
            assert 'return -*p;' in harness.decode()
        elif run['initial'] == 0:
            assert run['fulminate_test']['exit_code'] == 0
            assert result['test_result'] == 'PASS'
        else:
            assert run['fulminate_test']['exit_code'] == 2
            assert result['test_result'] == 'FAIL'
    assert len(controls) == 6
    assert spatial['case_pairs'] == 61
    assert spatial['modes']['off']['native_status_counts']['UNKNOWN'] == 12
    assert spatial['modes']['on']['native_status_counts'] == {'PASS':22,'FAIL':32,'ERROR':7}
    assert spatial['raw_classifications_unchanged'] == 49
    assert spatial['countermodels_checked'] == spatial['agreement_with_existing_kernel_refutations'] == 12
    assert len(itp['cases']) == 12
    for case in itp['cases']:
        assert case['itp_status'] == 'REFUTED_KERNEL_CHECKED'
        for key in ['original_goal', 'goal_copy', 'proof']:
            assert hashlib.sha256(keep(case[key])).hexdigest() == case[key+'_sha256']
    archive = PAPER / 'evidence/comparative-case-studies-20261013'
    for rel in ['evidence/least-root-20261013/receipt.json',
                'case-studies/divisibility/evidence/receipt.json',
                'case-studies/divisibility/theory/receipt.json']:
        keep(str((archive / rel).relative_to(ROOT)))
    audit = {'schema':'tespec-paper-case-study-audit/v1',
             'scope':'Existing evidence only; no tool or benchmark execution.',
             'read_negation_controls': controls,
             'read_pairs':61,'read_configurations':10,
             'fulminate_mismatches':1,'spatial_cases_resolved':12,
             'files':dict(sorted(files.items()))}
    if args.record:
        OUT.write_text(json.dumps(audit, indent=2)+'\n')
    else:
        assert json.loads(OUT.read_text()) == audit, 'Pinned case evidence changed; review before recording.'
    print('Case-study evidence verified:', len(files), 'pinned files; 6 boundary controls; 12 ITP groups.')

if __name__ == '__main__':
    main()
