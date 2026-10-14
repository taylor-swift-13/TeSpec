Require Import dll_remove_orig.qcp_goal dll_remove_orig.qcp_proof_auto dll_remove_orig.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include dll_remove_orig.qcp_proof_auto.
  Include dll_remove_orig.qcp_proof_manual.
End VC_Correctness.
