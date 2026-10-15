Require Import slf10_basic_ref.qcp_goal slf10_basic_ref.qcp_proof_auto slf10_basic_ref.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf10_basic_ref.qcp_proof_auto.
  Include slf10_basic_ref.qcp_proof_manual.
End VC_Correctness.
