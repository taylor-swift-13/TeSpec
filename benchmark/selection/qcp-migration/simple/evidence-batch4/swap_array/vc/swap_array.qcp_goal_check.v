Require Import swap_array.qcp_goal swap_array.qcp_proof_auto swap_array.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include swap_array.qcp_proof_auto.
  Include swap_array.qcp_proof_manual.
End VC_Correctness.
