Require Import ref_goal ref_proof_auto ref_proof_manual.

Module VC_Correctness : VC_Correct.
  Include ref_proof_auto.
  Include ref_proof_manual.
End VC_Correctness.
