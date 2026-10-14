Require Import slf11_basic_ref_greater.qcp_goal slf11_basic_ref_greater.qcp_proof_auto slf11_basic_ref_greater.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf11_basic_ref_greater.qcp_proof_auto.
  Include slf11_basic_ref_greater.qcp_proof_manual.
End VC_Correctness.
