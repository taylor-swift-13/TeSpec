Require Import return_owned_local.qcp_goal return_owned_local.qcp_proof_auto return_owned_local.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include return_owned_local.qcp_proof_auto.
  Include return_owned_local.qcp_proof_manual.
End VC_Correctness.
