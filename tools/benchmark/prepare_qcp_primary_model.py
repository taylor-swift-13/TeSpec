from pathlib import Path
import argparse
parser=argparse.ArgumentParser();parser.add_argument('--task-dir',type=Path,required=True);args=parser.parse_args()
R=Path(__file__).resolve().parents[2];G=R/'benchmark/results/historical/selection/paired-mutations/performance/20261015-positive18/automatic-final/read2/repeat-1/qcp/native/vc/qcp_goal.v';W=args.task_dir.resolve();assert not (W/'Candidate.v').exists(),'Use a fresh task directory';W.mkdir(exist_ok=True);(W/'PrimaryQcpGoal.v').write_bytes(G.read_bytes());header=G.read_text().split('(*----- Function read -----*)')[0]
candidate='Require Import PrimaryQcpGoal.\n'+header+'''\nTheorem primary_read_return_verified : PrimaryQcpGoal.read_return_wit_1.
Proof. Admitted.
Module PrimaryReadCertificate : PrimaryQcpGoal.VC_Correct.
  Definition proof_of_read_return_wit_1 := primary_read_return_verified.
End PrimaryReadCertificate.
Print Assumptions primary_read_return_verified.
''';(W/'Candidate.v').write_text(candidate)
prompt='''Fill Candidate.v with a valid Coq 8.20 proof of primary_read_return_verified, preserving all imports, the statement, the module implementing the original VC_Correct interface, and Print Assumptions. PrimaryQcpGoal.v is immutable actual unbound QCP verification-condition output for the designated read primary. Prove it universally, not with concrete test bindings. No Admitted/admit, new axioms, parameters, proof escapes or changed definitions. Edit Candidate.v only; do not read prior benchmark proof solutions. Do not change/create other files, call models or delegate. External compilation and independent kernel checking are controller-owned and separately measured. Return a brief completion message.\n\nActual immutable goal:\n'''+G.read_text()+'\n\nCandidate template:\n'+candidate
(W/'prompt.txt').write_text(prompt);print('Prepared exact universal QCP goal and interface-complete proof template; native generation reused.')
