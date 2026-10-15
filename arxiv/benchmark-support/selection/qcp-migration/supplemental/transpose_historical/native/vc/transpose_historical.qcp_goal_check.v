Require Import transpose_historical.qcp_goal transpose_historical.qcp_proof_auto transpose_historical.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include transpose_historical.qcp_proof_auto.
  Include transpose_historical.qcp_proof_manual.
End VC_Correctness.
