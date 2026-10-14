#!/usr/bin/env python3
"""Archive completed list reference certificates without changing tool verdicts."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent


def read(path):
    return json.loads(path.read_text())


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--case', choices=['qcp_list_length', 'qcp_list_reverse', 'qcp_list_append'], required=True)
    parser.add_argument('--archive-name', required=True)
    args = parser.parse_args()
    source = args.source.resolve()
    final = read(source / 'report.json')
    suite_path = HERE / 'suites' / args.case / 'suite.json'
    suite = read(suite_path)
    ids = {i['id'] for i in suite['inputs']}
    assert len(ids) == 128 and {r['id'] for r in final['results']} == ids
    assert final['summary']['total'] == final['summary']['PASS'] == 128
    assert all(r['status'] == 'PASS' and r['precondition_result'] == 'SAT' for r in final['results'])
    request = read(source / 'run-manifest.json')
    assert len(request['certificates']) == 128
    for entry in request['certificates']:
        report = read(Path(entry['manifest']).parent / 'certificate-report.json')
        assert report['status'] == 'PASS'
        assert report['kernel_replay_mode'] in ['full', 'checked-dependency-reuse']
        assert all(s['exit_code'] == 0 for s in report['stages'])
    target = HERE / 'evidence' / args.archive_name
    target.mkdir()  # Frozen archives must never be overwritten.
    skipped = {'.vo', '.vos', '.vok', '.glob', '.aux', '.pyc'}
    for path in sorted(source.rglob('*')):
        if not path.is_file() or path.suffix in skipped or '__pycache__' in path.parts:
            continue
        dest = target / path.relative_to(source)
        dest.parent.mkdir(parents=True, exist_ok=True)
        if path.suffix == '.log':
            dest.with_suffix('.log.gz').write_bytes(gzip.compress(path.read_bytes(), mtime=0))
        else:
            shutil.copyfile(path, dest)
    generation = read(source / 'generation.json')
    preparers = ['layout-profiles/list32-guarded/prepare-residual-entry-proofs.py',
                 'layout-profiles/list32-guarded/prepare-residual-entry-proofs-v2.py']
    generators = ['layout-profiles/list32/prepare-entry-proof-v2.py',
                  'layout-profiles/list32/prepare-entry-proof-v3.py']
    sources = {}
    for expected, paths in [(generation['driver_sha256'], preparers),
                            (generation['entry_generator_sha256'], generators)]:
        matches = [p for p in paths if sha(HERE / p) == expected]
        assert len(matches) == 1
        sources[matches[0]] = expected
    assert generation['suite_sha256'] == sha(suite_path)
    receipt = {
        'schema': 'tespec-list-reference-atp-itp/v1',
        'scope': 'all original reference bindings, experimental guarded layout profile',
        'admission_complete': False, 'included_in_frozen_atp_counts': False,
        'case': args.case, 'inputs': 128, 'PASS': 128,
        'sources': sources,
        'files': {str(p.relative_to(target)): sha(p) for p in sorted(target.rglob('*')) if p.is_file()},
    }
    (target / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print(json.dumps({'archive': str(target), 'files': len(receipt['files']), 'PASS': 128}))


if __name__ == '__main__':
    main()
