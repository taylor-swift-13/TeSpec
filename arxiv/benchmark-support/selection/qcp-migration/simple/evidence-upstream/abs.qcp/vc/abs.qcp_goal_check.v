Require Import abs.qcp_goal abs.qcp_proof_auto abs.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include abs.qcp_proof_auto.
  Include abs.qcp_proof_manual.
End VC_Correctness.
