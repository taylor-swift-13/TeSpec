Require Import same_func_asserted.qcp_goal same_func_asserted.qcp_proof_auto same_func_asserted.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include same_func_asserted.qcp_proof_auto.
  Include same_func_asserted.qcp_proof_manual.
End VC_Correctness.
