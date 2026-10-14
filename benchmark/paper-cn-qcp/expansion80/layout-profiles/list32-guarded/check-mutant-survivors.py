#!/usr/bin/env python3
"""Check surviving mutant inputs; keep the full original negative population separate."""
import argparse
from collections import Counter
import copy
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
EXP = HERE.parents[1]
ROOT = HERE.parents[4]
sys.path.insert(0, str(ROOT))
from spectest.certificates import digest
from spectest.run_certificates import check_run_certificates


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--profile-root', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--timeout', type=float, default=180)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    profile = args.profile_root.resolve()
    run = json.loads((profile / 'report.json').read_text())
    record = {'scope': 'mutant survivors only; full negative population retained in original profile reports',
              'admission_complete': False, 'included_in_frozen_atp_counts': False,
              'driver_sha256': digest(Path(__file__)), 'profile_report_sha256': digest(profile / 'report.json'),
              'complete': False, 'runs': []}

    def save():
        temporary = output / 'report.tmp'
        temporary.write_text(json.dumps(record, indent=2) + '\n')
        temporary.replace(output / 'report.json')

    save()
    for row in run['runs']:
        if row['variant'] != 'impl_mutation':
            continue
        suite_path = EXP / 'suites' / row['case'] / 'suite.json'
        suite = json.loads(suite_path.read_text())
        automatic_path = profile / row['report_path']
        assert digest(automatic_path) == row['report_sha256']
        automatic = json.loads(automatic_path.read_text())
        survivors = {i['id'] for i in suite['inputs'] if not i['impl_mutation_violated']}
        atp_valid = {r['id'] for r in automatic['results']
                     if r['execution_completed'] and r['vc_results']
                     and all(v['status'] == 'VALID' for v in r['vc_results'])}
        assert survivors == atp_valid, 'independent mutation oracle and automatic VCs disagree'
        result = {'case': row['case'], 'original_inputs': len(automatic['results']),
                  'expected_survivors': len(survivors),
                  'negative_inputs_retained': len(automatic['results']) - len(survivors),
                  'original_report_sha256': digest(automatic_path), 'suite_sha256': digest(suite_path)}
        if not survivors:
            result['scope'] = 'no surviving inputs'
            record['runs'].append(result)
            save()
            continue
        folder = output / row['case']
        folder.mkdir()
        selected = copy.deepcopy(automatic)
        selected['results'] = [r for r in selected['results'] if r['id'] in survivors]
        selected['itp_vcs'] = [r for r in selected['itp_vcs'] if r['case_id'] in survivors]
        counts = Counter(r['status'] for r in selected['results'])
        selected['summary'].update(total=len(survivors), **{k: counts[k] for k in ['PASS', 'FAIL', 'UNKNOWN', 'ERROR', 'INVALID']})
        selected['selection'] = {'scope': 'mutation survivors', 'original_report_sha256': digest(automatic_path),
                                 'original_input_count': len(automatic['results']),
                                 'timing_scope': 'inherited original batch; not selected-input timing'}
        report_path = folder / 'selected-automatic.json'
        report_path.write_text(json.dumps(selected, indent=2) + '\n')
        subprocess.run([sys.executable, str(HERE / 'prepare-residual-entry-proofs.py'),
                        '--report', str(report_path), '--suite', str(suite_path),
                        '--output', str(folder / 'proofs')], check=True, stdout=subprocess.DEVNULL)
        proofs = folder / 'proofs'
        generation = json.loads((proofs / 'generation.json').read_text())
        checked = check_run_certificates(proofs / 'run-manifest.json', generation['run_manifest_sha256'],
                                         timeout=args.timeout)
        result.update(summary=checked['summary'], report_sha256=digest(proofs / 'report.json'))
        record['runs'].append(result)
        save()
        print(json.dumps(result), flush=True)
    record['complete'] = True
    save()


if __name__ == '__main__':
    main()
