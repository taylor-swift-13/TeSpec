Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_sample_safety_wit_1 : Goal.sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : Goal.sample_safety_wit_2.
Axiom proof_of_sample_safety_wit_3 : Goal.sample_safety_wit_3.
Axiom proof_of_sample_safety_wit_4 : Goal.sample_safety_wit_4.
Axiom proof_of_sample_safety_wit_5 : Goal.sample_safety_wit_5.
Axiom proof_of_sample_safety_wit_6 : Goal.sample_safety_wit_6.
Axiom proof_of_sample_safety_wit_7 : Goal.sample_safety_wit_7.
Axiom proof_of_sample_safety_wit_8 : Goal.sample_safety_wit_8.
Axiom proof_of_sample_safety_wit_9 : Goal.sample_safety_wit_9.
Axiom proof_of_sample_safety_wit_10 : Goal.sample_safety_wit_10.
Axiom proof_of_sample_safety_wit_11 : Goal.sample_safety_wit_11.
Axiom proof_of_sample_return_wit_3 : Goal.sample_return_wit_3.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
