Require Import up_malloc_down_free.qcp_goal up_malloc_down_free.qcp_proof_auto up_malloc_down_free.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include up_malloc_down_free.qcp_proof_auto.
  Include up_malloc_down_free.qcp_proof_manual.
End VC_Correctness.
