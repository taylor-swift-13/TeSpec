Require Import slf9_basic_transfer_aliased.qcp_goal slf9_basic_transfer_aliased.qcp_proof_auto slf9_basic_transfer_aliased.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf9_basic_transfer_aliased.qcp_proof_auto.
  Include slf9_basic_transfer_aliased.qcp_proof_manual.
End VC_Correctness.
