Require Import add_read.qcp_goal add_read.qcp_proof_auto add_read.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include add_read.qcp_proof_auto.
  Include add_read.qcp_proof_manual.
End VC_Correctness.
