Require Import array_load2.qcp_goal array_load2.qcp_proof_auto array_load2.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include array_load2.qcp_proof_auto.
  Include array_load2.qcp_proof_manual.
End VC_Correctness.
