from pathlib import Path
import ctypes,ctypes.wintypes as wt,datetime,json,subprocess,time
ROOT=Path(__file__).resolve().parent/'init-array-positive-itp';state=ROOT/'deadline-watchdog.json';deadline=datetime.datetime(2026,10,16,tzinfo=datetime.timezone.utc);pid=19472
k=ctypes.WinDLL('kernel32',use_last_error=True);k.OpenProcess.argtypes=[wt.DWORD,wt.BOOL,wt.DWORD];k.OpenProcess.restype=wt.HANDLE;k.WaitForSingleObject.argtypes=[wt.HANDLE,wt.DWORD];k.CloseHandle.argtypes=[wt.HANDLE]
def save(value):state.write_text(json.dumps(value,indent=2)+'\n',encoding='utf-8')
handle=k.OpenProcess(0x100000,False,pid)
if not handle:save({'status':'CONTROLLER_ALREADY_EXITED','pid':pid});raise SystemExit(0)
save({'status':'WAITING','pid':pid,'deadline_utc':deadline.isoformat(),'scope':'Only this benchmark controller and its descendants; independent handle prevents PID-reuse termination.'})
remaining=max(0,int((deadline-datetime.datetime.now(datetime.timezone.utc)).total_seconds()*1000));result=k.WaitForSingleObject(handle,remaining)
if result==0:save({'status':'CONTROLLER_EXITED_BEFORE_DEADLINE','pid':pid,'time_utc':datetime.datetime.now(datetime.timezone.utc).isoformat()});k.CloseHandle(handle);raise SystemExit(0)
assert result==258,result
before=json.loads((ROOT/'controller.json').read_text(encoding='utf-8'));q=subprocess.run(['taskkill','/PID',str(pid),'/T','/F'],capture_output=True,text=True,creationflags=subprocess.CREATE_NO_WINDOW)
# Stop only Coq jobs whose actual command refers to this exact benchmark proof subtree.
code="""import os,signal,json
from pathlib import Path
prefix='/home/yangfp/teSpec/benchmark/results/init_array/20261016-positive-itp-per-execution/'
stopped=[]
for entry in Path('/proc').iterdir():
 if not entry.name.isdigit():continue
 try:
  argv=(entry/'cmdline').read_bytes().split(bytes([0]));exe=Path(argv[0].decode()).name
  if exe in ['coqc','coqchk'] and any(prefix in a.decode(errors='replace') for a in argv):os.kill(int(entry.name),signal.SIGTERM);stopped.append(int(entry.name))
 except (FileNotFoundError,ProcessLookupError,PermissionError):pass
print(json.dumps(stopped))
"""
r=subprocess.run(['wsl','-d','Ubuntu-22.04','-u','yangfp','--','python3','-c',code],capture_output=True,text=True,timeout=30,creationflags=subprocess.CREATE_NO_WINDOW)
save({'status':'STOPPED_AT_NIGHTLY_DEADLINE','pid':pid,'time_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'controller_before_stop':before,'controller_termination':q.stdout+q.stderr,'exact_subtree_coq_pids':r.stdout,'policy':'Incomplete calls and proof stages stay pending; preserve raw logs and actual usage, never fabricate missing token or cost totals. Pause heartbeat through the app tool on the cutoff turn.'});k.CloseHandle(handle)
