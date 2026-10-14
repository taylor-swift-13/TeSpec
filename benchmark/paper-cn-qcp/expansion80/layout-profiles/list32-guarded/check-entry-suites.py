#!/usr/bin/env python3
"""Check original entry SAT certificates for every reference input binding."""
import argparse
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
EXP = HERE.parents[1]
ROOT = HERE.parents[4]
sys.path.insert(0, str(ROOT))
from spectest.certificates import check_certificate, digest
from spectest.kernel_replay import KernelReplayCache


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--profile-root', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--timeout', type=float, default=180)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    generator = HERE.with_name('list32') / 'prepare-entry-proof-v2.py'
    profile_root = args.profile_root.resolve()
    run = json.loads((profile_root / 'report.json').read_text())
    references = [r for r in run['runs'] if r['variant'] == 'reference']
    cache = KernelReplayCache()
    record = {'scope': 'original reference entry SAT VCs only; no overall verdict assigned',
              'admission_complete': False, 'included_in_frozen_atp_counts': False,
              'generator_sha256': digest(generator), 'driver_sha256': digest(Path(__file__)),
              'profile_report_sha256': digest(profile_root / 'report.json'),
              'expected_inputs': sum(r['expected_input_count'] for r in references),
              'complete': False, 'results': []}

    def save():
        temporary = output / 'report.tmp'
        temporary.write_text(json.dumps(record, indent=2) + '\n')
        temporary.replace(output / 'report.json')

    save()
    for row in references:
        report = profile_root / row['report_path']
        assert digest(report) == row['report_sha256']
        automatic = json.loads(report.read_text())
        assert len(automatic['results']) == row['expected_input_count']
        profile = json.loads((profile_root / row['case'] / 'profile.json').read_text())
        suite = EXP / profile['suite_path']
        assert digest(suite) == profile['suite_sha256']
        for case in automatic['results']:
            folder = output / row['case'] / case['id']
            folder.parent.mkdir(parents=True, exist_ok=True)
            command = [sys.executable, str(generator), '--report', str(report),
                       '--suite', str(suite), '--input-id', case['id'], '--output', str(folder)]
            result = {'case': row['case'], 'input_id': case['id'], 'precondition_status': 'UNKNOWN'}
            try:
                with (folder.parent / (case['id'] + '-generation.log')).open('w') as log:
                    subprocess.run(command, check=True, stdout=log, stderr=subprocess.STDOUT)
                manifest = folder / 'manifest.json'
                certificate = check_certificate(manifest, digest(manifest), timeout=args.timeout,
                                                kernel_cache=cache)
                result.update(manifest_sha256=digest(manifest), certificate_status=certificate['status'])
                if certificate['status'] == 'PASS':
                    result['precondition_status'] = 'SAT'
            except Exception as error:
                result['error'] = str(error)
            record['results'].append(result)
            save()
            print(json.dumps(result), flush=True)
    record['complete'] = len(record['results']) == record['expected_inputs']
    save()


if __name__ == '__main__':
    main()
