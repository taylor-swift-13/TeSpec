Require Import get-free_goal get-free_proof_auto get-free_proof_manual.

Module VC_Correctness : VC_Correct.
  Include get-free_proof_auto.
  Include get-free_proof_manual.
End VC_Correctness.
