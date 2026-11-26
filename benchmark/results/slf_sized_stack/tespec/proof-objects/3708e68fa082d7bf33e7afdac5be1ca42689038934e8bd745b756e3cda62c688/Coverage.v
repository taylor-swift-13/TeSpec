Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_top_return_wit_1 : Goal.top_return_wit_1.
Axiom proof_of_top_precondition_wit_1 : Goal.top_precondition_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
