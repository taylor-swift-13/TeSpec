"""Read-only recovery evidence and partial cost arithmetic; never a certificate."""
from __future__ import annotations
import copy
import hashlib
import json
import math
import os
from pathlib import Path

SCHEMA = 'tespec-singleton-infrastructure-interruption/v1'
ARTIFACT_SCHEMA = 'tespec-interrupted-check-artifact-evidence/v1'


def need(condition, reason):
    if not condition:
        raise ValueError(reason)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def local_path(value):
    value = str(value)
    if os.name == 'nt':
        if value.startswith('/mnt/') and len(value) > 6 and value[6] == '/':
            return Path(value[5].upper() + ':/' + value[7:])
        if value.startswith('/'):
            return Path('//wsl.localhost/Ubuntu-22.04' + value)
        return Path(value)
    if len(value) > 2 and value[1:3] in (':\\', ':/'):
        return Path('/mnt') / value[0].lower() / value[3:].replace('\\', '/')
    return Path(value)


def verified_file(value, expected, artifact_resolver=None):
    path = artifact_resolver(str(value), expected) if artifact_resolver else local_path(value)
    need(path.is_file() and digest(path) == expected, 'Recovery artifact missing/changed: ' + str(path))
    return path


def artifact_file(record, artifact_resolver=None):
    need(record.get('present_in_backup') is True and record.get('backup_manifest_hash_match') is True,
         'Recovery artifact was not hash matched in backup')
    original = local_path(record['source'])
    if artifact_resolver:
        path = verified_file(record['source'], record['sha256'], artifact_resolver)
    else:
        path = original if original.is_file() else local_path(record['backup'])
        verified_file(str(path), record['sha256'])
    need(path.stat().st_size == record['bytes'], 'Recovery artifact byte length differs')
    return path


def numeric(value, label, positive=False):
    need(isinstance(value, (float, int)) and not isinstance(value, bool) and math.isfinite(value)
         and (value > 0 if positive else value >= 0), 'Invalid numeric measurement: ' + label)
    return value


def collect_interruption(raw, task, native_results_sha256, model, receipt_sha256, artifact_resolver=None):
    """Validate a reconstructed sidecar. Return UNKNOWN cost evidence, never PASS.

    The model is counted by its original meter receipt, not by this sidecar.
    Missing actual commands, exits, wall times and whole-attempt peak stay null.
    """
    need(raw.get('schema') == SCHEMA and raw.get('status') == 'UNKNOWN' and raw.get('final_status') == 'UNKNOWN',
         'Interruption cannot be a successful certificate')
    need(raw.get('group') == 'Dbl_Linked_List__singleton', 'Wrong interruption group')
    need(raw['execution_index'] == task['execution_index'] and raw['native_row_index'] == task['native_row_index'],
         'Interruption execution differs')
    need(raw['native_results_sha256'] == native_results_sha256, 'Interruption native snapshot differs')
    need(raw['model_receipt_sha256'] == model['source_receipt_sha256'], 'Interruption model receipt differs')
    need(raw['candidate_sha256'] == model['candidate_sha256'], 'Interruption candidate differs')
    need(raw['certificate_manifest_sha256'] == task['certificate_manifest_sha256'], 'Interruption manifest differs')
    binding = raw['binding']
    for field, source in (('case', 'case'), ('strategy', 'strategy'), ('spatial_smt', 'mode'), ('input', 'input'),
                          ('source_sha256', 'source_sha256'), ('original_goal_sha256', 'original_goal_sha256'),
                          ('original_residual_vcs', 'residual_vcs'), ('abi_context', 'abi_context'),
                          ('strong_template', 'strong_template')):
        need(binding[field] == task[source], 'Interruption task binding differs: ' + field)
    evidence_ref = raw['artifact_evidence']
    evidence_path = verified_file(evidence_ref['path'], evidence_ref['sha256'], artifact_resolver)
    evidence = json.loads(evidence_path.read_bytes().decode('utf-8-sig'))
    need(evidence.get('schema') == ARTIFACT_SCHEMA and evidence.get('status') == 'INFRASTRUCTURE_INTERRUPTED'
         and evidence.get('final_status') == 'UNKNOWN' and evidence.get('successful_execution') is False,
         'Invalid partial recovery evidence')
    for field, expected in (('execution_index', task['execution_index']), ('case', task['case']),
                            ('spatial_smt', task['mode']), ('strategy', task['strategy']),
                            ('model_attempt', model['attempt']), ('original_goal_sha256', task['original_goal_sha256']),
                            ('candidate_sha256', model['candidate_sha256']),
                            ('certificate_manifest_sha256', task['certificate_manifest_sha256']),
                            ('strong_template', task['strong_template'])):
        need(evidence[field] == expected, 'Artifact evidence binding differs: ' + field)
    verified_file(evidence['incident']['path'], evidence['incident']['sha256'], artifact_resolver)
    verified_file(evidence['backup_manifest']['path'], evidence['backup_manifest']['sha256'], artifact_resolver)
    model_cost = evidence['model_cost_from_incident']
    tokens = sum(u['input_tokens'] + u['output_tokens'] for u in model['token_usage'])
    need(model_cost['tokens'] == tokens and abs(model_cost['wall_seconds'] - model['wall_seconds']) < 1e-7
         and model_cost['max_process_peak_working_set_bytes'] == model['resources']['max_process_peak_working_set_bytes'],
         'Recovery incident/model bill differs')
    artifacts = {}
    for item in evidence['preserved_artifacts']:
        artifact_file(item, artifact_resolver)
        artifacts[item['source']] = item['sha256']
    cert_dir = evidence['interrupted_checker_directory']
    for name, expected in [('Goal.v', task['original_goal_sha256']), ('Candidate.v', model['candidate_sha256']),
                           ('manifest.json', task['certificate_manifest_sha256'])] + [
                           ('dependencies/' + name + '.v', value) for name, value in task['abi_context']['modules'].items()]:
        need(artifacts.get(cert_dir + '/' + name) == expected, 'Preserved proof input differs: ' + name)
    stages, missing = [], []
    for item in evidence['stages']:
        need(item['stage'] == 'version' or item['stage'].startswith('compile_'), 'Unproved kernel stage introduced')
        need(item['wall_seconds'] is None and item['exit_code'] is None, 'Recovered duration/exit was invented')
        resource_file = artifact_file(item['resource_artifact'], artifact_resolver)
        log_file = artifact_file(item['log_artifact'], artifact_resolver)
        resources = json.loads(resource_file.read_bytes())
        need(resources == item['resources'], 'Recovered resource values differ from GNU time artifact')
        for key in ('user_seconds', 'system_seconds', 'max_process_rss_kib'):
            numeric(resources[key], key, positive=key == 'max_process_rss_kib')
        stages.append({'stage': item['stage'], 'wall_seconds': None, 'exit_code': None, 'command': None,
            'resources': resources, 'resource_sha256': item['resource_artifact']['sha256'],
            'log_sha256': item['log_artifact']['sha256'],
            'diagnostic_tail': log_file.read_text(errors='replace')[-1200:],
            'measurement_status': 'surviving_GNU_time_record; actual command/exit/wall not preserved'})
        missing.append({'execution_index': task['execution_index'], 'check_attempt': raw.get('attempt', 'infrastructure-interruption'),
            'stage': item['stage'], 'field': 'wall_seconds', 'wall_seconds': None,
            'reason': 'Original wall clock measurement lost during infrastructure interruption; CPU is not substituted.'})
    need(len(stages) == 6 and len({s['stage'] for s in stages}) == 6, 'Recovered stage inventory changed')
    cost = evidence['partial_compile_cost']
    need(cost['wall_seconds'] is None and cost['peak_process_rss_kib'] is None and cost['resources_complete'] is False,
         'Whole interrupted attempt cost cannot be reconstructed as complete')
    need(abs(sum(s['resources']['user_seconds'] for s in stages) - cost['cpu_user_seconds_observed']) < 1e-9
         and abs(sum(s['resources']['system_seconds'] for s in stages) - cost['cpu_system_seconds_observed']) < 1e-9
         and max(s['resources']['max_process_rss_kib'] for s in stages) == cost['known_stages_peak_process_rss_kib'],
         'Recovered resource summary differs')
    need(evidence['independent_kernel_check']['kernel_completed'] is False,
         'No completed kernel evidence exists for interruption')
    missing.append({'execution_index': task['execution_index'], 'check_attempt': raw.get('attempt', 'infrastructure-interruption'),
        'stage': 'compilation_and_assumption_audit', 'field': 'peak_process_rss_kib', 'wall_seconds': None,
        'reason': 'Only six stage peaks survived; whole-attempt peak remains unknown.'})
    check = {'schema': SCHEMA, 'status': 'UNKNOWN', 'controller_status': 'INFRASTRUCTURE_INTERRUPTED',
        'receipt_kind': 'infrastructure_interruption', 'infrastructure_interrupted': True,
        'interruption_receipt_data': copy.deepcopy(raw),
        'attempt': raw.get('attempt', 'infrastructure-interruption'), 'model_attempt': model['attempt'],
        'model_receipt_sha256': raw['model_receipt_sha256'], 'candidate_sha256': model['candidate_sha256'],
        'controller_receipt_sha256': receipt_sha256, 'selected_goals': task['residual_vcs'],
        'binding': copy.deepcopy(binding), 'artifact_evidence_sha256': evidence_ref['sha256'],
        'incident_sha256': evidence['incident']['sha256'], 'backup_manifest_sha256': evidence['backup_manifest']['sha256'],
        'certificate_report_sha256': None, 'assumption_audit_status': 'NOT_PRESERVED',
        'kernel_check_status': 'NO_PRESERVED_KERNEL_EXECUTION_EVIDENCE',
        'measurement_scope_complete': False, 'stages': stages,
        'reason': raw['reason'], 'scope': 'Recovered infrastructure interruption costs only; no proof result or new model charge.'}
    return check, missing


def partial_stage_totals(stages, scope_complete=True):
    if not stages:
        return {'wall_seconds': None, 'known_wall_seconds_lower_bound': None, 'wall_time_complete': False,
            'peak_process_rss_kib': None, 'observed_peak_rss_lower_bound_kib': None,
            'resource_metrics_complete': False, 'tokens': None, 'subprocesses': 0, 'status': 'NOT_RUN'}
    walls = [s.get('wall_seconds') for s in stages]
    known_walls = [v for v in walls if v is not None]
    peaks = [(s.get('resources') or {}).get('max_process_rss_kib') for s in stages]
    known_peaks = [v for v in peaks if v is not None]
    wall_complete = scope_complete and len(known_walls) == len(stages)
    rss_complete = scope_complete and len(known_peaks) == len(stages)
    return {'wall_seconds': sum(known_walls) if wall_complete else None,
        'known_wall_seconds_lower_bound': sum(known_walls) if known_walls else None,
        'wall_time_complete': wall_complete,
        'peak_process_rss_kib': max(known_peaks) if rss_complete else None,
        'observed_peak_rss_lower_bound_kib': max(known_peaks) if known_peaks else None,
        'cpu_user_seconds_observed': sum((s.get('resources') or {}).get('user_seconds', 0) for s in stages),
        'cpu_system_seconds_observed': sum((s.get('resources') or {}).get('system_seconds', 0) for s in stages),
        'resource_metrics_complete': rss_complete and wall_complete,
        'tokens': 0, 'subprocesses': len(stages), 'measurement_scope_complete': scope_complete}


def combine_stage_metrics(items, agent=False):
    items = [i for i in items if i and (i.get('wall_seconds') is not None or i.get('subprocesses', 0) or i.get('model_calls', 0))]
    if not items:
        return partial_stage_totals([]) if not agent else {'wall_seconds': None, 'known_wall_seconds_lower_bound': None,
            'peak_process_resident_bytes': None, 'tokens': None, 'model_calls': 0, 'status': 'NOT_RUN'}
    peak_key = 'peak_process_resident_bytes' if agent else 'peak_process_rss_kib'
    lower_key = 'observed_peak_rss_lower_bound_bytes' if agent else 'observed_peak_rss_lower_bound_kib'
    peaks = [i.get(lower_key, i.get(peak_key)) for i in items]
    known_peaks = [v for v in peaks if v is not None]
    known_walls = [i.get('known_wall_seconds_lower_bound', i.get('wall_seconds')) for i in items]
    known_walls = [v for v in known_walls if v is not None]
    wall_complete = all(i.get('wall_seconds') is not None for i in items)
    rss_complete = all(i.get(peak_key) is not None for i in items)
    return {'wall_seconds': sum(i['wall_seconds'] for i in items) if wall_complete else None,
        'known_wall_seconds_lower_bound': sum(known_walls) if known_walls else None,
        'wall_time_complete': wall_complete, 'tokens': sum(i['tokens'] or 0 for i in items),
        peak_key: max(i[peak_key] for i in items) if rss_complete else None,
        lower_key: max(known_peaks) if known_peaks else None,
        'resource_metrics_complete': wall_complete and rss_complete,
        'cpu_user_seconds_observed': sum(i.get('cpu_user_seconds_observed', 0) for i in items),
        'cpu_system_seconds_observed': sum(i.get('cpu_system_seconds_observed', 0) for i in items),
        'model_calls' if agent else 'subprocesses': sum(i.get('model_calls' if agent else 'subprocesses', 0) for i in items)}
