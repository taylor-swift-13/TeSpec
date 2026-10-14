Require Import single-free_goal single-free_proof_auto single-free_proof_manual.

Module VC_Correctness : VC_Correct.
  Include single-free_proof_auto.
  Include single-free_proof_manual.
End VC_Correctness.
