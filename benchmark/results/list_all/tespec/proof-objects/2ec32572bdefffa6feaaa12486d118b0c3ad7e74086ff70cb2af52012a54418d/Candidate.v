From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_length_acc_precondition_wit_1 : Goal.IntList_length_acc_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_acc_precondition_wit_1.
  exists (@nil Z).
  exists 0.
  intro H.
  assert (Hs :
    ( “ (0 = 0) ”
      && “ ((@nil Z) = (@nil Z)) ”
      && sll 0 (@nil Z))
      (@ConAssertion.empty_state naive_C_Rules.sts)).
  {
    simpl sll.
    repeat split; try reflexivity.
    exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts).
  }
  exact (H (@ConAssertion.empty_state naive_C_Rules.sts) Hs).
Qed.

End Proofs.
