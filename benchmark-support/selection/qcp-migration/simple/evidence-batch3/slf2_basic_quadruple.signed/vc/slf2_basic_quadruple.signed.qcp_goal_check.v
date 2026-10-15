Require Import slf2_basic_quadruple.signed.qcp_goal slf2_basic_quadruple.signed.qcp_proof_auto slf2_basic_quadruple.signed.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf2_basic_quadruple.signed.qcp_proof_auto.
  Include slf2_basic_quadruple.signed.qcp_proof_manual.
End VC_Correctness.
