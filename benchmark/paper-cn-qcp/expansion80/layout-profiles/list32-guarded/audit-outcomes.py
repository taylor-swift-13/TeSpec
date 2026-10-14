#!/usr/bin/env python3
"""Compare profile results with frozen per-input spec and implementation oracles."""
import argparse
from collections import Counter
import gzip
import hashlib
import json
from pathlib import Path

EXP = Path(__file__).resolve().parents[2]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--evidence', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    evidence = args.evidence.resolve()
    rows = json.loads((evidence / 'report.json').read_text())['runs']
    record = {'scope': 'per-input outcome audit; expected verdicts do not assign tool verdicts',
              'admission_complete': False, 'included_in_frozen_atp_counts': False,
              'driver_sha256': sha(Path(__file__)), 'runs': []}
    for row in rows:
        suite_path = EXP / 'suites' / row['case'] / 'suite.json'
        suite = json.loads(suite_path.read_text())
        inputs = {i['id']: i for i in suite['inputs']}
        assert len(inputs) == suite['input_count'] == row['expected_input_count']
        report_path = evidence / (row['report_path'] + '.gz')
        raw = gzip.decompress(report_path.read_bytes())
        assert hashlib.sha256(raw).hexdigest() == row['report_sha256']
        report = json.loads(raw)
        results = report['results']
        assert len(results) == len(inputs)
        assert {r['id'] for r in results} == set(inputs)
        counts = Counter()
        details = []
        for result in results:
            item = inputs[result['id']]
            assert result['arguments'] == item['qcp_bind']['args']
            assert result['bindings'] == item['qcp_bind']['values']
            violated = row['variant'] != 'reference' and item[row['variant'] + '_violated']
            expected = 'FAIL' if violated else 'PASS'
            actual = result['status']
            counts[expected + '/' + actual] += 1
            details.append({'input_id': result['id'], 'expected': expected, 'actual': actual,
                            'entry': result['precondition_result'],
                            'execution_completed': result['execution_completed'],
                            'residual_vcs': result['residual_vcs']})
        record['runs'].append({'case': row['case'], 'variant': row['variant'],
                               'suite_sha256': sha(suite_path),
                               'automatic_report_sha256': row['report_sha256'],
                               'outcomes': dict(counts), 'inputs': details})
    args.output.write_text(json.dumps(record, indent=2) + '\n')
    print(json.dumps([{k: r[k] for k in ['case', 'variant', 'outcomes']} for r in record['runs']]))


if __name__ == '__main__':
    main()
