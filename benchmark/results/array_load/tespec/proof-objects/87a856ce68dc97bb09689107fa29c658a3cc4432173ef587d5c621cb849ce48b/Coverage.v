Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_main_entail_wit_5 : Goal.main_entail_wit_5.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
