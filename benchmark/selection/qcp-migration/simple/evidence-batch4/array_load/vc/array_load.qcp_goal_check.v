Require Import array_load.qcp_goal array_load.qcp_proof_auto array_load.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include array_load.qcp_proof_auto.
  Include array_load.qcp_proof_manual.
End VC_Correctness.
