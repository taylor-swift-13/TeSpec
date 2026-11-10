#!/usr/bin/env python3
"""Prepare six NEW native-bound certificates, never run models or Coq."""
from pathlib import Path
import argparse
import copy
import hashlib
import json
import sys
import time

from singleton_strong_support import (ROOT, MODULES, SELECTED, binding_layout, load, require,
                                      save, sha, strong_template, verify_native_dependencies)
from spectest.certificates import prepare_certificate
sys.path.insert(0, str(ROOT / 'tools/benchmark'))
from singleton_native_recovery import validate_native_source


def hash_json(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tasks', required=True, type=Path)
    parser.add_argument('--native-results', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--setup-receipt', required=True, type=Path)
    args = parser.parse_args()
    started = time.monotonic()
    require(not args.output.exists() and not args.setup_receipt.exists(), 'Fresh override/receipt paths required')
    old_tasks = load(args.tasks)
    original_tasks_sha = sha(args.tasks)
    old_native = load(old_tasks['native_result'])
    require(sha(old_tasks['native_result']) == old_tasks['native_result_sha256'], 'Original native baseline changed')
    recovered = load(args.native_results)
    require(recovered['schema'] == 'tespec-group-native-recovery/v1' and recovered['native_executions'] == 6 and len(recovered['runs']) == 6, 'Expected six real native recovery executions')
    require(recovered['old_native_results_sha256'] == old_tasks['native_result_sha256'], 'Recovery belongs to another baseline')
    indexes = {r['recovery']['execution_index'] for r in recovered['runs']}
    require(indexes == {4, 5, 8, 9, 10, 13}, 'Unexpected recovery task selection')
    model_root = Path(old_tasks['model_root'])
    certificate_root = model_root / 'recovered-native-certificates'
    require(not certificate_root.exists(), 'Do not overwrite previously prepared certificates')
    pending = []
    for native_index, row in enumerate(recovered['runs']):
        index = row['recovery']['execution_index']
        old = old_tasks['tasks'][index]
        require(old['execution_index'] == index and old['native_row_index'] == row['recovery']['original_row_index'], 'Original task index differs')
        model_dir = Path(old['model_dir_wsl'])
        require(not any(p.is_dir() for p in model_dir.glob('attempt-*')), 'Never rebind a task after a model invocation')
        original_row = old_native['runs'][old['native_row_index']]
        keys = ['case', 'variant', 'input', 'source', 'source_sha256', 'strategy', 'spatial_smt', 'vc_mode', 'expected',
                'raw_status', 'final_status', 'reason', 'execution_completed', 'precondition_result', 'residual_vcs']
        require(all(row[k] == original_row[k] for k in keys), 'Recovery execution behavior/input differs from original')
        require({k: v['sha256'] for k, v in row['vc_files'].items()} == {k: v['sha256'] for k, v in original_row['vc_files'].items()}, 'Original VC bytes differ')
        require(sha(ROOT / row['source']) == row['source_sha256'] and sha(row['report']) == row['report_sha256'], 'Recovery source/report changed')
        report = load(row['report'])
        require(len(report['results']) == 1, 'One native execution per task required')
        result = report['results'][0]
        require(result['status'] == 'UNKNOWN' and result['precondition_result'] == 'SAT' and result['execution_completed'] is True, 'New native execution is incomplete')
        original_manifest_path = Path(result['vc']['manifest'])
        native_manifest = load(original_manifest_path)
        context = binding_layout(Path(old['abi_context']['bundle']), native_manifest['target_layout'])
        require(context == old['abi_context'], 'ABI interpretation differs from the prior selected context')
        verify_native_dependencies(native_manifest, context)
        goal = Path(native_manifest['files']['goal'])
        require(sha(goal) == old['original_goal_sha256'] == row['vc_files']['goal']['sha256'] == sha(model_dir / 'Goal.v'), 'Model Goal differs from actual new execution')
        prefix, suffix, template = strong_template(goal.read_bytes())
        require(template == old['strong_template'], 'Strong-left obligation changed')
        candidate = (model_dir / 'Candidate.v').read_bytes()
        require(candidate.startswith(prefix) and candidate.endswith(suffix), 'Pending Candidate template changed')
        for module in MODULES:
            require(sha(model_dir / (module + '.v')) == context['modules'][module], 'Pending model dependency differs')
        pending.append((native_index, row, old, original_manifest_path, goal, context, template, candidate))
    tasks = copy.deepcopy(old_tasks)
    tasks['original_tasks'] = {'path': str(args.tasks.resolve()), 'sha256': original_tasks_sha}
    tasks['native_recovery_snapshot'] = {'path': str(args.native_results.resolve()), 'sha256': sha(args.native_results)}
    audits = []
    for native_index, row, old, original_manifest_path, goal, context, template, candidate in pending:
        index = old['execution_index']
        cert = certificate_root / f'execution-{index:02d}'
        prepared = prepare_certificate(original_manifest_path, cert, only={SELECTED})
        (cert / 'Candidate.v').write_bytes(candidate)
        save(cert / 'strong-template.json', template)
        task = copy.deepcopy(old)
        task.update(original_report=row['report'], original_report_sha256=row['report_sha256'],
                    original_manifest=str(original_manifest_path), original_manifest_sha256=sha(original_manifest_path),
                    original_goal=str(goal), original_goal_sha256=sha(goal),
                    certificate_manifest=prepared['manifest'], certificate_manifest_sha256=prepared['manifest_sha256'],
                    certificate_dir=str(cert), abi_context=context, strong_template=template)
        resource_path = Path(row['measured_command'][row['measured_command'].index('-o') + 1])
        task['native_source'] = {
            'native_result': str(args.native_results.resolve()), 'native_result_sha256': sha(args.native_results),
            'native_row_index': native_index, 'original_native_result': old_tasks['native_result'],
            'original_native_result_sha256': old_tasks['native_result_sha256'], 'original_native_row_index': old['native_row_index'],
            'original_task': copy.deepcopy(old), 'original_task_sha256': hash_json(old),
            'new_certificate_manifest': prepared['manifest'], 'new_certificate_manifest_sha256': prepared['manifest_sha256'],
            'native_resources': {'path': str(resource_path), 'sha256': sha(resource_path)},
        }
        validated_row, audit = validate_native_source(task, old_tasks['native_result'], old_tasks['native_result_sha256'])
        require(validated_row == row, 'Shared recovery audit returned a different execution')
        binding_path = cert / 'binding.json'
        save(binding_path, task)
        task['native_recovery_binding'] = {'path': str(binding_path), 'sha256': sha(binding_path)}
        tasks['tasks'][index] = task
        audits.append({'execution_index': index, 'audit': audit, 'binding': task['native_recovery_binding'],
                       'new_certificate_manifest_sha256': prepared['manifest_sha256']})
    require(sha(args.tasks) == original_tasks_sha, 'Original task inventory changed during preparation')
    overrides = {'schema': 'tespec-singleton-task-overrides/v1',
                 'original_tasks_sha256': original_tasks_sha,
                 'baseline_native_results_sha256': old_tasks['native_result_sha256'],
                 'overrides': [tasks['tasks'][i] for i in sorted(indexes)]}
    save(args.output, overrides)
    setup = {'schema': 'tespec-native-recovery-setup/v1', 'scope': 'One-time recovery preparation, excluded from per-execution ITP mean',
             'wall_seconds': time.monotonic() - started, 'tokens': 0, 'model_calls': 0, 'Coq_calls': 0,
             'original_tasks_sha256': original_tasks_sha, 'tasks_override': str(args.output.resolve()),
             'tasks_override_sha256': sha(args.output), 'native_results_sha256': sha(args.native_results),
             'certificate_root': str(certificate_root), 'audits': audits,
             'process_peak_rss_source': 'External GNU time resource file; record separately with this setup receipt.'}
    save(args.setup_receipt, setup)
    print(json.dumps({'tasks_override': str(args.output.resolve()), 'sha256': sha(args.output),
                      'fresh_certificates': len(audits), 'setup_receipt': str(args.setup_receipt.resolve()),
                      'wall_seconds': setup['wall_seconds'], 'model_calls': 0, 'Coq_calls': 0}, indent=2))


if __name__ == '__main__':
    main()
