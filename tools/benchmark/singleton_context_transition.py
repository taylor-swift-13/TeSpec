#!/usr/bin/env python3
"""Read-only singleton proof-context transition plan. No --apply or tool runs.

Default prints a compact plan. --documents prints the proposed JSON documents
and byte-preserving receipt-copy operations for review; it still writes nothing.
"""
from __future__ import annotations
import argparse
from collections import Counter
import copy
import hashlib
import json
from pathlib import Path
import statistics
import sys
sys.dont_write_bytecode = True
ROOT = Path('/home/yangfp/teSpec')
sys.path.insert(0, str(ROOT / 'tools/benchmark'))
from validate_canonical_group import audit_itp

GROUP = 'Dbl_Linked_List__singleton'
BASE = ROOT / 'benchmark/results' / GROUP
NATIVE = BASE / 'evidence/tespec-native.json'
PROGRESS = BASE / 'evidence/itp/progress.json'
LEGACY = BASE / 'evidence/itp/legacy-context'
ACTIVE = BASE / 'evidence/itp/abi-context'
TRANSITION = BASE / 'evidence/itp/context-transition.json'
REVIEW = ROOT / 'benchmark/results/tespec-unexpected/singleton-external-layout.json'
NEW_NATIVE_SHA = 'c84e5cb331f24d71eb8aaf082c77b20c55fd1fa990028cd67cc9f0eee9326d22'
LAYOUT_DIR = ROOT / 'benchmark/programs' / GROUP / 'variants/qcp_existing_8f229e47d6649f2a2eb8/dependencies/coq'


def need(condition, reason):
    if not condition:
        raise ValueError(reason)


def load(path):
    return json.loads(path.read_text())


def encoded(value):
    return (json.dumps(value, ensure_ascii=False, separators=(',', ':')) + '\n').encode()


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def obj_sha(value):
    return hashlib.sha256(json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def rel(path):
    return str(path.resolve().relative_to(ROOT))


def ref(path):
    return {'path': rel(path), 'sha256': sha(path)}


CHECKED = {}
def checked(path, expected):
    path = path.resolve()
    if path not in CHECKED:
        CHECKED[path] = sha(path)
    need(CHECKED[path] == expected, 'Missing/changed source: ' + str(path))
    return path


def execution_key(row):
    return obj_sha({k: row[k] for k in ('case', 'variant', 'strategy', 'spatial_smt', 'input', 'source_sha256')})


def rewrite(value, replacements):
    if isinstance(value, dict):
        if value.get('path') in replacements:
            return {**{k: rewrite(v, replacements) for k, v in value.items()}, **replacements[value['path']]}
        return {k: rewrite(v, replacements) for k, v in value.items()}
    if isinstance(value, list):
        return [rewrite(v, replacements) for v in value]
    if isinstance(value, str) and value in replacements:
        return replacements[value]['path']
    return value


class Plan:
    def __init__(self):
        self.writes = []

    def document(self, path, value):
        data = encoded(value)
        result = {'path': rel(path), 'sha256': hashlib.sha256(data).hexdigest()}
        self.writes.append({**result, 'bytes': len(data), 'action': 'replace-json' if path.exists() else 'create-json',
                            'expected_previous_sha256': sha(path) if path.exists() else None, 'document': value})
        return result

    def preserve(self, source, target):
        need(not target.exists() or source.read_bytes() == target.read_bytes(), 'Legacy destination differs')
        result = {'path': rel(target), 'sha256': sha(source)}
        self.writes.append({**result, 'action': 'preserve-receipt-bytes', 'copy_from': rel(source),
                            'bytes': source.stat().st_size, 'expected_previous_sha256': sha(target) if target.exists() else None})
        return result


def context_of(native, name, dependencies, scope):
    layouts, runtime_sets = {}, {}
    for row in native['runs']:
        for item in row['vc_files'].values():
            checked(Path(item['path']), item['sha256'])
        checked(Path(row['report']), row['report_sha256'])
        manifest = load(Path(row['vc_files']['goal']['path']).parent / 'manifest.json')
        target = manifest['target_layout']
        layouts[obj_sha(target)] = target
        runtime = []
        for item in manifest.get('runtime_dependencies', []):
            checked(Path(item['source']), item['sha256'])
            checked(Path(item['compiled']), item['compiled_sha256'])
            runtime.append({k: item[k] for k in ('module', 'sha256', 'compiled_sha256')})
        runtime.sort(key=lambda item: item['module'])
        runtime_sets[obj_sha(runtime)] = runtime
        staged = manifest.get('coq_dependencies', [])
        if name == 'computational-abi':
            need({(i['module'], i['sha256']) for i in staged} ==
                 {(i['module'], i['sha256']) for i in dependencies}, 'Native dependencies differ across rows')
            for item in staged:
                checked(Path(item['source']), item['sha256'])
                checked(Path(item['staged']), item['sha256'])
    need(len(layouts) == len(runtime_sets) == 1, 'Rows do not share one proof context')
    descriptor = {'name': name, 'external_modules': sorted(dependencies, key=lambda item: item['module']),
                  'target_layout': next(iter(layouts.values())), 'runtime_dependencies': next(iter(runtime_sets.values())),
                  'required_proof_scope': scope,
                  'legacy_equivalence_certified': False}
    return {**descriptor, 'proof_context_sha256': obj_sha(descriptor)}


def native_stage(row):
    need(row['wall_seconds'] >= 0 and row['resources']['max_process_rss_kib'] > 0, 'Missing native cost')
    need(row['tokens'] == row['model_calls'] == 0, 'Native run unexpectedly called a model')
    return {'wall_seconds': row['wall_seconds'], 'peak_process_rss_kib': row['resources']['max_process_rss_kib'],
            'tokens': 0, 'model_calls': 0, 'command_sha256': obj_sha(row['command']), 'report_sha256': row['report_sha256']}


def measured_context_preparation(active_context):
    receipt_path = Path('/tmp/tespec-singleton-layout-g86wp0im/receipt.json')
    resources_path = Path('/tmp/tespec-singleton-layout-preparation.resources')
    script_path = Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/prepare-singleton-layout-context.py')
    receipt = load(receipt_path)
    resource_text = resources_path.read_text()
    need(resource_text == '0.45 17244\n', 'Original measured context preparation resource record changed')
    wall, rss = resource_text.split()
    need(receipt['tokens'] == receipt['model_calls'] == 0, 'Unexpected model cost in context preparation')
    need(receipt['target_layout'] == active_context['target_layout'], 'Prepared target layout differs')
    need(receipt['program_spec_and_expectations_changed'] is False, 'Preparation changed benchmark semantics text')
    return {'stage': 'context_preparation', 'unit': 'once per group; excluded from per-execution ITP means',
        'wall_seconds': float(wall), 'peak_process_rss_kib': int(rss), 'tokens': 0, 'model_calls': 0,
        'measurement': 'Full GNU time process wall seconds and maximum process RSS, not internal Python timer',
        'raw_receipt_sha256': sha(receipt_path), 'raw_resources_sha256': sha(resources_path),
        'raw_resources_text': resource_text, 'preparation_script_sha256': sha(script_path),
        'command': ['/usr/bin/time', '-f', '%e %M', '-o', str(resources_path), 'python3', str(script_path)],
        'command_provenance': 'Exact WSL argv confirmed by the executing controller; no extra flags',
        'source_manifest_sha256': receipt['source_manifest_sha256'],
        'internal_python_wall_seconds_diagnostic_only': receipt['wall_seconds'],
        'prepared_modules': active_context['external_modules'],
        'preparation_manifest': active_context['layout_library_preparation'],
        'scope': 'Generate/select computational LayoutAddress, GeneratedLayout and reinterpreted DLLSupplement; source/spec/input/expected text unchanged, no legacy equivalence certificate.'}


def prepare(old_raw_path, new_raw_path):
    CHECKED.clear()
    plan = Plan()
    old, progress, review = load(NATIVE), load(PROGRESS), load(REVIEW)
    need(review.get('status') == 'OPEN', 'This transition must retain the existing OPEN semantic review')
    need(progress.get('running_checks') == [], 'Published legacy progress still lists a running check')
    need(progress['native_results_sha256'] == review['native_results_sha256'], 'Legacy context/review mismatch')
    checked(old_raw_path, progress['native_results_sha256'])
    checked(new_raw_path, NEW_NATIVE_SHA)
    old_raw, new = load(old_raw_path), load(new_raw_path)
    for snapshot in (old, old_raw, new):
        need(len(snapshot['runs']) == 28, 'Wrong native execution count')
        need(len({execution_key(r) for r in snapshot['runs']}) == 28, 'Duplicate execution identity')
    old_rows = {execution_key(r): (i, r) for i, r in enumerate(old['runs'])}
    old_raw_rows = {execution_key(r): (i, r) for i, r in enumerate(old_raw['runs'])}
    new_rows = {execution_key(r): (i, r) for i, r in enumerate(new['runs'])}
    need(old_rows.keys() == old_raw_rows.keys() == new_rows.keys(), 'Program/input execution set changed')
    need(Counter(r['raw_status'] for r in new['runs']) == {'PASS': 14, 'UNKNOWN': 14}, 'New native outcomes changed')
    for path, digest in old['input_identity'].items():
        need(new['input_identity'].get(path) == digest, 'Original program/spec/input/tool changed: ' + path)
        checked(ROOT / path, digest)
    for path, digest in new['input_identity'].items():
        checked(ROOT / path, digest)
    for key, (_, row) in new_rows.items():
        prior = old_raw_rows[key][1]
        need(all(row[k] == prior[k] for k in ('expected', 'raw_status', 'residual_vcs', 'precondition_result', 'execution_completed')),
             'Expectation or native execution eligibility changed')
        need(row['precondition_result'] == 'SAT' and row['execution_completed'] is True, 'Illegal/incomplete execution')
    replacements, receipts = {}, {}
    for entry in progress['executions']:
        if not entry.get('proof_complete'):
            need(not entry.get('models') and not entry.get('checks'), 'Unarchived legacy attempts require explicit handling')
            continue
        reference = entry['receipt']
        source = checked(ROOT / reference['path'], reference['sha256'])
        row = old['runs'][entry['native_row_index']]
        audit_itp(ROOT, reference, row, allow_partial=True)
        receipt = load(source)
        need(receipt['status'] == 'PASS', 'Parent receipt status changed')
        target = LEGACY / source.name
        replacements[reference['path']] = plan.preserve(source, target)
        receipts[execution_key(row)] = (receipt, replacements[reference['path']])
    need(len(receipts) == 2, 'Expected two legacy parent receipts')
    model_receipts = [m for receipt, _ in receipts.values() for m in receipt['model_attempts']]
    checks = [c for receipt, _ in receipts.values() for c in receipt['checks']]
    need(len(model_receipts) == len({m['source_receipt_sha256'] for m in model_receipts}) == 4, 'Model calls missing/double counted')
    need(len(checks) == len({c['controller_receipt_sha256'] for c in checks}) == 6, 'Checks missing/double counted')
    tokens = sum(u['input_tokens'] + u['output_tokens'] for m in model_receipts for u in m['token_usage'])
    need(tokens == progress['tokens'] == 416106, 'Legacy token accounting changed')
    legacy_deps = next(iter(receipts.values()))[0]['dependencies']
    need(all(r['dependencies'] == legacy_deps for r, _ in receipts.values()), 'Legacy proof dependencies differ')
    legacy_context = context_of(old_raw, 'legacy-opaque-address', legacy_deps, 'exported-parent-disjunction-only')
    layout_prep = load(LAYOUT_DIR / 'layout-libraries.json')
    dependencies = []
    for name in ('LayoutAddress', 'GeneratedLayout', 'DLLSupplement'):
        path = LAYOUT_DIR / (name + '.v')
        checked(path, layout_prep['files'][path.name])
        dependencies.append({**ref(path), 'module': name})
    active_context = context_of(new, 'computational-abi', dependencies, 'strong-left-original-spatial-entailment')
    need(legacy_context['proof_context_sha256'] != active_context['proof_context_sha256'], 'Contexts were collapsed')
    active_context['layout_library_preparation'] = ref(LAYOUT_DIR / 'layout-libraries.json')
    active_context['target_layout_file'] = ref(LAYOUT_DIR / 'target-layout.json')
    active_context['proof_context_sha256'] = obj_sha({k: v for k, v in active_context.items() if k != 'proof_context_sha256'})
    shared_setup = measured_context_preparation(active_context)

    # Only storage pointers in the OPEN issue move; proof claims and status do not.
    review_replacements = {**replacements,
        rel(NATIVE): {'path': rel(LEGACY / 'native.json')}, rel(PROGRESS): {'path': rel(LEGACY / 'progress.json')}}
    frozen_review = rewrite(review, review_replacements)
    need(frozen_review['status'] == 'OPEN' and frozen_review['proof_scope'] == review['proof_scope'], 'Review semantics changed')
    review_ref = plan.document(LEGACY / 'semantic-review.json', frozen_review)
    active_review = copy.deepcopy(frozen_review)
    active_review['legacy_review_snapshot'] = review_ref
    plan.document(REVIEW, active_review)
    replacements[rel(REVIEW)] = review_ref
    legacy_progress = rewrite(progress, replacements)
    legacy_progress.update(archive_role='context-repair-history', included_in_final_execution_cost=True,
        context=legacy_context, original_published_sha256=sha(PROGRESS),
        verdict_reuse_authorized=False, semantic_scope='Parent-only proof receipts remain PASS; original DLL entailment was not certified.')
    legacy_progress_ref = plan.document(LEGACY / 'progress.json', legacy_progress)
    replacements[rel(PROGRESS)] = legacy_progress_ref
    legacy_native = rewrite(old, replacements)
    legacy_native.update(archive_role='context-repair-history', included_in_final_execution_cost=True,
        context=legacy_context, original_published_sha256=sha(NATIVE), original_native_results_sha256=sha(old_raw_path))
    legacy_native_ref = plan.document(LEGACY / 'native.json', legacy_native)

    mappings, active_tasks = [], []
    for i, row in enumerate(new['runs']):
        key = execution_key(row)
        old_i, historical = old_raw_rows[key]
        receipt, receipt_ref = receipts.get(key, (None, None))
        task_index = len(active_tasks) if row['strategy'] == 'inline' else None
        entry = {'execution_key': key, 'case': row['case'], 'strategy': row['strategy'], 'spatial_smt': row['spatial_smt'],
            'source_sha256': row['source_sha256'], 'input_sha256': obj_sha(row['input']),
            'legacy_native_row_index': old_i, 'active_native_row_index': i,
            'legacy_native_stage': native_stage(historical), 'active_native_stage': native_stage(row),
            'legacy_itp_receipt': receipt_ref, 'legacy_itp_metrics': receipt['metrics'] if receipt else None,
            'legacy_itp_included_in_final_cost': True,
            'active_itp_execution_index': task_index,
            'active_itp_receipt_path': rel(ACTIVE / f'execution-{task_index:02d}.json') if task_index is not None else None}
        mappings.append(entry)
        if task_index is not None:
            goal_sha = row['vc_files']['goal']['sha256']
            active_tasks.append({'execution_index': task_index, 'native_row_index': i, 'execution_key': key,
                'case': row['case'], 'spatial_smt': row['spatial_smt'], 'status': 'NOT_RUN',
                'benchmark_final_status': 'UNKNOWN', 'selected_goals': row['residual_vcs'],
                'original_goal_sha256': goal_sha, 'proof_context_sha256': active_context['proof_context_sha256'],
                'proof_reuse_key': obj_sha({'execution_key': key, 'original_goal_sha256': goal_sha,
                    'proof_context_sha256': active_context['proof_context_sha256']}),
                'future_receipt_path': entry['active_itp_receipt_path'], 'legacy_itp_receipt': receipt_ref})
    need(len(active_tasks) == 14, 'New ITP inventory differs')
    native_cost = sum(m['legacy_native_stage']['wall_seconds'] + m['active_native_stage']['wall_seconds'] for m in mappings)
    itp_seconds = sum(r['metrics']['total']['wall_seconds'] for r, _ in receipts.values())
    missing = [item for r, _ in receipts.values() for item in r['missing_measurements']]
    transition = {'schema': 'tespec-proof-context-transition/v1', 'group': GROUP, 'status': 'PREPARED_NOT_PROVED',
        'legacy_context': legacy_context, 'active_context': active_context,
        'legacy_native': legacy_native_ref, 'legacy_itp_progress': legacy_progress_ref, 'semantic_review': review_ref,
        'legacy_native_results_sha256': sha(old_raw_path), 'active_native_results_sha256': sha(new_raw_path),
        'active_receipt_namespace': rel(ACTIVE), 'shared_object_namespace': rel(BASE / 'evidence/itp/objects'),
        'group_shared_setup': {'context_preparation': shared_setup},
        'per_execution_cost_mapping': mappings,
        'measured_totals_to_date': {'native_wall_seconds': native_cost, 'itp_wall_seconds': itp_seconds,
            'group_shared_setup_wall_seconds': shared_setup['wall_seconds'],
            'total_tespec_measured_work_wall_seconds': native_cost + itp_seconds + shared_setup['wall_seconds'],
            'model_calls': 4, 'tokens': tokens, 'check_attempts': 6, 'missing_measurements': missing,
            'resource_metrics_complete': False},
        'cost_policy': 'All context-repair native runs, model calls, failures and parent-only checks are included exactly once in each corresponding final execution cost. Add new independent ABI-context attempts; do not exclude historical attempts or add the aggregate total again.',
        'memory_policy': 'Take per-execution stage maxima across contexts; any missing historical RSS keeps that stage/final peak incomplete. No estimates.',
        'proof_policy': 'Equal Goal text is insufficient. Bind source/input, original Goal, selected target scope, target layout, external definitions and pinned runtime dependencies. Legacy parent PASS never authorizes new strong-left success.',
        'historical_qcp_scope': 'Existing universal QCP certificate remains bound to legacy abstract-address predicates; it is not a certificate for the ABI-reinterpreted predicate.'}
    transition_ref = plan.document(TRANSITION, transition)
    active_progress = {'schema': 'tespec-singleton-context-itp-progress/v1', 'group': GROUP,
        'context': active_context, 'context_transition': transition_ref, 'native_results_sha256': sha(new_raw_path),
        'required_itp_executions': 14, 'original_entailment_completed_executions': 0, 'pending_executions': 14,
        'active_context_model_calls': 0, 'active_context_tokens': 0, 'active_context_check_attempts': 0,
        'active_context_stage_measurements': None, 'complete': False, 'verdict_complete': False,
        'resource_metrics_complete': False, 'semantic_review': review_ref, 'executions': active_tasks,
        'scope': 'Only the active ABI context. No new model/Coq run has yet been measured. Zero calls records absence of calls, not completed proof cost. Historical costs are included through context_transition.'}
    active_progress_ref = plan.document(ACTIVE / 'progress.json', active_progress)
    compact = copy.deepcopy(new)
    compact.update(program_group=GROUP, context=active_context, context_transition=transition_ref,
        original_native_results_sha256=sha(new_raw_path), evaluation_complete=False, verdict_complete=False,
        resource_metrics_complete=False, native_resource_metrics_complete=True,
        historical_context_repair_evidence=legacy_native_ref,
        itp={'status': 'PENDING_STRONG_LEFT', 'progress': active_progress_ref, 'executions': 14,
             'completed_executions': 0, 'semantic_review': review_ref,
             'cost_policy': 'Add all matching legacy context attempts before computing final per-execution costs.'})
    for row in compact['runs']:
        row['vc_sha256'] = {name: item['sha256'] for name, item in row.pop('vc_files').items()}
        row.pop('report')
        row['matches_expected'] = row['final_status'] == row['expected']
    compact['modes'] = []
    for strategy in ('inline', 'modular'):
        for mode in ('off', 'on'):
            rows = [r for r in compact['runs'] if r['strategy'] == strategy and r['spatial_smt'] == mode]
            compact['modes'].append({'strategy': strategy, 'spatial_smt': mode, 'executions': len(rows),
                'raw_status_counts': dict(Counter(r['raw_status'] for r in rows)),
                'wall_seconds_total': sum(r['wall_seconds'] for r in rows),
                'wall_seconds_mean': statistics.mean(r['wall_seconds'] for r in rows),
                'peak_process_rss_kib_mean': statistics.mean(r['resources']['max_process_rss_kib'] for r in rows),
                'peak_process_rss_kib_max': max(r['resources']['max_process_rss_kib'] for r in rows)})
    active_native_ref = plan.document(NATIVE, compact)
    obsolete = [{'path': rel(PROGRESS), 'sha256': sha(PROGRESS), 'replaced_by': legacy_progress_ref}]
    obsolete += [{'path': source, 'sha256': target['sha256'], 'replaced_by': target}
                 for source, target in replacements.items() if source.startswith(rel(BASE / 'evidence/itp/execution-'))]
    return {'schema': 'tespec-singleton-transition-publication-plan/v1', 'read_only': True, 'apply_supported': False,
        'complete_groups': 22, 'complete_group_case_pairs': 901, 'review_status': 'OPEN',
        'active_native': active_native_ref, 'active_progress': active_progress_ref, 'transition': transition_ref,
        'proposed_writes': plan.writes, 'shared_objects_copied': 0,
        'conditional_removals_after_reference_audit': obsolete,
        'active_index_updates_required': ['group index.json/latest_native_recheck/per_tool_evidence',
            'tespec results/statistics and result-cost md/json/csv, preserving legacy cost inclusion',
            'group coverage-gap and global current-group/tespec-unexpected pointers',
            'docs current summary and all stale current progress links'],
        'publication_gate': 'This is an artifact-level read-only plan, not an atomic publisher. Rewrite active indices/cost views, validate every new reference and exact historical-cost inclusion, then remove superseded root progress/receipts. Never delete shared objects or close OPEN review as part of this transition.',
        'cost_summary': transition['measured_totals_to_date'],
        'same_goal_text_executions': sum(old_raw_rows[k][1]['vc_files']['goal']['sha256'] == row['vc_files']['goal']['sha256']
                                         for k, (_, row) in new_rows.items())}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--legacy-native-results', type=Path, default=Path('/tmp/tespec-singleton-current-irrfnr7y/results.json'))
    parser.add_argument('--new-native-results', type=Path, default=Path('/tmp/tespec-singleton-layout-native-24wkmdxt/results.json'))
    parser.add_argument('--documents', action='store_true', help='Print proposed content; never writes files')
    args = parser.parse_args()
    result = prepare(args.legacy_native_results, args.new_native_results)
    if not args.documents:
        result['proposed_writes'] = [{k: v for k, v in item.items() if k != 'document'} for item in result['proposed_writes']]
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
