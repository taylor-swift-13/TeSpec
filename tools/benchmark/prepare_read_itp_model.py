from pathlib import Path
import json,shutil
import argparse
parser=argparse.ArgumentParser();parser.add_argument('--task-dir',type=Path,required=True);args=parser.parse_args()
R=Path(__file__).resolve().parents[2];OLD=R/'benchmark/results/read/20261015-itp-refutations';D=json.loads((OLD/'receipt.json').read_text());W=args.task_dir.resolve();assert not (W/'Candidate.v').exists(),'Use a fresh task directory';W.mkdir(parents=True,exist_ok=True)
files=[]
for p in [OLD/'proofs/ReadCounterHeap.v']+[R/x['goal_copy'] for x in D['cases']]:
 shutil.copyfile(p,W/p.name);files.append(p.name)
header=(OLD/'proofs/ReadCounterHeap.v').read_text().split('Definition st ')[0];candidate='Require Import ReadCounterHeap '+ ' '.join(Path(x).stem for x in files if x!='ReadCounterHeap.v')+'.\n'+header
for i,row in enumerate(D['cases']):
 mod=Path(row['goal_copy']).stem
 for label,goal in [('return_refuted','~ '+mod+'.read_return_wit_1'),('spatial_refuted','~ '+mod+'.read_return_wit_1_split_goal_spatial'),('entry_sat',mod+'.read_precondition_wit_1')]:
  candidate+=f'\nTheorem case_{i:02d}_{label} : {goal}.\nProof. Admitted.\n'
for i in range(12):
 for label in ['return_refuted','spatial_refuted','entry_sat']:candidate+=f'Print Assumptions case_{i:02d}_{label}.\n'
(W/'Candidate.v').write_text(candidate)
prompt='''Construct Coq 8.20 proofs in Candidate.v for all 36 statements, preserving every statement and import. Immutable original VC modules ReadUnknown00Goal through ReadUnknown11Goal and checked concrete heap helper ReadCounterHeap.v are provided in this directory. Refute the original return VCs and spatial splits and prove entry satisfiability for each exact instance. Use the helper's exact concrete heap witnesses for input values including INT_MIN and INT_MAX. No Admitted, admit, new axioms, parameters, escapes, changed definitions, or imports of existing refutation solutions. Do not inspect any other benchmark proof. Only edit Candidate.v. Do not change or create other files. Do not call models or delegate. External compilation and kernel checking are controller-owned and separately measured; no shell execution or compilation is needed in this stage. Return a brief completion message. The Coq runtime uses exact heap ownership semantics and big-endian int stores. When proving concrete range/equality facts after computation, use a tactic appropriate for reduced boolean/comparison equalities as well as arithmetic.\n\nImmutable helper:\n'''+(W/'ReadCounterHeap.v').read_text()
for name in files[1:]:prompt+='\n\nImmutable goal module '+name+':\n'+(W/name).read_text()
prompt+='\n\nCandidate template:\n'+candidate
(W/'prompt.txt').write_text(prompt)
print('Prepared fresh metered model task: 12 exact goals, checked reusable heap helper, 36 theorem statements; prior refutation proofs excluded.')
