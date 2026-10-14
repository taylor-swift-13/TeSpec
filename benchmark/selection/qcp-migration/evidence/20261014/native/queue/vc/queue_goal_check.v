Require Import queue_goal queue_proof_auto queue_proof_manual.

Module VC_Correctness : VC_Correct.
  Include queue_proof_auto.
  Include queue_proof_manual.
End VC_Correctness.
