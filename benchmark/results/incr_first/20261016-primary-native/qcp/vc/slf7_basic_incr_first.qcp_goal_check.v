Require Import slf7_basic_incr_first.qcp_goal slf7_basic_incr_first.qcp_proof_auto slf7_basic_incr_first.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf7_basic_incr_first.qcp_proof_auto.
  Include slf7_basic_incr_first.qcp_proof_manual.
End VC_Correctness.
