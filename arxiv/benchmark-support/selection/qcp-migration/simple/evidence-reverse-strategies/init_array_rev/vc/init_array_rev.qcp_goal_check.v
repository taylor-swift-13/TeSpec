Require Import init_array_rev.qcp_goal init_array_rev.qcp_proof_auto init_array_rev.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include init_array_rev.qcp_proof_auto.
  Include init_array_rev.qcp_proof_manual.
End VC_Correctness.
