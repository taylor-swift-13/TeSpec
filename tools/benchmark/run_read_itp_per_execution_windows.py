from pathlib import Path
import subprocess,sys,json,time
import argparse
parser=argparse.ArgumentParser();parser.add_argument('--task-root',type=Path,required=True);args=parser.parse_args()
base=args.task_root.resolve()
script='/home/yangfp/teSpec/tools/benchmark/read_itp_per_execution.py'
state=base/'progress.json'
base.mkdir(parents=True,exist_ok=True)
subprocess.run(['wsl','-d','Ubuntu-22.04','-u','yangfp','--','python3',script,'prepare'],check=True)
for i in range(12):
 status=json.loads(subprocess.check_output(['wsl','-d','Ubuntu-22.04','-u','yangfp','--','python3',script,'status','--execution',str(i)],text=True))
 if status['accepted']:
  print(f'SKIP execution {i:02d}: existing kernel-checked receipt; no rerun',flush=True)
  continue
 task=base/f'execution-{i:02d}'
 for attempt in range(status['next_attempt'],status['next_attempt']+5):
  state.write_text(json.dumps({'execution':i,'stage':'model','attempt':attempt,'completed':i}));print(f'START execution {i:02d}, model attempt {attempt}',flush=True)
  model=task/f'attempt-{attempt}/model-receipt.json'
  if not model.exists():subprocess.run([sys.executable,str(Path(__file__).with_name('meter_itp_model_windows.py')),'--task-dir',str(task),'--attempt',str(attempt)],check=True)
  state.write_text(json.dumps({'execution':i,'stage':'coq','attempt':attempt,'completed':i}));print(f'START execution {i:02d}, Coq compile/kernel attempt {attempt}',flush=True)
  done=subprocess.run(['wsl','-d','Ubuntu-22.04','-u','yangfp','--','python3',script,'compile','--execution',str(i),'--attempt',str(attempt)])
  if done.returncode==0:break
  if attempt==status['next_attempt']+4:raise SystemExit('Five unsuccessful new attempts; retained measured diagnostics')
  diagnostic=(task/'repair-diagnostic.txt').read_text(encoding='utf-8') if (task/'repair-diagnostic.txt').exists() else 'The external proof validator rejected the candidate. Check original statements and proof completeness.'
  with (task/'prompt.txt').open('a',encoding='utf-8') as f:f.write('\n\nRepair attempt: fix the current Candidate.v, preserving all statements and immutable files. Actual compilation diagnostic:\n'+diagnostic+'\nCurrent candidate:\n'+(task/'Candidate.v').read_text(encoding='utf-8'))
 else:raise SystemExit(1)
 print(f'COMPLETE execution {i:02d} ({i+1}/12)',flush=True)
 state.write_text(json.dumps({'execution':i,'stage':'complete','completed':i+1}))
subprocess.run(['wsl','-d','Ubuntu-22.04','-u','yangfp','--','python3',script,'summarize'],check=True)
subprocess.run(['wsl','-d','Ubuntu-22.04','-u','yangfp','--','python3',script,'validate'],check=True)
state.write_text(json.dumps({'stage':'ALL_COMPLETE','completed':12}))
