Require Import runway_inline.qcp_goal runway_inline.qcp_proof_auto runway_inline.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include runway_inline.qcp_proof_auto.
  Include runway_inline.qcp_proof_manual.
End VC_Correctness.
