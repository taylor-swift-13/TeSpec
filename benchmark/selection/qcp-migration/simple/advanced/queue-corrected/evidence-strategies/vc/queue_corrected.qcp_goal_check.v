Require Import queue_corrected.qcp_goal queue_corrected.qcp_proof_auto queue_corrected.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include queue_corrected.qcp_proof_auto.
  Include queue_corrected.qcp_proof_manual.
End VC_Correctness.
