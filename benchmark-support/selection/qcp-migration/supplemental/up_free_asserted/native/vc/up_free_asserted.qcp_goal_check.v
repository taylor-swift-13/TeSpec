Require Import up_free_asserted.qcp_goal up_free_asserted.qcp_proof_auto up_free_asserted.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include up_free_asserted.qcp_proof_auto.
  Include up_free_asserted.qcp_proof_manual.
End VC_Correctness.
