Require Import list_all.qcp_goal list_all.qcp_proof_auto list_all.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include list_all.qcp_proof_auto.
  Include list_all.qcp_proof_manual.
End VC_Correctness.
