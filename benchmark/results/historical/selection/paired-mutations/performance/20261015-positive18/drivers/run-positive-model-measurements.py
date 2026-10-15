from pathlib import Path
import ctypes,ctypes.wintypes as wt,subprocess,os,time,json,threading,hashlib,shutil
BASE=Path(__file__).resolve().parent/'positive-model-runs'
kernel=ctypes.WinDLL('kernel32',use_last_error=True);psapi=ctypes.WinDLL('psapi',use_last_error=True)
class PE(ctypes.Structure):
 _fields_=[('dwSize',wt.DWORD),('cntUsage',wt.DWORD),('th32ProcessID',wt.DWORD),('th32DefaultHeapID',ctypes.c_size_t),('th32ModuleID',wt.DWORD),('cntThreads',wt.DWORD),('th32ParentProcessID',wt.DWORD),('pcPriClassBase',wt.LONG),('dwFlags',wt.DWORD),('szExeFile',wt.WCHAR*260)]
class PMC(ctypes.Structure):
 _fields_=[('cb',wt.DWORD),('PageFaultCount',wt.DWORD),('PeakWorkingSetSize',ctypes.c_size_t),('WorkingSetSize',ctypes.c_size_t),('QuotaPeakPagedPoolUsage',ctypes.c_size_t),('QuotaPagedPoolUsage',ctypes.c_size_t),('QuotaPeakNonPagedPoolUsage',ctypes.c_size_t),('QuotaNonPagedPoolUsage',ctypes.c_size_t),('PagefileUsage',ctypes.c_size_t),('PeakPagefileUsage',ctypes.c_size_t)]
kernel.CreateToolhelp32Snapshot.restype=wt.HANDLE;kernel.OpenProcess.restype=wt.HANDLE
kernel.CreateToolhelp32Snapshot.argtypes=[wt.DWORD,wt.DWORD]
kernel.Process32FirstW.argtypes=[wt.HANDLE,ctypes.POINTER(PE)]
kernel.Process32NextW.argtypes=[wt.HANDLE,ctypes.POINTER(PE)]
kernel.OpenProcess.argtypes=[wt.DWORD,wt.BOOL,wt.DWORD]
kernel.CloseHandle.argtypes=[wt.HANDLE];psapi.GetProcessMemoryInfo.argtypes=[wt.HANDLE,ctypes.POINTER(PMC),wt.DWORD]
def sample(pid):
 snapshot=kernel.CreateToolhelp32Snapshot(2,0);pe=PE();pe.dwSize=ctypes.sizeof(pe);pairs={}
 if kernel.Process32FirstW(snapshot,ctypes.byref(pe)):
  while True:
   pairs[pe.th32ProcessID]=pe.th32ParentProcessID
   if not kernel.Process32NextW(snapshot,ctypes.byref(pe)):break
 kernel.CloseHandle(snapshot);selected={pid}
 for _ in range(10):
  more={p for p,parent in pairs.items() if parent in selected};old=len(selected);selected|=more
  if len(selected)==old:break
 total=peak=0
 for p in selected:
  handle=kernel.OpenProcess(0x410,False,p)
  if not handle:continue
  pmc=PMC();pmc.cb=ctypes.sizeof(pmc)
  if psapi.GetProcessMemoryInfo(handle,ctypes.byref(pmc),pmc.cb):total+=pmc.WorkingSetSize;peak=max(peak,pmc.PeakWorkingSetSize)
  kernel.CloseHandle(handle)
 return total,peak
exe=shutil.which('codex.exe');assert exe
for ident in ['slf0_basic_incr','slf0_incr.broken','slf1_basic_example_let','slf2_basic_quadruple']:
 d=BASE/ident;candidate=d/'Candidate.v';text=candidate.read_text().replace('Require Import qcp_proof_auto.\n','');candidate.write_text(text)
 prompt=(d/'prompt.txt').read_text().replace('Require Import qcp_proof_auto.\n','');(d/'prompt.txt').write_text(prompt)
 cmd=[exe,'exec','--json','--skip-git-repo-check','--ephemeral','--model','gpt-6.1-sol','--sandbox','workspace-write','-C',str(d),'-']
 stdout=d/'agent.stdout.jsonl';stderr=d/'agent.stderr.log';start=time.monotonic();rss={'sampled_tree_peak_working_set_bytes':0,'max_process_peak_working_set_bytes':0,'sampling_interval_ms':20,'platform':'Windows model client; excludes remote service/GPU memory'};stop=threading.Event()
 with stdout.open('wb') as out,stderr.open('wb') as err:
  proc=subprocess.Popen(cmd,stdin=subprocess.PIPE,stdout=out,stderr=err,creationflags=subprocess.CREATE_NO_WINDOW)
  def monitor():
   while not stop.is_set():
    total,peak=sample(proc.pid);rss['sampled_tree_peak_working_set_bytes']=max(rss['sampled_tree_peak_working_set_bytes'],total);rss['max_process_peak_working_set_bytes']=max(rss['max_process_peak_working_set_bytes'],peak);stop.wait(.02)
  worker=threading.Thread(target=monitor,daemon=True);worker.start()
  try:proc.communicate(prompt.encode(),timeout=600);code=proc.returncode
  except subprocess.TimeoutExpired:subprocess.run(['taskkill','/PID',str(proc.pid),'/T','/F'],capture_output=True);proc.wait();code='TIMEOUT'
  stop.set();worker.join(timeout=5)
 usage=[];errors=[]
 for line in stdout.read_text(encoding='utf-8',errors='replace').splitlines():
  try:event=json.loads(line)
  except ValueError:continue
  if event.get('type')=='turn.completed' and isinstance(event.get('usage'),dict):usage.append(event['usage'])
  if event.get('type') in ['error','turn.failed']:errors.append(event)
 receipt={'source':ident,'requested_model':'gpt-6.1-sol','command':cmd,'exit_code':code,'wall_seconds':time.monotonic()-start,'resources':rss,'token_usage':usage or None,'token_usage_source':'CLI turn.completed events; never estimated','errors':errors,'goal_sha256':hashlib.sha256((d/'CaseGoal.v').read_bytes()).hexdigest(),'candidate_sha256':hashlib.sha256(candidate.read_bytes()).hexdigest(),'status':'GENERATED_NOT_YET_COMPILED' if code==0 else 'MODEL_EXECUTION_FAILED'}
 if (d/'attempt-1/model-receipt.json').exists():
  receipt['previous_attempts']=[json.loads((d/'attempt-1/model-receipt.json').read_text())]
  receipt['attempt_number']=2
 (d/'model-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
 print(ident,'exit',code,'seconds',round(receipt['wall_seconds'],2),'usage',usage,'errors',str(errors)[:300],flush=True)
 if code!=0:break
