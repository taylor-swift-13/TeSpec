#!/usr/bin/env python3
"""Freeze and remeasure three historical singleton checks without model calls.

--prepare only validates/copies hashed evidence. --run invokes the unchanged
production certificate checker in three fresh directories, serially. Original
missing observations remain unknown; these are new measurements, never verdict
upgrades or replacements for the historical costs.
"""
from __future__ import annotations
import argparse
import hashlib
import json
from pathlib import Path
import resource
import subprocess
import sys
import time

ROOT = Path('/home/yangfp/teSpec')
BASE = ROOT / 'benchmark/results/Dbl_Linked_List__singleton/evidence/itp'
WINDOWS = Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work')
CACHE = Path('/home/yangfp/.cache/tespec-benchmark')
sys.path.insert(0, str(ROOT))
import spectest.certificates as cert


def need(ok, message):
    if not ok:
        raise ValueError(message)


def sha(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def load(path):
    return json.loads(Path(path).read_text(encoding='utf8'))


def encoded(value):
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()


def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(path.name + '.new')
    temporary.write_bytes(encoded(value))
    temporary.replace(path)


def canonical_sha(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def ref(path):
    return {'path': str(path), 'sha256': sha(path)}


def resolve(reference):
    p = Path(reference['path'])
    p = p if p.is_absolute() else ROOT / p
    need(p.is_file() and sha(p) == reference['sha256'], 'Changed evidence: ' + str(p))
    return p


def reconstruct_legacy_manifest(execution, check, task, runtime_hash):
    entries = [(n, s) for n, s in cert.goal_interface(resolve(execution['goal']).read_text())
               if n in execution['selected_goals']]
    return {
        'schema': 'qcp-spectest-certificate/v1', 'scope': 'selected-original-vcs',
        'refuted_goal': None, 'selected_goals': sorted(execution['selected_goals']),
        'case_id': execution['case'], 'function': 'singleton',
        'target_layout': check['target_layout'],
        'original_manifest': task['controller_manifest'],
        'original_manifest_sha256': task['controller_manifest_sha256'],
        'original_goal_sha256': execution['original_goal_sha256'],
        'goals': [{'proof': n, 'statement': s} for n, s in entries],
        'immutable_sha256': {'Goal.v': execution['goal']['sha256'],
                            'Coverage.v': execution['proof_files']['Coverage.v']['sha256'],
                            'Assumptions.v': execution['proof_files']['Assumptions.v']['sha256']},
        'dependencies': [{'module': d['module'], 'file': 'dependencies/' + d['module'] + '.v',
                          'sha256': d['sha256']} for d in execution['dependencies']],
        'runtime': str(ROOT / 'runtime/qcip/SeparationLogic'), 'runtime_sha256': runtime_hash,
        'allowed_assumptions': sorted(cert.TRUSTED_ASSUMPTIONS), 'editable': 'Candidate.v',
    }


def prepare(run_root):
    need(not run_root.exists(), 'Preparation destination already exists')
    runtime = ROOT / 'runtime/qcip/SeparationLogic'
    runtime_hash = cert.tree_digest(runtime)
    legacy_path = BASE / 'legacy-context/execution-00.json'
    active_path = BASE / 'abi-context/execution-03.json'
    legacy, active = load(legacy_path), load(active_path)
    tasks_path = WINDOWS / 'singleton-itp-eeicppo7/tasks.json'
    task = load(tasks_path)['tasks'][0]
    plan = {'schema': 'tespec-singleton-resource-remeasurement-plan/v1',
            'profile': 'whole-check-remeasurement/v1', 'group': 'Dbl_Linked_List__singleton',
            'runtime': str(runtime), 'runtime_sha256': runtime_hash,
            'runner': ref(Path(__file__).resolve()), 'production_checker': ref(Path(cert.__file__)),
            'source_executions': [ref(legacy_path), ref(active_path)],
            'legacy_task_inventory': ref(tasks_path), 'model_calls': 0, 'tokens': 0,
            'verdict_authority': False, 'kernel_cache': None, 'jobs': []}
    # Validate every input before creating the output tree.
    prepared = []
    for context, attempt in [('legacy', 'attempt-2'), ('legacy', 'attempt-3'),
                             ('active', 'attempt-1-infrastructure-interruption')]:
        execution = legacy if context == 'legacy' else active
        original = next(c for c in execution['checks'] if c['attempt'] == attempt)
        command_check = original if context == 'legacy' else next(
            c for c in active['checks'] if c['attempt'] == 'attempt-1-replay-1')
        model = next(m for m in execution['model_attempts'] if m['attempt'] == original['model_attempt'])
        need(model['candidate_sha256'] == original['candidate_sha256'], 'Candidate/model binding differs')
        if context == 'legacy':
            candidate = WINDOWS / f'singleton-itp-eeicppo7/execution-00/attempt-{model["attempt"]}/Candidate.v'
            manifest = reconstruct_legacy_manifest(execution, original, task, runtime_hash)
            manifest_bytes = (json.dumps(manifest, indent=2) + '\n').encode()
            manifest_hash = original['manifest_sha256']
            model_receipt = candidate.parent / 'model-receipt.json'
            need(sha(model_receipt) == model['source_receipt_sha256'], 'Original model receipt changed')
        else:
            candidate = resolve(active['candidate'])
            manifest_path = resolve(active['certificate_manifest'])
            manifest_bytes = manifest_path.read_bytes()
            manifest = json.loads(manifest_bytes)
            manifest_hash = active['certificate_manifest']['sha256']
        need(hashlib.sha256(manifest_bytes).hexdigest() == manifest_hash, 'Original manifest not reconstructed exactly')
        need(manifest['runtime_sha256'] == runtime_hash, 'Original runtime differs from current source/compiled runtime')
        need(sha(candidate) == model['candidate_sha256'], 'Original Candidate changed')
        cert.check_candidate_commands(candidate.read_text())
        file_refs = {'Goal.v': execution['goal'], 'Candidate.v': ref(candidate), **execution['proof_files']}
        for dep in execution['dependencies']:
            file_refs['dependencies/' + dep['module'] + '.v'] = dep
        for name, reference in file_refs.items():
            resolve(reference)
            if name in manifest['immutable_sha256']:
                need(reference['sha256'] == manifest['immutable_sha256'][name], 'Immutable source mismatch')
        stages = command_check['stages']
        need(stages[-1]['stage'] == 'kernel_replay', 'Expected full original check inventory')
        old_work = next(s['command'][-1][:-len('/Goal.v')] for s in stages if s['stage'] == 'compile_Goal.v')
        kernel = stages[-1]['command']
        need(kernel[-1] == 'Coverage' and '-norec' not in kernel and '-admit' not in kernel, 'Kernel closure is not full')
        need(('-silent' in kernel) == (context == 'active'), 'Original kernel verbosity changed')
        name = f'{context}-execution-{execution["execution_index"]:02d}-attempt-{model["attempt"]}'
        job = {'id': name, 'proof_context': context, 'execution_index': execution['execution_index'],
               'source_execution': ref(legacy_path if context == 'legacy' else active_path),
               'original_check_attempt': attempt, 'original_check_sha256': canonical_sha(original),
               'original_controller_receipt_sha256': original['controller_receipt_sha256'],
               'source_model_receipt_sha256': model['source_receipt_sha256'],
               'original_candidate_sha256': model['candidate_sha256'],
               'certificate_manifest_sha256': manifest_hash,
               'original_goal_sha256': execution['original_goal_sha256'],
               'command_source_attempt': command_check['attempt'],
               'command_source_check_sha256': canonical_sha(command_check),
               'command_source_note': 'Exact original recorded commands' if context == 'legacy' else
                   'Interrupted commands were not preserved; use the separately recorded exact-Candidate replay commands, disclosed as the command source.',
               'original_work_dir': old_work, 'files': file_refs,
               'original_commands': [{'stage': s['stage'], 'command': s['command']} for s in stages],
               'kernel_timeout_seconds': 300 if context == 'legacy' else 1800,
               'compile_timeout_seconds': 90, 'version_timeout_seconds': 15,
               'kernel_silent': context == 'active', 'model_calls': 0, 'tokens': 0,
               'verdict_authority': False, 'scope': 'New resource measurement only; historical missing values and proof context are unchanged.'}
        # Derive the production commands without executing them. This catches
        # any changed load-path convention before a measured replay starts.
        future_work = run_root / name / 'check'
        paths = cert._coq_load_path_args(runtime, future_work, future_work / 'dependencies')
        prefix = ['opam', 'exec', '--switch=qcp-8.20', '--']
        for stage in job['original_commands']:
            label = stage['stage']
            if label == 'version':
                expected = prefix + ['coqc', '--version']
            elif label == 'kernel_replay':
                expected = prefix + ['coqchk', *(['-silent'] if job['kernel_silent'] else []), *paths, 'Coverage']
            else:
                unit = ('AssumptionIdentities.v' if label == 'assumption_identities' else
                        label[len('compile_'):].replace('dependencies_', 'dependencies/', 1))
                need(unit in file_refs, 'Original compile source missing: ' + unit)
                expected = prefix + ['coqc', *paths, str(future_work / unit)]
            relocated = [arg.replace(old_work, str(future_work)) for arg in stage['command']]
            need(expected == relocated, 'Original command differs from production derivation: ' + label)
        prepared.append((job, manifest_bytes))
    run_root.mkdir(parents=True)
    for job, manifest_bytes in prepared:
        inputs = run_root / job['id'] / 'inputs'
        inputs.mkdir(parents=True)
        for name, reference in job['files'].items():
            target = inputs / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(resolve(reference).read_bytes())
            need(sha(target) == reference['sha256'], 'Frozen input copy mismatch')
        (inputs / 'manifest.json').write_bytes(manifest_bytes)
        job['input_dir'] = str(inputs)
        job['receipt'] = str(run_root / job['id'] / 'receipt.json')
        plan['jobs'].append(job)
    save(run_root / 'plan.json', plan)
    print(json.dumps({'prepared': str(run_root / 'plan.json'), 'sha256': sha(run_root / 'plan.json'),
                      'jobs': 3, 'Coq_calls': 0, 'model_calls': 0, 'runtime_sha256': runtime_hash}), flush=True)


def aggregate(stages):
    complete = bool(stages) and all(s.get('resources') is not None for s in stages)
    return {'wall_seconds': sum(s['wall_seconds'] for s in stages) if stages else None,
            'peak_process_rss_kib': max(s['resources']['max_process_rss_kib'] for s in stages) if complete else None,
            'subprocesses': len(stages), 'resources_complete': complete, 'tokens': 0}


def run_job(plan, job, plan_path):
    receipt_path = Path(job['receipt'])
    work = receipt_path.parent / 'check'
    need(not receipt_path.exists() and not work.exists(), 'Do not overwrite or automatically resume a measured check')
    for name, reference in job['files'].items():
        need(sha(Path(job['input_dir']) / name) == reference['sha256'], 'Frozen source changed')
    need(sha(Path(job['input_dir']) / 'manifest.json') == job['certificate_manifest_sha256'], 'Frozen manifest changed')
    work.mkdir()
    for source in Path(job['input_dir']).rglob('*'):
        if source.is_file():
            target = work / source.relative_to(job['input_dir'])
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(source.read_bytes())
    receipt = {'schema': 'tespec-singleton-resource-remeasurement/v1', 'profile': plan['profile'],
               **job, 'plan': ref(plan_path), 'status': 'RUNNING', 'model_calls': 0, 'tokens': 0,
               'production_checker': plan['production_checker'], 'runner': plan['runner'],
               'runtime_sha256': plan['runtime_sha256'], 'verdict_authority': False,
               'address_space_limit_bytes': resource.getrlimit(resource.RLIMIT_AS)[0],
               'kernel_cache': None, 'stages': [], 'executed_wrappers': []}
    started = time.monotonic()
    original_subprocess = cert.subprocess
    wrappers = receipt['executed_wrappers']
    try:
        class MeteredSubprocess:
            def __getattr__(self, name):
                return getattr(original_subprocess, name)

            def Popen(self, measured, *positional, **keywords):
                need(measured[:2] == ['/usr/bin/time', '--quiet'], 'Unexpected production meter command')
                split = measured.index('-o') + 2
                production_command = list(measured[split:])
                index = len(wrappers)
                need(index < len(job['original_commands']), 'Unexpected extra production stage')
                source = job['original_commands'][index]
                expected = [arg.replace(job['original_work_dir'], str(work)) for arg in source['command']]
                actual = list(production_command)
                if 'coqchk' in actual and job['kernel_silent']:
                    actual.insert(actual.index('coqchk') + 1, '-silent')
                need(actual == expected, 'Production command differs beyond disclosed workdir relocation: ' + source['stage'])
                timeout = job['kernel_timeout_seconds'] if source['stage'] == 'kernel_replay' else (
                    job['version_timeout_seconds'] if source['stage'] == 'version' else job['compile_timeout_seconds'])
                envelope = list(measured[:split])
                envelope[envelope.index('-f') + 1] = '{"elapsed_seconds":%e,"user_seconds":%U,"system_seconds":%S,"max_process_rss_kib":%M}'
                envelope += ['/usr/bin/timeout', '--signal=TERM', '--kill-after=5', str(timeout), *actual]
                wrappers.append({'stage': source['stage'], 'original_command': source['command'],
                                 'production_command': production_command, 'actual_command': actual,
                                 'executed_wrapper_command': envelope, 'resource_file': measured[split - 1],
                                 'timeout_seconds': timeout, 'outer_timeout_seconds': job['kernel_timeout_seconds'] + 30,
                                 'transform': 'Only workdir relocation and an outer GNU time/inner TERM+5s KILL timeout envelope; original kernel verbosity and full dependency closure preserved.'})
                save(work / 'measurement-commands.json', wrappers)
                return original_subprocess.Popen(envelope, *positional, **keywords)

        cert.subprocess = MeteredSubprocess()
        checked = cert.check_certificate(work / 'manifest.json', job['certificate_manifest_sha256'],
                                         timeout=job['kernel_timeout_seconds'] + 30, kernel_cache=None)
        receipt['certificate_result'] = checked
        receipt['certificate_report'] = ref(work / 'certificate-report.json')
        need(len(checked['stages']) == len(wrappers), 'Wrapper/stage count mismatch')
        for stage, wrapper in zip(checked['stages'], wrappers):
            need(stage['stage'] == wrapper['stage'], 'Stage inventory changed')
            record = {**stage, 'production_command': stage['command'], 'command': wrapper['actual_command'],
                      'original_command': wrapper['original_command'],
                      'executed_wrapper_command': wrapper['executed_wrapper_command'],
                      'timeout_seconds': wrapper['timeout_seconds'], 'log_sha256': sha(Path(stage['log']))}
            metrics = Path(wrapper['resource_file'])
            record['resource_file'] = str(metrics)
            record['resource_sha256'] = sha(metrics) if metrics.is_file() else None
            record['timed_out'] = stage['exit_code'] in {'TIMEOUT', 124, 137}
            receipt['stages'].append(record)
        receipt['compilation_and_assumption_audit'] = aggregate([s for s in receipt['stages'] if s['stage'] != 'kernel_replay'])
        receipt['independent_kernel_check'] = aggregate([s for s in receipt['stages'] if s['stage'] == 'kernel_replay'])
        receipt['whole_check'] = aggregate(receipt['stages'])
        receipt['status'] = 'KERNEL_CHECKED' if checked['status'] == 'PASS' else 'UNKNOWN'
        receipt['reason'] = checked['reason']
        need(cert.tree_digest(Path(plan['runtime'])) == plan['runtime_sha256'], 'Runtime changed during rerun')
        for name, reference in job['files'].items():
            need(sha(work / name) == reference['sha256'], 'Frozen input changed during check: ' + name)
    except Exception as error:
        receipt['status'] = 'ERROR'
        receipt['error'] = type(error).__name__ + ': ' + str(error)
        # Production stage files remain intact even if its outer controller fails.
    finally:
        cert.subprocess = original_subprocess
        receipt['controller_wall_seconds'] = time.monotonic() - started
        save(receipt_path, receipt)
    print(json.dumps({'job': job['id'], 'status': receipt['status'], 'receipt': str(receipt_path),
                      'sha256': sha(receipt_path), 'tokens': 0, 'model_calls': 0}), flush=True)
    return receipt


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--prepare', action='store_true')
    mode.add_argument('--run', action='store_true')
    parser.add_argument('--run-root', required=True, type=Path)
    parser.add_argument('--plan-sha256')
    args = parser.parse_args()
    run_root = args.run_root.resolve()
    need(run_root.is_relative_to(CACHE) and run_root != CACHE, 'Run root must be a child of the durable benchmark cache')
    if args.prepare:
        prepare(run_root)
        return 0
    plan_path = run_root / 'plan.json'
    need(args.plan_sha256 and sha(plan_path) == args.plan_sha256, 'Pinned preparation plan differs')
    plan = load(plan_path)
    resolve(plan['runner']); resolve(plan['production_checker'])
    need(sha(Path(__file__).resolve()) == plan['runner']['sha256'], 'Runner differs from prepared version')
    for reference in plan['source_executions']:
        resolve(reference)
    need(cert.tree_digest(Path(plan['runtime'])) == plan['runtime_sha256'], 'Prepared runtime changed')
    need(not (run_root / 'started.json').exists(), 'This run already started; do not repeat measured checks')
    save(run_root / 'started.json', {'plan_sha256': args.plan_sha256, 'model_calls': 0, 'tokens': 0})
    results = []
    for job in plan['jobs']:
        result = run_job(plan, job, plan_path)
        results.append(ref(Path(job['receipt'])))
        if result['status'] == 'ERROR':
            break
    save(run_root / 'results.json', {'schema': 'tespec-singleton-resource-remeasurement-index/v1',
         'profile': plan['profile'], 'plan': ref(plan_path), 'checks': results,
         'requested_checks': 3, 'closed_checks': len(results), 'model_calls': 0, 'tokens': 0,
         'verdict_authority': False, 'historical_missing_observations_replaced': False})
    return 0 if len(results) == 3 and all(load(resolve(r))['status'] != 'ERROR' for r in results) else 1


if __name__ == '__main__':
    raise SystemExit(main())
