Require Import runtime_swap_array.qcp_goal runtime_swap_array.qcp_proof_auto runtime_swap_array.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include runtime_swap_array.qcp_proof_auto.
  Include runtime_swap_array.qcp_proof_manual.
End VC_Correctness.
