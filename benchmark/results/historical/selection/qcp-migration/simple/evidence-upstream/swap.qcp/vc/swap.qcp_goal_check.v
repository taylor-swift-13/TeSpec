Require Import swap.qcp_goal swap.qcp_proof_auto swap.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include swap.qcp_proof_auto.
  Include swap.qcp_proof_manual.
End VC_Correctness.
