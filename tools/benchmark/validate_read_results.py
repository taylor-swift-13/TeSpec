#!/usr/bin/env python3
"""Audit actual read executions, their inputs, statuses and metric aggregation."""
from pathlib import Path
import collections, hashlib, json, math
from evidence_paths import evidence_path

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / 'benchmark/results/read/20261015-variants'

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    data = json.loads((BASE / 'results.json').read_text())
    stats = json.loads((BASE / 'statistics.json').read_text())
    manifest = json.loads((ROOT / 'benchmark/programs/read/manifest.json').read_text())
    variants = {e['id']: json.loads((ROOT / e['manifest']).read_text()) for e in manifest['variants']}
    runs = data['runs']
    assert len(runs) == 61
    assert {vid for r in runs for vid in r['related_variant_records']} == set(variants)
    counts = collections.Counter(r['variant'] for r in runs)
    assert len(counts) == 10 and min(counts.values()) >= 6
    for r in runs:
        cn = variants[r['variant']]['files']['cn']
        qcp = variants[r['paired_qcp_variant']]['files']['qcp']
        assert sha(ROOT / cn['path']) == r['cn_source_sha256'] == cn['sha256']
        assert sha(ROOT / qcp['path']) == r['qcp_source_sha256'] == qcp['sha256']
        for name in ['harness', 'binds']:
            assert sha(ROOT / r[name]) == r[name + '_sha256']
        for tool in ['fulminate_pipeline', 'fulminate_test', 'tespec']:
            stage = r[tool]
            assert stage['tokens'] == stage['model_calls'] == 0
            for name in ['stdout', 'stderr']:
                assert (ROOT / stage[name]).is_file()
            assert stage['wall_seconds'] > 0
            assert stage['resources']['max_process_rss_kib'] >= 0
        raw = json.loads((ROOT / r['tespec']['report']).read_text())
        assert r['tespec']['statuses'] == [x.get('status') for x in raw['results']]
        assert ('PASS' if r['fulminate_test']['exit_code'] == 0 else 'RUNTIME_FAILURE') == r['fulminate_test']['status']
        for x in raw['results']:
            for name in ['generated_source', 'stdout', 'stderr']:
                if x.get(name):
                    assert evidence_path(x[name]).is_file(), x[name]
    assert data['summary']['tespec'] == dict(collections.Counter(s for r in runs for s in r['tespec']['statuses']))
    for row in stats['configurations']:
        selected = [r for r in runs if r['variant'] == row['variant']]
        assert row['test_cases'] == len(selected)
        for tool in ['fulminate_pipeline', 'fulminate_test', 'tespec']:
            assert math.isclose(row[tool + '_wall_seconds_total'], sum(r[tool]['wall_seconds'] for r in selected))
            assert row[tool + '_max_process_rss_kib'] == max(r[tool]['resources']['max_process_rss_kib'] for r in selected)
    relocations = json.loads((ROOT / 'benchmark/results/relocation-map.json').read_text())
    for r in relocations['files']:
        if r['old'] == 'benchmark/programs/evidence.json':
            continue  # regenerated path-only view of the immutable registry
        assert sha(ROOT / r['new']) == r['sha256'], r['new']
    assert not (ROOT / 'benchmark/programs/evidence.json').exists()
    assert not list((ROOT / 'benchmark/programs').rglob('tests/results.json'))
    print('PASS: all 13 read records covered by 61 paired finite inputs; raw statuses, source/input hashes, time/RSS totals and historical relocation bytes checked.')

if __name__ == '__main__':
    main()
