Require Import zero.qcp_goal zero.qcp_proof_auto zero.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include zero.qcp_proof_auto.
  Include zero.qcp_proof_manual.
End VC_Correctness.
