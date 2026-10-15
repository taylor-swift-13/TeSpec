from pathlib import Path
import json,re
r=Path('/home/yangfp/teSpec-benchmark-tespec');p=r/'benchmark/selection/paired-mutations/performance/20261015-positive18'
w=Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/positive-model-runs');w.mkdir(exist_ok=True)
ids=['slf0_basic_incr','slf0_incr.broken','slf1_basic_example_let','slf2_basic_quadruple']
for ident in ids:
 src=p/ident/'repeat-1/qcp/native/vc';d=w/ident;d.mkdir(exist_ok=True)
 goal=(src/'qcp_goal.v').read_text();candidate=(src/'qcp_proof_manual.v').read_text().replace('qcp_goal','CaseGoal')
 (d/'CaseGoal.v').write_text(goal);(d/'Candidate.v').write_text(candidate)
 prompt='''You are the sole proof constructor for this independent QCP benchmark subject. Fill Candidate.v in the current directory. CaseGoal.v is immutable original native QCP VC data. Prove all lemmas in Candidate.v exactly as stated, using Coq 8.20 and the standard QCP SeparationLogic runtime imports. Preserve the statements and imports. No Admitted, admit, axioms, parameters, proof escapes, or altered definitions. Do not inspect other benchmark proofs or previous solutions. Do not launch other agents or tools that call a model. Do not change CaseGoal.v or other files. Do not claim acceptance; an external controller compiles and checks your result. This timed proof-generation stage is separate from external compilation: edit Candidate.v only and return a short completion message. No command execution or local compilation is needed in this stage. Resource/token costs come from real CLI telemetry, not your self-report.\n\nOriginal goal data:\n'''+goal+'\n\nCandidate template:\n'+candidate
 (d/'prompt.txt').write_text(prompt)
 print(ident,'manual lemmas',len(re.findall(r'^Lemma ',candidate,re.M)))
