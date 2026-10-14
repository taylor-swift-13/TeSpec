Require Import transpose2.qcp_goal transpose2.qcp_proof_auto transpose2.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include transpose2.qcp_proof_auto.
  Include transpose2.qcp_proof_manual.
End VC_Correctness.
