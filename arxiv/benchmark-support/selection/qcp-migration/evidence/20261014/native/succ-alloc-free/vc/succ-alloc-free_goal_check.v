Require Import succ-alloc-free_goal succ-alloc-free_proof_auto succ-alloc-free_proof_manual.

Module VC_Correctness : VC_Correct.
  Include succ-alloc-free_proof_auto.
  Include succ-alloc-free_proof_manual.
End VC_Correctness.
