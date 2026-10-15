Require Import add_1.qcp_goal add_1.qcp_proof_auto add_1.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include add_1.qcp_proof_auto.
  Include add_1.qcp_proof_manual.
End VC_Correctness.
