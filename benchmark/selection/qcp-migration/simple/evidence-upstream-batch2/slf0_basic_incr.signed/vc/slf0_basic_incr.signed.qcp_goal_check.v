Require Import slf0_basic_incr.signed.qcp_goal slf0_basic_incr.signed.qcp_proof_auto slf0_basic_incr.signed.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf0_basic_incr.signed.qcp_proof_auto.
  Include slf0_basic_incr.signed.qcp_proof_manual.
End VC_Correctness.
