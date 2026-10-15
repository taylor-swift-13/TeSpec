Require Import array_client_bound.qcp_goal array_client_bound.qcp_proof_auto array_client_bound.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include array_client_bound.qcp_proof_auto.
  Include array_client_bound.qcp_proof_manual.
End VC_Correctness.
