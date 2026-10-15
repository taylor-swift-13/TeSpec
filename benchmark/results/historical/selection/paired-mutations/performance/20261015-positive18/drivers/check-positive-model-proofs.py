from pathlib import Path
import json,subprocess,shlex,re,hashlib,os,time,signal
ROOT=Path('/home/yangfp/teSpec-benchmark-tespec');BASE=ROOT/'benchmark/selection/paired-mutations';OUT=BASE/'performance/20261015-positive18';WIN=Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/positive-model-runs');runtime=ROOT/'runtime/qcip/SeparationLogic';coq=Path('/home/yangfp/.opam/qcp-8.20/bin')
tokens=shlex.split((runtime/'_CoqProject').read_text());flags=[str(runtime/t) if i%3==1 else t for i,t in enumerate(tokens)]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def measure(cmd,d):
 d.mkdir(exist_ok=True);start=time.monotonic()
 with (d/'stdout.log').open('w') as out,(d/'stderr.log').open('w') as err:p=subprocess.run(['/usr/bin/time','--quiet','-f','{"max_process_rss_kib":%M,"user_seconds":%U,"system_seconds":%S}','-o',str(d/'resources.json'),*map(str,cmd)],cwd=ROOT,stdout=out,stderr=err)
 return {'command':list(map(str,cmd)),'exit_code':p.returncode,'wall_seconds':time.monotonic()-start,'resources':json.loads((d/'resources.json').read_text()),'stderr':(d/'stderr.log').read_text()[-2400:]}
rows=[];modules=[];allflags=flags.copy()
for ident in ['slf0_basic_incr','slf0_incr.broken','slf1_basic_example_let','slf2_basic_quadruple']:
 src=WIN/ident
 if not (src/'model-receipt.json').exists():print(ident,'MODEL STILL RUNNING',flush=True);continue
 receipt=json.loads((src/'model-receipt.json').read_text());assert receipt['exit_code']==0
 assert sha(src/'CaseGoal.v')==receipt['goal_sha256']
 assert sha(src/'Candidate.v')==receipt['candidate_sha256']
 d=OUT/ident/'model';d.mkdir(exist_ok=True);mod='M_'+ident.replace('.','_')
 raw=OUT/ident/'repeat-1/qcp/native/vc/qcp_goal.v';assert sha(raw)==sha(src/'CaseGoal.v')
 manual=(src/'Candidate.v').read_text();original=(OUT/ident/'repeat-1/qcp/native/vc/qcp_proof_manual.v').read_text()
 statements=lambda s:re.findall(r'Lemma\s+(\w+)\s*:\s*(.*?)\.\s*Proof\.',s,re.S)
 assert statements(manual)==statements(original)
 assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter|Abort)\b',manual)
 (d/(mod+'_Goal.v')).write_bytes(raw.read_bytes());(d/(mod+'_Manual.v')).write_text(manual.replace('Require Import CaseGoal.','Require Import '+mod+'_Goal.'))
 for name in ['model-receipt.json','agent.stdout.jsonl','agent.stderr.log','prompt.txt']:(d/name).write_bytes((src/name).read_bytes())
 # The Windows monitor reliably records the main client's PeakWorkingSetSize.
 # Do not present the unvalidated descendant enumeration as process-tree RSS.
 receipt['resources']['memory_reporting_note']='Use max_process_peak_working_set_bytes as Windows Codex main-client peak; descendant/tree enumeration is not relied upon.'
 (d/'model-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
 allflags+=['-Q',str(d),''];local=flags+['-Q',str(d),''];results=[]
 for suffix in ['Goal','Manual']:
  check=measure([coq/'coqc',*local,d/(mod+'_'+suffix+'.v')],d/('compile-'+suffix));results.append(check)
  if check['exit_code']:break
 ok=all(x['exit_code']==0 for x in results)
 if ok:
  theorem=next(n for n,t in statements(manual) if '_split_goal_' not in n)
  (d/(mod+'_Audit.v')).write_text('Require Import '+mod+'_Manual.\nPrint Assumptions '+theorem+'.\n')
  audit=measure([coq/'coqc',*local,d/(mod+'_Audit.v')],d/'assumption-audit');results.append(audit);ok=audit['exit_code']==0
  modules.append(mod+'_Manual')
 row={'source':ident,'status':'COMPILED' if ok else 'FAILED','model':receipt,'compilation':results,'module':mod+'_Manual','goal_sha256':sha(raw),'candidate_sha256':sha(d/(mod+'_Manual.v'))}
 rows.append(row);(OUT/'model-proof-results.json').write_text(json.dumps(rows,indent=2)+'\n')
 print(ident,row['status'],results[-1].get('stderr','')[-1600:] if not ok else '',flush=True)
if len(rows)==4 and all(x['status']=='COMPILED' for x in rows):
 for row in rows:
  d=OUT/row['source']/'model/kernel-replay';d.mkdir(exist_ok=True)
  result=measure([coq/'coqchk','-silent',*allflags,row['module']],d)
  row['kernel_replay']=result
  row['status']='KERNEL_CHECKED' if result['exit_code']==0 else 'KERNEL_FAILED'
  (OUT/'model-proof-results.json').write_text(json.dumps(rows,indent=2)+'\n')
  print(row['source'],'independent kernel replay',result['exit_code'],flush=True)
else:print('Proof repairs required before independent replay',flush=True)
