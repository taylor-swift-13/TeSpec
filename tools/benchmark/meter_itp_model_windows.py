from pathlib import Path
import ctypes,ctypes.wintypes as wt,subprocess,os,time,json,threading,hashlib,shutil
import argparse
parser=argparse.ArgumentParser();parser.add_argument('--task-dir',type=Path,required=True);parser.add_argument('--attempt',type=int,default=1);args=parser.parse_args()
BASE=args.task_dir.resolve()
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
folder=BASE/('attempt-'+str(args.attempt));folder.mkdir(parents=True,exist_ok=True)
assert not (folder/'model-receipt.json').exists(),'Do not overwrite a metered attempt'
locked={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in BASE.glob('*.v') if p.name!='Candidate.v'}
prompt=(BASE/'prompt.txt').read_text(encoding='utf-8')
cmd=[exe,'exec','--json','--skip-git-repo-check','--ephemeral','--model','gpt-6.1-sol','--sandbox','workspace-write','-C',str(BASE),'-']
stdout=folder/'agent.stdout.jsonl';stderr=folder/'agent.stderr.log';start=time.monotonic();rss={'sampled_tree_peak_working_set_bytes':0,'max_process_peak_working_set_bytes':0,'sampling_interval_ms':20,'platform':'Windows Codex model client; remote service and GPU memory excluded'};stop=threading.Event()
with stdout.open('wb') as out,stderr.open('wb') as err:
 proc=subprocess.Popen(cmd,stdin=subprocess.PIPE,stdout=out,stderr=err,creationflags=subprocess.CREATE_NO_WINDOW)
 def monitor():
  while not stop.is_set():
   total,peak=sample(proc.pid);rss['sampled_tree_peak_working_set_bytes']=max(rss['sampled_tree_peak_working_set_bytes'],total);rss['max_process_peak_working_set_bytes']=max(rss['max_process_peak_working_set_bytes'],peak);stop.wait(.02)
 worker=threading.Thread(target=monitor,daemon=True);worker.start()
 try:proc.communicate(prompt.encode('utf-8'),timeout=600);code=proc.returncode
 except subprocess.TimeoutExpired:
  subprocess.run(['taskkill','/PID',str(proc.pid),'/T','/F'],capture_output=True);proc.wait();code='TIMEOUT'
 stop.set();worker.join(timeout=5)
usage=[];events=[];errors=[]
for line in stdout.read_text(encoding='utf-8',errors='replace').splitlines():
 try:event=json.loads(line)
 except ValueError:continue
 if event.get('type')=='turn.completed' and isinstance(event.get('usage'),dict):usage.append(event['usage']);events.append(event)
 if event.get('type') in ['error','turn.failed']:errors.append(event)
assert all(hashlib.sha256((BASE/name).read_bytes()).hexdigest()==h for name,h in locked.items()),'Model changed immutable proof inputs'
candidate=BASE/'Candidate.v';shutil.copyfile(candidate,folder/'Candidate.v')
receipt={'schema':'tespec-metered-itp-model/v1','requested_model':'gpt-6.1-sol','attempt':args.attempt,'command':cmd,'exit_code':code,'wall_seconds':time.monotonic()-start,'resources':rss,'token_usage':usage or None,'token_usage_source':'Actual CLI turn.completed events; no estimates','errors':errors,'locked_goal_and_helper_sha256':locked,'prompt_sha256':hashlib.sha256(prompt.encode()).hexdigest(),'candidate_sha256':hashlib.sha256(candidate.read_bytes()).hexdigest(),'raw_event_log_sha256':hashlib.sha256(stdout.read_bytes()).hexdigest(),'status':'GENERATED_PENDING_COQ' if code==0 else 'MODEL_EXECUTION_FAILED'}
(folder/'model-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
(folder/'usage-events.json').write_text(json.dumps(events,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'exit_code':code,'wall_seconds':receipt['wall_seconds'],'resources':rss,'token_usage':usage,'errors':errors}),flush=True)
