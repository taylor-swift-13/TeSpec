Require Import slf17_get_and_free.qcp_goal slf17_get_and_free.qcp_proof_auto slf17_get_and_free.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf17_get_and_free.qcp_proof_auto.
  Include slf17_get_and_free.qcp_proof_manual.
End VC_Correctness.
