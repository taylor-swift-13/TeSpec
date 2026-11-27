From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_length_acc_precondition_wit_1 : Goal.IntList_length_acc_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_acc_precondition_wit_1.
  exists (@nil Z), 0%Z.
  intro H.
  apply (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  simpl sll.
  repeat split; try reflexivity;
    exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts).
Qed.

End Proofs.
