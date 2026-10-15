Require Import dll_add.qcp_goal dll_add.qcp_proof_auto dll_add.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include dll_add.qcp_proof_auto.
  Include dll_add.qcp_proof_manual.
End VC_Correctness.
