Require Import array_main_verified.qcp_goal array_main_verified.qcp_proof_auto array_main_verified.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include array_main_verified.qcp_proof_auto.
  Include array_main_verified.qcp_proof_manual.
End VC_Correctness.
