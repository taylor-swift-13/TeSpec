Require Import init_point.qcp_goal init_point.qcp_proof_auto init_point.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include init_point.qcp_proof_auto.
  Include init_point.qcp_proof_manual.
End VC_Correctness.
