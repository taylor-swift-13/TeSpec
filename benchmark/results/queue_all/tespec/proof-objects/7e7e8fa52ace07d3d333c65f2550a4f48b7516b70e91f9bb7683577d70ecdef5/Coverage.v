Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_IntQueue_push_return_wit_1 : Goal.IntQueue_push_return_wit_1.
Axiom proof_of_IntQueue_push_precondition_wit_1 : Goal.IntQueue_push_precondition_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
