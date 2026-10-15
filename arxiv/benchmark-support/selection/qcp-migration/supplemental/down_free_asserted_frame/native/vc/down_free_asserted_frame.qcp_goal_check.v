Require Import down_free_asserted_frame.qcp_goal down_free_asserted_frame.qcp_proof_auto down_free_asserted_frame.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include down_free_asserted_frame.qcp_proof_auto.
  Include down_free_asserted_frame.qcp_proof_manual.
End VC_Correctness.
