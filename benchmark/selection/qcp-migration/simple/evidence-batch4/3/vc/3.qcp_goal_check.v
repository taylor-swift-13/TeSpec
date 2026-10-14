Require Import 3.qcp_goal 3.qcp_proof_auto 3.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include 3.qcp_proof_auto.
  Include 3.qcp_proof_manual.
End VC_Correctness.
