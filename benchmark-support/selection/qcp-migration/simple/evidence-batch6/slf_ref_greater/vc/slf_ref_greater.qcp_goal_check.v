Require Import slf_ref_greater.qcp_goal slf_ref_greater.qcp_proof_auto slf_ref_greater.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf_ref_greater.qcp_proof_auto.
  Include slf_ref_greater.qcp_proof_manual.
End VC_Correctness.
