#!/usr/bin/env python3
"""Recompile checked positive manual proofs and run independent kernel checking."""
from pathlib import Path
import argparse,hashlib,json,shlex,shutil,subprocess
p=argparse.ArgumentParser(description=__doc__);p.add_argument('--runtime',type=Path,required=True);a=p.parse_args()
b=Path(__file__).resolve().parent;r=a.runtime.resolve();tokens=shlex.split((r/'_CoqProject').read_text());flags=[str(r/t) if i%3==1 else t for i,t in enumerate(tokens)]
coqc,coqchk=shutil.which('coqc'),shutil.which('coqchk')
if not coqc or not coqchk:raise SystemExit('Activate Coq 8.20 first')
if '8.20' not in subprocess.check_output([coqc,'--version'],text=True):raise SystemExit('Coq 8.20 required')
rows=json.loads((b/'manual-proof-receipts.json').read_text());modules=[]
for row in rows:
 goal=b/row['goal'];proof=b/row['proof']
 for path,key in [(goal,'goal_sha256'),(proof,'manual_sha256')]:
  if hashlib.sha256(path.read_bytes()).hexdigest()!=row[key]:raise ValueError('Proof source changed: '+str(path))
 flags+=['-Q',str(goal.parent),'']
 for path in [goal,proof]:subprocess.run([coqc,*flags,str(path)],check=True)
 modules.append(proof.stem)
subprocess.run([coqchk,'-silent',*flags,*modules],check=True)
print('All recorded positive manual proofs passed kernel checking.')
