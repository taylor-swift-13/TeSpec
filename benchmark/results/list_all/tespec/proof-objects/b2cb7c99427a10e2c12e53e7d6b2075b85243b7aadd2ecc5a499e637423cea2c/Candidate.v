From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (@nil Z), 7, 7, 0.
  intro H.
  apply (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  simpl sll.
  repeat split; try reflexivity;
    try exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts).
Qed.

End Proofs.
