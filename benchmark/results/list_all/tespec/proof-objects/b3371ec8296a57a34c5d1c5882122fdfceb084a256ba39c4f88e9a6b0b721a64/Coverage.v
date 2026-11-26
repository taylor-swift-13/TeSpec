Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Axiom proof_of_IntList_mergesort_return_wit_2 : Goal.IntList_mergesort_return_wit_2.
Axiom proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
