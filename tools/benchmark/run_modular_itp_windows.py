"""Resume independently metered modular ITP jobs; three bounded Coq clients maximum."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor,as_completed
import argparse,json,subprocess,sys,threading,time,os
p=argparse.ArgumentParser();p.add_argument("--task-root",type=Path,required=True);p.add_argument("--start",type=int,default=0);p.add_argument("--workers",type=int,default=3);a=p.parse_args()
assert 1<=a.workers<=3
root=a.task_root.resolve();status=root/"controller-status.json";lock=threading.Lock()
repo="/home/yangfp/teSpec";task_wsl="/mnt/"+str(root)[0].lower()+"/"+str(root)[3:].replace(chr(92),"/")
artifact=Path(chr(92)*2+"wsl.localhost"+chr(92)+"Ubuntu-22.04"+chr(92)+"home"+chr(92)+"yangfp"+chr(92)+"teSpec"+chr(92)+"benchmark"+chr(92)+"results"+chr(92)+"modular-itp"+chr(92)+"20261020")
meter=Path(__file__).with_name("meter_itp_model_windows.py")
state={"status":"RUNNING","workers":a.workers,"started_epoch":time.time(),"executions":{}}
def save():
 temp=status.with_suffix(".tmp");temp.write_text(json.dumps(state,indent=2),encoding="utf8");os.replace(temp,status)
def update(i,**kw):
 with lock:
  state["executions"].setdefault(str(i),{}).update(kw);save()
def receipt(i,n):
 p=artifact/("execution-%02d"%i)/("attempt-%d"%n)/"coq-receipt.json"
 return json.loads(p.read_text(encoding="utf8")) if p.exists() else None
def invoke(cmd,folder):
 folder.mkdir(parents=True,exist_ok=False);started=time.monotonic()
 with (folder/"stdout.log").open("wb") as out,(folder/"stderr.log").open("wb") as err:
  v=subprocess.run(cmd,stdout=out,stderr=err,timeout=900,creationflags=subprocess.CREATE_NO_WINDOW)
 (folder/"receipt.json").write_text(json.dumps({"command":cmd,"exit_code":v.returncode,"wall_seconds":time.monotonic()-started,"scope":"Controller transport only; model and Coq have separate actual receipts."},indent=2),encoding="utf8")
 return v.returncode
def work(i):
 task=root/("execution-%02d"%i)
 for n in range(1,4):
  old=receipt(i,n)
  if old and old["status"]=="KERNEL_CHECKED":update(i,stage="KERNEL_CHECKED",attempt=n);return True
  if old and old["status"]!="COMPILING":continue
  update(i,stage="MODEL",attempt=n)
  if not (task/("attempt-%d"%n)/"model-receipt.json").exists():
   code=invoke([sys.executable,str(meter),"--task-dir",str(task),"--attempt",str(n)],task/"controller"/("model-%d"%n))
   if code: update(i,stage="MODEL_TRANSPORT_FAILED",attempt=n);return False
  update(i,stage="COQ",attempt=n)
  cmd=["wsl.exe","-d","Ubuntu-22.04","-u","yangfp","--","python3",repo+"/tools/benchmark/modular_execution_itp.py","compile","--task-root",task_wsl,"--execution",str(i),"--attempt",str(n)]
  folder=task/"controller"/("coq-%d-%d"%(n,time.time_ns()))
  code=invoke(cmd,folder);result=receipt(i,n)
  if code==0 and result and result["status"]=="KERNEL_CHECKED":
   update(i,stage="KERNEL_CHECKED",attempt=n);print(json.dumps({"completed":i,"attempt":n}),flush=True);return True
  diagnostic=(folder/"stdout.log").read_bytes().decode("utf8",errors="replace")+(folder/"stderr.log").read_bytes().decode("utf8",errors="replace")
  with (task/"prompt.txt").open("a",encoding="utf8") as f:f.write("\nRepair only Candidate.v. Keep all statements and immutable inputs. Actual controller diagnostic:\n"+diagnostic[-8000:]+"\n")
 update(i,stage="FAILED_AFTER_ATTEMPTS");return False
save()
with ThreadPoolExecutor(max_workers=a.workers) as pool:
 futures={pool.submit(work,i):i for i in range(a.start,58)}
 for f in as_completed(futures):
  try:f.result()
  except BaseException as e:update(futures[f],stage="CONTROLLER_EXCEPTION",error=repr(e))
with lock:
 state["status"]="DONE";state["finished_epoch"]=time.time();save()
print(json.dumps(state),flush=True)
