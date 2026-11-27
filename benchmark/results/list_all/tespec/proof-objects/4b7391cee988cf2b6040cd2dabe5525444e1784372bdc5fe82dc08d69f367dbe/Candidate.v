From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_free_list_precondition_wit_1 : Goal.IntList_free_list_precondition_wit_1.
Proof.
  unfold Goal.IntList_free_list_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  pose proof (@ConAssertion.empty_state_is_empty naive_C_Rules.sts) as Hemp.
  apply (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  cbn [sll].
  repeat first [exact Hemp | reflexivity | split].
Qed.

End Proofs.
