Require Import slf13_basic_ref_with_frame.qcp_goal slf13_basic_ref_with_frame.qcp_proof_auto slf13_basic_ref_with_frame.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf13_basic_ref_with_frame.qcp_proof_auto.
  Include slf13_basic_ref_with_frame.qcp_proof_manual.
End VC_Correctness.
