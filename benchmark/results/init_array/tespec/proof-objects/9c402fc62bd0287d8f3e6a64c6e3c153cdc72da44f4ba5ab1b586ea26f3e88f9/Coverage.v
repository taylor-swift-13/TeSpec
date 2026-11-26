Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Axiom proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Axiom proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Axiom proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Axiom proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
