Require Import slf3_basic_inplace_double.qcp_goal slf3_basic_inplace_double.qcp_proof_auto slf3_basic_inplace_double.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf3_basic_inplace_double.qcp_proof_auto.
  Include slf3_basic_inplace_double.qcp_proof_manual.
End VC_Correctness.
