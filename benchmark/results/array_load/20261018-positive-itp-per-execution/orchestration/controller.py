from pathlib import Path
import hashlib, json, subprocess, sys, time

BASE = Path(__file__).resolve().parent
REPO = '/home/yangfp/teSpec'
TASK_ROOT = '/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/array-load-positive-itp'
ARTIFACT = Path(r'\\wsl.localhost\Ubuntu-22.04\home\yangfp\teSpec\benchmark\results\array_load\20261018-positive-itp-per-execution')
state = {'schema': 'array-load-itp-controller/v1', 'complete': [], 'failed': [], 'status': 'RUNNING'}

def save():
    (BASE/'controller-status.json').write_text(json.dumps(state, indent=2)+'\n', encoding='utf-8')

def invoke(command, task, label):
    folder = task/'controller-invocations'/(label+'-'+str(time.time_ns()))
    folder.mkdir(parents=True)
    started = time.monotonic()
    result = subprocess.run(command, capture_output=True, timeout=900)
    (folder/'stdout.log').write_bytes(result.stdout)
    (folder/'stderr.log').write_bytes(result.stderr)
    (folder/'receipt.json').write_text(json.dumps({'command': command, 'exit_code': result.returncode, 'wall_seconds': time.monotonic()-started, 'scope': 'Orchestration only; stage cost measured separately.'}, indent=2)+'\n', encoding='utf-8')
    return result.returncode, (result.stdout+result.stderr).decode('utf-8', errors='replace')

save()
for index in range(4):
    task = BASE/f'execution-{index:02d}'
    accepted = False
    for attempt in range(1, 4):
        state.update(current_execution=index, current_attempt=attempt)
        save()
        receipt_path = ARTIFACT/f'execution-{index:02d}'/f'attempt-{attempt}'/'coq-receipt.json'
        if receipt_path.exists():
            receipt = json.loads(receipt_path.read_text())
            if receipt['status'] == 'KERNEL_CHECKED':
                accepted = True
                break
            if receipt['status'] == 'COMPILING':
                raise RuntimeError('Existing compilation needs process review; do not duplicate')
            continue
        if not (task/f'attempt-{attempt}'/'model-receipt.json').exists():
            code, diagnostic = invoke([sys.executable, str(BASE/'meter_itp_model_windows.py'), '--task-dir', str(task), '--attempt', str(attempt)], task, f'model-{attempt}')
            if code:
                state['failed'].append({'index': index, 'attempt': attempt, 'reason': 'MODEL_FAILED', 'detail': diagnostic[-2500:]})
                break
        command = ['wsl.exe', '-d', 'Ubuntu-22.04', '-u', 'yangfp', '--cd', REPO, '--', 'python3', 'tools/benchmark/positive_execution_itp.py', 'compile', '--group', 'array_load', '--task-root', TASK_ROOT, '--execution', str(index), '--attempt', str(attempt), '--itp-run-id', '20261018-positive-itp-per-execution']
        code, diagnostic = invoke(command, task, f'coq-{attempt}')
        receipt = json.loads(receipt_path.read_text()) if receipt_path.exists() else {}
        print(index, attempt, receipt.get('status', 'NO_RECEIPT'), flush=True)
        if receipt.get('status') == 'KERNEL_CHECKED':
            accepted = True
            break
        if not receipt or receipt.get('status') == 'COMPILING':
            state['status'] = 'NEEDS_PROCESS_REVIEW'
            save()
            raise RuntimeError(diagnostic[-2500:])
        prompt = task/'prompt.txt'
        prompt.write_text(prompt.read_text(encoding='utf-8')+'\nActual Coq/controller diagnostic from attempt '+str(attempt)+':\n'+diagnostic[-9000:]+'\nRepair Candidate.v only. Preserve all original theorem statements and audits.\n', encoding='utf-8')
    if accepted:
        state['complete'].append(index)
    elif not any(x['index'] == index for x in state['failed']):
        state['failed'].append({'index': index, 'reason': 'NOT_CHECKED_WITHIN_THREE_ATTEMPTS'})
    save()
state['status'] = 'DONE' if not state['failed'] else 'GAPS'
save()
print(json.dumps(state), flush=True)
