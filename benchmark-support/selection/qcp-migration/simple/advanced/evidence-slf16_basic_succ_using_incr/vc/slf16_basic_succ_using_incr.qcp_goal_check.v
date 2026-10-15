Require Import slf16_basic_succ_using_incr.qcp_goal slf16_basic_succ_using_incr.qcp_proof_auto slf16_basic_succ_using_incr.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf16_basic_succ_using_incr.qcp_proof_auto.
  Include slf16_basic_succ_using_incr.qcp_proof_manual.
End VC_Correctness.
