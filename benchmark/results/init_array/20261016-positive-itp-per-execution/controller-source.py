from pathlib import Path
import subprocess,sys,json,time,datetime,base64,shutil
GROUP='init_array';ROOT=Path(__file__).resolve().parent/'init-array-positive-itp';REPO='/home/yangfp/teSpec';METER=Path(r'\\wsl.localhost\Ubuntu-22.04\home\yangfp\teSpec\tools\benchmark\meter_itp_model_windows.py');DEADLINE=datetime.datetime(2026,10,16,tzinfo=datetime.timezone.utc);STATE=ROOT/'controller.json';state={'group':GROUP,'scope':'One actual gpt-6.1-sol model task per finite execution; all its original residual VCs, per-attempt compile/audit/full kernel costs.','started_at':datetime.datetime.now(datetime.timezone.utc).isoformat(),'completed':[],'deferred':[],'current':None,'status':'RUNNING'}
def wsl(args,timeout=600):
 p=subprocess.run(['wsl','-d','Ubuntu-22.04','-u','yangfp','--',*map(str,args)],capture_output=True,text=True,encoding='utf-8',errors='replace',timeout=timeout,creationflags=subprocess.CREATE_NO_WINDOW);return p

def persist():
 STATE.write_text(json.dumps(state,indent=2)+'\n');blob=base64.b64encode(STATE.read_bytes()).decode();code="from pathlib import Path;import base64;p=Path('/home/yangfp/teSpec/benchmark/results/init_array/20261016-positive-itp-per-execution/controller.json');p.write_bytes(base64.b64decode('"+blob+"'))";q=wsl(['python3','-c',code]);q.check_returncode()

def compile_task(i,a):
 q=wsl(['python3',REPO+'/tools/benchmark/positive_execution_itp.py','compile','--group',GROUP,'--task-root','/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/init-array-positive-itp','--execution',i,'--attempt',a]);return q

def attach():
 for name in ['attach_positive_execution_itp','refresh_positive_execution_progress']:
  args=['python3',REPO+'/tools/benchmark/'+name+'.py','--group',GROUP]+(['--allow-partial'] if name.startswith('attach') else []);q=wsl(args);print(q.stdout,q.stderr,flush=True);q.check_returncode()

persist()
for i in range(1,24):
 if datetime.datetime.now(datetime.timezone.utc)>=DEADLINE:state['status']='DEADLINE_REACHED';break
 task=ROOT/f'execution-{i:02d}';state['current']={'execution':i,'stage':'PREPARING'};persist();success=False
 for attempt in [1,2]:
  if datetime.datetime.now(datetime.timezone.utc)>=DEADLINE:break
  state['current']={'execution':i,'attempt':attempt,'stage':'MODEL'};persist();receipt=task/f'attempt-{attempt}'/'model-receipt.json'
  if not receipt.exists():
   q=subprocess.run([sys.executable,str(METER),'--task-dir',str(task),'--attempt',str(attempt)],capture_output=True,text=True,encoding='utf-8',errors='replace',creationflags=subprocess.CREATE_NO_WINDOW);(task/f'controller-model-{attempt}.log').write_text(q.stdout+q.stderr,encoding='utf-8')
  state['current']['stage']='COMPILE_AUDIT_AND_KERNEL';persist();q=compile_task(i,attempt);(task/f'controller-compile-{attempt}.log').write_text(q.stdout+q.stderr,encoding='utf-8');print(i,attempt,q.returncode,q.stdout[-1500:],q.stderr[-1500:],flush=True)
  if q.returncode==0:success=True;state['completed'].append(i);persist();attach();break
  if attempt==1:
   prompt=task/'prompt.txt';prompt.write_text(prompt.read_text(encoding='utf-8')+'\nController diagnostic for actual failed attempt; repair Candidate.v only, preserving every original statement. No compiler/shell/model calls.\n'+q.stdout[-8000:]+q.stderr[-8000:],encoding='utf-8')
 if not success:state['deferred'].append(i);persist()
else:state['status']='QUEUE_FINISHED'
state['current']=None;state['finished_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();persist();attach();print(json.dumps(state),flush=True)
