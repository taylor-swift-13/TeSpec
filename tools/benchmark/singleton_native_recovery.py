"""Read-only binding of actual recovery executions to six unstarted singleton tasks.

An identical VC does not authorize reuse of a prior certificate. This validates
new native evidence; it never runs tools or grants an ITP verdict.
"""
from __future__ import annotations
import copy
import hashlib
import json
from pathlib import Path, PurePosixPath
from singleton_interruption import need, verified_file, numeric


def canonical_sha(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def validate_native_source(task, baseline_native_path, expected_baseline_hash, artifact_resolver=None):
    """Return (real recovery row, audit descriptor); all files are hash verified.

    task.native_row_index remains the 28-row original index; native_source's
    native_row_index indexes the six-row recovery snapshot. Optional resolver
    has the same (original_path, sha256) -> readable Path contract as recovery.
    """
    source = task['native_source']
    artifacts = {}
    def checked(path, digest):
        result = verified_file(str(path), digest, artifact_resolver)
        need(str(path) not in artifacts or artifacts[str(path)] == digest, 'Conflicting recovery file hashes')
        artifacts[str(path)] = digest
        return result
    def read(path, digest):
        return json.loads(checked(path, digest).read_bytes().decode('utf-8-sig'))
    need(source['original_native_result_sha256'] == expected_baseline_hash, 'Recovery original snapshot differs')
    old = read(baseline_native_path, expected_baseline_hash)
    need(read(source['original_native_result'], expected_baseline_hash) == old, 'Recovery baseline bytes differ')
    new = read(source['native_result'], source['native_result_sha256'])
    need(new['schema'] == 'tespec-group-native-recovery/v1' and new['group'] == old['group'] == 'Dbl_Linked_List__singleton',
         'Wrong native recovery schema/group')
    need(new['old_native_results_sha256'] == expected_baseline_hash and new['old_costs_retained'] is True,
         'Recovery must preserve original cost')
    need(new['input_evidence_unchanged'] is True and new['changed'] == []
         and new['input_identity'] == old['input_identity'], 'Recovery input/tool identity changed')
    original_task = source['original_task']
    need(canonical_sha(original_task) == source['original_task_sha256'], 'Original task hash differs')
    need('native_source' not in original_task, 'Recovery task cannot recursively replace a prior recovery')
    need(task['execution_index'] in (4, 5, 8, 9, 10, 13), 'Only the six unstarted tasks permit native recovery')
    for key in ('execution_index', 'native_row_index', 'case', 'mode', 'strategy', 'input', 'expected', 'source',
                'source_sha256', 'original_goal_sha256', 'abi_context', 'strong_template', 'residual_vcs', 'model'):
        need(task[key] == original_task[key], 'Recovery task identity changed: ' + key)
    old_index = source['original_native_row_index']
    new_index = source['native_row_index']
    need(isinstance(old_index, int) and not isinstance(old_index, bool) and old_index == task['native_row_index'], 'Original native index differs')
    need(isinstance(new_index, int) and not isinstance(new_index, bool) and 0 <= new_index < len(new['runs']), 'Invalid recovery row index')
    old_row = old['runs'][old_index]
    row = new['runs'][new_index]
    for key in ('case', 'variant', 'input', 'source', 'source_sha256', 'strategy', 'spatial_smt', 'vc_mode', 'expected',
                'raw_status', 'execution_completed', 'precondition_result', 'residual_vcs'):
        need(row[key] == old_row[key], 'Recovered native execution differs: ' + key)
    for key, native_key in (('case', 'case'), ('mode', 'spatial_smt'), ('strategy', 'strategy'), ('input', 'input'),
                            ('expected', 'expected'), ('source', 'source'), ('source_sha256', 'source_sha256'), ('residual_vcs', 'residual_vcs')):
        need(task[key] == row[native_key], 'Task/native identity differs: ' + key)
    need(row['raw_status'] == 'UNKNOWN' and row['precondition_result'] == 'SAT' and row['execution_completed'] is True,
         'Recovery is not a completed native residual-VC execution')
    need(original_task['original_report'] == old_row['report'] and original_task['original_report_sha256'] == old_row['report_sha256'],
         'Original task/report binding differs')
    recovery = row['recovery']
    need(recovery['original_row_index'] == old_index and recovery['execution_index'] == task['execution_index']
         and recovery['original_native_results_sha256'] == expected_baseline_hash
         and recovery['original_report_sha256'] == old_row['report_sha256']
         and recovery['original_report_unavailable'] is True, 'Recovery provenance differs')
    need(recovery['original_native_cost'] == {k: old_row[k] for k in ('wall_seconds', 'resources', 'executor_resources', 'tokens', 'model_calls')},
         'Original native cost changed')
    need(set(row['vc_files']) == set(old_row['vc_files']) == {'goal', 'proof_auto', 'proof_manual', 'goal_check'}, 'Incomplete original VC inventory')
    for name, item in row['vc_files'].items():
        need(item['sha256'] == old_row['vc_files'][name]['sha256'], 'Recovered VC differs: ' + name)
        checked(item['path'], item['sha256'])
        checked(old_row['vc_files'][name]['path'], item['sha256'])
    need(task['original_goal'] == row['vc_files']['goal']['path'], 'Task does not use recovery Goal')
    need(task['original_goal_sha256'] == row['vc_files']['goal']['sha256'], 'Recovery Goal binding differs')
    need(task['original_report'] == row['report'] and task['original_report_sha256'] == row['report_sha256'], 'Task does not use recovery report')
    report = read(task['original_report'], task['original_report_sha256'])
    need(report['provenance']['source_sha256'] == task['source_sha256'], 'Recovery report source differs')
    checked(report['source'], task['source_sha256'])
    checked(report['qcp_binary'], report['provenance']['binary_sha256'])
    need(report['provenance']['binary_sha256'] == old['input_identity']['bin/tespec-symexec'], 'Recovery binary differs from baseline')
    need(len(report['results']) == 1 and len(report['itp_vcs']) == 1, 'Recovery report has an ambiguous execution')
    executed = report['results'][0]
    for key, value in [('id', row['case']), ('arguments', row['input']['args']), ('bindings', row['input']['values']),
                       ('status', row['raw_status']), ('precondition_result', 'SAT'), ('execution_completed', True),
                       ('execution_strategy', row['strategy']), ('mode', row['vc_mode'])]:
        need(executed[key] == value, 'Recovery report outcome differs: ' + key)
    need(report['itp_vcs'][0]['manifest'] == task['original_manifest'] and report['itp_vcs'][0]['goals'] == task['residual_vcs'],
         'Recovery report/VC manifest differs')
    manifest = read(task['original_manifest'], task['original_manifest_sha256'])
    original_manifest = read(original_task['original_manifest'], original_task['original_manifest_sha256'])
    for key in ('case_id', 'function', 'status', 'residual_goals', 'counterexample_goals', 'immutable_sha256', 'target_layout', 'runtime_dependencies'):
        need(manifest[key] == original_manifest[key], 'Original/recovery VC context differs: ' + key)
    abi = task['abi_context']
    need(canonical_sha(manifest['target_layout']) == abi['target_layout_canonical_sha256']
         and executed['target_layout'] == manifest['target_layout'], 'Recovery target layout differs from ABI')
    modules = lambda m: {d['module']: d['sha256'] for d in m['coq_dependencies']}
    need(modules(manifest) == modules(original_manifest) == abi['modules'], 'Recovery external predicate dependencies differ')
    for dep in manifest['coq_dependencies']:
        checked(dep['source'], dep['sha256']); checked(dep['staged'], dep['sha256'])
    for dep in manifest['runtime_dependencies']:
        checked(dep['source'], dep['sha256']); checked(dep['compiled'], dep['compiled_sha256'])
    for name, item in row['vc_files'].items():
        need(manifest['files'][name] == item['path'], 'Recovery manifest VC path differs: ' + name)
        if name != 'proof_manual':
            need(manifest['immutable_sha256'][name] == item['sha256'], 'Recovery manifest VC hash differs: ' + name)
    need(source['new_certificate_manifest'] == task['certificate_manifest']
         and source['new_certificate_manifest_sha256'] == task['certificate_manifest_sha256'], 'New certificate binding differs')
    cert = read(task['certificate_manifest'], task['certificate_manifest_sha256'])
    need(cert['original_manifest'] == task['original_manifest'] and cert['original_manifest_sha256'] == task['original_manifest_sha256']
         and cert['original_goal_sha256'] == task['original_goal_sha256'] and cert['selected_goals'] == task['residual_vcs']
         and cert['target_layout'] == manifest['target_layout'], 'Certificate is not freshly bound to recovery native evidence')
    need({d['module']: d['sha256'] for d in cert['dependencies']} == abi['modules'], 'Recovery certificate dependencies differ')
    for name, value in cert['immutable_sha256'].items():
        checked(str(PurePosixPath(task['certificate_dir']) / name), value)
    for dep in cert['dependencies']:
        checked(str(PurePosixPath(task['certificate_dir']) / dep['file']), dep['sha256'])
    need(row['tokens'] == row['model_calls'] == 0, 'Native recovery may not invent model charges')
    numeric(row['wall_seconds'], 'native wall seconds', positive=True)
    numeric(row['resources']['max_process_rss_kib'], 'native peak RSS', positive=True)
    command = row['measured_command']
    need(command[0] == '/usr/bin/time' and '-o' in command, 'Recovery has no measured command')
    resource_path = command[command.index('-o') + 1]
    need(source['native_resources']['path'] == resource_path, 'Native resource command path differs')
    need(read(resource_path, source['native_resources']['sha256']) == row['resources'], 'Native resource artifact differs')
    return copy.deepcopy(row), {'schema': 'tespec-singleton-native-recovery-binding/v1',
        'baseline_native_results_sha256': expected_baseline_hash, 'recovery_native_results_sha256': source['native_result_sha256'],
        'original_native_row_index': old_index, 'recovery_native_row_index': new_index,
        'original_task_sha256': source['original_task_sha256'], 'execution_index': task['execution_index'],
        'abi_context_sha256': canonical_sha(abi), 'vc_sha256': {k: v['sha256'] for k, v in row['vc_files'].items()},
        'new_native_stage': {k: copy.deepcopy(row[k]) for k in ('wall_seconds', 'resources', 'tokens', 'model_calls', 'command', 'report_sha256')},
        'original_native_cost': copy.deepcopy(recovery['original_native_cost']),
        'artifacts': [{'path': path, 'sha256': value} for path, value in sorted(artifacts.items())],
        'verdict_authorized': False, 'scope': 'Actual recovery run for an unstarted task; original native cost retained; no certificate transfer.'}
