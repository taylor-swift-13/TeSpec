Require Import transpose.qcp_goal transpose.qcp_proof_auto transpose.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include transpose.qcp_proof_auto.
  Include transpose.qcp_proof_manual.
End VC_Correctness.
