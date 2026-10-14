Require Import ref-greater_goal ref-greater_proof_auto ref-greater_proof_manual.

Module VC_Correctness : VC_Correct.
  Include ref-greater_proof_auto.
  Include ref-greater_proof_manual.
End VC_Correctness.
