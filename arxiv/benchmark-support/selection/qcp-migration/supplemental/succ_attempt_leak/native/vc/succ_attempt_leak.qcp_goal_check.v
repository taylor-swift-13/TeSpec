Require Import succ_attempt_leak.qcp_goal succ_attempt_leak.qcp_proof_auto succ_attempt_leak.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include succ_attempt_leak.qcp_proof_auto.
  Include succ_attempt_leak.qcp_proof_manual.
End VC_Correctness.
