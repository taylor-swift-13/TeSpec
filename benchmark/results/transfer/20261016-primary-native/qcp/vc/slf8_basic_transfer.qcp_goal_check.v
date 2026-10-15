Require Import slf8_basic_transfer.qcp_goal slf8_basic_transfer.qcp_proof_auto slf8_basic_transfer.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf8_basic_transfer.qcp_proof_auto.
  Include slf8_basic_transfer.qcp_proof_manual.
End VC_Correctness.
