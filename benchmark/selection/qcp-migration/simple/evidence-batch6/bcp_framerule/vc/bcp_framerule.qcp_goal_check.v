Require Import bcp_framerule.qcp_goal bcp_framerule.qcp_proof_auto bcp_framerule.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include bcp_framerule.qcp_proof_auto.
  Include bcp_framerule.qcp_proof_manual.
End VC_Correctness.
