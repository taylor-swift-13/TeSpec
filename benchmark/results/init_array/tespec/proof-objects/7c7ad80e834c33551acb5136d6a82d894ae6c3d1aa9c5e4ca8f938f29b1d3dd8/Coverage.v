Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Axiom proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Axiom proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Axiom proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Axiom proof_of_init_array2_entail_wit_5 : Goal.init_array2_entail_wit_5.
Axiom proof_of_init_array2_entail_wit_6 : Goal.init_array2_entail_wit_6.
Axiom proof_of_init_array2_entail_wit_7 : Goal.init_array2_entail_wit_7.
Axiom proof_of_init_array2_entail_wit_8 : Goal.init_array2_entail_wit_8.
Axiom proof_of_init_array2_entail_wit_9 : Goal.init_array2_entail_wit_9.
Axiom proof_of_init_array2_entail_wit_10 : Goal.init_array2_entail_wit_10.
Axiom proof_of_init_array2_entail_wit_11 : Goal.init_array2_entail_wit_11.
Axiom proof_of_init_array2_entail_wit_12 : Goal.init_array2_entail_wit_12.
Axiom proof_of_init_array2_entail_wit_13 : Goal.init_array2_entail_wit_13.
Axiom proof_of_init_array2_entail_wit_14 : Goal.init_array2_entail_wit_14.
Axiom proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
