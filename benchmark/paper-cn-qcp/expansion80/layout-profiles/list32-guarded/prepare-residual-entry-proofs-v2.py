#!/usr/bin/env python3
"""Prepare ATP/ITP run completion when only original entry SAT VCs remain."""
import argparse
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[4]
sys.path.insert(0, str(ROOT))
from spectest.certificates import digest
from spectest.run_certificates import prepare_run_certificates


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--report', type=Path, required=True)
    parser.add_argument('--suite', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    request = prepare_run_certificates(args.report.resolve(), args.output, residual_only=True)
    path = Path(request['manifest'])
    entries = json.loads(path.read_text())['certificates']
    generator = HERE.with_name('list32') / 'prepare-entry-proof-v3.py'
    rows = []
    for entry in entries:
        folder = Path(entry['manifest']).parent
        bundle = json.loads(Path(entry['manifest']).read_text())
        assert len(bundle['goals']) == 1 and '_precondition_wit_' in bundle['goals'][0]['statement']
        generated = path.parent / 'entry-pieces' / folder.name
        subprocess.run([sys.executable, str(generator), '--report', str(args.report.resolve()),
                        '--suite', str(args.suite.resolve()), '--input-id', entry['case_id'],
                        '--output', str(generated)], check=True, stdout=subprocess.DEVNULL)
        assert (folder / 'Goal.v').read_bytes() == (generated / 'Goal.v').read_bytes()
        (folder / 'Candidate.v').write_bytes((generated / 'Candidate.v').read_bytes())
        rows.append({'case_id': entry['case_id'], 'candidate_sha256': digest(folder / 'Candidate.v')})
    (path.parent / 'generation.json').write_text(json.dumps({
        'scope': 'entry-only residual completion, automatic execution VCs retained',
        'driver_sha256': digest(Path(__file__)), 'entry_generator_sha256': digest(generator),
        'suite_sha256': digest(args.suite), 'automatic_report_sha256': digest(args.report),
        'run_manifest_sha256': request['manifest_sha256'], 'certificates': rows,
    }, indent=2) + '\n')
    print(json.dumps(request, indent=2))


if __name__ == '__main__':
    main()
