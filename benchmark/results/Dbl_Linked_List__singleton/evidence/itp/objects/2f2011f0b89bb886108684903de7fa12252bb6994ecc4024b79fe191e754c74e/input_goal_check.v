Require Import input_goal input_proof_auto input_proof_manual.

Module VC_Correctness : VC_Correct.
  Include input_proof_auto.
  Include input_proof_manual.
End VC_Correctness.
