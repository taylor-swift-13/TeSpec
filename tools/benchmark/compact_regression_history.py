#!/usr/bin/env python3
"""Fold legacy native regression costs into group receipts, discard duplicate traces."""
import collections
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
from compact_published_groups import load, encoded, digest, decision_cost_facts


def save(path, obj):
    data = encoded(obj)
    if len(data) > 32768:
        data = (json.dumps(obj, ensure_ascii=False, separators=(',', ':')) + '\n').encode()
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)


def summarize_cost_records(records):
    buckets = collections.defaultdict(list)
    counts = collections.Counter()
    statuses = collections.defaultdict(collections.Counter)
    def walk(x, key, destination):
        if isinstance(x, dict):
            for k, v in x.items():walk(v, key + '.' + k, destination)
        elif isinstance(x, list):
            for v in x:walk(v, key + '[]', destination)
        elif isinstance(x, (int, float)) and not isinstance(x, bool):
            destination[key].append(x)
    for row in records:
        mode = str(row.get('execution_strategy')) + '/' + str(row.get('mode'))
        counts[mode] += 1
        statuses[mode][str(row.get('raw_status'))] += 1
        for key in ('measurement', 'stage_measurements'):
            walk(row.get(key), mode + '.' + key, buckets)
    return {'executions_by_mode': dict(counts),
            'raw_status_counts': {k: dict(v) for k, v in statuses.items()},
            'metrics': {k: {'observations': len(v), 'total_of_observations': sum(v),
                            'mean': sum(v)/len(v), 'maximum': max(v), 'minimum': min(v)}
                        for k, v in sorted(buckets.items())},
            'semantics': 'Native historical attempts only. RSS maximum is the maximum process peak; RSS mean averages process peaks. RSS totals are sums of observations, never process peaks. Nested timing fields overlap and must not be added across fields.'}


def summarize_existing():
    audit_path = ROOT/'benchmark/results/storage-migration-audit.json'
    audit = load(audit_path)
    accounted = 0
    for group in audit['groups']:
        path = ROOT/f'benchmark/results/{group}/evidence/attempts.json'
        data = load(path)
        for record in data.get('native_regression_attempts', []):
            if 'executions' not in record:continue
            rows = record.pop('executions')
            assert digest(encoded(rows)) == record['measurements_sha256']
            record['cost_summary'] = summarize_cost_records(rows)
            record['accounted_executions'] = len(rows)
            accounted += len(rows)
        save(path, data)
        name = path.relative_to(ROOT).as_posix()
        audit['retained_json_hashes'][name] = digest(path.read_bytes())
        audit['numeric_and_verdict_invariants'][name] = digest(encoded(decision_cost_facts(data)))
    audit['historical_regression_compaction']['accounted_executions'] = accounted
    audit['historical_regression_compaction']['retained_per_execution_cost_records'] = 0
    audit['historical_regression_compaction']['cost_retention'] = 'Verified original record digests, then retained per-batch/mode exact totals, observation counts, means and maxima/minima; raw per-execution historical rows discarded.'
    save(audit_path, audit)
    print(json.dumps({'historical_executions_accounted': accounted, 'retention': 'cost summaries only'}))


def main():
    audit_path = ROOT / 'benchmark/results/storage-migration-audit.json'
    audit = load(audit_path)
    selected = set(audit['groups'])
    registry_path = ROOT / 'benchmark/results/regression-history.json'
    assert not registry_path.exists(), 'History already compacted; run compact_published_groups.py --audit'
    history = []
    additions = collections.defaultdict(list)
    remove = set()
    aliases = {}
    total_bytes = 0
    preserved = set(audit['retained_json_hashes']) | set(audit['proof_files'])
    for report in sorted((ROOT / 'benchmark/results/spatial-smt-regressions').glob('*/results.json')):
        data = load(report)
        runs = data.get('runs', [])
        if not runs:
            continue
        def group(row):
            if row.get('group'):
                return row['group']
            src = row.get('source', {}).get('path', '')
            if src.startswith('benchmark/programs/'):
                return src.split('/')[2]
            return None
        covered = {group(r) for r in runs}
        if None in covered or not covered <= selected:
            continue
        origin = report.relative_to(ROOT).as_posix()
        report_hash = digest(report.read_bytes())
        item = {'id': report.parent.name, 'original_report': origin,
                'original_report_sha256': report_hash, 'summary': data.get('summary'),
                'original_metadata_sha256': {p.name: digest(p.read_bytes()) for p in report.parent.iterdir() if p.is_file()},
                'group_cost_receipts': {g: f'benchmark/results/{g}/evidence/attempts.json' for g in sorted(covered)}}
        history.append(item)
        for g in sorted(covered):
            records = []
            for row in runs:
                if group(row) != g:
                    continue
                m = row.get('measurement', row)
                current = row.get('current', {})
                record = {'variant': row.get('variant'), 'case': row.get('case'),
                    'mode': row.get('mode'), 'execution_strategy': row.get('execution_strategy'),
                    'raw_status': row.get('status', current.get('status')),
                    'measurement': {k: m[k] for k in ('wall_seconds', 'resources', 'max_process_rss_kib', 'tokens', 'model_calls', 'exit_code') if k in m},
                    'stage_measurements': row.get('stage_measurements')}
                records.append(record)
            additions[g].append({'id': report.parent.name, 'original_report_sha256': report_hash,
                'scope': 'Historical native execution costs; overlaps active measurements where reused; never add blindly to the active cost table.',
                'source_input_identity_sha256': digest(encoded([
                    [r.get('variant'), r.get('case'), r.get('source'), r.get('binds')] for r in runs if group(r) == g])),
                'representative_command': next((r.get('measurement', {}).get('command') for r in runs if group(r) == g), None),
                'measurements_sha256': digest(encoded(records)), 'executions': records})
        # Only direct run metadata/snapshots; formal proof files and shared
        # receipts remain protected by the migration's dependency inventory.
        for p in report.parent.iterdir():
            if p.is_file() and p.relative_to(ROOT).as_posix() not in preserved:
                remove.add(p)
                aliases[p.relative_to(ROOT).as_posix()] = registry_path.relative_to(ROOT).as_posix()
    for g, records in additions.items():
        path = ROOT / f'benchmark/results/{g}/evidence/attempts.json'
        original = load(path)
        before = decision_cost_facts(original)
        original['native_regression_attempts'] = records
        assert decision_cost_facts({k: v for k, v in original.items() if k != 'native_regression_attempts'}) == before
        for record in records:
            assert digest(encoded(record['executions'])) == record['measurements_sha256']
        save(path, original)
    # Registry is one global history index; it carries no repeated VC traces.
    save(registry_path, {'schema': 'tespec-compact-regression-history/v1', 'runs': history})

    def rewrite(x, key=''):
        if isinstance(x, list):
            return x if key in ('command', 'representative_command') else [rewrite(v, key) for v in x]
        if not isinstance(x, dict):
            return aliases.get(x, x) if isinstance(x, str) and key not in ('origin', 'original_report') else x
        return {k: rewrite(v, k) for k, v in x.items()}
    # Update current machine-readable indexes; old measured argv stays exact.
    targets = set(audit['retained_json_hashes'])
    targets.update(str(p.relative_to(ROOT)) for p in (ROOT / 'benchmark/results').glob('*.json'))
    targets.discard('benchmark/results/storage-migration-audit.json')
    targets.discard('benchmark/results/regression-history.json')
    for name in sorted(targets):
        path = ROOT / name
        obj = load(path)
        revised = rewrite(obj)
        if revised != obj:
            assert decision_cost_facts(revised) == decision_cost_facts(obj), name
            save(path, revised)
    # Direct path+SHA bindings must track the new summary, not a removed file.
    def refresh(x):
        if isinstance(x, list):return [refresh(v) for v in x]
        if not isinstance(x, dict):return x
        y = {k: refresh(v) for k, v in x.items()}
        for k, v in list(y.items()):
            if isinstance(v, str) and v.startswith('benchmark/') and (ROOT/v).is_file():
                if k == 'path' and 'sha256' in y:y['sha256'] = digest((ROOT/v).read_bytes())
                if k+'_sha256' in y:y[k+'_sha256'] = digest((ROOT/v).read_bytes())
        return y
    for _ in range(12):
        changed = 0
        for name in sorted(targets):
            path = ROOT/name; obj = load(path); revised = refresh(obj)
            if revised != obj:save(path, revised); changed += 1
        if not changed:break
    else:raise AssertionError('Cyclic receipt hashes')
    for p in sorted(remove):
        assert p.resolve().is_relative_to(ROOT/'benchmark/results/spatial-smt-regressions')
        total_bytes += p.stat().st_size
        p.unlink()
    # Human links to retired whole-run dumps now lead to the single history registry.
    for p in list((ROOT/'docs').glob('*.md')) + list((ROOT/'benchmark/results').glob('*.md')):
        old = p.read_text(); new = old
        for src, dst in aliases.items():new = new.replace(src, dst)
        if old != new:p.write_text(new)
    for name in targets:
        audit['retained_json_hashes'][name] = digest((ROOT/name).read_bytes())
        if name in audit['numeric_and_verdict_invariants']:
            new_facts = decision_cost_facts(load(ROOT/name))
            old_hash = audit['numeric_and_verdict_invariants'][name]
            if name.endswith('/evidence/attempts.json'):
                old_obj = load(ROOT/name); old_obj.pop('native_regression_attempts', None)
                assert digest(encoded(decision_cost_facts(old_obj))) == old_hash, name
                audit['numeric_and_verdict_invariants'][name] = digest(encoded(new_facts))
            else:assert digest(encoded(new_facts)) == old_hash, name
    audit['retained_json_hashes']['benchmark/results/regression-history.json'] = digest(registry_path.read_bytes())
    audit['historical_regression_compaction'] = {'batches': len(history), 'deleted_files': len(remove),
        'deleted_bytes': total_bytes, 'retained_per_execution_cost_records': sum(len(batch['executions']) for batches in additions.values() for batch in batches),
        'registry': 'benchmark/results/regression-history.json',
        'metrics_integrity': 'Exact per-execution wall/RSS/token/model-call/exit and nested-stage values retained; record digests verified before deleting whole-run dumps.'}
    save(audit_path, audit)
    print(json.dumps(audit['historical_regression_compaction'], indent=2))


if __name__ == '__main__':
    if '--summarize' in sys.argv:summarize_existing()
    else:main()
