Require Import slf18_two_dice.qcp_goal slf18_two_dice.qcp_proof_auto slf18_two_dice.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf18_two_dice.qcp_proof_auto.
  Include slf18_two_dice.qcp_proof_manual.
End VC_Correctness.
