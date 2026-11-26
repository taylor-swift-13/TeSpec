Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_remove_return_wit_1 : Goal.remove_return_wit_1.
Axiom proof_of_remove_precondition_wit_1 : Goal.remove_precondition_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
