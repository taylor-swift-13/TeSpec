#!/usr/bin/env python3
"""Materialize grouped benchmark inputs without rewriting archived evidence."""
from pathlib import Path
import argparse, collections, hashlib, json, re, shutil

ROOT = Path(__file__).resolve().parents[2]
ARCHIVE = ROOT / 'arxiv/benchmark-support/selection'
GROUPS = ROOT / 'benchmark/programs'
REGISTRY = ARCHIVE / 'paired-mutations/grouping/existing-variants-and-results.json'
PREFIXES = {
    'third_party/fulminate-cn/': 'arxiv/fulminate-cn/',
    'benchmark-support/': 'arxiv/benchmark-support/',
    'benchmark/selection/sources/fulminate-cn/': 'arxiv/fulminate-cn/',
    'benchmark/selection/': 'arxiv/benchmark-support/selection/',
}

def relocated(path):
    for old, new in PREFIXES.items():
        if path.startswith(old):
            return new + path[len(old):]
    return path

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def save(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')

def load():
    return json.loads(REGISTRY.read_text())

def pointer_value(data, pointer):
    for part in pointer.split('/')[1:]:
        part = part.replace('~1', '/').replace('~0', '~')
        data = data[int(part)] if isinstance(data, list) else data[part]
    return data

def build():
    data = load()
    artifacts = {a['id']: a for a in data['artifacts']}
    variants = {v['id']: v for v in data['variants']}
    inputs = {v['id']: v for v in data['input_sets']}
    results = {v['id']: v for v in data['results']}
    index = []
    for family in data['families']:
        group = GROUPS / family['family']
        entries = []
        for vid in family['variant_ids']:
            v = variants[vid]
            slug = re.sub(r'[^A-Za-z0-9_.-]', '_', vid)
            folder = group / 'variants' / slug
            entry = dict(v)
            entry['files'] = {}
            for lang, ref in v['files'].items():
                a = artifacts[ref['artifact']]
                source = ROOT / relocated(a['path'])
                target = folder / lang / source.name
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(source, target)
                assert digest(target) == ref['sha256']
                entry['files'][lang] = {
                    'path': target.relative_to(ROOT).as_posix(),
                    'sha256': ref['sha256'],
                    'provenance_path': relocated(a['path']),
                    'include_dirs': [source.parent.relative_to(ROOT).as_posix()],
                    'scope': 'Byte-identical benchmark input; dependencies and archived proof context remain recorded separately.',
                }
            save(folder / 'manifest.json', entry)
            # Input sets retain individual JSON pointers and execution status. A set
            # may contain multiple cases; an original main is not assumed executed.
            test_entries = []
            for key in v['input_set_ids']:
                row = dict(inputs[key])
                if row.get('locator_kind') != 'embedded_c_function':
                    report = ROOT / relocated(artifacts[row['report']]['path'])
                    extracted = pointer_value(json.loads(report.read_text()), row['record_pointer'])
                    testcase = folder / 'tests/cases' / (key + '.json')
                    save(testcase, extracted)
                    row['materialized_input_record'] = testcase.relative_to(ROOT).as_posix()
                test_entries.append(row)
            save(folder / 'tests/inputs.json', test_entries)
            save(folder / 'tests/results.json', [results[k] for k in v['result_ids']])
            entries.append({'id': vid, 'manifest': (folder / 'manifest.json').relative_to(ROOT).as_posix()})
        existing_manifest = group / 'manifest.json'
        previous = json.loads(existing_manifest.read_text()) if existing_manifest.is_file() else {}
        manifest = {
            'schema': 'tespec-grouped-benchmark/v1', 'program_group': family['family'],
            'primary_variant': previous.get('primary_variant'),
            'primary_selection_status': previous.get('primary_selection_status', 'PENDING_EXPLICIT_BINDING_TO_REUSABLE_VERIFICATION'),
            'verification_policy': 'Only designated primary requires CN/QCP formal verification; reuse matching archived proofs. Other variants require testing only.',
            'variants': entries,
            'evidence_catalog': 'benchmark/programs/evidence.json',
            'archive_registry': REGISTRY.relative_to(ROOT).as_posix(),
        }
        save(group / 'manifest.json', manifest)
        index.append({'program_group': family['family'], 'manifest': (group / 'manifest.json').relative_to(ROOT).as_posix(), 'variant_records': len(entries)})
    # Only path locators change. Evidence bytes, source hashes, raw statuses and
    # proof receipts are preserved. Archived path strings resolve via this map.
    evidence = dict(data)
    evidence['artifacts'] = [dict(a, archived_path=a['path'], path=relocated(a['path'])) for a in data['artifacts']]
    save(GROUPS / 'evidence.json', evidence)
    save(GROUPS / 'index.json', {'schema': 'tespec-program-groups/v1', 'groups': index, 'source_snapshot': 'arxiv/fulminate-cn', 'path_map': PREFIXES, 'policy': data['policy']})
    save(ROOT / 'arxiv/benchmark-support/path-map.json', PREFIXES)
    validate()

def validate():
    original = load()
    current = json.loads((GROUPS / 'evidence.json').read_text())
    assert len(original['families']) == 45
    original_variants = {v['id']: v for v in original['variants']}
    original_inputs = {v['id']: v for v in original['input_sets']}
    original_results = {v['id']: v for v in original['results']}
    original_artifacts = {v['id']: v for v in original['artifacts']}
    for key in ['variants', 'input_sets', 'results', 'summary', 'historical_unmatched_result_ids']:
        assert current[key] == original[key], key
    for a in current['artifacts']:
        assert digest(ROOT / a['path']) == a['sha256'], a['path']
    count = 0
    for f in original['families']:
        group = GROUPS / f['family']
        manifest = json.loads((group / 'manifest.json').read_text())
        assert {v['id'] for v in manifest['variants']} == set(f['variant_ids'])
        for entry in manifest['variants']:
            path = ROOT / entry['manifest']
            v = json.loads(path.read_text())
            assert {k: x for k, x in v.items() if k != 'files'} == {k: x for k, x in original_variants[v['id']].items() if k != 'files'}
            for ref in v['files'].values():
                assert digest(ROOT / ref['path']) == ref['sha256']
                assert digest(ROOT / ref['provenance_path']) == ref['sha256']
            assert (path.parent / 'tests/inputs.json').is_file()
            tests = json.loads((path.parent / 'tests/inputs.json').read_text())
            assert [row['id'] for row in tests] == v['input_set_ids']
            for row in tests:
                assert {k: x for k, x in row.items() if k != 'materialized_input_record'} == original_inputs[row['id']]
                if 'materialized_input_record' in row:
                    report = ROOT / relocated(original_artifacts[row['report']]['path'])
                    assert json.loads((ROOT / row['materialized_input_record']).read_text()) == pointer_value(json.loads(report.read_text()), row['record_pointer'])
            assert json.loads((path.parent / 'tests/results.json').read_text()) == [original_results[k] for k in v['result_ids']]
            count += 1
    # Audit all archived JSON pointers, including historical UNKNOWN results.
    artifacts = {a['id']: a for a in current['artifacts']}
    parsed = {}
    for row in current['results'] + current['input_sets']:
        if row.get('locator_kind') == 'embedded_c_function':
            continue
        aid = row['report']
        if aid not in parsed:
            parsed[aid] = json.loads((ROOT / artifacts[aid]['path']).read_text())
        value = parsed[aid]
        for part in row['record_pointer'].split('/')[1:]:
            part = part.replace('~1', '/').replace('~0', '~')
            value = value[int(part)] if isinstance(value, list) else value[part]
    assert not (ROOT / 'benchmark/selection').exists()
    assert not (ROOT / 'benchmark/sources').exists()
    assert len(list((ROOT / 'arxiv/fulminate-cn/src/examples').rglob('*.c'))) == 76
    print(f'PASS: 45 groups, {count} group-local variant entries; 76 originals outside benchmark; {len(current["artifacts"])} evidence hashes and all archived result/input pointers preserved.')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    validate() if args.check else build()
