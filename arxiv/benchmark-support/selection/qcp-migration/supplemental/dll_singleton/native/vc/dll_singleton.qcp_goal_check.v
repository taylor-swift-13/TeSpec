Require Import dll_singleton.qcp_goal dll_singleton.qcp_proof_auto dll_singleton.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include dll_singleton.qcp_proof_auto.
  Include dll_singleton.qcp_proof_manual.
End VC_Correctness.
