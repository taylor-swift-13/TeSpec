Require Import queue_push_induction.qcp_goal queue_push_induction.qcp_proof_auto queue_push_induction.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include queue_push_induction.qcp_proof_auto.
  Include queue_push_induction.qcp_proof_manual.
End VC_Correctness.
