Require Import slf_sized_stack.qcp_goal slf_sized_stack.qcp_proof_auto slf_sized_stack.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf_sized_stack.qcp_proof_auto.
  Include slf_sized_stack.qcp_proof_manual.
End VC_Correctness.
