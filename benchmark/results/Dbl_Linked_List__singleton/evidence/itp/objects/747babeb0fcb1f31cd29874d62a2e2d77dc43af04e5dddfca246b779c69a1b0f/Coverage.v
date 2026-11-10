Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
