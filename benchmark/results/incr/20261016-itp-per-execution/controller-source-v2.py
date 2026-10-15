"""Serial resumable ITP controller: preserve binary transport logs and stop at deadline."""
from pathlib import Path
import sys,subprocess,json,time,hashlib,os,datetime,shutil
ROOT=Path('C:/Users/50635/Documents/Codex/2026-10-14/jin/work/incr-itp-per-execution');REPO='/home/yangfp/teSpec';METER=Path('C:/Users/50635/Documents/Codex/2026-10-14/jin/work/meter_itp_model_windows.py')
ARTIFACT=Path(r'\\wsl.localhost\Ubuntu-22.04\home\yangfp\teSpec\benchmark\results\incr\20261016-itp-per-execution')
DEADLINE=datetime.datetime(2026,10,16,tzinfo=datetime.timezone.utc).timestamp();STATUS=ROOT/'controller-status.json'
state={'group':'incr','started_utc':time.time(),'controller_pid':os.getpid(),'controller_source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'model_meter_sha256':hashlib.sha256(METER.read_bytes()).hexdigest(),'complete':[],'failed':[],'status':'RUNNING','resumed_after':'Original controller UTF-8 text reader failure; completed proofs and model receipts are reused exactly.'}
def save():STATUS.write_bytes((json.dumps(state,indent=2)+'\n').encode('utf8'))
def decode(raw):
 if raw.startswith((b'\xff\xfe',b'\xfe\xff')):return raw.decode('utf16',errors='replace')
 if b'\x00' in raw[:200]:return raw.decode('utf-16-le',errors='replace')
 return raw.decode('utf8',errors='replace')
def wsl(*args):return ['wsl','-d','Ubuntu-22.04','-u','yangfp','--',*args]
def receipt(index,attempt):
 p=ARTIFACT/f'execution-{index:02d}'/f'attempt-{attempt}'/'coq-receipt.json'
 return json.loads(p.read_text(encoding='utf8')) if p.exists() else None

def invoke(command,task,label):
 if time.time()>=DEADLINE:state['status']='DEADLINE_REACHED';save();raise SystemExit(0)
 folder=task/'controller-invocations'/(label+'-'+str(time.time_ns()));folder.mkdir(parents=True)
 started=time.monotonic();limit=max(1,min(900,DEADLINE-time.time()))
 try:p=subprocess.run(command,capture_output=True,timeout=limit)
 except subprocess.TimeoutExpired as e:
  (folder/'stdout.raw.log').write_bytes(e.stdout or b'');(folder/'stderr.raw.log').write_bytes(e.stderr or b'');state['status']='TRANSPORT_TIMEOUT_NEEDS_PROCESS_REVIEW';state['timeout_log']=str(folder);save();raise SystemExit(1)
 (folder/'stdout.raw.log').write_bytes(p.stdout);(folder/'stderr.raw.log').write_bytes(p.stderr)
 text=decode(p.stdout)+decode(p.stderr);(folder/'decoded.log').write_bytes(text.encode('utf8'))
 (folder/'receipt.json').write_bytes((json.dumps({'command':command,'exit_code':p.returncode,'wall_seconds':time.monotonic()-started,'scope':'Controller transport/orchestration measurement; Coq process execution time/RSS is measured independently inside WSL. Not an extra model call.','stdout_sha256':hashlib.sha256(p.stdout).hexdigest(),'stderr_sha256':hashlib.sha256(p.stderr).hexdigest()},indent=2)+'\n').encode('utf8'))
 return p.returncode,text

save()
for index in range(13):
 task=ROOT/f'execution-{index:02d}';accepted=False
 for attempt in range(1,4):
  if time.time()>=DEADLINE:state['status']='DEADLINE_REACHED';save();raise SystemExit(0)
  r=receipt(index,attempt)
  if r and r.get('status')=='KERNEL_CHECKED':accepted=True;break
  if r and r.get('status')=='COMPILING':state['status']='INCOMPLETE_COMPILE_RECEIPT_NEEDS_PROCESS_REVIEW';state.update(current_execution=index,current_attempt=attempt);save();raise SystemExit(1)
  if r:continue
  state.update(current_execution=index,current_attempt=attempt);save();md=task/f'attempt-{attempt}'
  if not(md/'model-receipt.json').exists():
   code,diag=invoke([sys.executable,str(METER),'--task-dir',str(task),'--attempt',str(attempt)],task,'model-'+str(attempt))
   if code:state['failed'].append({'index':index,'attempt':attempt,'reason':'MODEL_CONTROLLER_FAILED','detail':diag[-3000:]});break
  # A completed model is reused after a failed WSL transport: never request it again.
  for transport in range(3):
   code,diag=invoke(wsl('python3',REPO+'/tools/benchmark/cell_leak_itp.py','compile','--group','incr','--task-root','/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/incr-itp-per-execution','--execution',str(index),'--attempt',str(attempt)),task,'coq-'+str(attempt)+'-transport-'+str(transport))
   r=receipt(index,attempt)
   if r:break
   if transport==2:state['status']='WSL_TRANSPORT_FAILED_NEEDS_REVIEW';state['transport_diagnostic']=diag[-3000:];save();raise SystemExit(1)
  if r and r.get('status')=='KERNEL_CHECKED':accepted=True;break
  if r and r.get('status')=='COMPILING':state['status']='INCOMPLETE_COMPILE_RECEIPT_NEEDS_PROCESS_REVIEW';save();raise SystemExit(1)
  prompt=task/'prompt.txt';text=prompt.read_text(encoding='utf8');text+='\nActual controller Coq diagnostic for this execution, attempt '+str(attempt)+':\n'+diag[-6000:]+'\nRepair Candidate.v only; preserve all statements, proof constraints and Print Assumptions.\n';prompt.write_bytes(text.encode('utf8'))
 if accepted:state['complete'].append(index)
 elif not any(r['index']==index for r in state['failed']):state['failed'].append({'index':index,'reason':'NO_KERNEL_CHECKED_CANDIDATE_WITHIN_3_ATTEMPTS'})
 save();print(json.dumps({'complete':state['complete'],'failed':state['failed']}),flush=True)
state['status']='DONE_PENDING_PUBLICATION' if not state['failed'] else 'PARTIAL_GAPS_PENDING_REVIEW';state['finished_utc']=time.time();save()
