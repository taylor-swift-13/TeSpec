"""Serial, resumable controller for independent per-execution cell-leak ITP."""
from pathlib import Path
import sys,subprocess,json,time,hashlib
ROOT=Path('C:/Users/50635/Documents/Codex/2026-10-14/jin/work/incr-itp-per-execution');REPO='/home/yangfp/teSpec';METER=Path('C:/Users/50635/Documents/Codex/2026-10-14/jin/work/meter_itp_model_windows.py')
STATUS=ROOT/'controller-status.json'
def save(d):STATUS.write_text(json.dumps(d,indent=2)+'\n',encoding='utf8')
def wsl(*args):return ['wsl','-d','Ubuntu-22.04','-u','yangfp','--',*args]
def artifact(index,attempt):return f'{REPO}/benchmark/results/incr/20261016-itp-per-execution/execution-{index:02d}/attempt-{attempt}/coq-receipt.json'
def receipt(index,attempt):
 p=subprocess.run(wsl('cat',artifact(index,attempt)),capture_output=True,text=True,encoding='utf8')
 return json.loads(p.stdout) if p.returncode==0 else None
state={'group':'incr','started_utc':time.time(),'controller_pid':__import__('os').getpid(),'controller_source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'model_meter_sha256':hashlib.sha256(METER.read_bytes()).hexdigest(),'complete':[],'failed':[],'status':'RUNNING'}
# The first execution is validated by the interactive controller; continue remaining tasks only.
for index in range(13):
 task=ROOT/f'execution-{index:02d}';accepted=False
 for attempt in range(1,4):
  r=receipt(index,attempt)
  if r and r.get('status')=='KERNEL_CHECKED':accepted=True;break
  if r:continue
  state.update(current_execution=index,current_attempt=attempt);save(state)
  md=task/f'attempt-{attempt}'
  if not(md/'model-receipt.json').exists():
   p=subprocess.run([sys.executable,str(METER),'--task-dir',str(task),'--attempt',str(attempt)],capture_output=True,text=True,encoding='utf8',timeout=900)
   if p.returncode:state['failed'].append({'index':index,'attempt':attempt,'reason':'MODEL_CONTROLLER_FAILED','detail':p.stderr[-3000:]});break
  p=subprocess.run(wsl('python3',REPO+'/tools/benchmark/cell_leak_itp.py','compile','--group','incr','--task-root','/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/incr-itp-per-execution','--execution',str(index),'--attempt',str(attempt)),capture_output=True,text=True,encoding='utf8',timeout=900)
  (task/f'controller-attempt-{attempt}.log').write_text(p.stdout+p.stderr,encoding='utf8')
  r=receipt(index,attempt)
  if r and r.get('status')=='KERNEL_CHECKED':accepted=True;break
  diag=p.stdout+p.stderr
  prompt=task/'prompt.txt';text=prompt.read_text(encoding='utf8');text+='\nActual controller Coq diagnostic for this execution, attempt '+str(attempt)+':\n'+diag[-6000:]+'\nRepair Candidate.v only; preserve all statements, proof constraints and Print Assumptions.\n';prompt.write_bytes(text.encode('utf8'))
 if accepted:state['complete'].append(index)
 elif not any(r['index']==index for r in state['failed']):state['failed'].append({'index':index,'reason':'NO_KERNEL_CHECKED_CANDIDATE_WITHIN_3_ATTEMPTS'})
 save(state);print(json.dumps({'complete':state['complete'],'failed':state['failed']}),flush=True)
state['status']='DONE_PENDING_PUBLICATION' if not state['failed'] else 'PARTIAL_GAPS_PENDING_REVIEW';state['finished_utc']=time.time();save(state)
