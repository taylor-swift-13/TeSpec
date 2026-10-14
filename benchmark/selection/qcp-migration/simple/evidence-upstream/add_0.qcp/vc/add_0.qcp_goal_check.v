Require Import add_0.qcp_goal add_0.qcp_proof_auto add_0.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include add_0.qcp_proof_auto.
  Include add_0.qcp_proof_manual.
End VC_Correctness.
