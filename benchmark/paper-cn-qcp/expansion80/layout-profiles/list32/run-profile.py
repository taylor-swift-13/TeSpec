#!/usr/bin/env python3
"""Run every original binding and variant in explicit list-layout profiles."""
import argparse
import hashlib
import json
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[4]
VARIANTS = ('reference', 'spec_mutation', 'impl_mutation')

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cases', nargs='+', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--timeout', type=float, default=120)
    args = parser.parse_args()
    if args.timeout <= 0:
        parser.error('timeout must be positive')
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    report = {'schema': 'tespec-list-layout-profile-runs/v1',
              'scope': 'experimental profile, all original bindings; not full suite admission',
              'admission_complete': False, 'included_in_frozen_atp_counts': False,
              'driver_sha256': sha(Path(__file__)), 'runs': []}
    def save():
        staging = out / 'report.json.tmp'
        staging.write_text(json.dumps(report, indent=2) + '\n')
        staging.replace(out / 'report.json')
    save()
    for case in args.cases:
        profile = out / case
        subprocess.run([sys.executable, str(HERE / 'prepare-profile.py'),
                        '--case', case, '--output', str(profile)], check=True)
        metadata = json.loads((profile / 'profile.json').read_text())
        for variant in VARIANTS:
            command = [sys.executable, '-m', 'spectest', 'run',
                       str(profile / (variant + '.qcp.c')),
                       '--function', metadata['function'], '--binds', str(profile / 'binds.json'),
                       '--output-dir', str(profile / (variant + '-run')),
                       '--execution-mode', 'expand', '--arch', '32',
                       '--loop-unroll-limit', '128', '--call-depth-limit', '128',
                       '--timeout', str(args.timeout), '--compact', '-I', str(profile),
                       '-I', str(ROOT / 'runtime/qcip/QCP_examples/QCP_demos_human')]
            log = profile / (variant + '-run.log')
            with log.open('w') as stream:
                completed = subprocess.run(command, cwd=ROOT, stdout=stream, stderr=subprocess.STDOUT)
            path = profile / (variant + '-run/report.json')
            row = {'case': case, 'variant': variant, 'command': command,
                   'returncode': completed.returncode, 'log_sha256': sha(log),
                   'expected_input_count': len(metadata['input_ids'])}
            if path.exists():
                data = json.loads(path.read_text())
                row['report_path'] = str(path.relative_to(out))
                row['report_sha256'] = sha(path)
                row['counts'] = {status: sum(x['status'] == status for x in data['results'])
                                 for status in ('PASS', 'FAIL', 'UNKNOWN', 'ERROR')}
                assert [x['id'] for x in data['results']] == metadata['input_ids']
            else:
                row['infrastructure_error'] = 'missing report'
            report['runs'].append(row)
            save()
            print(json.dumps(row), flush=True)
    report['execution_complete'] = True
    save()

if __name__ == '__main__':
    main()
