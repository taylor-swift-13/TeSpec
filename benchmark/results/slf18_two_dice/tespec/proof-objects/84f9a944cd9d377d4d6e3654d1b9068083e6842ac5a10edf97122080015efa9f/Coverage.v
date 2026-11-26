Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_two_dice_entail_wit_1 : Goal.two_dice_entail_wit_1.
Axiom proof_of_two_dice_entail_wit_2 : Goal.two_dice_entail_wit_2.
Axiom proof_of_two_dice_return_wit_1 : Goal.two_dice_return_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
