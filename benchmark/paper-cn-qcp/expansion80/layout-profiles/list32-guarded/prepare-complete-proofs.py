#!/usr/bin/env python3
"""Prepare complete original VC certificates using generic list proofs."""
import argparse
import hashlib
import json
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
EXP = HERE.parents[1]
ROOT = HERE.parents[4]
sys.path.insert(0, str(ROOT))
from spectest.run_certificates import prepare_run_certificates

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--report', type=Path, required=True)
    parser.add_argument('--suite', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    prepared = prepare_run_certificates(args.report.resolve(), args.output)
    run_manifest = Path(prepared['manifest'])
    bundle = json.loads(run_manifest.read_text())
    entry_generator = HERE.with_name('list32') / 'prepare-entry-proof.py'
    tactics = EXP / 'theory/ListConcreteVCTactics.v'
    rows = []
    for row in bundle['certificates']:
        folder = Path(row['manifest']).parent
        entry_folder = run_manifest.parent / 'entry-pieces' / folder.name
        command = [sys.executable, str(entry_generator), '--report', str(args.report.resolve()),
                   '--suite', str(args.suite.resolve()), '--input-id', row['case_id'],
                   '--output', str(entry_folder)]
        subprocess.run(command, check=True, stdout=subprocess.DEVNULL)
        assert (entry_folder / 'Goal.v').read_bytes() == (folder / 'Goal.v').read_bytes()
        source = (entry_folder / 'Candidate.v').read_text().removesuffix('End Proofs.\n')
        assert source.count('Module Proofs.') == 1
        source = source.replace('Module Proofs.', tactics.read_text() + '\nModule Proofs.')
        certificate = json.loads((folder / 'manifest.json').read_text())
        for goal in certificate['goals']:
            if f"Lemma {goal['proof']} :" in source:
                continue
            source += (f"Lemma {goal['proof']} : Goal.{goal['statement']}.\n"
                       f"Proof. unfold Goal.{goal['statement']}. prove_flat_list_vc. Qed.\n")
        source += 'End Proofs.\n'
        (folder / 'Candidate.v').write_text(source)
        rows.append({'case_id': row['case_id'], 'folder': folder.name,
                     'candidate_sha256': sha(folder / 'Candidate.v'),
                     'goal_sha256': sha(folder / 'Goal.v'),
                     'original_goal_count': len(certificate['goals'])})
    record = {'scope': 'generated complete original VC proofs; kernel checks pending; no assigned verdict',
              'generator_sha256': sha(Path(__file__)), 'entry_generator_sha256': sha(entry_generator),
              'tactics_sha256': sha(tactics), 'suite_sha256': sha(args.suite),
              'automatic_report_sha256': sha(args.report),
              'run_manifest_sha256': prepared['manifest_sha256'], 'certificates': rows}
    (run_manifest.parent / 'generation.json').write_text(json.dumps(record, indent=2) + '\n')
    print(json.dumps(prepared, indent=2))

if __name__ == '__main__':
    main()
