Require Import add_2.qcp_goal add_2.qcp_proof_auto add_2.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include add_2.qcp_proof_auto.
  Include add_2.qcp_proof_manual.
End VC_Correctness.
