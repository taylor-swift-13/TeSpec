#!/usr/bin/env python3
"""Publish measured singleton ABI-context progress, retaining all repair costs.
Default is read-only; --apply stages a checked transaction with rollback.
Never runs models, Coq, native tests or changes expected results.
"""
from __future__ import annotations
import argparse
import copy
import fcntl
import hashlib
import json
import os
from pathlib import Path
import statistics
import tempfile
import re
from collections import Counter
import singleton_context_transition as transition
from singleton_context_transition import ROOT, GROUP, BASE, NATIVE, PROGRESS, LEGACY, ACTIVE, TRANSITION, REVIEW, encoded, load, need, sha, rel, obj_sha
from publish_singleton_completed import usage_events, require_hash, stage_totals, csv_bytes, COST_FIELDS, build_execution, audit_prepared_execution
from singleton_canonical_support import canonical_sha
from publish_singleton_itp_progress import running_checks, section
from validate_canonical_group import model_attempt, attempt_measurement


class Publication:
    def __init__(self):
        self.files, self.before, self.removals = {}, {}, {}

    def watch(self, path):
        path = path.resolve()
        need(path.is_relative_to(ROOT / 'benchmark') or path.is_relative_to(ROOT / 'docs'), 'Output outside benchmark/docs')
        self.before.setdefault(path, path.read_bytes() if path.exists() else None)
        return path

    def put(self, path, data):
        path = self.watch(path)
        data = data.encode() if isinstance(data, str) else data
        self.files[path] = data
        return {'path': rel(path), 'sha256': hashlib.sha256(data).hexdigest()}

    def json(self, path, data, compact=True):
        return self.put(path, encoded(data))

    def object(self, path, name=None):
        data = path.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        matches = list((BASE / 'evidence/itp/objects' / digest).glob('*'))
        target = matches[0] if matches else BASE / 'evidence/itp/objects' / digest / (name or path.name)
        if target.exists():
            need(target.read_bytes() == data, 'Existing object changed')
        return self.put(target, data)

    def remove(self, path, expected):
        path = self.watch(path)
        need(sha(path) == expected, 'Superseded source changed')
        self.removals[path] = expected

    def read(self, path):
        path = path.resolve()
        return json.loads(self.files[path]) if path in self.files else load(path)

    def validate_refs(self):
        def visit(value):
            if isinstance(value, dict):
                if isinstance(value.get('path'), str) and value.get('sha256') and value['path'].startswith(('benchmark/', 'runtime/', 'arxiv/')):
                    path = ROOT / value['path']
                    need(path not in self.removals, 'Reference to a scheduled removal: ' + str(path))
                    actual = hashlib.sha256(self.files[path]).hexdigest() if path in self.files else sha(path)
                    need(actual == value['sha256'], 'Publication reference hash mismatch: ' + str(path))
                for item in value.values():
                    visit(item)
            elif isinstance(value, list):
                for item in value:
                    visit(item)
        for path, data in self.files.items():
            if path.suffix == '.json' and (path.is_relative_to(BASE / 'evidence') or path == REVIEW):
                visit(json.loads(data))

    def apply(self):
        self.validate_refs()
        with open('/tmp/tespec-singleton-publication.lock', 'a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
            for path, before in self.before.items():
                need((path.read_bytes() if path.exists() else None) == before, 'Concurrent edit: ' + str(path))
            staged = {}
            try:
                for path, data in self.files.items():
                    path.parent.mkdir(parents=True, exist_ok=True)
                    with tempfile.NamedTemporaryFile(dir=path.parent, prefix='.singleton-publish-', delete=False) as tmp:
                        tmp.write(data)
                        tmp.flush()
                        os.fsync(tmp.fileno())
                        staged[path] = Path(tmp.name)
                for path, tmp in staged.items():
                    os.replace(tmp, path)
                for path in self.removals:
                    path.unlink()
                self.validate_refs()
                need(all(path.read_bytes() == data for path, data in self.files.items()), 'Committed bytes differ')
            except BaseException:
                for path, before in self.before.items():
                    if before is None:
                        path.unlink(missing_ok=True)
                    else:
                        path.write_bytes(before)
                raise
            finally:
                for tmp in staged.values():
                    tmp.unlink(missing_ok=True)


def closed_models(directory, task):
    models, pending = [], []
    folders = sorted(directory.glob('attempt-*'), key=lambda path: int(path.name.split('-')[1]))
    for folder in folders:
        receipt_path = folder / 'model-receipt.json'
        if not receipt_path.is_file():
            pending.append({'attempt': folder.name, 'status': 'UNRECEIPTED', 'cost': None})
            continue
        value = load(receipt_path)
        model_attempt(value, str(folder))
        need(value['attempt'] == int(folder.name.split('-')[1]), 'Model ordinal differs')
        for filename, key in (('agent.stdout.jsonl', 'raw_event_log_sha256'), ('prompt.txt', 'prompt_sha256'), ('Candidate.v', 'candidate_sha256')):
            require_hash(folder / filename, value[key], filename)
        events = usage_events(folder / 'agent.stdout.jsonl')
        need([e['usage'] for e in events] == value['token_usage'], 'Actual model usage differs')
        need(value['locked_goal_and_helper_sha256']['Goal.v'] == task['original_goal_sha256'], 'Model Goal differs')
        for module, digest in task['abi_context']['modules'].items():
            need(value['locked_goal_and_helper_sha256'][module + '.v'] == digest, 'Model dependency differs')
        value.update(usage_events=events, source_receipt_sha256=sha(receipt_path))
        models.append(value)
    return models, pending


def metric(stages):
    if not stages:
        return {'wall_seconds': None, 'peak_process_rss_kib': None, 'observed_peak_rss_lower_bound_kib': None,
                'resource_metrics_complete': False, 'tokens': None, 'subprocesses': 0, 'status': 'NOT_RUN'}
    return stage_totals(stages)


def combined_stage(items, agent=False):
    items = [i for i in items if i and i.get('wall_seconds') is not None]
    if not items:
        return metric([]) if not agent else {'wall_seconds': None, 'peak_process_resident_bytes': None, 'tokens': None, 'model_calls': 0, 'status': 'NOT_RUN'}
    peak_key = 'peak_process_resident_bytes' if agent else 'peak_process_rss_kib'
    lower_key = 'observed_peak_rss_lower_bound_bytes' if agent else 'observed_peak_rss_lower_bound_kib'
    known = [i.get(lower_key, i.get(peak_key)) for i in items]
    known = [i for i in known if i is not None]
    complete = all(i.get(peak_key) is not None for i in items)
    return {'wall_seconds': sum(i['wall_seconds'] for i in items), 'tokens': sum(i['tokens'] for i in items),
            peak_key: max(i[peak_key] for i in items) if complete else None,
            lower_key: max(known) if known else None, 'resource_metrics_complete': complete,
            'model_calls' if agent else 'subprocesses': sum(i.get('model_calls' if agent else 'subprocesses', 0) for i in items)}


def metrics_for(models, checks):
    agent = {'wall_seconds': sum(m['wall_seconds'] for m in models),
             'peak_process_resident_bytes': max(m['resources']['max_process_peak_working_set_bytes'] for m in models),
             'tokens': sum(u['input_tokens'] + u['output_tokens'] for m in models for u in m['token_usage']),
             'model_calls': len(models)} if models else combined_stage([], True)
    stages = [s for c in checks for s in c['stages']]
    return {'agent': agent,
        'coq_compile_and_assumption_audit': metric([s for s in stages if not s['stage'].startswith('kernel_replay')]),
        'independent_kernel_check': metric([s for s in stages if s['stage'].startswith('kernel_replay')])}


def collect_execution(pub, task, native, root, model_root, mapping, context_ref):
    index = task['execution_index']
    row = native['runs'][task['native_row_index']]
    for key, other in (('case', 'case'), ('mode', 'spatial_smt'), ('strategy', 'strategy'), ('input', 'input'), ('source_sha256', 'source_sha256')):
        need(task[key] == row[other], 'Strong task/native identity differs')
    need(task['residual_vcs'] == row['residual_vcs'] and row['raw_status'] == 'UNKNOWN', 'Strong task coverage differs')
    for key in ('original_report', 'original_manifest', 'original_goal', 'certificate_manifest'):
        require_hash(Path(task[key]), task[key + '_sha256'], key)
    require_hash(ROOT / task['source'], task['source_sha256'], 'source')
    models, pending = closed_models(model_root / f'execution-{index:02d}', task)
    model_by_hash = {m['source_receipt_sha256']: m for m in models}
    checks, missing = [], []
    for path in sorted((root / 'checks' / f'execution-{index:02d}').glob('*.json')):
        raw = load(path)
        need(raw['schema'] == 'tespec-singleton-strong-left-execution-itp/v1', 'Unknown strong check schema')
        need(raw['model_receipt_sha256'] in model_by_hash, 'Check/model link missing')
        need(raw['native_row_index'] == task['native_row_index'] and raw['native_results_sha256'] == native['_sha256'], 'Check/native differs')
        model = model_by_hash[raw['model_receipt_sha256']]
        binding = raw['binding']
        need(binding['abi_context'] == task['abi_context'], 'Strong ABI binding differs')
        for key, other in (('original_goal_sha256', 'original_goal_sha256'), ('source_sha256', 'source_sha256'), ('original_residual_vcs', 'residual_vcs')):
            need(binding[key] == task[other], 'Strong check binding differs')
        need(all(binding['strong_left'][k] == v for k, v in task['strong_template'].items()), 'Strong template lock differs')
        require_hash(Path(raw['certificate_report']), raw['certificate_report_sha256'], 'checker report')
        report = load(Path(raw['certificate_report']))
        need(report == raw['certificate_result'] and report['candidate_sha256'] == model['candidate_sha256'], 'Checked candidate/report differs')
        check = {k: copy.deepcopy(v) for k, v in report.items() if k not in ('stages', 'duration_seconds')}
        check.update(attempt=path.stem, model_attempt=model['attempt'], model_receipt_sha256=raw['model_receipt_sha256'],
            controller_status=raw['status'], controller_receipt_sha256=sha(path),
            certificate_report_sha256=raw['certificate_report_sha256'], controller_sha256=raw['controller_sha256'],
            checker_sha256=raw['checker_sha256'], support_sha256=raw['support_sha256'],
            binding=binding, abi_context=binding['abi_context'], strong_left_attestation=binding['strong_left'],
            selected_goals=task['residual_vcs'], stages=[])
        for stage in raw['stages']:
            attempt_measurement(stage, 'strong Coq attempt', allow_missing_rss=report.get('status') != 'PASS')
            require_hash(Path(stage['log']), stage['log_sha256'], 'stage log')
            check['stages'].append({k: copy.deepcopy(v) for k, v in stage.items() if k != 'log'})
            if (stage.get('resources') or {}).get('max_process_rss_kib') is None:
                missing.append({'execution_index': index, 'check_attempt': path.stem, 'stage': stage['stage'],
                    'field': 'resources.max_process_rss_kib', 'wall_seconds': stage['wall_seconds'],
                    'reason': 'Missing original RSS; not estimated or replaced by another attempt.'})
        if raw.get('assumption_audit_text') is not None:
            check['audit_text'] = raw['assumption_audit_text']
            check['audit_sha256'] = hashlib.sha256(check['audit_text'].encode()).hexdigest()
        checks.append(check)
    active_metrics = metrics_for(models, checks)
    legacy_metrics = mapping['legacy_itp_metrics'] or {}
    cumulative = {stage: combined_stage([legacy_metrics.get(stage), active_metrics[stage]], stage == 'agent')
                  for stage in active_metrics}
    seen = any(c['controller_status'] == 'KERNEL_CHECKED' and models and c['model_receipt_sha256'] == models[-1]['source_receipt_sha256'] for c in checks)
    receipt = {'schema': 'tespec-singleton-strong-left-progress-execution/v1', 'group': GROUP,
        'execution_index': index, 'native_row_index': task['native_row_index'], 'case': row['case'],
        'strategy': row['strategy'], 'spatial_smt': row['spatial_smt'], 'input': row['input'], 'source_sha256': row['source_sha256'],
        'status': 'UNKNOWN', 'observed_strong_kernel_status': 'KERNEL_CHECKED_PENDING_PUBLICATION_AUDIT' if seen else 'PENDING',
        'proof_profile': 'singleton-strong-left-abi/v1', 'abi_context': task['abi_context'], 'strong_template': task['strong_template'],
        'original_goal_sha256': task['original_goal_sha256'], 'original_manifest_sha256': task['original_manifest_sha256'],
        'original_report_sha256': task['original_report_sha256'], 'selected_goals': task['residual_vcs'],
        'model_attempts': models, 'unreceipted_model_attempts': pending, 'checks': checks,
        'metrics': active_metrics, 'cumulative_metrics': cumulative, 'missing_measurements': missing,
        'legacy_execution_receipt': mapping['legacy_itp_receipt'], 'legacy_metrics': legacy_metrics or None,
        'context_transition': context_ref, 'scope': 'Active measured strong-left attempts; no verdict promotion until strict proof publication audit. Legacy proofs contribute costs only.'}
    if models:
        cert = Path(task['certificate_dir'])
        receipt['goal'] = pub.object(cert / 'Goal.v')
        latest = model_root / f'execution-{index:02d}' / f"attempt-{models[-1]['attempt']}" / 'Candidate.v'
        receipt['candidate'] = pub.object(latest)
        receipt['proof_files'] = {name: pub.object(cert / name) for name in ('Coverage.v', 'Assumptions.v')}
        receipt['dependencies'] = [{**pub.object(cert / 'dependencies' / (name + '.v')), 'module': name} for name in task['abi_context']['modules']]
    reference = pub.json(ACTIVE / f'execution-{index:02d}.json', receipt) if models or checks or pending else None
    if seen:
        canonical, reference = build_execution(pub, task, native, root, model_root, transition_mapping=None)
        audit_row = {**row, 'vc_sha256': {k: v['sha256'] for k, v in row['vc_files'].items()}}
        audit_prepared_execution(pub, reference, audit_row)
        receipt['_audited_canonical'] = canonical
    return receipt, reference


def summarize(entries, field):
    result = {}
    for stage in ('agent', 'coq_compile_and_assumption_audit', 'independent_kernel_check'):
        items = [e[field][stage] for e in entries if e[field][stage].get('wall_seconds') is not None]
        peaks = [(i.get('peak_process_resident_bytes') if stage == 'agent' else
                  None if i.get('peak_process_rss_kib') is None else i['peak_process_rss_kib'] * 1024) for i in items]
        result[stage] = {'measured_executions': len(items), 'wall_seconds_total': sum(i['wall_seconds'] for i in items),
            'tokens_total': sum(i['tokens'] for i in items),
            'observed_mean_wall_seconds': statistics.mean(i['wall_seconds'] for i in items) if items else None,
            'observed_mean_tokens': statistics.mean(i['tokens'] for i in items) if items else None,
            'observed_mean_peak_process_mib': statistics.mean(peaks) / 1048576 if peaks and all(p is not None for p in peaks) else None,
            'full_14_execution_mean': None, 'complete': False}
    return result


def prepare(args):
    pub = Publication()
    if TRANSITION.exists():
        context = load(TRANSITION)
        need(context['active_native_results_sha256'] == sha(args.native_results), 'Active native context changed')
        context_ref = {'path': rel(TRANSITION), 'sha256': sha(TRANSITION)}
        native = load(NATIVE)
    else:
        planned = transition.prepare(args.legacy_native_results, args.native_results)
        for item in planned['proposed_writes']:
            target = ROOT / item['path']
            if item['action'] == 'preserve-receipt-bytes':
                pub.put(target, (ROOT / item['copy_from']).read_bytes())
            else:
                pub.json(target, item['document'])
        for item in planned['conditional_removals_after_reference_audit']:
            pub.remove(ROOT / item['path'], item['sha256'])
        context_ref = planned['transition']
        context = pub.read(TRANSITION)
        native = pub.read(NATIVE)
    review = pub.read(REVIEW)
    need(review['status'] in ('OPEN', 'RESOLVED_FOR_EXPLICIT_ABI_CONTEXT'), 'Unqualified semantic review status')
    active_review_ref = pub.json(REVIEW, pub.read(REVIEW))
    raw = load(args.native_results)
    raw['_sha256'] = sha(args.native_results)
    for path, digest in raw['input_identity'].items():
        require_hash(ROOT / path, digest, 'current input/tool context')
    task_bundle = load(args.itp_root / 'tasks.json')
    need(task_bundle['native_result_sha256'] == raw['_sha256'] and len(task_bundle['tasks']) == 14, 'Task/native snapshot mismatch')
    need({t['native_row_index'] for t in task_bundle['tasks']} == {i for i, r in enumerate(raw['runs']) if r['raw_status'] == 'UNKNOWN'}, 'Incomplete ITP inventory')
    need({t['execution_index'] for t in task_bundle['tasks']} == set(range(14)), 'Duplicate/missing execution ordinal')
    mappings = {m['active_itp_execution_index']: m for m in context['per_execution_cost_mapping'] if m['active_itp_execution_index'] is not None}
    entries, entry_refs = [], []
    for task in task_bundle['tasks']:
        entry, reference = collect_execution(pub, task, raw, args.itp_root, args.model_root, mappings[task['execution_index']], context_ref)
        entries.append(entry)
        entry_refs.append(reference)
    resolved = review['status'] == 'RESOLVED_FOR_EXPLICIT_ABI_CONTEXT'
    if resolved:
        need(review.get('legacy_context_status') == 'NOT_CERTIFIED', 'Resolution must not certify legacy context')
        need(review.get('resolution_native_results_sha256') == raw['_sha256'], 'Resolution/native context differs')
        abi_hashes = {canonical_sha(t['abi_context']) for t in task_bundle['tasks']}
        need(len(abi_hashes) == 1 and review.get('resolution_abi_context_sha256') in abi_hashes, 'Resolution/ABI context differs')
        first = review.get('first_strong_certificate', {})
        matching = [entry for entry in entries if '_audited_canonical' in entry and
                    entry['native_row_index'] == first.get('native_row_index') and any(
                        c['controller_receipt_sha256'] == first.get('controller_receipt_sha256') and
                        c['certificate_report_sha256'] == first.get('certificate_report_sha256') and
                        c['candidate_sha256'] == first.get('candidate_sha256') and c['status'] == 'PASS'
                        for c in entry['_audited_canonical']['checks'])]
        need(len(matching) == 1, 'Resolution first certificate lacks a matching fully audited strong proof')
    for entry in entries:
        entry['status'] = 'PASS' if resolved and '_audited_canonical' in entry else 'UNKNOWN'
    completed = sum(e['status'] == 'PASS' for e in entries)
    active_stats, cumulative_stats = summarize(entries, 'metrics'), summarize(entries, 'cumulative_metrics')
    active_models = [m for e in entries for m in e['model_attempts']]
    active_checks = [c for e in entries for c in e['checks']]
    need(len(active_models) == len({m['source_receipt_sha256'] for m in active_models}), 'Active model counted twice')
    need(len(active_checks) == len({c['controller_receipt_sha256'] for c in active_checks}), 'Active check counted twice')
    legacy_cost = context['measured_totals_to_date']
    setup = context['group_shared_setup']['context_preparation']
    need(setup['wall_seconds'] == 0.45 and setup['peak_process_rss_kib'] == 17244 and setup['tokens'] == setup['model_calls'] == 0,
         'Measured group setup changed')
    need(legacy_cost['model_calls'] == 4 and legacy_cost['tokens'] == 416106 and legacy_cost['check_attempts'] == 6, 'Legacy cost identity changed')
    observed = sum(e['observed_strong_kernel_status'].startswith('KERNEL_CHECKED') for e in entries)
    progress = {'schema': 'tespec-singleton-context-itp-progress/v1', 'group': GROUP, 'complete': False,
        'verdict_complete': False, 'resource_metrics_complete': False, 'context': context['active_context'],
        'context_transition': context_ref, 'native_results_sha256': raw['_sha256'], 'tasks_sha256': sha(args.itp_root / 'tasks.json'),
        'required_itp_executions': 14, 'original_entailment_completed_executions': completed, 'pending_executions': 14-completed,
        'strictly_audited_strong_executions': sum('_audited_canonical' in e for e in entries),
        'observed_strong_kernel_checked_executions': observed,
        'active_context_model_calls': len(active_models), 'active_context_check_attempts': len(active_checks),
        'active_context_tokens': active_stats['agent']['tokens_total'],
        'model_calls_including_context_repair': 4 + len(active_models), 'check_attempts_including_context_repair': 6 + len(active_checks),
        'tokens_including_context_repair': 416106 + active_stats['agent']['tokens_total'],
        'active_context_measured_stages': active_stats, 'cumulative_measured_stages': cumulative_stats,
        'group_shared_setup': context['group_shared_setup'],
        'tespec_group_measured_work_wall_seconds': legacy_cost['native_wall_seconds'] + setup['wall_seconds'] +
            sum(stage['wall_seconds_total'] for stage in cumulative_stats.values()),
        'missing_measurements': legacy_cost['missing_measurements'] + [m for e in entries for m in e['missing_measurements']],
        'semantic_review': active_review_ref, 'running_checks': running_checks(args.itp_root),
        'executions': [{'execution_index': e['execution_index'], 'native_row_index': e['native_row_index'],
                        'status': e['status'], 'observed_strong_kernel_status': e['observed_strong_kernel_status'],
                        'receipt': reference, 'legacy_execution_receipt': e['legacy_execution_receipt']}
                       for e, reference in zip(entries, entry_refs)],
        'scope': 'Only closed model/check receipts contribute cost. Running/unreceipted stages are not estimated. Every legacy context repair is added exactly once to its corresponding execution; successful legacy parent checks are not new ABI proofs. PASS requires full strong certificate audit plus resolution bound to this exact native/ABI context.'}
    progress_ref = pub.json(ACTIVE / 'progress.json', progress)
    native.update(context_transition=context_ref, evaluation_complete=False, verdict_complete=False, resource_metrics_complete=False)
    native['itp'] = {'status': 'STRONG_LEFT_IN_PROGRESS' if resolved else 'PENDING_CONTEXT_RESOLUTION', 'progress': progress_ref, 'executions': 14,
                     'completed_executions': completed, 'observed_strong_kernel_checked_executions': observed,
                     'semantic_review': active_review_ref, 'context_repair_costs_included': True}
    for row in native['runs']:
        row['final_status'] = row['raw_status']
        row['matches_expected'] = row['expected'] == row['final_status']
    for task, reference, entry in zip(task_bundle['tasks'], entry_refs, entries):
        row = native['runs'][task['native_row_index']]
        row['final_status'] = entry['status']
        row['matches_expected'] = row['expected'] == row['final_status']
        if reference:
            row['itp_attempts'] = reference
    native_ref = pub.json(NATIVE, native)
    latest = {'evidence': native_ref['path'], 'sha256': native_ref['sha256'], 'case_pairs': 7, 'executions': 28,
        'complete': False, 'pending_itp_executions': 14-completed, 'itp_progress': progress_ref, 'context_transition': context_ref,
        'original_entailment_completed_executions': completed, 'observed_strong_kernel_checked_executions': observed}
    final_counts = {'PASS': 14+completed, 'UNKNOWN': 14-completed}
    summary = {'case_pairs': 7, 'executions': 28, 'correct_executions': 14+completed, 'raw_status_counts': {'PASS': 14, 'UNKNOWN': 14},
        'final_status_counts': final_counts, 'complete': False, 'verdict_complete': False, 'resource_metrics_complete': False}
    pub.json(BASE / 'tespec/results.json', {'tool': 'tespec', 'program_group': GROUP, 'summary': summary,
        'evidence': native_ref['path'], 'evidence_sha256': native_ref['sha256'], 'latest_native_recheck': latest,
        'current_itp_progress': progress_ref, 'historical_context_repair': context_ref,
        'cases': [{k: r[k] for k in ('case', 'variant', 'strategy', 'spatial_smt', 'expected', 'raw_status', 'final_status', 'matches_expected')} for r in native['runs']]})
    pub.put(BASE / 'cases.csv', csv_bytes([{**r, 'input': json.dumps(r['input'], separators=(',', ':')),
        'proof_context_sha256': context['active_context']['proof_context_sha256']} for r in native['runs']],
        ['case', 'variant', 'strategy', 'spatial_smt', 'input', 'source_sha256', 'proof_context_sha256',
         'expected', 'raw_status', 'final_status', 'matches_expected', 'wall_seconds']))
    pub.json(BASE / 'tespec/statistics.json', {'schema': 'tespec-context-progress-costs/v1', 'program_group': GROUP,
        'complete': False, 'verdict_complete': False, 'resource_metrics_complete': False, 'latest_native_recheck': latest,
        'tokens': progress['tokens_including_context_repair'], 'model_calls': progress['model_calls_including_context_repair'],
        'current_itp_progress': progress_ref, 'context_transition': context_ref, 'active_measured_stages': active_stats,
        'cumulative_measured_stages': cumulative_stats, 'native_stage_costs': context['measured_totals_to_date']['native_wall_seconds'],
        'group_shared_setup': context['group_shared_setup'],
        'tespec_group_measured_work_wall_seconds': progress['tespec_group_measured_work_wall_seconds'],
        'missing_measurements': progress['missing_measurements'], 'final_14_execution_means': None,
        'scope': 'Cumulative ITP includes all context repair calls/checks. Native cost includes both contexts. Stage totals are not a completed end-to-end duration; unclosed work is pending.'})
    table = load(BASE / 'result-cost.json')
    old_costs = table['costs']
    need([r['tool'] for r in old_costs[:8]] == ['cn', 'qcp', 'qcp', 'qcp', 'qcp', 'qcp', 'fulminate', 'fulminate'], 'Primary tool costs changed')
    if 'pre_context_transition_cost_views' not in table:
        table['pre_context_transition_cost_views'] = {'costs': transition.rewrite(old_costs[8:], {rel(PROGRESS): context['legacy_itp_progress']}),
            'scope': 'Superseded display views retained as historical provenance; overlapping values are not added again. Exact repair costs are charged by context-transition.'}
    table['costs'] = old_costs[:8]
    table['costs'].append({'tool': 'tespec group setup', 'stage': '确定性 ABI 库准备', 'unit': '每组一次；不进入14次ITP均值',
        'wall_seconds': setup['wall_seconds'], 'peak_process_memory_mib': setup['peak_process_rss_kib'] / 1024,
        'tokens': 0, 'estimated': False, 'status': 'MEASURED', 'source': context_ref['path']})
    for mode in native['modes']:
        table['costs'].append({'tool': f"tespec {mode['strategy']} spatial-{mode['spatial_smt']}", 'stage': '当前 ABI 原生测试',
            'unit': '每次执行均值', 'wall_seconds': mode['wall_seconds_mean'],
            'peak_process_memory_mib': mode['peak_process_rss_kib_mean'] / 1024, 'tokens': 0,
            'estimated': False, 'status': 'MEASURED', 'source': native_ref['path']})
    old_native = pub.read(ROOT / context['legacy_native']['path'])
    table['costs'].append({'tool': 'tespec context-repair', 'stage': '旧上下文原生执行（计入总成本）',
        'unit': '28 次旧执行均值', 'wall_seconds': statistics.mean(r['wall_seconds'] for r in old_native['runs']),
        'peak_process_memory_mib': statistics.mean(r['resources']['max_process_rss_kib'] for r in old_native['runs']) / 1024,
        'tokens': 0, 'estimated': False, 'status': 'MEASURED_INCLUDED', 'source': context['legacy_native']['path']})
    for stage, value in cumulative_stats.items():
        table['costs'].append({'tool': 'tespec cumulative ITP', 'stage': stage,
            'unit': f"已尝试 {value['measured_executions']}/14 次执行的暂计均值，含旧上下文；不是最终均值",
            'wall_seconds': value['observed_mean_wall_seconds'], 'peak_process_memory_mib': value['observed_mean_peak_process_mib'],
            'tokens': value['observed_mean_tokens'], 'estimated': False, 'status': 'INCOMPLETE_MEASURED_ATTEMPTS', 'source': progress_ref['path']})
    for result in table['results']:
        if result['tool'] == 'tespec':
            result.update(result=f'{14+completed}/28 configurations; strong-left ITP in progress', test_pairs=7, expected_matches=None,
                          executions=28, expected_execution_matches=14+completed)
    table.update(complete=False, verdict_complete=False, resource_metrics_complete=False, latest_native_recheck=latest,
        current_itp_progress=progress_ref, context_transition=context_ref, current_measured_itp_stages=cumulative_stats,
        current_missing_measurements=progress['missing_measurements'], group_shared_setup=context['group_shared_setup'],
        group_measured_work_wall_seconds=progress['tespec_group_measured_work_wall_seconds'] +
            sum(row['wall_seconds'] for i, row in enumerate(old_costs[:8]) if i != 5),
        group_measured_work_scope='Selected current four-tool evaluation stages, including both native contexts, every legacy/new ITP attempt and one shared setup. Skip the overlapping QCP ITP aggregate row. Not a continuous end-to-end duration; pending work unmeasured.')
    pub.json(BASE / 'result-cost.json', table)
    pub.put(BASE / 'result-cost.csv', csv_bytes(table['costs'], COST_FIELDS))
    for name in ('index.json', 'coverage-gap.json'):
        value = load(BASE / name)
        value.update(complete=False, verdict_complete=False, resource_metrics_complete=False, latest_native_recheck=latest,
            current_itp_progress=progress_ref, context_transition=context_ref, current_missing_measurements=progress['missing_measurements'],
            tespec_current_run_status='ABI_STRONG_LEFT_ITP_PENDING')
        if name == 'index.json':
            value['evaluation'] = native_ref['path']
            value['per_tool_evidence']['tespec'] = native_ref['path']
        pub.json(BASE / name, value)
    detail = (f"当前 ABI 上下文原生执行为 14 PASS、14 UNKNOWN；包含已审计强证明后的最终结果为 **{14+completed} PASS、{14-completed} UNKNOWN**。"
        f"已观测强证明内核完成 {observed}/14，满足完整审计及限定上下文 resolution 的 {completed}/14。\n\n"
        f"当前上下文已关闭 {len(active_models)} 次 gpt-6.1-sol 调用、{len(active_checks)} 次检查；"
        f"连同上下文修复共 {progress['model_calls_including_context_repair']} 次模型调用、{progress['tokens_including_context_repair']:,} token。"
        "旧 4 次调用、6 次检查的全部成本计入相应执行；旧父 VC 成功不转移为新 ABI 证明。未关闭阶段不估算，两个旧失败 RSS 缺失保持缺失。"
        "ABI 库准备另计每组一次 0.45 秒、17244 KiB、0 token，纳入组已测工作量，不进入14次ITP均值。"
        + ("新显式 ABI 上下文的修复已限定确认；旧上下文仍 NOT_CERTIFIED。" if resolved else "语义审核仍 OPEN。") + "历史 QCP 仍绑定旧抽象地址上下文。\n\n"
        "[当前逐执行成本与证据](evidence/itp/abi-context/progress.json) · [上下文与费用映射](evidence/itp/context-transition.json)。完整进度仍为 **22/45 组、901 对输入**。")
    md = ['# Dbl_Linked_List__singleton：结果与成本表', '', detail, '',
        '各原生行是当前模式的逐执行均值；ITP 行是已尝试执行的暂计均值，包含所有旧上下文和新上下文失败/成功尝试，不是最终 14 次均值。峰值不相加；有历史缺失时保持缺失。', '',
        '| 工具 | 阶段 | 时间（秒） | 峰值进程内存（MiB） | token | 口径 |', '|---|---|---:|---:|---:|---|']
    fmt = lambda value: '待补齐' if value is None else f'{value:.4f}'
    for cost in table['costs']:
        md.append('| ' + ' | '.join([cost['tool'], cost['stage'], fmt(cost['wall_seconds']), fmt(cost['peak_process_memory_mib']), fmt(cost['tokens']), cost['unit']]) + ' |')
    pub.put(BASE / 'result-cost.md', '\n'.join(md) + '\n')
    docs = ROOT / 'docs/benchmark-evaluation-progress.md'
    text = docs.read_text()
    detail_docs = detail.replace('(evidence/', '(../benchmark/results/Dbl_Linked_List__singleton/evidence/')
    pub.put(docs, section(text, detail_docs, after_paragraph='本次 singleton 当前原生补测已完成'))
    global_path = ROOT / 'benchmark/results/group-result-cost-index.json'
    global_index = load(global_path)
    need(sum(bool(g['complete']) for g in global_index['groups']) == 22, 'Global completed count changed')
    pairs = sum(next(r['test_pairs'] for r in load(ROOT / g['json'])['results'] if r['tool'] == 'tespec')
                for g in global_index['groups'] if g['complete'])
    need(pairs == 901, 'Global completed pairs changed')
    global_index['current_completion_summary'].update(next_group_current_native_evidence=native_ref['path'],
        next_group_current_itp_progress=progress_ref, next_group_pending_itp_executions=14-completed, next_group_context_transition=context_ref)
    pub.json(global_path, global_index)
    ledger_path = ROOT / 'benchmark/results/tespec-unexpected/index.json'
    ledger = load(ledger_path)
    ledger.setdefault('current_group_rechecks', {})[GROUP] = {'evidence': native_ref['path'], 'sha256': native_ref['sha256'],
        'case_pairs': 7, 'executions': 28, 'complete': False, 'unexpected_executions': 14-completed,
        'raw_status_counts': {'PASS': 14, 'UNKNOWN': 14}, 'final_status_counts': final_counts,
        'itp': 'ABI_STRONG_LEFT_ITP_PENDING', 'progress': progress_ref, 'context_transition': context_ref,
        'semantic_review': active_review_ref, 'reason': 'Only fully audited strong proofs in the exact resolved native/ABI context can update PASS. Prior parent proofs are cost history only.'}
    pub.json(ledger_path, ledger)
    global_result_path = ROOT / 'benchmark/results/index.json'
    global_results = load(global_result_path)
    global_results['current_singleton_summary'] = {'evidence': native_ref, 'case_pairs': 7, 'executions': 28,
        'complete': False, 'verdict_complete': False, 'resource_metrics_complete': False, 'context_transition': context_ref}
    pub.json(global_result_path, global_results)
    pub.validate_refs()
    return pub, progress


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--legacy-native-results', type=Path, default=Path('/tmp/tespec-singleton-current-irrfnr7y/results.json'))
    parser.add_argument('--native-results', type=Path, default=Path('/tmp/tespec-singleton-layout-native-24wkmdxt/results.json'))
    parser.add_argument('--itp-root', type=Path, default=Path('/tmp/tespec-singleton-strong-itp-ueo9fs4a'))
    parser.add_argument('--model-root', type=Path, default=Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/singleton-strong-itp-3f5f5qwg'))
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    pub, progress = prepare(args)
    if args.apply:
        pub.apply()
    print(json.dumps({'preflight': 'PASS', 'applied': args.apply, 'writes': len(pub.files), 'superseded_files': len(pub.removals),
        'active_model_calls': progress['active_context_model_calls'], 'active_closed_checks': progress['active_context_check_attempts'],
        'total_model_calls': progress['model_calls_including_context_repair'], 'total_tokens': progress['tokens_including_context_repair'],
        'observed_strong_kernel_checks': progress['observed_strong_kernel_checked_executions'],
        'final_status_counts': {'PASS': 14+progress['original_entailment_completed_executions'], 'UNKNOWN': progress['pending_executions']}, 'complete_groups': 22, 'complete_group_case_pairs': 901,
        'missing_measurements': progress['missing_measurements']}, ensure_ascii=False))


if __name__ == '__main__':
    main()
