Require Import push_induction.qcp_goal push_induction.qcp_proof_auto push_induction.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include push_induction.qcp_proof_auto.
  Include push_induction.qcp_proof_manual.
End VC_Correctness.
