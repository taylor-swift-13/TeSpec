Require Import abs_mem_struct.qcp_goal abs_mem_struct.qcp_proof_auto abs_mem_struct.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include abs_mem_struct.qcp_proof_auto.
  Include abs_mem_struct.qcp_proof_manual.
End VC_Correctness.
