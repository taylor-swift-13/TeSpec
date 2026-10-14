Require Import slf4_basic_incr_two.qcp_goal slf4_basic_incr_two.qcp_proof_auto slf4_basic_incr_two.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf4_basic_incr_two.qcp_proof_auto.
  Include slf4_basic_incr_two.qcp_proof_manual.
End VC_Correctness.
