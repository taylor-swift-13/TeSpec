Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_succ_using_incr_attempt_return_wit_1 : Goal.succ_using_incr_attempt_return_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
