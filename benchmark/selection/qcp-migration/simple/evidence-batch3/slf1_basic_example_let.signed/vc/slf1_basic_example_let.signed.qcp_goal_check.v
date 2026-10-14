Require Import slf1_basic_example_let.signed.qcp_goal slf1_basic_example_let.signed.qcp_proof_auto slf1_basic_example_let.signed.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf1_basic_example_let.signed.qcp_proof_auto.
  Include slf1_basic_example_let.signed.qcp_proof_manual.
End VC_Correctness.
