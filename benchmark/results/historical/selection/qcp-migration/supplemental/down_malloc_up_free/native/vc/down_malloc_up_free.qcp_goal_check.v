Require Import down_malloc_up_free.qcp_goal down_malloc_up_free.qcp_proof_auto down_malloc_up_free.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include down_malloc_up_free.qcp_proof_auto.
  Include down_malloc_up_free.qcp_proof_manual.
End VC_Correctness.
