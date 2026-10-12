Require Import Goal Candidate.
Module Type Refutation_Correct.
Axiom proof_of_root_cell_safety_wit_1 : Goal.root_cell_safety_wit_1.
Axiom proof_of_root_cell_safety_wit_2 : Goal.root_cell_safety_wit_2.
Axiom proof_of_root_cell_safety_wit_3 : Goal.root_cell_safety_wit_3.
Axiom proof_of_root_cell_safety_wit_4 : Goal.root_cell_safety_wit_4.
Axiom proof_of_root_cell_safety_wit_5 : Goal.root_cell_safety_wit_5.
Axiom proof_of_root_cell_safety_wit_6 : Goal.root_cell_safety_wit_6.
Axiom proof_of_root_cell_safety_wit_7 : Goal.root_cell_safety_wit_7.
Axiom proof_of_root_cell_safety_wit_8 : Goal.root_cell_safety_wit_8.
Axiom proof_of_root_cell_safety_wit_9 : Goal.root_cell_safety_wit_9.
Axiom proof_of_root_cell_safety_wit_10 : Goal.root_cell_safety_wit_10.
Axiom proof_of_root_cell_safety_wit_11 : Goal.root_cell_safety_wit_11.
Axiom proof_of_root_cell_safety_wit_12 : Goal.root_cell_safety_wit_12.
Axiom proof_of_root_cell_safety_wit_13 : Goal.root_cell_safety_wit_13.
Axiom proof_of_root_cell_safety_wit_14 : Goal.root_cell_safety_wit_14.
Axiom proof_of_root_cell_safety_wit_15 : Goal.root_cell_safety_wit_15.
Axiom proof_of_root_cell_safety_wit_16 : Goal.root_cell_safety_wit_16.
Axiom proof_of_root_cell_safety_wit_17 : Goal.root_cell_safety_wit_17.
Axiom proof_of_root_cell_safety_wit_18 : Goal.root_cell_safety_wit_18.
Axiom proof_of_root_cell_safety_wit_19 : Goal.root_cell_safety_wit_19.
Axiom proof_of_root_cell_entail_wit_1 : ~ Goal.root_cell_entail_wit_1.
Axiom proof_of_root_cell_entail_wit_2 : Goal.root_cell_entail_wit_2.
Axiom proof_of_root_cell_entail_wit_3 : Goal.root_cell_entail_wit_3.
Axiom proof_of_root_cell_entail_wit_4 : Goal.root_cell_entail_wit_4.
Axiom proof_of_root_cell_entail_wit_5 : Goal.root_cell_entail_wit_5.
Axiom proof_of_root_cell_entail_wit_6 : Goal.root_cell_entail_wit_6.
Axiom proof_of_root_cell_return_wit_1 : Goal.root_cell_return_wit_1.
Axiom proof_of_root_cell_precondition_wit_1 : Goal.root_cell_precondition_wit_1.
End Refutation_Correct.
Module Checked : Refutation_Correct.
Include Candidate.Proofs.
End Checked.
