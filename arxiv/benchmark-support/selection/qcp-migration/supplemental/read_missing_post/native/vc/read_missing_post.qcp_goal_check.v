Require Import read_missing_post.qcp_goal read_missing_post.qcp_proof_auto read_missing_post.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include read_missing_post.qcp_proof_auto.
  Include read_missing_post.qcp_proof_manual.
End VC_Correctness.
