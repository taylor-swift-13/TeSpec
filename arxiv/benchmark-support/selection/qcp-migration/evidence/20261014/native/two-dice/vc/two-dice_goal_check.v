Require Import two-dice_goal two-dice_proof_auto two-dice_proof_manual.

Module VC_Correctness : VC_Correct.
  Include two-dice_proof_auto.
  Include two-dice_proof_manual.
End VC_Correctness.
