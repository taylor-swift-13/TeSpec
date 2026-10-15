Require Import leaky_get.qcp_goal leaky_get.qcp_proof_auto leaky_get.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include leaky_get.qcp_proof_auto.
  Include leaky_get.qcp_proof_manual.
End VC_Correctness.
