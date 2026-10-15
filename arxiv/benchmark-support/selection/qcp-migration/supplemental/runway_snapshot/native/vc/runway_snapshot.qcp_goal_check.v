Require Import runway_snapshot.qcp_goal runway_snapshot.qcp_proof_auto runway_snapshot.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include runway_snapshot.qcp_proof_auto.
  Include runway_snapshot.qcp_proof_manual.
End VC_Correctness.
