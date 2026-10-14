Require Import abs_mem.qcp_goal abs_mem.qcp_proof_auto abs_mem.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include abs_mem.qcp_proof_auto.
  Include abs_mem.qcp_proof_manual.
End VC_Correctness.
